Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB44B853E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiBPKH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:07:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiBPKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:07:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CA1B85A3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:07:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 614A41EC04C1;
        Wed, 16 Feb 2022 11:07:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645006028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mc1byk01SMNlUFOzzBp9ZSJPPb31u5PB8VWGi7eix5E=;
        b=Z0zaQ3nbJ1YzlRMd4uKT4BEkM8VbIWo5VeAxr/dS5ZVBnKq+WYSOCRgQEtRseB00CnpPFV
        TBXzGqsZfLiTVfCAVPNivNdefp+hgFsC4WoR7Ch0iJ827aTBCrMSiGVwAk+3Nzr+SRseCb
        3EBUIDPrq8bvl9zxAQF5XDkq2fK5yhQ=
Date:   Wed, 16 Feb 2022 11:07:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <YgzM03ovVdaXhT39@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
 <Yfpqk0amEbcyte+w@zn.tnic>
 <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
 <Yf0vB+TBR2AjHmV5@zn.tnic>
 <20220215213624.tzdahmbhucupwtqe@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215213624.tzdahmbhucupwtqe@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:36:24AM +0300, Kirill A. Shutemov wrote:
> How can signle trampoline_start cover all cases?

All I'm saying is that the real mode header should have a single

	u32     trampoline_start;

instead of:

	u32     trampoline_start;
	u32     sev_es_trampoline_start;
	u32     trampoline_start64;

which all are the same thing on a single system.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
