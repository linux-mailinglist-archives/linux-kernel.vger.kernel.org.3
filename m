Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A228654ECE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378581AbiFPV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiFPV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:56:32 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773C5D5E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:56:31 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f13so2457757vsp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjlM3vbou88b5LgLylvLtPzb4A4wi5OpV/vwF2bF6vA=;
        b=luZH+ZNaG5KVeSHWoVUQPxhwIvaNc10bfWOshMf4MSOUNEufKJmDGhFIsXYipizIrL
         kvXIo35UZLhZs5NAkxN02wDob9it6O3RpNIBEOFNATLHtrk60YwH8SkXqa4KZ63SZ5ln
         3K6ssQHFLWhAl3AJAkTUAQAjzmuJ3RklEZENWSps45I/F4m0teJKOHYzQd8QoFGTimjD
         /jA+DmwfWTmO/GKPI5aqKlAYB7BHTD+OJemVEqCa6mhcELgpgWwvzzuG1LHv9MREzpUG
         rhEP0ul00polFwwQtXryB9iGzIQSUBiHVlMBZz3EyCORkNC0mc8S874U5Rl21v/w7oUI
         VeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjlM3vbou88b5LgLylvLtPzb4A4wi5OpV/vwF2bF6vA=;
        b=aikJHJv0pQiZ9+xMA6teoPveEI4wwmQAb9YDUWbwMp6l294MGZRYSlxlrW0F3JyNMA
         tF/Flak1DH13ASJTnwn2TpMOMn1yuIPzZezonuzGNWM8BzDnKQeDT1stJNmsTm7TtSXX
         hBUtt/tI2R4MVwSqc0q2sxGlA0BOu5kKU6sd/vMxyPFJsYs8uvOgoVAKT+0IU0hCUxYl
         zN/gPD5/yMZBtWWuo4TZNIxS5d6DmcHDuUq2r6fVGT30jSrShAb75Y2I0YAF1IaZLMrS
         gxeoYXhrr2acfkr/i0MAvjbhWyJ4iYv+3BlxIYWVNL0lU7GghOanIdQhbgEoGX/I5Vbc
         A6zQ==
X-Gm-Message-State: AJIora+93OdGU1mcRnErpRjQU8XSMpZgkYZSQXUyL4S1GcWY/RvYZa8S
        cHsSbDTdiDGk2brf4PtouwfVzfOoEkU+aRJVYaF92Q==
X-Google-Smtp-Source: AGRyM1tlXhUmHC3noZOjt2OwAeuKugI4s20YGAvEyporuM+MgUc1WLNWUacFUVElKg67zIxZuSJVRLmo22Y+UbnVJ+0=
X-Received: by 2002:a67:b907:0:b0:34b:d597:d6e8 with SMTP id
 q7-20020a67b907000000b0034bd597d6e8mr3230751vsn.84.1655416590903; Thu, 16 Jun
 2022 14:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck> <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
 <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com>
 <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com> <CAGsJ_4yLCsJJvK5QkFOk_7UW72DRO7gWnd6wdn2TWzBrTmRjSg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yLCsJJvK5QkFOk_7UW72DRO7gWnd6wdn2TWzBrTmRjSg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 16 Jun 2022 15:55:54 -0600
Message-ID: <CAOUHufZn5L_R7b_S3P9O+VoJC=EnY10e+xyFF7UqiGbLzzzqKg@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Barry Song <21cnbao@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 4:46 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Jun 9, 2022 at 3:52 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Jun 7, 2022 at 5:43 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > Given we used to have a flush for clear pte young in LRU, right now we are
> > > moving to nop in almost all cases for the flush unless the address becomes
> > > young exactly after look_around and before ptep_clear_flush_young_notify.
> > > It means we are actually dropping flush. So the question is,  were we
> > > overcautious? we actually don't need the flush at all even without mglru?
> >
> > We stopped flushing the TLB on A bit clears on x86 back in 2014.
> >
> > See commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case
> > clear the accessed bit instead of flushing the TLB").
>
> This is true for x86, RISC-V, powerpc and S390. but it is not true for
> most platforms.
>
> There was an attempt to do the same thing in arm64:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793830.html
> but arm64 still sent a nosync tlbi and depent on a deferred to dsb :
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1794484.html

Barry, you've already answered your own question.

Without commit 07509e10dcc7 arm64: pgtable: Fix pte_accessible():
   #define pte_accessible(mm, pte)        \
  -       (mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid_young(pte))
  +       (mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))

You missed all TLB flushes for PTEs that have gone through
ptep_test_and_clear_young() on the reclaim path. But most of the time,
you got away with it, only occasional app crashes:
https://lore.kernel.org/r/CAGsJ_4w6JjuG4rn2P=d974wBOUtXUUnaZKnx+-G6a8_mSROa+Q@mail.gmail.com/

Why?
