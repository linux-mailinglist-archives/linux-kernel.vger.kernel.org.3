Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF8A549B00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbiFMSDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242686AbiFMSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:01:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BFA3FBF4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:46:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me5so11327244ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oz0TSHV6YibOu6tc/5orXXjHQ8MbMxUcncoqA4aXgsw=;
        b=n7JdFwECnhhUL1dLeSQ//ZJYsNONYjH51NPj+wkg/wrQ7bvBJRdyt8UrWsFim/C61O
         96YUEqosV7TbGGXls0LrpNdpOaQskhlQoQYSw57/cTyQQorCQ/k9zYzof7BpsCqKfBU3
         g5ZXP/ZXGEK+WCUOTl7e3G7UtklbBZIWme6Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oz0TSHV6YibOu6tc/5orXXjHQ8MbMxUcncoqA4aXgsw=;
        b=GKhiUyNK4hhQCAKrIjrkkZebmUSAs1javBNYgFTD5V+CJEM/cLQf0lymFhSTqNCadH
         7jOXypn1baV/jM3qomkfLr9jmoc7Gx7TkD7G7UPjdw5BV7fc8k0eaAG6oOJNMMRlqqeJ
         grKhmJ0+mbYh8eozJTJ0zgjpGgugWFjGDPv4mGQFU27LrIMTycvW3h5uP6OmSYxx5ob1
         QdqHPk+wTrhqzbfCoqI5GZJXNQUgmCDppLsCu4FW0oOScTl0Iwfj2oQXOlVO0EA7D9zW
         20NqU2BFRQQDFP243qd3LCMp0zb5rg1LRa11Gq89uxNA1kAZ/FAIi6sZ6OmUNz8Yqaus
         fXIg==
X-Gm-Message-State: AOAM531Ake/M2/d/uRquYzE8sltgJ1JucbynSX/d4wCZubwxlveqf6S/
        kIYmVcJNoOb+ylGZxERnqYJRqRYNKPdQfRNuv5ba9g==
X-Google-Smtp-Source: ABdhPJyvmkSgw072UHRnxND0KgUWRAzqc9nZk+izs23tKS/t6KazemOaZFtDajiE/juzKvXO8q+b2oLKjsmpxv6p55s=
X-Received: by 2002:a17:906:c347:b0:718:ca61:e7b7 with SMTP id
 ci7-20020a170906c34700b00718ca61e7b7mr3050168ejb.746.1655127959979; Mon, 13
 Jun 2022 06:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601103922.1338320-1-hsinyi@chromium.org> <20220601103922.1338320-4-hsinyi@chromium.org>
 <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
 <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com> <31ed17e7-29d1-55e8-cb09-a750ab80da15@squashfs.org.uk>
 <701bee9a-a06d-8b1a-bf23-d893249c7764@samsung.com>
In-Reply-To: <701bee9a-a06d-8b1a-bf23-d893249c7764@samsung.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 13 Jun 2022 21:45:34 +0800
Message-ID: <CAJMQK-hVT=TcVfsbhUiqxcTBz3ZrX=B7yBPbuc2=MD6i7iGkAw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 8:08 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Phillip,
>
> On 07.06.2022 09:35, Phillip Lougher wrote:
> > On 03/06/2022 13:54, Marek Szyprowski wrote:
> >> Hi,
> >>
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
> >>
> >> This patch landed recently in linux-next as commit 95f7a26191de
> >> ("squashfs: implement readahead"). I've noticed that it causes serious
> >> issues on my test systems (various ARM 32bit and 64bit based boards).
> >> The easiest way to observe is udev timeout 'waiting for /dev to be fully
> >> populated' and prolonged booting time. I'm using squashfs for deploying
> >> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
> >> top of the next-20220603 fixes the issue.
> >>
> >> Let me know how I can help debugging this issue. There is no hurry
> >> though, because the next week I will be on holidays.
> >
> > Hi Marek,
> >
> > Can you supply an example Squashfs filesystem and script that
> > reproduces the slow-down?  Failing that, can you supply a copy
> > of your initrd/root-filesystem that can be run under emulation
> > to reproduce the issue? (I don't have any modern ARM embedded
> > systems).
> >
> > Again failing that, are you happy to test some debug code?
> >
> > Thanks
> >
> > Phillip (Squashfs maintainer and author).
>
> I've just got back from my holidays.
>
> Is this still relevant? I've noticed that v6 has been posted, but I
> failed to apply it on top of next-20220610 as mentioned in the
> cover-letter to test. I've also tried also to apply the mentioned
> 'Squashfs: handle missing pages decompressing into page cache' patchset.
> On the other hand, next-20220610 seems to be working fine on my setup now.
>

hi Marek,

next-20220610 contains v5 of the series. To apply v6, you need to
revert ca1505bf4805 ("squashfs: implement readahead") and 9d58b94aa73a
("squashfs: always build "file direct" version of page actor") first,
then apply  'Squashfs: handle missing pages decompressing into page
cache' patchset, then finally apply v6, since v6 is dependent on the
patchset.

Thanks.

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
