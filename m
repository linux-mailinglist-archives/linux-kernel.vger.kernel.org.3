Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02B54589E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiFIXYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiFIXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:24:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAA9156B6D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:24:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a15so40264950lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEFimUlvbzlYBEwgNMXz/kgCUClpMd8S7embt+3S67k=;
        b=OXo8cl/f5RR2QG82SuqbtuvrAT3zgfLUCgtl6dE3mbH5MD0MYpSDUra4e0rn6NKAMu
         XAcXYw8PgvmGYveRHfdiFPFI8TnC5Kbe3d0uC7sgnAPqJNDyb5hGp0bdSh3ubx8IAf8b
         qffpe6N4DPwkspWnanK4W7sCgyXS5FT3CDa8xK69m7Mk6fQPwX9MaX3G1wDh3txM+fwz
         UqE5ye3GIN77G9BQoPhHJh02INEKpJdAmvtIfFaoNoNgikAm6LhpCkpq6stYv/qXrkOw
         b9JwnzB2kpTT3TZ4Uhyd0BPJO7aERXwH1OPNSl+M8NMoaFKcegqOA1aKhEGHuczVLxqz
         pcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEFimUlvbzlYBEwgNMXz/kgCUClpMd8S7embt+3S67k=;
        b=pZexnNmx5I2VTELnTdMc0i8VeQtK2t7LWbSmqEKwks30IXcra1X+31rcs9Nc064UUk
         Ita/RVDgqNNNgRoO+lHol8TBL4NP6WdfgfsT9MXruo1OBu1ysbn/P5+A2uXEcrmveAMk
         nTLMo/vt9uw7SrJG4q7wfrkF7snjS9qt6MlknsiFSoDKKMMEFpADJoSlaiEVsgoN7Xaz
         5BKVjiB4zdUTY5OVtV8YHwJ6miKcfjOHFaeU+/A54C+k0nbHRTa1e8HlztFsNOO5AiyM
         BbnYsFTb73S/vd77QQHAiuVLLY4+qR0oeUb3p4ajJDOXvbIrEHbAMJ5x5cPM81IcgYv7
         ySYA==
X-Gm-Message-State: AOAM5307YRLaabx4iyutbYJHgslMOl4YoX3FWt5WWhzNv5mZ1uDXXTHn
        faC3R9xyJxZswbST82F/KWYtOAa2TiFh5slMwu8j0A==
X-Google-Smtp-Source: ABdhPJxZ9D6scmVmMCKxMCHwRwJCz+W1zYnSffVkRb2dVLKyqKiee8qpE89ys12AioU4EoXa8RrnAqi7/S0lQE/iEP8=
X-Received: by 2002:a05:6512:68e:b0:47d:ae64:fcf4 with SMTP id
 t14-20020a056512068e00b0047dae64fcf4mr730984lfe.685.1654817048572; Thu, 09
 Jun 2022 16:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-4-shy828301@gmail.com>
In-Reply-To: <20220606214414.736109-4-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Jun 2022 16:23:31 -0700
Message-ID: <CAAa6QmRTt2EXJTudBf7DK6yPTr2DRDUbGZiHDC8pAmKRwoB4_A@mail.gmail.com>
Subject: Re: [v3 PATCH 3/7] mm: khugepaged: remove the redundant anon vma check
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
>
> The hugepage_vma_check() already checked it, so remove the redundant
> check.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d0f8020164fc..7a5d1c1a1833 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>                 return SCAN_ADDRESS_RANGE;
>         if (!hugepage_vma_check(vma, vma->vm_flags))
>                 return SCAN_VMA_CHECK;
> -       /* Anon VMA expected */
> -       if (!vma->anon_vma || !vma_is_anonymous(vma))
> -               return SCAN_VMA_CHECK;
>         return 0;
>  }
>
> --
> 2.26.3
>
>

So, I don't know if this is possible, but I wonder if there is a race here:

hugepage_vma_revalidate() is called in the anon path when mmap_lock
after dropped + reacquired, and we want to refind / revalidate the
vma, since it might have changed.

There is the possibility that the memory was unmapped, then remapped
as file or shmem. If so, hugepage_vma_check() could return true
without actually checking vma->anon_vma || !vma_is_anonymous(vma) -
and we probably do want to (re)validate that this is indeed still an
anon vma.
