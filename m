Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850AA4CBC72
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiCCLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiCCLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:21:53 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715511768D0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:21:07 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2db569555d6so51372957b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 03:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lP2eYkn3jCttHpEzQjHtAuLqqZQ4NdZMKDrxiU6dv4U=;
        b=y8vT8zoGiHPENgs7BRcIeDNUYpJjdneQIFVAungmmew1e6xABHI3J8hDqB5sJWPZBr
         x+NKrJIRcSY1outii6hvceo9yWSzG9XWWqDk1kZ+vwy7SRnTftKaCykBapcn4znEKd/q
         gWGlUlXuKwr+jNGSFf3yumvMDRxDJVDXKNR+2ssF0tNIvadwAjCQG/jrGra2nTejoQwu
         aA8LyowSm0vQV1mXVexJLvp7Skqo4NNmO89V88I9W4okrhOihk5MOXxpsZA66TN5pjYH
         C6JF014/6Yq7BuvuPgmcpJRmapUaFUwkSu0l0pZ/UQALDZVTDU39F9KRfMV5j0xhIny3
         MOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lP2eYkn3jCttHpEzQjHtAuLqqZQ4NdZMKDrxiU6dv4U=;
        b=2/N5B/MR1sFsfh9VfO/r8chsozkIV2F/sJf45bqdToSAVZjk38PYViX+Qi5R215z5s
         zsz8Lv9XDHyqdxU3YJjGXPGUpHMqC9DvVSs4iLnhYlXe1UqGpu6zvpILJ2Qen7uh4k6b
         c2iNXDBvN2Fm9IMETAFFUy9bDoYr+eQKVBFtjAaDlmjW8noOjoMne90AGHDVb97rW7k1
         p4LoX9gF2sHAHWoIrbaH8VqEAmUT0D1GAihoveWhYUENU3h1tf9VAZBxUvi049DDnzoA
         jw4PbyNJGObDoRIf8VWanz0eq3ba51l6zYYVaJRumWX15yxS3B1L63iN2itWkbqXrKaT
         iwWw==
X-Gm-Message-State: AOAM531CLSwxZVcDUBj4WqrjlU5mc30355UEB9/iGe5TrhL6VcTAmDaq
        Cok9nIlWXBssP4TVzmU48iX939cgMAZLJfFOPiHz1g==
X-Google-Smtp-Source: ABdhPJytzDF+rrZxtHvKjlaJhF7+9swMvL6S5G58zt8ipoCmv16tay7Bz/Q2qo19fTvP6FxEqV8CyPZafDDogmlTwc8=
X-Received: by 2002:a0d:f9c5:0:b0:2db:7a9a:b01a with SMTP id
 j188-20020a0df9c5000000b002db7a9ab01amr19596239ywf.458.1646306466738; Thu, 03
 Mar 2022 03:21:06 -0800 (PST)
MIME-Version: 1.0
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 3 Mar 2022 19:20:30 +0800
Message-ID: <CAMZfGtXHX7qovi_-oRwbpoGKig_6rqdx4eK6Hva40qCZVRL26w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/2] arm64: avoid flushing icache multiple times
 on contiguous HugeTLB
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 8:32 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Mar 02, 2022 at 04:46:23PM +0800, Muchun Song wrote:
> > When a contiguous HugeTLB page is mapped, set_pte_at() will be called
> > CONT_PTES/CONT_PMDS times.  Therefore, __sync_icache_dcache() will
> > flush cache multiple times if the page is executable (to ensure
> > the I-D cache coherency).  However, the first flushing cache already
> > covers subsequent cache flush operations.  So only flusing cache
> > for the head page if it is a HugeTLB page to avoid redundant cache
> > flushing.  In the next patch, it is also depends on this change
> > since the tail vmemmap pages of HugeTLB is mapped with read-only
> > meanning only head page struct can be modified.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for your review.

>
> (for this patch only, I have yet to figure out whether Anshuman's and
> Mark's comments have been addressed in patch 2)
>

Their comments are memory hotplug related, actually, those issues
are not real issues as I explained in patch 2.  And If you have any
questions, feel free to ask, maybe I can help.

Thanks Catalin.
