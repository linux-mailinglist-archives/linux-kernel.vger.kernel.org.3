Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4F5314B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiEWQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbiEWQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:16:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D532EEB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:16:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220523161615euoutp0202f9261c4d8efa1b171bd3fea2298c21~xyB9wB50-1808118081euoutp02k
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:16:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220523161615euoutp0202f9261c4d8efa1b171bd3fea2298c21~xyB9wB50-1808118081euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653322575;
        bh=aLBSqS5uAesNMicTZHySwg8Swibu7HOYfUS7gR9bn94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7lHHDcnMiHGeh+Q+8z/MXZKknjJVpgVsRtdLQE4Nxm2DWJaInn0kZx11CyAKk9yO
         eaH5hMz9wMUsjETfoUO5Wr79yWkRrpdt8vxyLMwq2vAiGcYSPY7xbZHASug5xPWyM6
         MlGlBQMrI4tEs1on9cIkGnHBU2NZ/Y8T5nrEGG3A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220523161613eucas1p14eb4dfeeca85d1b74be3a853a80b3897~xyB8L9OR_1546315463eucas1p1V;
        Mon, 23 May 2022 16:16:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5E.7E.09887.D43BB826; Mon, 23
        May 2022 17:16:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220523161613eucas1p256b21b1a631324b4814465decf3958ce~xyB7qut2W0957009570eucas1p2d;
        Mon, 23 May 2022 16:16:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220523161613eusmtrp2c000f1ed1707206c2a22768a34db555b~xyB7p7UDg0219002190eusmtrp2W;
        Mon, 23 May 2022 16:16:13 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-28-628bb34de617
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.29.09404.D43BB826; Mon, 23
        May 2022 17:16:13 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220523161612eusmtip1e2e71268148d672b0c1860ca258f8832~xyB7VIab71408314083eusmtip1g;
        Mon, 23 May 2022 16:16:12 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
        damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v5 7/7] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Mon, 23 May 2022 18:16:01 +0200
