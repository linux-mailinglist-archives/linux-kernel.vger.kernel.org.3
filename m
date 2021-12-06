Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2381B469702
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbhLFNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbhLFNdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:33:12 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF78C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 05:29:43 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t19so21463956oij.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 05:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwAXMiVFRnMKI3jWqdRm+kJXMsdijWyrT1caWs3PQTk=;
        b=IE5me+LHMRQjptKGhcOsOYxfNBz3f/ma9giWCe0AmPHl/vDbTh1J1FDFLqvFN/ip3u
         SdIyQ3mLl8xI37tnuhWlfrCKZUOIlx/POoiMM8ta/SdHSLG3Ghy64KFwR9XKFos8LNkR
         XQgASNCrdTEIcFRAOJehnK9/tBgE2TEDbBwKRe0eTfAE293GfxkqzHhqmeqiSV5PRg54
         361QXS2QEyn23ymeMIws6qaKLS0WnAAtr9jHpqiQ0M4Kj8d8FpNTRv7ET4d+pu09VMh2
         WVNft46OfBrXOotOAiXS4D+mSc80oO49I4pc8J9O2ocL0U14aiEgxEMv9wyaS8RkhlSB
         J/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwAXMiVFRnMKI3jWqdRm+kJXMsdijWyrT1caWs3PQTk=;
        b=BqVYr4qRg/KdxqNDBPLKGH1/ARsc2YQ8+qYACMrvXRB9WyqvFZxnYKmfwtbtb6I+Lp
         faS9x8VAXk/d1QUoDzPe7BMAzFguUoxbLd10nVOdwU5hOsUU2HGgAGI+j4vaSs4mfZ61
         yaUnUKGubZa8Y0bPf87s7os4Q3FQpzSHRWDWazxg++NPUH8Yfj6r4EsMDZnrRvpDK/EW
         QOI3xlj0AOxrZUuGbsablYKWNq7J7MngSuYrq2LFY9u4fZxg1QSJXs/+y5bc14S7GmZZ
         lULFAq6zHyLq1dfKjvsgAmsuZq6ch33PvQKUqMSnbwpOGvRvS1Sa6HptD5P8zNLz4ZvP
         6HtQ==
X-Gm-Message-State: AOAM532KjVBtn7tD9jio4/BBmqXJBGQBDwcHGX2PPmDMphnkLnVI6Yoj
        vg4Ck5sFlcFll4cglOh9fYlqxcUMRGsghxjuKAUQdw==
X-Google-Smtp-Source: ABdhPJznGtTOJYXxjMhot0YDEEwLZ8B0iXN5RefIFoYsB6XzS0mEBOnEYJnWWh9wDrEen/v+vlHP7abzw2uwwVzmKlI=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr23741704oil.65.1638797382907;
 Mon, 06 Dec 2021 05:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20211206133628.2822545-1-libaokun1@huawei.com>
In-Reply-To: <20211206133628.2822545-1-libaokun1@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Dec 2021 14:29:31 +0100
Message-ID: <CANpmjNOrtcu16zKEjiZbBZJPDKWa6-PM_hw1yNZhXvpZupYgng@mail.gmail.com>
Subject: Re: [PATCH -next] kfence: fix memory leak when cat kfence objects
To:     Baokun Li <libaokun1@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 14:24, Baokun Li <libaokun1@huawei.com> wrote:
>
> Hulk robot reported a kmemleak problem:
> -----------------------------------------------------------------------
> unreferenced object 0xffff93d1d8cc02e8 (size 248):
>   comm "cat", pid 23327, jiffies 4624670141 (age 495992.217s)
>   hex dump (first 32 bytes):
>     00 40 85 19 d4 93 ff ff 00 10 00 00 00 00 00 00  .@..............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000db5610b3>] seq_open+0x2a/0x80
>     [<00000000d66ac99d>] full_proxy_open+0x167/0x1e0
>     [<00000000d58ef917>] do_dentry_open+0x1e1/0x3a0
>     [<0000000016c91867>] path_openat+0x961/0xa20
>     [<00000000909c9564>] do_filp_open+0xae/0x120
>     [<0000000059c761e6>] do_sys_openat2+0x216/0x2f0
>     [<00000000b7a7b239>] do_sys_open+0x57/0x80
>     [<00000000e559d671>] do_syscall_64+0x33/0x40
>     [<000000000ea1fbfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> unreferenced object 0xffff93d419854000 (size 4096):
>   comm "cat", pid 23327, jiffies 4624670141 (age 495992.217s)
>   hex dump (first 32 bytes):
>     6b 66 65 6e 63 65 2d 23 32 35 30 3a 20 30 78 30  kfence-#250: 0x0
>     30 30 30 30 30 30 30 37 35 34 62 64 61 31 32 2d  0000000754bda12-
>   backtrace:
>     [<000000008162c6f2>] seq_read_iter+0x313/0x440
>     [<0000000020b1b3e3>] seq_read+0x14b/0x1a0
>     [<00000000af248fbc>] full_proxy_read+0x56/0x80
>     [<00000000f97679d1>] vfs_read+0xa5/0x1b0
>     [<000000000ed8a36f>] ksys_read+0xa0/0xf0
>     [<00000000e559d671>] do_syscall_64+0x33/0x40
>     [<000000000ea1fbfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> -----------------------------------------------------------------------
>
> I find that we can easily reproduce this problem with the following
> commands:
>         `cat /sys/kernel/debug/kfence/objects`
>         `echo scan > /sys/kernel/debug/kmemleak`
>         `cat /sys/kernel/debug/kmemleak`
>
> The leaked memory is allocated in the stack below:
> ----------------------------------
> do_syscall_64
>   do_sys_open
>     do_dentry_open
>       full_proxy_open
>         seq_open            ---> alloc seq_file
>   vfs_read
>     full_proxy_read
>       seq_read
>         seq_read_iter
>           traverse          ---> alloc seq_buf
> ----------------------------------
>
> And it should have been released in the following process:
> ----------------------------------
> do_syscall_64
>   syscall_exit_to_user_mode
>     exit_to_user_mode_prepare
>       task_work_run
>         ____fput
>           __fput
>             full_proxy_release  ---> free here
> ----------------------------------
>
> However, the release function corresponding to file_operations is not
> implemented in kfence. As a result, a memory leak occurs. Therefore,
> the solution to this problem is to implement the corresponding
> release function.
>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Good catch!

Acked-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 46103a7628a6..186838f062b2 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -684,6 +684,7 @@ static const struct file_operations objects_fops = {
>         .open = open_objects,
>         .read = seq_read,
>         .llseek = seq_lseek,
> +       .release = seq_release,
>  };
>
>  static int __init kfence_debugfs_init(void)
> --
> 2.31.1
>
