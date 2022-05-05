Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4551C16F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380203AbiEENzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380278AbiEENzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:55:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD057B3A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:51:15 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135114euoutp01485591c70decf4eaf43d362549cb35b7~sOcNNTvWA3116431164euoutp013
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:51:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220505135114euoutp01485591c70decf4eaf43d362549cb35b7~sOcNNTvWA3116431164euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758674;
        bh=2XMubIyolz4ZLTc9DAEWfdq40b874mLFKF8nTtEYP/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0wnMNi6o6VpqVWeerR6H0o4DPAoZnjnpW4WdtH8WgqR2fuYbJdIzXE0ZwbJBNffm
         AXXjY54NSLxOLP/1YOBgGrwJKIh1NwvUSyN58Y6hV01sSLGE1TNmwlQsoJdt7g8kg/
         egWp6SEMujttwatGdcFud817L/dI6iq0xrP2HgTY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135112eucas1p1f5543b0d1b522e3f7a73821940c9d5ed~sOcLiaiOK1070010700eucas1p1J;
        Thu,  5 May 2022 13:51:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B3.0D.10009.056D3726; Thu,  5
        May 2022 14:51:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220505135111eucas1p218b79f4b1e54bb3a24d2ec189ec445d1~sOcKzFSGC0041400414eucas1p29;
        Thu,  5 May 2022 13:51:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220505135111eusmtrp131b2472d47e1950f5d2b04b938f6ee9e~sOcKyPmFR1310613106eusmtrp1j;
        Thu,  5 May 2022 13:51:11 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-52-6273d6501c0d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.6A.09404.F46D3726; Thu,  5
        May 2022 14:51:11 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135111eusmtip25f1e0efa88e3a562d73f5ea4b94fbc5f~sOcKeCtqw1486514865eusmtip2I;
        Thu,  5 May 2022 13:51:11 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Thu,  5 May 2022 15:47:11 +0200
