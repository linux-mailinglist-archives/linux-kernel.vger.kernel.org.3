Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA54D2900
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiCIGcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiCIGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:32:30 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF216203A;
        Tue,  8 Mar 2022 22:31:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V6hi7Gt_1646807489;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V6hi7Gt_1646807489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 14:31:30 +0800
Message-ID: <1646807409.605431-1-xuanzhuo@linux.alibaba.com>
Subject: Re: linux-next: build warning after merge of the vhost tree
Date:   Wed, 9 Mar 2022 14:30:09 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220307154011.6d456f28@canb.auug.org.au>
 <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
 <20220307211242.59fc0f0e@canb.auug.org.au>
 <20220307060012-mutt-send-email-mst@kernel.org>
 <20220309171300.0500a07e@canb.auug.org.au>
 <1646806544.818761-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1646806544.818761-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 14:15:44 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Wed, 9 Mar 2022 17:13:00 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Michael,
> >
> > On Mon, 7 Mar 2022 06:00:27 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > On Mon, Mar 07, 2022 at 09:12:42PM +1100, Stephen Rothwell wrote:
> > > >
> > > > On Mon, 7 Mar 2022 14:46:40 +0800 Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > Can you help me test this patch? I don't have an arm environment around me.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 1fa2d632a994..4d629d1ea894 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,
> > > > >
> > > > >  err:
> > > > >         netdev_err(vi->dev,
> > > > > -                  "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> > > > > +                  "reset rx reset vq fail: rx queue index: %td err: %d\n",
> > > > >                    rq - vi->rq, err);
> > > > >         virtnet_napi_enable(rq->vq, &rq->napi);
> > > > >         return err;
> > > > > @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,
> > > > >
> > > > >  err:
> > > > >         netdev_err(vi->dev,
> > > > > -                  "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> > > > > +                  "reset tx reset vq fail: tx queue index: %td err: %d\n",
> > > > >                    sq - vi->sq, err);
> > > > >         virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> > > > >         return err;
> > > >
> > > > I had to apply that by hand, but it does work.
> > > >
> > > > Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > >
> > > OK, I squashed this into the problematic patch. Thanks a lot!
> >
> > The warnings have reappeared today :-( and this fixup is not applied.
> > Something got lost in the rebase/rewrite?
>
> Sorry for that.
>
> The patch of the fix I submitted before was not merged locally. When the patch
> set of v7 was released yesterday, this fix patch was not included.

I see that Jason is reviewing, and when he completes the review, I will re-post
the patch set. And according to his meaning, it will be split into two patch
sets.

Thanks.


>
>
> > --
> > Cheers,
> > Stephen Rothwell
> >
