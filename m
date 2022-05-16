Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D0D528482
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiEPMsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiEPMsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:20 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68738BE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id q2so15377308vsr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPZL+h8jcnBW8PHWzi1Lq2sdX5BxnED0XWH1cfUGZUM=;
        b=DEZpbOgEvpT0/mw7g8WxEqnXML+QP8L1f8t8EVAx5s6EJcEal8pQJc72+LahAsseMq
         jxB1+F3/ufWv217kKKmVIIay1JoTF+vO0ReKEN4pFmokQ6DwS263F0437nEDO79rvDTg
         lLyLQLHmMI0I70TkS9sgr7H2lgaMMthSrfP3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPZL+h8jcnBW8PHWzi1Lq2sdX5BxnED0XWH1cfUGZUM=;
        b=AEsLh1krWx78Wl7oNF34LGZ33pqyxOwg8OiZZgGgmTznUd1n7coNcQ2YiHa/j6dJE8
         RylRWJlArr4Ii1Ud7vYlCNsr4NFid3mW/tb39qxav0/ugdc2nlzGYjVXXf+R5GexlmQs
         Jt9IJncZZPVaNht/OkH+Qsa8rc9nsw4fOzhzjNzx+xPUVfdfhwYG9hbcK7iC9o9ASEaI
         9yu9P3TiOzfZUPuH1EstiohSs3TNr05KfPVfsHofpM2w3Pq892P1V/1zuleT6MNBu7ox
         U4ee/QYo65th36MtYJWx5BeQefby7ELfLjri6NtbvUhsh9O+yC/XuREfh8ZrwKHWj3Kp
         OjXw==
X-Gm-Message-State: AOAM533nmYpS5AlEVsqF8FK0q3JY9PD4G+R/5BzQYz3GaBOZ2fPrHRBW
        6aMSkwIMRaI5GU+KX6kS8ieaKHHhR2e+J2xXxNSyQw==
X-Google-Smtp-Source: ABdhPJyFGR82c/fth2bgKdRpk7amgaoBeyp1CambTvVyEA4sPHZFBf0Us5CA+S0ti98tO7thswX8hquoKaAZAoNpccU=
X-Received: by 2002:a67:d999:0:b0:335:7e5c:63d5 with SMTP id
 u25-20020a67d999000000b003357e5c63d5mr4976709vsj.69.1652705298452; Mon, 16
 May 2022 05:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220516105100.1412740-1-hsinyi@chromium.org> <20220516105100.1412740-3-hsinyi@chromium.org>
 <CAJMQK-jjNRuZFOJrd2knQHwPERaJ64pyys+14cCVyfdsP1GZSQ@mail.gmail.com> <YoJFOpbMYSEOGfXy@casper.infradead.org>
In-Reply-To: <YoJFOpbMYSEOGfXy@casper.infradead.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 16 May 2022 20:47:52 +0800
Message-ID: <CAJMQK-iDFJGHzmJQ0VZRXL-O8MBeqLFS-b0M-6bm3ncZ4TgMJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] squashfs: implement readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
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
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 8:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, May 16, 2022 at 07:04:08PM +0800, Hsin-Yi Wang wrote:
> > > +       loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
> > > +       loff_t start = readahead_pos(ractl) &~ mask;
> > > +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> > > +       struct squashfs_page_actor *actor;
> > > +       unsigned int nr_pages = 0;
> > > +       struct page **pages;
> > > +       u64 block = 0;
> > > +       int bsize, res, i, index;
> > > +       int file_end = i_size_read(inode) >> msblk->block_log;
> > > +       unsigned int max_pages = 1UL << shift;
> > > +
> > > +       readahead_expand(ractl, start, (len | mask) + 1);
> > > +
> > > +       if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
> > > +           file_end == 0)
> > > +               return;
>
> What's the first half of this condition supposed to be checking for?
> It seems to be checking whether readahead_expand() shrunk the range
> covered by the ractl, but readahead_expand() never does that, so I'm
> confused why you're checking for it.

hi Matthew,

This is to check if readahead_expand() expands as much as it's requested.
I didn't encounter the mismatch so far in my testing. If this check is
not necessary, it can be removed.
