Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99D551E12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350971AbiFTOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352992AbiFTN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:57:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0348437A3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:23:14 -0700 (PDT)
Received: from zn.tnic (p200300ea974657f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57f0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E81721EC0657;
        Mon, 20 Jun 2022 15:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1655731333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LrGpaF007OQqZrjEUL4cOEK+6b5ptHcd1OgrPbOBhQc=;
        b=kWLHioT5UQlaSJoVi5j86oOVwPwb26iLxGk6Lbs+ei26Nq/TNiLbkDhLvIBEcM1dDW7PwE
        REHLuI7rtdbxYZJ11zXspxBMbDlwr0roQw/RaMWMbPlZlmUydz0+9GqupSWNQ5iHJDtzLd
        ZDKnGzQwg1BILxQITGEggBx6lvjZ+IE=
Date:   Mon, 20 Jun 2022 15:22:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/pat: fix x86_has_pat_wp()
Message-ID: <YrB0gNtIfCwV+xnE@zn.tnic>
References: <20220620113441.23961-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220620113441.23961-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tom.

On Mon, Jun 20, 2022 at 01:34:41PM +0200, Juergen Gross wrote:
> x86_has_pat_wp() is using a wrong test, as it relies on the normal
> PAT configuration used by the kernel. In case the PAT MSR has been
> setup by another entity (e.g. BIOS or Xen hypervisor) it might return
> false even if the PAT configuration is allowing WP mappings.

... because Xen doesn't allow writing the PAT MSR. Please explain
exactly what happens because we will forget.

> The correct way to test for WP support is:
> 
> 1. Get the PTE protection bits needed to select WP mode by reading
>    __cachemode2pte_tbl[_PAGE_CACHE_MODE_WP] (depending on the PAT MSR
>    setting this might return protection bits for a stronger mode, e.g.
>    UC-)
> 2. Translate those bits back into the real cache mode selected by those
>    PTE bits by reading __pte2cachemode_tbl[__pte2cm_idx(prot)]
> 3. Test for the cache mode to be _PAGE_CACHE_MODE_WP

Yes, this is a good explanation albeit a bit too verbose. You can stick
a shorter version of it as a comment over the function so that we don't
have to swap it all back in next time.

> Fixes: 1f6f655e01ad ("x86/mm: Add a x86_has_pat_wp() helper")

If anything, this should be:

f88a68facd9a ("x86/mm: Extend early_memremap() support with additional attrs")

Also, I'm thinking CC:stable here.

> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - fix indexing into __pte2cachemode_tbl[]

Yes, in any case, I see it now. The key aspect being in the comment
above it:

 *   Index into __pte2cachemode_tbl[] are the caching attribute bits of the pte
 *   (_PAGE_PWT, _PAGE_PCD, _PAGE_PAT) at index bit positions 0, 1, 2.

which is how one should index into that array.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
