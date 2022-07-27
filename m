Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24D582AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiG0QZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiG0QYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4117D4E612
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:23:14 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162257euoutp01baabbc0dd8393f978276dc4d5d9d6307~FvDYHZjUf2263722637euoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162257euoutp01baabbc0dd8393f978276dc4d5d9d6307~FvDYHZjUf2263722637euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938978;
        bh=bGWThfwHOEp7mmQTUw5C+8KJuKfjScM9cKVMnYcvmQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaE8EM7F1p2E3k7Z8pZ51CGfkGHdMmZhhqLQ59ZtNAhEyx10zRjOuzg1WlurCP7PY
         +QpBqFHdn3LdkvfD4og8GFZvrI4ApF5/r4EolKyxEN5800IpoHFUhvaQEEWxIzy9jC
         KrLMfpNXSviF267AC/KwzWvVkHEPR9cqHyycFbsA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162256eucas1p26353ef138695507e6f8643aeaede4e78~FvDWuiFFY2169421694eucas1p2t;
        Wed, 27 Jul 2022 16:22:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.C3.09664.06661E26; Wed, 27
        Jul 2022 17:22:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8~FvDWEgher2238722387eucas1p2k;
        Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220727162255eusmtrp1e5f37af38464571ccadbe3d2a13e71c3~FvDWDv6y10298902989eusmtrp1Q;
        Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-f3-62e16660d0c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.8D.09038.F5661E26; Wed, 27
        Jul 2022 17:22:55 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162255eusmtip25fb2b24fbcb9d0862c628cfdc10559a5~FvDVtuT4W2868528685eusmtip2J;
        Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v8 09/11] dm-table: allow non po2 zoned devices
Date:   Wed, 27 Jul 2022 18:22:43 +0200
Message-Id: <20220727162245.209794-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7oJaQ+TDA5/F7VYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8XnpS3sFmtuPmWxOHFL2kHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
        6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPFJdNSmpOZllqkb5dAlfGh8u8Be95KjqfT2Vp
        YJzP1cXIySEhYCJxYWcraxcjF4eQwApGiZ4zR9ggnC+MEh/fz2OEcD4zSjxpXMEI0zLh3Xom
        iMRyRonnj6+wQzjPGSU+b7gB1M/BwSagJdHYyQ7SICJQLPHwXSsLSA2zwCwmidPHHjODJIQF
        7CVaJu9hBbFZBFQlFizeDRbnFbCW2LtuEzvENnmJmZe+g9mcQPHNU+YxQdQISpyc+YQFxGYG
        qmneOpsZZIGEwGJOicWbp0Kd6iJxaGonK4QtLPHq+BaooTISpyf3sEDY1RJPb/yGam5hlOjf
        uR7sAwmgbX1nckBMZgFNifW79CHKHSWuHt/FAlHBJ3HjrSDECXwSk7ZNZ4YI80p0tAlBVCtJ
        7Pz5BGqphMTlpjlQSz0kvt6dyDiBUXEWkmdmIXlmFsLeBYzMqxjFU0uLc9NTiw3zUsv1ihNz
        i0vz0vWS83M3MQKT3+l/xz/tYJz76qPeIUYmDsZDjBIczEoivAnR95OEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MPks2n0tsC7irciUrgt7ZoeaN+3K
        eOAn1PEj8+fzo3zxMwWm6NcKau55pcGt/O0Gt2nt3sqv1p/ZmLIPRx2wkX3LeW6WtdhGgXN/
        i7nvOvzRmlW5+MTfmtmmIk1ye7kU3iXMe7BMPObkjJwVsxf07p/B8XRyzYKZzHkXpJ2ZLM6e
        8dviwB4wM+TvhttfS6yCxH3D2lY0H5u8cbVR3HXxQ97fCxqimK1+7GF+JLL66oVFSdt+3wtw
        Od/g6LOW8/Fm76qjIYWvi74YZijP8pWYs1OprT0g43XI2/JvLY9CZ2lHadh398n46wWmnJiw
        1Nb+ecvzfx6zEgKl5/sqBB12ubcwspIh3cGN++ych5/dXyuxFGckGmoxFxUnAgCDdvwC7QMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7rxaQ+TDGZd0LBYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8XnpS3sFmtuPmWxOHFL2kHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
        6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
        nqGxeayVkamSvp1NSmpOZllqkb5dgl7Gh8u8Be95KjqfT2VpYJzP1cXIySEhYCIx4d16pi5G
        Lg4hgaWMElc3/maHSEhI3F7YxAhhC0v8udbFBlH0lFHi8vUFQAkODjYBLYnGTnYQU0SgUuLs
        F1mQcmaBZUwSG07IgNjCAvYSLZP3sILYLAKqEgsW72YGsXkFrCX2rtsEtUpeYual72A2J1B8
        85R5TCC2kICVxLMHH9kg6gUlTs58wgIxX16ieets5gmMArOQpGYhSS1gZFrFKJJaWpybnlts
        pFecmFtcmpeul5yfu4kRGKPbjv3csoNx5auPeocYmTgYDzFKcDArifAmRN9PEuJNSaysSi3K
        jy8qzUktPsRoCnT3RGYp0eR8YJLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1I
        LYLpY+LglGpgcmV1lD9VWXhgVtkRNovX3F/lCg+Emn24dtmwvUo4e4fE+58LxbskVqnZzVaQ
        OWpcd8RR/KJUfOvPXR784hFHJLy2L1Ltc+vv9/r+WPr0jWhRGcON/B/efS5Y9XXxobcNOdqr
        GZl+rvJYaXvXlz+Fo9jj66WfVXxJZa+vXik5/3hLZ97RS+dOTWjQXfbB6tmpTa/mSpYns7qZ
        tGRsF9hy+N5xxTdv/LVeTj2Z2in778nz/YX529MWyxa4TF2xV5Nr9YXg7VO2Jp356icS0h9+
        P7FJTrA0d5n1rGc777PFOfjlPz8QM0vrlkqUxW/eV2x3BXlF10+fumC5cO3XmcVar+v+Lbyr
        ypa84+7Jw5JqUkosxRmJhlrMRcWJAGBR6RRaAwAA
X-CMS-MailID: 20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the block layer now supports non po2 zoned devices, allow dm to
support non po2 zoned device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b58252..534fddfc2b42 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_aligned(bdev, start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_aligned(bdev, len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
@@ -1642,8 +1642,8 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	/* Check zone size validity */
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1

