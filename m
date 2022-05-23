Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2C53136D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiEWQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiEWQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:16:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9920F63
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:16:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220523161611euoutp01dc7695105e7e75581ba5c6fa65388be6~xyB55ZxNv2128421284euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:16:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220523161611euoutp01dc7695105e7e75581ba5c6fa65388be6~xyB55ZxNv2128421284euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653322571;
        bh=9W1pLbbKKEsanlon70WFxiL7DVRrcoEEPxlxXdEW3tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+5dSK/d7b8Ph6xvXX8Q9EWPyzlu0EkiNlxa2nXL8c38PkTt5omi8GUyXEMibAPFe
         CISBDh+DsKGy6VMi0fkMfjFqZEnJtM6q56Sa5Ee4xSbg5j0mTGEluy+uZ6jHkS6DAO
         mCegylTPqTYKnGCQm12kKriPUdale5Hm4p3jmfLg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220523161609eucas1p27754a51739628374be85028f4954b683~xyB4VyB3q0957009570eucas1p2Z;
        Mon, 23 May 2022 16:16:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.A4.10009.943BB826; Mon, 23
        May 2022 17:16:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220523161609eucas1p16c381cd9438240905bfdb0a739132e65~xyB3z4X131867318673eucas1p1E;
        Mon, 23 May 2022 16:16:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220523161609eusmtrp2b6776808758c9ecadcc8ec5d2a7ac2a3~xyB3zBIlt0219002190eusmtrp2N;
        Mon, 23 May 2022 16:16:09 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-13-628bb3493b82
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.19.09404.943BB826; Mon, 23
        May 2022 17:16:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220523161608eusmtip23cd80bf73bf7fb5af10d44d04beb495e~xyB3eFHeK0812708127eusmtip2N;
        Mon, 23 May 2022 16:16:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
        damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 4/7] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Mon, 23 May 2022 18:15:58 +0200
Message-Id: <20220523161601.58078-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523161601.58078-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qem7uTDA73aVisvtvPZjHtw09m
        i99nzzNb7H03m9Xiwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxeJv1z0mi723tC0u
        75rDZjF/2VN2ixsTnjJafF7awm7RtvEro4Ogx+Ur3h7/Tqxh87h8ttRj06pONo/NS+o9dt9s
        YPPY2Xqf1eP9vqtsHn1bVjF6rN9ylcVj8+lqj8+b5DzaD3QzBfBGcdmkpOZklqUW6dslcGWc
        XGNZcJK/Yte5x+wNjPN4uxg5OSQETCQ+bPrB1sXIxSEksIJR4tGD/2wgCSGBL4wS3+bxQSQ+
        M0pcfzeJDaaj8eFdZojEckaJ75vWs0I4Lxgljl//w97FyMHBJqAl0djJDhIXEWhklHh/dB5Y
        EbPANyaJu/M2MYMUCQuESVy+nA4ylUVAVeLU4QfMIDavgKXE3BmPmCG2yUvMvPSdHcTmFLCS
        uH71KhtEjaDEyZlPWEBsZqCa5q2zwS6SENjOKdHwcztUs4vE8XuvGSFsYYlXx7ewQ9gyEv93
        zmeCsKslnt74DdXcwijRv3M9G8hxEgLWEn1nckBMZgFNifW79CHKHSVOvpzNBFHBJ3HjrSDE
        CXwSk7ZNZ4YI80p0tAlBVCtJ7Pz5BGqphMTlpjksELaHxJM1M1knMCrOQvLMLCTPzELYu4CR
        eRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgQjz97/inHYxzX33UO8TIxMF4iFGCg1lJ
        hHd7YkeSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqbF
        Hz4xp+ystG5mrZn7wnXNZqNfkVc3NbFJBt73ZtgwS//ga8kpj/NXn/JpbpUUf5Dx57rp+9om
        udnuXLd/LhBpnHzZKe/F4tc60x5IVdn+8Z820ZZ/26I6wTizstk+PnNer79+9NubL3aJ92Q2
        eR05JbLwVWmR6AfDYwFf3n14qvbo+1WLfn41qT+1xyuVsurMPliuLP3SKaMd+5+n4ljP8013
        qlcsbRFpirIPZTjK0v8pcvfrmW8eL1Go/ulxuGTmparNJ4UzxCLlPhzw+7b/2+LdzHoiH6Z3
        T/rbXrpn+dp9nFHMlp8PJT3kO+vZwfmkWsLYVC1KsGLZxGyPScqF7DPWNrxju9GkbMT/nGOC
        EktxRqKhFnNRcSIAuQmgVvcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7qem7uTDLoa2S1W3+1ns5j24Sez
        xe+z55kt9r6bzWpx4Ucjk8XNAzuZLPYsmsRksXL1USaLJ+tnMVv0HPjAYvG36x6Txd5b2haX
        d81hs5i/7Cm7xY0JTxktPi9tYbdo2/iV0UHQ4/IVb49/J9aweVw+W+qxaVUnm8fmJfUeu282
        sHnsbL3P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZAnij9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJOrrEsOMlfsevcY/YGxnm8XYyc
        HBICJhKND+8ydzFycQgJLGWUmHD2BCNEQkLi9sImKFtY4s+1LjYQW0jgGaPE4Wf5XYwcHGwC
        WhKNnewgvSICnYwSR1ecYgFxmAWamCXeT90D1iAsECJxePpHVhCbRUBV4tThB8wgNq+ApcTc
        GY+YIRbIS8y89J0dxOYUsJK4fvUq1DJLiVPrJ7BD1AtKnJz5hAXEZgaqb946m3kCo8AsJKlZ
        SFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbvtmM/t+xgXPnqo94hRiYOxkOMEhzM
        SiK82xM7koR4UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5H5g+8kriDc0MTA1NzCwNTC3NjJXE
        eT0LOhKFBNITS1KzU1MLUotg+pg4OKUamMRqY/aauLR+bci+4n6kZ3NGJKeO/vI5S/W85oX7
        s3l8u60cnb/TTmS2ROqKvayCp/b7TPasP/tvtb+r1c67y8+URZtxK53x3OKgEulkasukfPbr
        nTlW66ZPNS1f7X96P0vRxLfyNnINnq92ThFpz3PitDvWys7YKcT++1e7ibGPgtD+Zd/nRtT8
        ucJSlV+9TC9FQl1RfmP9F+trbtdmz5vjcHdmX6H0rNdxz5Qvvr+78qNdc4LHJvHv6XnC7fMl
        wpdr6D20jD0bovKN/UsZu6TMnPIU2zrxlwufvc3zk3nL9mn3btd/XKttdmXeCclf+0rhzGXV
        yKn/2m7d+Bh4956FXqzxnnafPdv89K8fV2Ipzkg01GIuKk4EACpvuzJnAwAA
X-CMS-MailID: 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65
References: <20220523161601.58078-1-p.raghav@samsung.com>
        <CGME20220523161609eucas1p16c381cd9438240905bfdb0a739132e65@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index e34718b09550..e41b6a6ef048 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -243,7 +243,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f5c7a41032ba..ed8742a72dcb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1382,6 +1382,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

