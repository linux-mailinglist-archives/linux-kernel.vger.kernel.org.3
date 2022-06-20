Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F545515C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiFTK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiFTK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:26:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD713F88
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:26:06 -0700 (PDT)
Received: from zn.tnic (p200300ea974657f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57f0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9D7D1EC05ED;
        Mon, 20 Jun 2022 12:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1655720760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q17a9XDpjwTWrwYDkkTaQRPmMqGL4q0bN7aju6sX8fc=;
        b=ot3uDji6ieMC7dhTqMOPLpRfYZ+D/oOGVFqRzqgKnfa0kcNpM/bfgTF0HcgcUwm1ytR3UF
        ZcxLVAfRbqvIk7ehY+JDCg/3PXcH03o7yOuj7hy3MWW6UBKZz+alWlDdoJiftWvYpq7DOu
        W9CoStDuS1uK4u2ui87Jeq2OESCWxlw=
Date:   Mon, 20 Jun 2022 12:26:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jbeulich@suse.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
Message-ID: <YrBLU2C5cJoalnax@zn.tnic>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220503132207.17234-2-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:22:06PM +0200, Juergen Gross wrote:
> x86_has_pat_wp() is using a wrong test, as it relies on the normal
> PAT configuration used by the kernel. In case the PAT MSR has been
> setup by another entity (e.g. BIOS or Xen hypervisor) it might return
> false even if the PAT configuration is allowing WP mappings.
> 
> Fixes: 1f6f655e01ad ("x86/mm: Add a x86_has_pat_wp() helper")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index d8cfce221275..71e182ebced3 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -80,7 +80,8 @@ static uint8_t __pte2cachemode_tbl[8] = {
>  /* Check that the write-protect PAT entry is set for write-protect */
>  bool x86_has_pat_wp(void)
>  {
> -	return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
> +	return __pte2cachemode_tbl[__cachemode2pte_tbl[_PAGE_CACHE_MODE_WP]] ==
> +	       _PAGE_CACHE_MODE_WP;

So this code always makes my head spin... especially after vacation but
lemme take a stab:

__pte2cachemode_tbl indices are of type enum page_cache_mode.

What you've done is index with

__cachemode2pte_tbl[_PAGE_CACHE_MODE_WP]

which gives uint16_t.

So, if at all, this should do __pte2cm_idx(_PAGE_CACHE_MODE_WP) to index
into it.

But I'm still unclear on the big picture. Looking at Jan's explanation,
there's something about PAT init being skipped due to MTRRs not being
emulated by Xen.... or something to that effect.

So if that's the case, the Xen guest code should init PAT in its own
way, so that the generic code works with this without doing hacks.

But I'm only guessing - this needs a *lot* more elaboration and
explanation why exactly this is needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
