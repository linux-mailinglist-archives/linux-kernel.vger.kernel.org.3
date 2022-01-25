Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB949BF33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiAYW6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiAYW6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:58:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDDEC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:58:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x7so59571362lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUEaRvAeqO4wB5ShFfH+VshVtU3ztYzAw/eGT2KcLXg=;
        b=emXX7F+vgI8KhnQH9o8EoWDuLk34WEtKEuctbuMWmeiFTDs04Yti6LC1oiu8hvoE0F
         6zHK6uDducjGcgdYBRTb/60kK0eZSzL099gOzXGM+UvZ2vcGKri/cniF0gpJYUVnWRea
         6dGK8DLP2OcCP90vFMP7G/3sSDZi7vsl0YXErQRmv4pNYTWuvtBLkg0s3XkX0t93bXLX
         1OF5dZjc6ezxkmX4OZJavqEQKMXuh+0Jok/FvIWwPv+o/Ck56Z/kEONKFEdFsr8xnxJ3
         6kjKUATDq6/IYyps70N9u/r+ZwJx3zo8OXiUl5ue0/cHQkVTBeKKA9HgNz4/nTD/6vmB
         uMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUEaRvAeqO4wB5ShFfH+VshVtU3ztYzAw/eGT2KcLXg=;
        b=38/doV7Gdp/ktMl7mcV4QDMdsNtgoUlq5TXWVC71fMvv1K5c2CHfjHSKF98nyD1uR/
         HJXez4pswiKc+YNwEyX28+7MtFXHNn7Qil/ff6ClW65tfMQdOVb0UF37P3OeYOE8IYTh
         xKi1smnoueo7Xl7PMRPqyAua9r6eVK4fUkW8xU+a1yYOnrSlFL8vUPcUzkmqQWGTq6ae
         h/uXwQjGo1jLW4Q3wa32jKshJk5+ZYQRqtqlmZQKEpX8eIyuiLoE+h6+To8akmQeaCjE
         3ZmoR2NA8yOzxXzzhiu7ZJReDft+eXZJu3HW5mhRVfKa14OYWt0t0er9zaz8NgD3FiwH
         YAPQ==
X-Gm-Message-State: AOAM531l367CXROLXrEaxeN5l6RqXLUN1hWnc/8oINhaMyK+5vZkD/7g
        d+KVxmnB8XmTWTFvkLOCCFtMMZwG4Oxqj+hPu+4pCw==
X-Google-Smtp-Source: ABdhPJzS7mt6iG3Pp05PQnOZLNNTR53sS7DB6BxYN+I6qmf5VodV069J0P5dkoLqwCzN7ToUVidHyehHCQRs1LfEyXA=
X-Received: by 2002:a05:6512:33d5:: with SMTP id d21mr18778383lfg.8.1643151483817;
 Tue, 25 Jan 2022 14:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20220125051736.2981459-1-shakeelb@google.com> <2bec4db-1533-2d39-77f9-bf613fc262d9@google.com>
In-Reply-To: <2bec4db-1533-2d39-77f9-bf613fc262d9@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jan 2022 14:57:52 -0800
Message-ID: <CALvZod5B_nQdU_MHmcYyOpHhGrv5YUnMY-rBPE11Tou6XU_mSA@mail.gmail.com>
Subject: Re: [PATCH] mm: io_uring: allow oom-killer from io_uring_setup
To:     David Rientjes <rientjes@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:35 AM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 24 Jan 2022, Shakeel Butt wrote:
>
> > On an overcommitted system which is running multiple workloads of
> > varying priorities, it is preferred to trigger an oom-killer to kill a
> > low priority workload than to let the high priority workload receiving
> > ENOMEMs. On our memory overcommitted systems, we are seeing a lot of
> > ENOMEMs instead of oom-kills because io_uring_setup callchain is using
> > __GFP_NORETRY gfp flag which avoids the oom-killer. Let's remove it and
> > allow the oom-killer to kill a lower priority job.
> >
>
> What is the size of the allocations that io_mem_alloc() is doing?
>
> If get_order(size) > PAGE_ALLOC_COSTLY_ORDER, then this will fail even
> without the __GFP_NORETRY.  To make the guarantee that workloads are not
> receiving ENOMEM, it seems like we'd need to guarantee that allocations
> going through io_mem_alloc() are sufficiently small.
>
> (And if we're really serious about it, then even something like a
> BUILD_BUG_ON().)
>

The test case provided to me for which the user was seeing ENOMEMs was
io_uring_setup() with 64 entries (nothing else).

If I understand rings_size() calculations correctly then the 0 order
allocation was requested in io_mem_alloc().

For order > PAGE_ALLOC_COSTLY_ORDER, maybe we can use
__GFP_RETRY_MAYFAIL. It will at least do more aggressive reclaim
though I think that is a separate discussion. For this issue, we are
seeing ENOMEMs even for order 0 allocations.
