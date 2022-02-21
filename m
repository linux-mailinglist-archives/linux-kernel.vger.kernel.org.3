Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E884BEB57
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiBUTtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:49:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiBUTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:49:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C773E2251A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:49:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 236571EC0531;
        Mon, 21 Feb 2022 20:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645472948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=csTPPmj2Aw+cg+CxpaxLS4ygAO7+Q61Ik+J8CNclrGM=;
        b=kfzciMbKeqJT7RVjURpb+BA9iymlvy19ONLbQT7VJO8pDb2gR24ogrLYZpWSzuccbLWhEw
        Q1furpRgn+sHDK5XnYNO3cgkuLdSELjXg0gHVAswNt5qHbJtzLL396rwyzkNHjPuh1ea2e
        1bzw72ADwXfKqZyUaQmPJbXO04Kmke0=
Date:   Mon, 21 Feb 2022 20:49:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <YhPst1DdG3T5hsnM@zn.tnic>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:28:16AM -0800, Dave Hansen wrote:
> Why don't we just have:
> 
> 	pgprot_t cc_mkenc(pgprot prot)
> 	pgprot_t cc_mkenc(pgprot prot)
> 
> and *no* pgprot_{en,de}crypted()?

Yes, and can the above cc_get_mask() thing be:

	cpa.mask_set = enc ? cc_mkenc(0) : cc_mkdec(0);
	cpa.mask_clr = enc ? cc_mkdec(0) : cc_mkenc(0);

since we're going to feed it pgprot things?

And then you don't need a separate cc_get_mask() thing or whatever
- there's only those two mkenc and mkdec things converting pgprots
back'n'forth.

> sme_me_mask does look quite AMD-specialized, like its assembly
> manipulation.  Even if it's just a copy of cc_mask, it would be nice to
> call that out so the relationship is crystal clear.

Yes, the ultimate goal is to have cc_mask be shared by both AMD and
Intel. We'll phase out sme_me_mask on the AMD side gradually while Intel
can use cc_mask directly.

Methinks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
