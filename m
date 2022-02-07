Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC44AC5B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389841AbiBGQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388324AbiBGQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:27:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0AC0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:27:30 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5079C1EC01A9;
        Mon,  7 Feb 2022 17:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644251245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V+wFfsqHNfZRL4X27c/FVRJb4slH/Iyz43L5rnSVKww=;
        b=X9yluiiEo6dUxb589S8A5/IYUIB2oE4PRH2xaGSR2m0NgweXp+TpqR5Su58q4dmnHaYj7a
        FCZD7OM0zodQtYSYpkwKPdSf+7QOLpRjFeARpFYmEDEAFT9PcxUR9BH0Q/G+g5hA0fHVuA
        ySgGSvdru5np43vV2veodivKtoSjK30=
Date:   Mon, 7 Feb 2022 17:27:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <YgFIaJ8ijgQQ04Nv@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:02:08PM +0300, Kirill A. Shutemov wrote:
> -/*
> - * Macros to add or remove encryption attribute
> - */
> -#define pgprot_encrypted(prot)	__pgprot(__sme_set(pgprot_val(prot)))
> -#define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))

Why can't you simply define

cc_set() and cc_clear()

helpers which either call the __sme variants or __tdx variants, the
latter you can define the same way, respectively, as the __sme ones.

And then you do:

#define pgprot_encrypted(prot)       __pgprot(cc_set(pgprot_val(prot)))
#define pgprot_decrypted(prot)       __pgprot(cc_clear(pgprot_val(prot)))

And just so that it works as early as possible, you can define a global
tdx_shared_mask or so which gets initialized the moment you have
td_info.gpa_width.

And then you don't need to export anything or other ifdefferies - you
just make sure you have that mask defined as early as needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
