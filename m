Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22A47A9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhLTMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLTMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:50:05 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F50C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:50:05 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id s1so6039002vks.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mebw+t+6AZGZkXmp7vDvG7ApJYeVNYn7Za2C9wEefaI=;
        b=keM546ZVFFY7h+ySf8UPE/BR4WPf6nIR/oud8lzcFMmsUIRn/5xDfjXOKshw/TvhjS
         gOdGtopoEPiz83D+JA9aRr5js22m+Od50s37c3zjkulqv8xF0zznlVyzFpyB3+hJgRlQ
         HHNj2qzinTd0e6RP6cM/DvqaSZo5pbWSgiClw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mebw+t+6AZGZkXmp7vDvG7ApJYeVNYn7Za2C9wEefaI=;
        b=M53OlCqwFZk/w54D8k3VjnJlfJuleEpsmlSP4OTFRx/FG7sCn56TXgXkVwokloxSbl
         ebVJsMnJ4mS+y7Mn0ABI4TXBszzvmlKsnDCUnDJw/uNCVUbodrR5fSowCbicwRba+zPY
         AWhEmcoFnGlI8AxiVfQTU6XstFGE2ZXie4SVHwP61ZZsRRJjSTfZRV92L6B9uU0YDbqK
         9eWzDo7TBWizddzwo0WIEGwm+soeyDM6FndJWFwlC+lBMeWrckdmABFIU/+5zpunxU/T
         6DXr067vrg3bTICfmEzcKGCDuTJbS/x7M/CdurYDzS7/uDi+GF9MXXA9kKq9/t5mlub6
         4/+A==
X-Gm-Message-State: AOAM533CevhpkXvUXsVclrRg0OskMBUStfrsn9FT2i20NK3wECH3gjaV
        7/GnFzzEGNTKxaOnfImKpqBXqTZjwAz+gAgrVYpuzA==
X-Google-Smtp-Source: ABdhPJxLi7dYvgVXTw3RKjMCy6zDRgzU5qsr8lQryPwB1pb3R1jBRbvjqe/N/HUAouhiNhYAaHVuoEFdX4st1ZpxUOA=
X-Received: by 2002:a1f:52c7:: with SMTP id g190mr5544848vkb.1.1640004604088;
 Mon, 20 Dec 2021 04:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20211216144558.63931-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20211216144558.63931-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Dec 2021 13:49:53 +0100
Message-ID: <CAJfpegvQCmBOD4XDncijGaFDgrmKhtWK1-h28VCUELPXdgw0JQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix deadlock between O_TRUNC open() and non-O_TRUNC open()
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 at 15:46, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> fuse_finish_open() will be called with FUSE_NOWRITE set in case of atomic
> O_TRUNC open(), so commit 76224355db75 ("fuse: truncate pagecache on
> atomic_o_trunc") replaced invalidate_inode_pages2() by truncate_pagecache()
> in such a case to avoid the A-A deadlock. However, we found another A-B-B-A
> deadlock related to the case above, which will cause the xfstests
> generic/464 testcase hung in our virtio-fs test environment.
>
> Consider two processes concurrently open one same file, one with O_TRUNC
> and another without O_TRUNC. The deadlock case is described below, if
> open(O_TRUNC) is already set_nowrite(acquired A), and is trying to lock
> a page (acquiring B), open() could have held the page lock (acquired B),
> and waiting on the page writeback (acquiring A). This would lead to
> deadlocks.
>
> This commit tries to fix it by locking inode in fuse_open_common() even
> if O_TRUNC is not set. This introduces a lock C to protect the area with
> A-B-B-A the deadlock rick.

Okay.

One problem is that this seems to affect a number of other calls to
invalidate_inode_pages2(), specifically those without lock_inode()
protection:

- dmap_writeback_invalidate()
- fuse_file_mmap()
- fuse_change_attributes()
- fuse_reverse_inval_inode()

fuse_change_attributes() is especially problematic because it can be
called with or without the inode lock.

The other issue is that locking the inode may impact performance and
doing it unconditionally for all opens seems excessive.

If there are no better ideas, then the brute force fix is to introduce
another lock (since the inode lock cannot always be used) to protect
fuse_set_nowrite()/fuse_clear_nowrite() racing with
invalidate_inode_pages2().

Thoughts?

Thanks,
Miklos
