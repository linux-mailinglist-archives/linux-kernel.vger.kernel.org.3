Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8904BED7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiBUW41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:56:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiBUW41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:56:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957F2459E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:56:02 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1DB91EC02DD;
        Mon, 21 Feb 2022 23:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645484156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OUdPPZ2NT87B88qz4359G2+QNZZ17wqBwZG4z05PFOM=;
        b=kHZEzHjMZByJoEOPA/CQLIWjgX8GUt3xLO9lum3tK2I9mA7vQhw4ZP8QbXVUHnKNMrHIk9
        8FmGpJYPeXLdxsSFUNMQUZPlgU94wEgATDPByFn/WfJT977VWADjvoFygIkUGKAcdQdYW4
        cgPv1HyVAdH7BUFthzr1Wgp5SuDEfPM=
Date:   Mon, 21 Feb 2022 23:56:00 +0100
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
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <YhQYgBYOBtdPD65X@zn.tnic>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
 <YhPst1DdG3T5hsnM@zn.tnic>
 <20220221222149.jpuwlinaihq6fjwy@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221222149.jpuwlinaihq6fjwy@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 01:21:49AM +0300, Kirill A. Shutemov wrote:
> Well, it actually going to be
> 
>  	cpa.mask_set = enc ? cc_mkenc(__pgprot(0)) : cc_mkdec(__pgprot(0));
>  	cpa.mask_clr = enc ? cc_mkdec(__pgprot(0)) : cc_mkenc(__pgprot(0));
> 
> as '0' is not a valid pgprot_t.
> 
> Still wonna go this path?

Why "still"? What's wrong with that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
