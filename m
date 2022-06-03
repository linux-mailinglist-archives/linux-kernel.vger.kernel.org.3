Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48553CBD3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiFCOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiFCOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:55:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24337BDC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:55:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq6so3408683ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jti+/hClusDdX5mEjQ70q82JHacK1xdb+tp2pVFM1n8=;
        b=Fd9xTBcSvNG6BRqet4SbqmnC1o3LYHcv4CmibDdJ8jlBhCN89cgV6tGGevXEhJtNOM
         2fmDmh7rlRG1bghvDHAveyYs6VAYgDIXgalaPpPAUrOFNuqUpIPeFs/oRlyMUJoDcSHX
         QpaFtonZHOmgcLiH8hJKm6wePMRLDdrliq3Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jti+/hClusDdX5mEjQ70q82JHacK1xdb+tp2pVFM1n8=;
        b=N8Hy8sEQHCOXqRJU2S0cOyRJpTp1sXaT5MYGPttBnwZvPH95lfqJcDY+6fGl/xTtc0
         0Isj6r1PB+y4eDkXE8mUQVpQR4he65wG98x+puZDIzvSTEilqElg9bq4xie+YJYHC9YW
         raUVqVzrJIWT1Wqo3dytIkS0xo4nQ309h3Z1gsgqJ5iKIIzK11RFNDxtp2QWnWfkdxpV
         jyAoBm/zLekfTeZ7rqTEEz0eBotnOeqBJX8fR11D4+kLGf2RS0v7/tKrsYW/ikMK18tW
         BkPtY3rroUiz1ZKYULxplFj72WHFved1LH38ZhVfyVmifP94UoYQNNKLcg3dLH+G/tE9
         KC7Q==
X-Gm-Message-State: AOAM532I+Xsatk3Zd8VGJJOJZZrkLY83qEDED333RUDKWIoO7Hx4r06E
        RwK0AyZ42+ST++EE3fjRNcQ0dVEqjR0RwCQCUH1hyg==
X-Google-Smtp-Source: ABdhPJxO8HK7gbiywtFok3ZbT24PxpO7hjRYRksLcHtuGaNcwI5NE2DPOLztaWmWayq8D4Inf84tbhgzpCYcD2wq8yw=
X-Received: by 2002:a17:906:1b19:b0:70d:6fe8:eb44 with SMTP id
 o25-20020a1709061b1900b0070d6fe8eb44mr4340593ejg.129.1654268126818; Fri, 03
 Jun 2022 07:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220601103922.1338320-1-hsinyi@chromium.org> <20220601103922.1338320-4-hsinyi@chromium.org>
 <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
 <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com> <YpoFnROxAwdSScuV@casper.infradead.org>
 <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com>
In-Reply-To: <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 Jun 2022 22:55:01 +0800
Message-ID: <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 10:10 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Matthew,
>
> On 03.06.2022 14:59, Matthew Wilcox wrote:
> > On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
> >> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
> >>> Implement readahead callback for squashfs. It will read datablocks
> >>> which cover pages in readahead request. For a few cases it will
> >>> not mark page as uptodate, including:
> >>> - file end is 0.
> >>> - zero filled blocks.
> >>> - current batch of pages isn't in the same datablock or not enough in a
> >>>     datablock.
> >>> - decompressor error.
> >>> Otherwise pages will be marked as uptodate. The unhandled pages will be
> >>> updated by readpage later.
> >>>
> >>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> >>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>> Reported-by: Matthew Wilcox <willy@infradead.org>
> >>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> >>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> >>> ---
> >> This patch landed recently in linux-next as commit 95f7a26191de
> >> ("squashfs: implement readahead"). I've noticed that it causes serious
> >> issues on my test systems (various ARM 32bit and 64bit based boards).
> >> The easiest way to observe is udev timeout 'waiting for /dev to be fully
> >> populated' and prolonged booting time. I'm using squashfs for deploying
> >> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
> >> top of the next-20220603 fixes the issue.
> > How large are these files?  Just a few kilobytes?
>
> Yes, they are small, most of them are smaller than 16KB, some about
> 128KB and a few about 256KB. I've sent a detailed list in private mail.
>

Hi Marek,

Are there any obvious squashfs errors in dmesg? Did you enable
CONFIG_SQUASHFS_FILE_DIRECT or CONFIG_SQUASHFS_FILE_CACHE?

Thanks

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
