Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C14EFA53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351543AbiDATRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347016AbiDATRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:17:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E433E3D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:15:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c11so3078840pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=74mB6MqkSJBkwlaVi13tzJeL9OKs1IHJIH4CRNeep8g=;
        b=bJTyRdDTmlbuSOM0B2IOeSL9/WFOBdcTPTkBu4BZi3VTXTZXyU9USVbd0ARBpqBd/o
         Xhqm+ZokB9H18FXjbbbKA3nLPKuk8jlb1DV9o4R5Shg4d7X2Zd9deT8e+k5Wcvp8TurP
         7FXpoK+YCocWG8BZCLk/6mOj8pmP2DTACrdxvZe8W597X5HAdipYg2QW/3kQ8Hh8kNfw
         ddNYibFysh1gqMIgVAdqbXiMWNdskLI9YyNFUwamOWZgIQlW7hYipsYzaSZAs9wNLwDh
         wJvQMCRCBmmEzHUKRTYCPGPum6YvplBPsG//0oQb/q9Es28OAkEP2D8h/i4/NbjA1iCK
         Gf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=74mB6MqkSJBkwlaVi13tzJeL9OKs1IHJIH4CRNeep8g=;
        b=0eYxBdU8gaJv4aqCAMZerorChSaHCqDd0PcZ5Q6nSvTCvkzz672o3KQO8YQxiPEuxy
         k9KZTIwNJ+bAYouH4A9G7SjlOXRymDbpfRC8lrZxWFY138iCaYGTGmCRFnZZBBzPikME
         yUbuUxTZJ7SKHGYGOmOnmH8hQOuDUdYKD3csJsAaI25dC30XXRy0LCz74EY/rYVgF43h
         LPdmAlGqEy22PcRtMDeDiqfNhJ8YjJE1rNJ33PUviGiPEobBaOCf1BIqB0TqLHlOrhwD
         /20EtvX4FNrqMSNQGsaCq2J5Ja5h+cNTA6Z2nVY0PFtsIrW1N3wojV4i3aVrovgVG1T8
         5UKw==
X-Gm-Message-State: AOAM530Dn1X3Dsm/EXWsU5e0BH/Gh20Rk4wBaHF9QuiTV1QLdAiHRVDc
        RM+tBBkYFBxKR+vTdwdTn1M=
X-Google-Smtp-Source: ABdhPJyLNOCEvxq6jQfaw9AVNQZAkvBxjWn0h+EdPMHZI8Q6BSfpdilPDso/5du4exJGhiBafhi/+w==
X-Received: by 2002:a63:3cf:0:b0:382:9343:bbd3 with SMTP id 198-20020a6303cf000000b003829343bbd3mr16248441pgd.511.1648840515432;
        Fri, 01 Apr 2022 12:15:15 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s10-20020a056a00178a00b004fda49fb25dsm3962041pfg.9.2022.04.01.12.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 12:15:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v1 mmotm] mm/mprotect: try avoiding write faults for
 exclusive anonynmous pages when changing protection
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220401101334.68859-1-david@redhat.com>
Date:   Fri, 1 Apr 2022 12:15:13 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A6AF878-D5D7-4D88-A736-0FEF71439D44@gmail.com>
References: <20220401101334.68859-1-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Rick ]

> On Apr 1, 2022, at 3:13 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable =
mappings, we
> can try mapping anonymous pages writable if they are exclusive,
> the PTE is already dirty, and no special handling applies. Mapping the
> PTE writable is essentially the same thing the write fault handler =
would do
> in this case.

In general I am all supportive for such a change.

I do have some mostly-minor concerns.

>=20
> +static inline bool can_change_pte_writable(struct vm_area_struct =
*vma,
> +					   unsigned long addr, pte_t =
pte,
> +					   unsigned long cp_flags)
> +{
> +	struct page *page;
> +
> +	if ((vma->vm_flags & VM_SHARED) && !(cp_flags & =
MM_CP_DIRTY_ACCT))
> +		/*
> +		 * MM_CP_DIRTY_ACCT is only expressive for shared =
mappings;
> +		 * without MM_CP_DIRTY_ACCT, there is nothing to do.
> +		 */
> +		return false;
> +
> +	if (!(vma->vm_flags & VM_WRITE))
> +		return false;
> +
> +	if (pte_write(pte) || pte_protnone(pte) || !pte_dirty(pte))
> +		return false;

If pte_write() is already try then return false? I understand you want
to do so because the page is already writable, but it is confusing.

In addition, I am not sure about the pte_dirty() check is really robust.
I mean I think it is ok, but is there any issue with shadow-stack?=20

And this also assumes the kernel does not clear the dirty bit without
clearing the present, as otherwise the note in Intel SDM section 4.8
("Accessed and Dirty Flags=E2=80=9D) will be relevant and dirty bit =
might be
set unnecessarily. I think it is ok.

> +
> +	/* Do we need write faults for softdirty tracking? */
> +	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !pte_soft_dirty(pte) &&
> +	    (vma->vm_flags & VM_SOFTDIRTY))

If !IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) then VM_SOFTDIRTY =3D=3D 0. So I =
do not
think the IS_ENABLED() is necessary (unless you think it is clearer this
way).

> +		return false;
> +
> +	/* Do we need write faults for uffd-wp tracking? */
> +	if (userfaultfd_pte_wp(vma, pte))
> +		return false;
> +
> +	if (!(vma->vm_flags & VM_SHARED)) {
> +		/*
> +		 * We can only special-case on exclusive anonymous =
pages,
> +		 * because we know that our write-fault handler =
similarly would
> +		 * map them writable without any additional checks while =
holding
> +		 * the PT lock.
> +		 */
> +		page =3D vm_normal_page(vma, addr, pte);

I guess we cannot call vm_normal_page() twice, once for prot_numa and =
once
here, in practice...

> +		if (!page || !PageAnon(page) || =
!PageAnonExclusive(page))
> +			return false;
> +	}
> +
> +	return true;
> +}

Note that there is a small downside to all of that. Assume you =
mprotect()
a single page from RO to RW and you have many threads.

With my pending patch you would avoid the TLB shootdown (and get a PF).
With this patch you would get a TLB shootdown and save the PF. IOW, I
think it is worthy to skip the shootdown as well in such a case and
instead flush the TLB on spurious page-faults. But I guess that=E2=80=99s =
for
another patch.

