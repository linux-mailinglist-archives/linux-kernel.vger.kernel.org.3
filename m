Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB14CF233
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiCGGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiCGGsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:48:55 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34021CFCD;
        Sun,  6 Mar 2022 22:48:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6QnIac_1646635677;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V6QnIac_1646635677)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 14:47:58 +0800
Message-ID: <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
Subject: Re: linux-next: build warning after merge of the vhost tree
Date:   Mon, 7 Mar 2022 14:46:40 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20220307154011.6d456f28@canb.auug.org.au>
In-Reply-To: <20220307154011.6d456f28@canb.auug.org.au>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 15:40:11 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the vhost tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
> drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
>  1823 |                    "reset rx reset vq fail: rx queue index: %ld err: %d\n",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long int
>       |                                                             %d
>  1824 |                    rq - vi->rq, err);
>       |                    ~~~~~~~~~~~
>       |                       |
>       |                       int
> drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
> drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
>  1873 |                    "reset tx reset vq fail: tx queue index: %ld err: %d\n",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long int
>       |                                                             %d
>  1874 |                    sq - vi->sq, err);
>       |                    ~~~~~~~~~~~
>       |                       |
>       |                       int
>
> Introduced by commit
>
>   920ee0c540a2 ("virtio_net: support rx/tx queue reset")
>


Can you help me test this patch? I don't have an arm environment around me.

Thanks


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1fa2d632a994..4d629d1ea894 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,

 err:
        netdev_err(vi->dev,
-                  "reset rx reset vq fail: rx queue index: %ld err: %d\n",
+                  "reset rx reset vq fail: rx queue index: %td err: %d\n",
                   rq - vi->rq, err);
        virtnet_napi_enable(rq->vq, &rq->napi);
        return err;
@@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,

 err:
        netdev_err(vi->dev,
-                  "reset tx reset vq fail: tx queue index: %ld err: %d\n",
+                  "reset tx reset vq fail: tx queue index: %td err: %d\n",
                   sq - vi->sq, err);
        virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
        return err;

> --
> Cheers,
> Stephen Rothwell
>