Message-Id: <20220523161601.58078-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523161601.58078-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTZxzG895dr0dD2VkdfCPTbV2EUGfLnISTkQUiSy5biNPELJQYqXjD
        BqikBxsbcYPxU1z40f1sYWIYagGxlVal7dywCXaMMQhNJ2Vxm9puRFEghWFHhFFOM/97vu/z
        ed/n+yQvhct+E22mtLpSTq/TFMlJCXH5enhsR7bt5OHk1XEV03uzmWSWR8dw5uqDNhEz/rAK
        Y/yDDoz5rtOAMd29QxgTsJhw5tPBOYJ51Pg7xlyd2s54ne0k03E2KGYmW4KICZ2pETN1FxdR
        Bs2u/HieZL2jZWx/zwmStXV9zLr8lSTrqP1DxM5+7yPZJnsPYi12H8HaRirYUP9Wtn7wJPZ2
        tFqSfoQr0r7H6VWv50mOfj6sLjklKfff7yMqkZVqRFEU0LvggudvshFJKBltRtDg6UcRQ0Yv
        ILA/ekcwQgjC4yfET278YO1AgnEOgdvaKxKGaQRBc+vaQFEkrYCqyAUJtYmuQjA7dGodwuk2
        DPzLD0WRpzbS+2DVZVzPI+htYO+xExEtpXeDddxFCnHPg3FiaT06ik6DGz4fKTAbYNgYWOfx
        Nab6Uhsu8JYomP6pXNBZYKu+gQS9Ee567I8rPAerjg5M0BUQnFzGI8sBXYOg2WEhIw2Afg2a
        fi6KSJxOAotTJeCZ4HpQLRKIGJi8v0HYIAYMl7/ChWMpNNTJBFoOjnDgcSiA95N2QtAsmG6H
        xC3oRdNTXUxPdTH9n3sa4T0ojivjiws4fqeOe1/Ja4r5Ml2BMv9YcT9a+38jK56FAXTu7rzS
        jTAKuRFQuHyT9Iqm4bBMekTzwYec/tghfVkRx7tRPEXI46T5WqtGRhdoSrlCjivh9E9cjIra
        XIm9/KYiZfuvxtzW9B3/fnRgbvrL3IWKGpeXz7zzbsLSrYREtVuRZ+ja9kt+VyDTILXO8wOp
        Ru0/U4rjKYmS+j1xX8c7n51p6VZmJF/oMIYrC9Wcrzc7/G2TNnY4Y4Ev2TI298bwmUuhP70x
        5i9yEoN468061lnarTZnfTaAv1U/4Uu7PhqdoBqRFiPbxOR8knio0xx7b2tSVdZZi6TPc1sV
        2O1ul88V5i7vzJzNcXwTP5PdGchZ2vPM4L3UWdysO1S7K+/41C2V8wVzmu8vQ8506uJL3TV3
        9jtWF2ObiS0Ho/devOZPkXfWNV57dX9f+XllbWKh7eCV7AxxKHnvzMqBdDnBH9W8osD1vOY/
        s4Y9Ge4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7q+m7uTDN4cE7BYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLH423WPyWLvLW2Ly7vmsFnM
        X/aU3eLGhKeMFp+XtrBbtG38yugg4PHvxBo2j8tnSz02repk89i8pN5j980GNo+drfdZPd7v
        u8rm0bdlFaPH+i1XWTw2n672+LxJzqP9QDdTAE+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaUk1EF87gqbr5dy9LAuIGji5GTQ0LARGL/hvmM
        XYxcHEICSxklPv1qYINISEjcXtjECGELS/y51sUGUfSMUWLNi0PMXYwcHGwCWhKNnewgcRGB
        TkaJoytOsYA4zALLmSRuPGlhAukWFvCX2LfwPCuIzSKgKrFl1RYWEJtXwFJiw4XdUNvkJWZe
        +s4OYnMKWElcv3oVLC4EVHNq/QR2iHpBiZMzn4D1MgPVN2+dzTyBUWAWktQsJKkFjEyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAqN127GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHe7YkdSUK8
        KYmVValF+fFFpTmpxYcYTYHunsgsJZqcD0wXeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJ
        JanZqakFqUUwfUwcnFINTFMFpirMu1Une2/b55riPXOYGMrcpn+/Jf/G+op0mtjfZ6dV3N+n
        7F8bfGnhuX8pizmN1907Erz5/MKnC6//t1ji9OeMMdOhmCsr7h0VOHK+ccGErH9GT4vMF62d
        +XLya47cG+YnGlQtOQ9t9ViguKlU/aPGGo+pfaKx0TVH2f+Hvm7j+/zE5s9KsW6h5W5fJta/
        uC0cvVu7+k6t7XuD8FtuuifKNm48cGDatomeRxIub2PSmLGZlydD/01kQOv6xObfZVZz+y9K
        1mkcs6/uDM9v8Bb0nFkTaLhZbK3p1u8matyTt2sf2rHtkp7X69tuXf9uzd+Z+P+zoijTyuM7
        JzVfEmYMk+FTuMX09dneX6nHlFiKMxINtZiLihMBy1qFi18DAAA=
X-CMS-MailID: 20220523161613eucas1p256b21b1a631324b4814465decf3958ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220523161613eucas1p256b21b1a631324b4814465decf3958ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523161613eucas1p256b21b1a631324b4814465decf3958ce
References: <20220523161601.58078-1-p.raghav@samsung.com>
        <CGME20220523161613eucas1p256b21b1a631324b4814465decf3958ce@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Today dm-zoned relies on the assumption that you have a zone size
with a power of 2. Even though the block layer today enforces this
requirement, these devices do exist and so provide a stop-gap measure
to ensure these devices cannot be used by mistake

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zone.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 57daa86c19cf..f87a1eda8252 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	struct request_queue *q = md->queue;
 	unsigned int noio_flag;
 	int ret;
+	struct block_device *bdev = md->disk->part0;
+	sector_t zone_sectors;
+	char bname[BDEVNAME_SIZE];
+
+	zone_sectors = bdev_zone_sectors(bdev);
+
+	if (!is_power_of_2(zone_sectors)) {
+		DMWARN("%s: %s only power of two zone size supported",
+		       dm_device_name(md),
+		       bdevname(bdev, bname));
+		return -EINVAL;
+	}
 
 	/*
 	 * Check if something changed. If yes, cleanup the current resources
-- 
2.25.1

