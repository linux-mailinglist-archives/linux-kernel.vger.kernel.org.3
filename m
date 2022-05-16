Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600985284D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiEPM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiEPM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:57:54 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A339682
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:57:53 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id bc42so7429336vkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8xDKjeA5vjhnmsZaoY94PaYuZJ/k/2yUmf/Dmij7ao=;
        b=IIAZ2Vr+cKp9N/hE450cPXfGMc4W6fTjUA8NYQM8OGAxXmIn1uHumxtB8a/sB6412j
         7sdniG4owzBih4e4mPYRlB3BXJ01DS3cwu+86vHTAJNTxcICEueQB4LSBWAXb4H9CYav
         /1AyHO5SDWCl65RbUtarwktsst7MJJfImV4wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8xDKjeA5vjhnmsZaoY94PaYuZJ/k/2yUmf/Dmij7ao=;
        b=WFw0ziTThAcGPkecnDxgqIIa2/FGrtGypg6PvI8zNiD0DINahqecu9JkEOj4zwPt9M
         MqunRJ5qMeTXEMaCkM6SfWZ1QJ9JKueD8BcmQc94GMfNN6JpMAOb9CpqAe0nqXDIsVZE
         JWIvVSYt/t8RfJsnYbxfJisJ7zSpZzW2WrjmXz2p0J/mm29kV9VZfjMhoI/iwAJlBmbD
         SCKUF0mrCv70Aak/U/pTSIKfgmMoB1CQdhlnz/RJWcucbvVuGNNBELVWuWgE9FDF3KY4
         Bs5qBeBMrxe0GBt6q9kg4027V7zBbU67itNsugisedAuf/IU7/Q8nsjEbyyjFCqE7Vj5
         ZSQw==
X-Gm-Message-State: AOAM532x3QRAvj9vG6fTKDMiu58e7YfIFuipQnauSiD0FcQsLb+ddjm/
        kXnVQjZdwuuevbh/tLJOUKOIMOHldwxFaGKqsd6apQ==
X-Google-Smtp-Source: ABdhPJzbR154HdykUqMlOSgdS61sMbReXdsrDnc05byBsyuvClGk3qSBPM5na8t5c/P9iHuHZlbfFJyxBc7kjWU87L4=
X-Received: by 2002:a05:6122:da8:b0:331:3b30:8b40 with SMTP id
 bc40-20020a0561220da800b003313b308b40mr5898585vkb.30.1652705872210; Mon, 16
 May 2022 05:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220516105100.1412740-1-hsinyi@chromium.org> <20220516105100.1412740-3-hsinyi@chromium.org>
 <CAJMQK-jjNRuZFOJrd2knQHwPERaJ64pyys+14cCVyfdsP1GZSQ@mail.gmail.com>
 <YoJFOpbMYSEOGfXy@casper.infradead.org> <CAJMQK-iDFJGHzmJQ0VZRXL-O8MBeqLFS-b0M-6bm3ncZ4TgMJQ@mail.gmail.com>
 <YoJJvabBCTJHryGm@casper.infradead.org>
In-Reply-To: <YoJJvabBCTJHryGm@casper.infradead.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 16 May 2022 20:57:26 +0800
Message-ID: <CAJMQK-hst=6NYehj8Bw5LsSv3bqWpQ9whOdrOKEOPWe4dVz_BA@mail.gmail.com>
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

On Mon, May 16, 2022 at 8:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, May 16, 2022 at 08:47:52PM +0800, Hsin-Yi Wang wrote:
> > On Mon, May 16, 2022 at 8:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, May 16, 2022 at 07:04:08PM +0800, Hsin-Yi Wang wrote:
> > > > > +       loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
> > > > > +       loff_t start = readahead_pos(ractl) &~ mask;
> > > > > +       size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> > > > > +       struct squashfs_page_actor *actor;
> > > > > +       unsigned int nr_pages = 0;
> > > > > +       struct page **pages;
> > > > > +       u64 block = 0;
> > > > > +       int bsize, res, i, index;
> > > > > +       int file_end = i_size_read(inode) >> msblk->block_log;
> > > > > +       unsigned int max_pages = 1UL << shift;
> > > > > +
> > > > > +       readahead_expand(ractl, start, (len | mask) + 1);
> > > > > +
> > > > > +       if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
> > > > > +           file_end == 0)
> > > > > +               return;
> > >
> > > What's the first half of this condition supposed to be checking for?
> > > It seems to be checking whether readahead_expand() shrunk the range
> > > covered by the ractl, but readahead_expand() never does that, so I'm
> > > confused why you're checking for it.
> >
> > hi Matthew,
> >
> > This is to check if readahead_expand() expands as much as it's requested.
> > I didn't encounter the mismatch so far in my testing. If this check is
> > not necessary, it can be removed.
>
> Then I think req_end is miscalculated?  It should surely be:
>
>         req_end = start + (len | mask) + 1;
>
> But I'm not sure that we should be failing under such circumstances.
> For example, we may have been asked to read 1.5MB, attempt to round up
> to 2MB, and fail.  But we can still submit a readahead for the first 1MB,
> before leaving the second 512kB for readpage to handle.
>
> So maybe we should just remove this check entirely.

I'll remove this in the next version.
