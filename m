Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE457068F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiGKPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:04:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117025595
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:04:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu42so9234503lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgUS82K2zhP325p8wjy8l4MlvN11hbzE1cFNOBCQxvk=;
        b=GdTS2TUW+MKBGeytBsDh+01B8SSagYtpNa8iZEYMVgtRkJXiVtGKG/Sn6L5ulw8VZj
         USog3UCmjJyVfyYP4CazkBpndDGdLflG5tl8u+wgZCDolfKCyP2ImFnZKFQAv9N9Gv/p
         8Y/enTeqUR01OOvMjLRme6G7rwT7cxL4FTfKviVk8xEEzEfRyAvRfFJcTF8DVUHf6do9
         zY60LXSuWxJPQXKyauTzwiqNm9ayDmYh5YRxwV9s/jEiDKgIk0G6M/fZfABsSksWwWGh
         ahxN9jgXWZPpmmyxkO/ozmGhIlPfacXrl6v9AHHIlS2S2T6heTMNhQWPqsgSt3T8gvgi
         Tslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgUS82K2zhP325p8wjy8l4MlvN11hbzE1cFNOBCQxvk=;
        b=7mB0v0GSm0a1gn11RJ6muMnHx1OIpil1uV4+b7xLC4Blpon0PKqbTZ77ZVfQwkVt42
         PaIMFOvhhxZ+VnXLym3XiXqBl2MnsiCPq5kcy4c8sZCiksS9SS1w28gyqpRSAMWAoRPv
         6+nYCGgFXMcqT+AW1Py8f9ynRURntPR+/7G68Dyjno9wRuZuftM00dkvXrUf98yFq9Xw
         0IySDLDMz0kQ9l4Rbx3k0iedu/Sfj+7RfveaTD1FSrITGslFysLw8nZA5iIWsWjOT91j
         XBwkom06lvxiWInuOwo2KN/9OvhpRKg8/sveiZhoFkokXmffeaZcsXzHFuVFaxkds59M
         ddrA==
X-Gm-Message-State: AJIora/N5/Ex2B5rA+64ohnQZTKM+YBk/hRWsOM5rAc3s9fpPmMbjliL
        LYAhC8hpH6n9ZUPAcB1IDd9Gxo0RPxlbP5G8D/qMdPIeL7A=
X-Google-Smtp-Source: AGRyM1t+zU3BMjodTIBb1odDySeQMaK1DpIwSRMsOXG7y3vqRH+ot5y07mqKhFJNT1tfn6xpW3t0PAbm6Dio/ktMQOg=
X-Received: by 2002:a05:6512:33c4:b0:489:da1c:76cc with SMTP id
 d4-20020a05651233c400b00489da1c76ccmr5240202lfg.237.1657551879124; Mon, 11
 Jul 2022 08:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220708071802.751003711@infradead.org> <20220708071834.149930530@infradead.org>
 <CAG48ez1eFwoDYnuyqp3FSDCaEOFsQEbBzsT4pGS7Xw0eLVf+nQ@mail.gmail.com> <Ysk+aUdA+3olVRtT@worktop.programming.kicks-ass.net>
In-Reply-To: <Ysk+aUdA+3olVRtT@worktop.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 11 Jul 2022 17:04:02 +0200
Message-ID: <CAG48ez0XK-js7h3Aes=W7cpctkuQ0_aAjFb2SmOdFfszZgoZOQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmu_gather: Force tlb-flush VM_PFNMAP vmas
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
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

On Sat, Jul 9, 2022 at 10:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Jul 08, 2022 at 04:04:38PM +0200, Jann Horn wrote:
> > On Fri, Jul 8, 2022 at 9:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > @@ -507,16 +502,22 @@ static inline void tlb_start_vma(struct
> > >
> > >  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > >  {
> > > -       if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> > > +       if (tlb->fullmm)
> > >                 return;
> >
> > Is this correct, or would there still be a race between MM teardown
> > (which sets ->fullmm, see exit_mmap()->tlb_gather_mmu_fullmm()) and
> > unmap_mapping_range()? My understanding is that ->fullmm only
> > guarantees a flush at tlb_finish_mmu(), but here we're trying to
> > ensure a flush before unlink_file_vma().
>
> fullmm is when the last user of the mm goes away, there should not be

(FWIW, there also seems to be an error path in write_ldt ->
free_ldt_pgtables -> tlb_gather_mmu_fullmm where ->fullmm can be set
for a TLB shootdown in a live process, but that's irrelevant for this
patch.)

> any races on the address space at that time. Also see the comment with
> tlb_gather_mmu_fullmm() and its users.

Ah, right, aside from the LDT weirdness, fullmm is only used in
exit_mmap, and at that point there can be no more parallel access to
the MM except for remote memory reaping (which is synchronized against
using mmap_write_lock()) and rmap walks...

> Subject: mmu_gather: Force TLB-flush VM_PFNMAP|VM_MIXEDMAP vmas
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jul 7 11:51:16 CEST 2022
>
> Jann reported a race between munmap() and unmap_mapping_range(), where
> unmap_mapping_range() will no-op once unmap_vmas() has unlinked the
> VMA; however munmap() will not yet have invalidated the TLBs.
>
> Therefore unmap_mapping_range() will complete while there are still
> (stale) TLB entries for the specified range.
>
> Mitigate this by force flushing TLBs for VM_PFNMAP ranges.
>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me.
