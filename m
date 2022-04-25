Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DA50E15D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbiDYNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDYNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:19:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA318371
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:16:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w16so8292186ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc/dEr5pwPMLhoa+YKleCXQFYWS2sX/902+8X3X7DqI=;
        b=VBGcSS5BAXuONpYWkt67xGVOtQbYl6w2EnQBsZkFutRb2kqi4IzrZc9kaHQs5Dk+Z9
         nqI4eHhDRTf8d0EX7rHCmEvIGuJNLCI55gbZaTcpId1oqofcqB6Np6l3vsd1lWkjj8wc
         5AexgDjRnfkWZ0XoEuIeJEvOHkGLw8WeqKocU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc/dEr5pwPMLhoa+YKleCXQFYWS2sX/902+8X3X7DqI=;
        b=kUJJD1vMbc82xTbVdyETxoIwf4CpVnSuXLkIl4luSGPzdNq8uCKxeZT5zw5yXxouVy
         1ErNtz8pStqZBxQNxGLQdEVdguK+hm7vopxNF2pulw/zioYkmFU9y/rK63goGxCDV+K9
         wM40DBh13LOZ2H9zFNcXvfnt+MKHg0+M/dZ+A6xL4GPY1qcJ/CMhiPTmsEowKdr3/8xG
         aO1aesTxKwW61Mit7JVISDCSFmX6vMf2R/0Ca3yqVBjwe+AJhiHjmQ8IwRvTk2g9ceie
         vHZ5nFeSPAe65fMRf4Ek2HST+0z09FeSjvlwmfpbhPWqYNitTHUzg5teX1LL91hKvo9B
         tMQw==
X-Gm-Message-State: AOAM533xC3UN6sYHZnWOVsEMDK1iGDqcwPAWBzWrb+YCb8EVh02RaG0n
        Zt2NPSqqTTtKUnWfERzmqQd+bJS8h+YPKgvgTF9OJg==
X-Google-Smtp-Source: ABdhPJwNzf9snapdCoGQnnUDVd4WNGEHAAkVfUD+kFSan3W2X/sl+nAPQNQ8wSzU1xYyrNWL3lBjB1yB+FwDgxrkJ3Q=
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr4626275ejc.524.1650892564570; Mon, 25
 Apr 2022 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegsbORd5hDhnth5qY1aP-6AZDMe9f9+CyWVhvpEmHPnuwQ@mail.gmail.com>
 <20220310111026.684924-1-wu-yan@tcl.com>
In-Reply-To: <20220310111026.684924-1-wu-yan@tcl.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 15:15:53 +0200
Message-ID: <CAJfpegvR1khmFbQ99EHguBTQqG8cPgnQHSyoxEi6brf=+-U7QQ@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH] fuse: avoid deadlock when write fuse inode
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
        guoweichao@oppo.com, Huang Jianan <huangjianan@oppo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, zhangshiming@oppo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 at 12:11, Rokudo Yan <wu-yan@tcl.com> wrote:
>
> Hi, Miklos
>
> The similar issue occurs in our Android device(4G RAM + 3G zram + 8 arm cores + kernel-4.14) too.
> Under the monkey test, kswapd and fuse daemon thread deadlocked when free pages is extreme low
> (less than 1/2 of the min watermark), the backtrace of the 2 threads is as follows. kswapd
> try to evict inode to free some memory(blocked at inode_wait_for_writeback), and fuse daemon thread
> handle the fuse inode write request, which is throttled when do direct reclaim in page allocation
> slow path(blocked at throttle_direct_reclaim). As the __GFP_FS is set, the thread is throttled until
> kswapd free enough pages until watermark ok(check allow_direct_reclaim), which cause the deadlock.
> Although the kernel version is 4.14, the same issue exists in the upstream kernel too.
>
> kswapd0         D 26485194.538158 157 1287917 23577482 0x1a20840 0x0 157 438599862461462
> <ffffff8beec866b4> __switch_to+0x134/0x150
> <ffffff8befb838cc> __schedule+0xd5c/0x1100
> <ffffff8befb83ce0> schedule+0x70/0x90
> <ffffff8befb849b4> bit_wait+0x14/0x54
> <ffffff8befb84350> __wait_on_bit+0x74/0xe0
> <ffffff8beeeae0b4> inode_wait_for_writeback+0xa0/0xe4

This is the one I don't understand.  Fuse inodes must never be dirty
on eviction for the reason stated in my previous reply:

> > I don't see how it can happen on upstream kernels, since there's a
> >"write_inode_now(inode, 1)" call in fuse_release() and nothing can
> > dirty the inode after the file has been released.

If you could trace the source of this dirtyness I think that would
explain this deadlock.

Thanks,
Miklos
