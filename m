Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5946C14F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhLGRIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbhLGRI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:08:29 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14188C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:04:59 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f186so42626695ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O73Ze+VaZ72yqZEQS/KFQihGyU4Mm5AKKp2/1/GYgVA=;
        b=KrByQ0JfoqCtbQKA/SPw4hrXd2hut53v8cVXeumIKc3jsfhmQy+eu+jBSjFhMOZO5N
         qFeO9hBpT0uyME6t11z11b1Q48aIYpnkk8+J2oMf275wKThdmf3t6bfm8Cd6HqRs07EQ
         IA/OeE3VQsz6f26MEfyaWVBqROeIU1N+JGYxx95CFhdsNifoX2cts0O3D8tzXJBCr6TF
         csw89OCuXY5pilyURgMjZGe34oy2xuj1GJ4VniStv9aEFI57agr1bn0E5sA+WTxxUgTj
         VGbwhA6J8aUjrf01dyebrbaAaksUlAm5CD+DvdtfpEg2YUbZ83DdSfqHvw+oETsMioTz
         Wo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O73Ze+VaZ72yqZEQS/KFQihGyU4Mm5AKKp2/1/GYgVA=;
        b=aTDNkfGO08bwI2t9ZrlnyYJAlnl8dmtUXi0qarXudpNhU48Spre2nNQ1ritzFeOPYY
         l2QSETwTl3C8KQYvpPPE5pz1i1USbFxrLE4eRTh8/5A7yb3nSipVKHrYRozA+niUkLp+
         2RuGOzQYmYyaxyZcWkrTSVCLgO3Vf08uCqzxwoSK9mYdyYh8o+A0VgrhiPVRxTmHlhkB
         2Ia/uvLGPa0ByRmmZVBfXwMeepgfkgBqgvEOFtOMLrN1yhc9+OKKFTsrAaEHTrIOKIGT
         FJFQLKyAzNlb11h+yojXkDIM3MpOMgsQ3XlVTOSQqjaWrXgqML1QYo8P0bo1bNfTQ9K3
         n5PQ==
X-Gm-Message-State: AOAM531K5WuIcgNBnUP4a5V5togJIYD8+qOQZR377trxFGGdjhd12S+4
        5cw0FV0kTpjtmNLqDvu39wyUC0HcedJsneYJ3GNx8Q==
X-Google-Smtp-Source: ABdhPJwp9DybShWds517wP/lVihTekfcDrGzA+mDrpQ8/7v2KoG0f6RJNuvIBdbUpi9vbxnyaKQN6XHRMU+yLNoUsxs=
X-Received: by 2002:a25:6ec5:: with SMTP id j188mr52542171ybc.602.1638896698078;
 Tue, 07 Dec 2021 09:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20211207032202.6022-1-xiaofeng5@xiaomi.com>
In-Reply-To: <20211207032202.6022-1-xiaofeng5@xiaomi.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 Dec 2021 09:04:47 -0800
Message-ID: <CAJuCfpFgEB0qNcQGhi+wyrx4ktwm+PZujLeKTUeEMZTRUL=31w@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: break reclaim when lock race
To:     xf2017140389@gmail.com
Cc:     akpm@linux-foundation.org, christian@brauner.io,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhangcang@xiaomi.com, wangju@xiaomi.com, fangzhirong@xiaomi.com,
        xiaofeng <xiaofeng5@xiaomi.com>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 7:22 PM <xf2017140389@gmail.com> wrote:
>
> From: xiaofeng <xiaofeng5@xiaomi.com>
>
> When the process_madvise() system call is being used, it takes mmap_lock and blocks the application from allocating memory, leading to unreasonable delays. This patchset aims to fix it.

Please use checkpatch.pl script before posting (see this blog for
example: http://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/).

Could you please describe your usecase a bit more? Which MADV is being
used specifically (MADV_COLD or MADV_PAGEOUT)?
CC'ing Minchan as he might be interested in learning more about this.

>
> Signed-off-by: xiaofeng <xiaofeng5@xiaomi.com>
> ---
>  mm/madvise.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 8c927202bbe6..8f1e325873e0 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -322,6 +322,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>         if (fatal_signal_pending(current))
>                 return -EINTR;
>
> +       if (mmap_lock_is_contended(mm))
> +               return -EINTR;
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (pmd_trans_huge(*pmd)) {
>                 pmd_t orig_pmd;
> --
> 2.17.1
>
