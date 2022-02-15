Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE934B69BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiBOKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:50:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiBOKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:50:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C2D1D6E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:50:38 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A387A1EC0411;
        Tue, 15 Feb 2022 11:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644922232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IzCrnAOofGleT2uc8mAaCqsxLqSS4dt0dciqd9BdXtQ=;
        b=U8F7IaUHR8yjW+7vzvxAWOJeetnpdDgIbuVW7arQZjZAASj3rh13asaKrB4T/m+efekuVy
        e2jjZ6HFvQRub2NUXB8g3hqaqhZvy6SYF4Ir10pKPLQH8UAPRh1rWV8vhyp5emCxybM3gH
        ePgz1ozMUXbQTUgDBX80e15k3qGFkSI=
Date:   Tue, 15 Feb 2022 11:50:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <YguFet7RoVmYbHcN@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic>
 <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:09:26AM +0300, Kirill A. Shutemov wrote:
> pgprotval_t cc_enc(pgprotval_t protval)
> {
> 	if (sme_me_mask)
> 		return __sme_set(protval);
> 	else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> 		return protval & ~tdx_shared_mask();
				 ^^^^^^^^^^^^^^^^^^^

LGTM.

Btw, what about sticking the mask tdx_shared_mask() returns into a
proper u64 variable and using it everywhere, just like sme_me_mask?

We could unify it later into a common encryption mask, see thread
starting here:

https://lore.kernel.org/r/YgZ427v95xcdOKSC@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