Message-Id: <20220505134710.132630-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjlve/t7W23NtdK5jsomHXMBIxFXOPupjFua7K7OTOZP7ZpjLZw
        RTZaSSsbG2YpguVDtNXNbZbilA2krbNY+RDxo2syoK2Mhs7ZmoFA2mSSiWAxUt3YWi5m/jvP
        Oed5z3OSl4SSGV4aWazdx+q0qhIZIcS7+uK/rtryu169+nv/87TT1wdpx4iJoL+ZjkP68eAQ
        pK9MNfLowFwlRofdPRh9ufkYRtscv2B0xGmBdIN7Gqdt1eOQDl6yErTZ+ADSIXMU0LGWaj59
        NhzF6YFb6RslTPC3Tcz8wFmC6bGM8JngYBnjstcRzGnDccj0hg0J/uBtHnPv6g2COdJhB4yz
        4wbOXPBXMDFXJlPjPoRtEW8Tri9kS4o/ZXW5G3YJ9/QHA6D0a2G5L+gABtBK1gMBiSgFehhp
        hfVASEqoNoCMXXUgKUioWYAcVQpOiAHU1jCFPdkIDLUCTjgDkC8wRnDDHYACN9v49YAkCSoH
        Vdbxk3wqdQigwaq/8OQAKS+Gjs/d5yefWkptRe3nWxfycOol9M/syYUIEbUOtbkGCC5uOTox
        /HDBL0jw1rpxHudZgrwnIngSw4SnqrNxoQSifAJkjd6F3LISjVmnAIeXosn+Dj6Hpcj/VQPO
        4QoUDT1eXK4GyNTjJJIVUCLtyPWSJIRUNnJeyuXsryPbv8mbkw4xCt1dwp0gRse6voUcLUK1
        RgnnlqGeeGQxFKHgAetiKIP+cHlxM3jB8lQZy1NlLP/nngLQDpaxZXpNEavP07KfyfUqjb5M
        WyQv2KtxgcSv9M/3378ImiZn5B6AkcADEAllqaI3W0rVElGh6vMvWN3enbqyElbvAekkLlsm
        KihuV0moItU+9hOWLWV1T1SMFKQZsOpC93i23daQ/hP2seO9zj9blsvfNu0abfFl7m5Se1kI
        f6iQO38uqNr28oY3Tnf7j24SxF/k5/gnpBm9OyyvXM9dg10L7Xx2perdZ1Tnat95f2ssYr8w
        Qa3o3b4eqOdoZbhGUR5qDl48E8lakzVkeS31g/KP8o3GRqj98fyd6QPbXf0bHx0uOlj+XPt8
        YbplRpeS/0jPfDeckgJn80ynCtQec7M5T3rTMPrWuYyYR8EzN6XV3FsRGNXMbS6dGNl/q/bw
        rNSWJR7O7Bz5ku+e3C9eB1avNLPxvpOa+ssPlGutps0fZjBSRbgbxV/tO5o2VJl/W5kt8O7u
        HvtbeTU3ulaG6/eo8nKgTq/6D/qtA9EEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7r+14qTDJZd0rBYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS0u/Ghksrh5YCeTxZ5Fk5gsVq4+ymTxZP0sZoueAx9YLFa2PGS2
        uLxrDpvFhLavzBY3JjxltPi8tIXdYs3NpywWJ25JOwh5XL7i7fHvxBo2j52z7rJ7XD5b6rFp
        VSebx8KGqcweu282AMVb77N6vN93lc2jb8sqRo/1W66yeGw+Xe3xeZOcR/uBbqYAvig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOOXLzAWTOGq
        OHV5NWMD4zKOLkZODgkBE4kL55cxdjFycQgJLGWUmHL8FgtEQkLi9sImRghbWOLPtS42iKLn
        jBJ313QBJTg42AS0JBo72UHiIgJTGSUubL/AAuIwC1xlkri4eT8zSLewQKDE/t6jYJNYBFQl
        /n6ZxwRi8wpYS6zYdIINYoO8xMxL39lBbE6g+JzOh6wgtpCAlcTEh+/YIOoFJU7OfAJ2HTNQ
        ffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCutx37uWUH48pX
        H/UOMTJxMB5ilOBgVhLhdV5akCTEm5JYWZValB9fVJqTWnyI0RTo7onMUqLJ+cDEklcSb2hm
        YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwCTeXTNtRfn7G4HrZKYESNgq
        lfwIffq7W+bLx+q+Vw6+i1MnblA+mMJ9P/ey2tUD4a2z7v2WkFI7mNTHucvv7sXibbyNPYGc
        mh6y+rbHxHi11s5we5TbF/Xv4mSd4ukq6m+uaWZl8MTrBudlLVGQ/75dhoVTxFnjpOPvxXsq
        9T5yMnad7V407xJbu57ryisqK1h1tO8+uTNPaNPjx4wnpbQExWp2hjw6bOAWa6ylczy3Pi2k
        gynVqGvqq6oFm/jkenwtDsp1RS9SVTgYfWjhvYPWXL5PAlwWn2dSErsdIDh1dnxd0oZ4mZ1V
        PXVXTRTOBKn3TLr5rXVD9/ylBdPd5xfl7Pc96vtV0bJw2vsaJZbijERDLeai4kQAYjOhCXQD
        AAA=
X-CMS-MailID: 20220505135111eucas1p218b79f4b1e54bb3a24d2ec189ec445d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135111eucas1p218b79f4b1e54bb3a24d2ec189ec445d1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135111eucas1p218b79f4b1e54bb3a24d2ec189ec445d1
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135111eucas1p218b79f4b1e54bb3a24d2ec189ec445d1@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 3e7b1fe15..27dc4ddf2 100644
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
+		DMWARN("%s: %s only power of two zone size supported\n",
+		       dm_device_name(md),
+		       bdevname(bdev, bname));
+		return 1;
+	}
 
 	/*
 	 * Check if something changed. If yes, cleanup the current resources
-- 
2.25.1

