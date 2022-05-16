Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD24528282
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiEPKrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiEPKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:47:31 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2120FDFDE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:47:29 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id m203so7261091vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cyzBmAuy85hTG407fSwXszxBhDeY0JEI9Vsim/drlp0=;
        b=fYHp5Ibgf6MU75g8M8dbc1iSHzvS5K4/hMPc3yTsfMlxDqqNFVmGAcoDLdOXY1uZhe
         kxXLoaC7sVNiyhGnqUUD2FPW4gu/Yr0Y4tvBzGtbxoBJiAr0NwSXfatjNeQaTMUYNbCF
         u9IV+SW0L+bO2nvFYGIzQla+Mqp+mz/O9Wa8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyzBmAuy85hTG407fSwXszxBhDeY0JEI9Vsim/drlp0=;
        b=TIEs6c+zP0XHwN9mls6zSi+GHXRmnrW7ms36Ac2+ahzkVXlHu4X3abK+WACWvzJRrT
         o2uJlzBzG+ecGlBhFcR6q0az8fTpsKYaoleQUrUJWZZT9f8xdS/lJ2BmccurSnAikTVU
         wuk8gR6p6OkUZVm3zJF63DVy46Gt+cFdSF/XY3DCnJgtkROyffsjaYk5iqBQB1VXj54P
         QljpNYx/vJ6syv+iZRe/gF/Y9tDUM0Qi4BYvgARRnGC0BYH1QI8cEyEZ732gT6lqcrmV
         jeDUKB7b3vmGXBJSIXvie+bNzkdKqrv4dfgNjoBWi4uiJXDFPT4UyOzB8AFullRxrBR+
         XvVw==
X-Gm-Message-State: AOAM531VMomm8J+bZg/g2shRIHIwx3tWLk7bPE6QVxGvtr/aatDelehF
        HU2X2pID2OyqJ6OLat0d8Jp+0Oqz3dV2/xahNMft2w==
X-Google-Smtp-Source: ABdhPJw30mOuCBmzAFwBccM5ilcLCgr57LGu0Vj+MV2y0pvq4kJocvrhJbs9ahsylTcg8yw7LbLYezAiyeApW8mi718=
X-Received: by 2002:a05:6122:da8:b0:331:3b30:8b40 with SMTP id
 bc40-20020a0561220da800b003313b308b40mr5718489vkb.30.1652698048140; Mon, 16
 May 2022 03:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220516104209.1407388-1-hsinyi@chromium.org>
In-Reply-To: <20220516104209.1407388-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 16 May 2022 18:47:02 +0800
Message-ID: <CAJMQK-gT6H1BM0i+tLM1ORuf+Tz+GNSJUJdKZOjPYzVJX84u1A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement readahead for squashfs
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 6:42 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Commit c1f6925e1091("mm: put readahead pages in cache earlier") requires
> fs to implement readahead callback. Otherwise there will be a
> performance regression.
>
> Commit 9eec1d897139("squashfs: provide backing_dev_info in order to
> disable read-ahead") mitigates the performance drop issue for squashfs
> by closing readahead for it.
>
> This series implements readahead callback for squashfs. The previous
> discussion are in [1] and [2].
>
> [1] https://lore.kernel.org/all/CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com/T/
> [2] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m4af4473b94f98a4996cb11756b633a07e5e059d1
>
> Hsin-Yi Wang (3):
>   Revert "squashfs: Convert squashfs to read_folio"
>   Revert "squashfs: provide backing_dev_info in order to disable
>     read-ahead"
>   squashfs: implement readahead
>
>  fs/squashfs/file.c    | 82 +++++++++++++++++++++++++++++++++++++++++--
>  fs/squashfs/super.c   | 33 -----------------
>  fs/squashfs/symlink.c |  5 ++-
>  3 files changed, 81 insertions(+), 39 deletions(-)
>
> --
> 2.36.0.550.gb090851708-goog
>

hi, please ignore this for now. I'll resend a correct cover letter.
