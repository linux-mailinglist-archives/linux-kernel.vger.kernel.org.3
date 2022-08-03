Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD385889C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiHCJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiHCJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18728E1B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:15 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094813euoutp02ae8ed85f130ca1eed2f72c8014dea080~HzLuhj7K92007720077euoutp02t
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220803094813euoutp02ae8ed85f130ca1eed2f72c8014dea080~HzLuhj7K92007720077euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520093;
        bh=YUh2zeQE2RmUBXA7/4tWmxObmeVjkyPLOxi8ex3NZxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMw9zF1OjPwosTdt09H260Wpb9aFfbmmJqYCBGL6Pp296oxb4eaG4/MoTC7eBiIFd
         w0jWf1XGKUmSBhW+LpOfpkJAPwGB9C19+gVKR81r8T8LyXN3iBUgJJ8gBRA38udPfx
         DuhGA76zBCAkHg8cx2pV646ZXx7gFkBkou+36Rjg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094811eucas1p28cd48175b9feac0080f9be506dd1b5b5~HzLspo2by1532415324eucas1p2S;
        Wed,  3 Aug 2022 09:48:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 08.FF.09664.B544AE26; Wed,  3
        Aug 2022 10:48:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f~HzLsBClpH3109631096eucas1p18;
        Wed,  3 Aug 2022 09:48:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803094811eusmtrp1ba4f7f94f43e6937f2a29d964ceaf11c~HzLr5us1F2000320003eusmtrp1Y;
        Wed,  3 Aug 2022 09:48:11 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-8e-62ea445bc010
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.9B.09038.A544AE26; Wed,  3
        Aug 2022 10:48:11 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094810eusmtip2b837e592c0d57ed90af9168ead84a75c~HzLrkbg3V1623616236eusmtip29;
        Wed,  3 Aug 2022 09:48:10 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v9 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Wed,  3 Aug 2022 11:47:56 +0200
Message-Id: <20220803094801.177490-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7rRLq+SDM5+NrZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlXF8
        +hmWgr3cFX/nvmdtYFzH2cXIySEhYCKxc9cV1i5GLg4hgRWMEpvO72OHcL4wSix9vxjK+cwo
        8fT9RRaYlv0PH0G1LGeU2PtoEpTzklHi7OofQA4HB5uAlkRjJ1i3iEAzo8Tdvz1gRcwCB5gk
        Fr3+wQgySlggWGLqqx1MIA0sAqoSJ65EgoR5Bawkmg89Y4bYJi8x89J3dhCbU8BaYsq/f8wQ
        NYISJ2c+AbuIGaimeetsZpD5EgK7OSUe3z7LCNHsIvH14nGos4UlXh3fwg5hy0icntwDFa+W
        eHrjN1RzC6NE/871bCAHSQBt6zuTA2IyC2hKrN+lDxF1lOh94Qth8knceCsIcQGfxKRt05kh
        wrwSHW1CELOVJHb+fAK1U0LictMcqJ0eEltf3mWewKg4C8kvs5D8Mgth7QJG5lWM4qmlxbnp
        qcWGeanlesWJucWleel6yfm5mxiBCfH0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd47Ls+ThHhT
        EiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTC1mfEsnBhTnH89
        fv8xJ/Fd2dNmGMZa/BeYPePNh9rIRetjklqLFoUoGEXONFw84fj+BX2XFTQYQor2iMV/lu67
        FWsu7zjr5KLOdSI3Kl1L2QoXLK9wfqG00Wp13dqPKgpnkq8nz+WpvdhvKr+8711/GsOHOYUn
        nMRzkjkXqnHo2PxVzQmJP72N54HI/ovPFyYxrjcwi9z/t/FWQVp+u17xAnetl0F7NgonH/G+
        c+B0W2mgiOMVE2af7sbrLLNfT3C+r2t2JWD/gq9MMavPivrs+bF9SdlDX8/o3M7a9AV5732s
        phscru0Qy53fNMtPSdAzcEpX3W1eq/X8cWVuZjMOOYnJsm+JSVLcoXaYU4mlOCPRUIu5qDgR
        ALVI1Yn3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7rRLq+SDNZcZrRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F8+hmWgr3cFX/nvmdtYFzH2cXI
        ySEhYCKx/+EjVhBbSGApo8T1S5IQcQmJ2wubGCFsYYk/17rYuhi5gGqeM0osOvCduYuRg4NN
        QEuisZMdJC4i0M0ocfnMOVYQh1ngHJPE8+9dYN3CAoESy7dfZwFpYBFQlThxJRIkzCtgJdF8
        6BkzxAJ5iZmXvrOD2JwC1hJT/v1jhjjISmLd31msEPWCEidnPmEBsZmB6pu3zmaewCgwC0lq
        FpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGxu+3Yzy07GFe++qh3iJGJg/EQowQH
        s5II7x2X50lCvCmJlVWpRfnxRaU5qcWHGE2Bzp7ILCWanA9MHnkl8YZmBqaGJmaWBqaWZsZK
        4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUy8DglX0y5Os9431+SK32yn9srn2cviUpdsjzvU
        +Pm0pvmsys28b973PDlXf2V1bHqUiPOurFzhokVHlMq3RMSm9H97/HdRvVznunfmdcdqM+Zo
        qSZLPmqxPB951fb9ar+Lrz5YTl7w5NXkl4Hbiw6631adkyf+jlGJ42ez6DsfaS5BNY0ZiT88
        NXsNVjxjSH+YH7rpzwGV+yGx/YcLHZsiMqpqV5znuBx8aOpa9x0vf8i6zzz9lJ9vGV9J8DOd
        uQw3dOS27eovfJUT7SZyJmjT1wn7rgZvc/rbKBQZYLdx5zNbZe5vJQxbeW8mJWzea/2j7kPt
        wjXF4i1blRNj9zou0WXfWFjwbMs1jYe+Oz8qsRRnJBpqMRcVJwIARSsy8WYDAAA=
X-CMS-MailID: 20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

dm-zoned relies on the assumption that the zone size is a
power-of-2(po2) and the zone capacity is same as the zone size.

Ensure only po2 devices can be used as dm-zoned target until a native
non po2 support is added.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zoned-target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 95b132b52f33..9325bf5dee81 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = bdev_zone_sectors(bdev);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size is not a power-of-2 number of sectors";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones = bdev_nr_zones(bdev);
 		}
@@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 			return -EINVAL;
 		}
 		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
+		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
+			ti->error = "Zone size is not a power-of-2 number of sectors";
+			return -EINVAL;
+		}
 		zoned_dev->nr_zones = bdev_nr_zones(bdev);
 	}
 
-- 
2.25.1

