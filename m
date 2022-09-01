Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D695A89CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiIAA2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIAA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:28:28 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CB1037C1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:28:24 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220901002817epoutp02e30bfeb838066f27079d11fbc7f73d1a~QlQHUpMHT0728107281epoutp02G
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:28:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220901002817epoutp02e30bfeb838066f27079d11fbc7f73d1a~QlQHUpMHT0728107281epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661992097;
        bh=ArRzi/HQUaHkCfhJYBQkVmRhBXhrtrwh+XW/veC3mG4=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Mu2418+AQl2EMjglZvCrcgKgo0LYQDgMdiP6k3rGIJTtJVmuIxSAqTWFyZLr/XH/Q
         4E5cJqU3Unuy01Ud2c2w0tRsGea/zKHuahEVHqeDNXK4kiHRHz3Nx04hqMxiR5oIHO
         siXUqOFMQ7q6+TncOq8D1nktZ61YYy8VuQqYHDW4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220901002816epcas2p358e8e500eefb7d431c0d0956250b2b71~QlQGP9ezl0583105831epcas2p3T;
        Thu,  1 Sep 2022 00:28:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MJ22R6XG3z4x9Pt; Thu,  1 Sep
        2022 00:28:15 +0000 (GMT)
X-AuditID: b6c32a47-465ff70000003d30-5f-630ffc9f179c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.66.15664.F9CFF036; Thu,  1 Sep 2022 09:28:15 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] drivers/nvme/host: Fix namespace duplication check rule
Reply-To: sungup.moon@samsung.com
Sender: Sungup Moon <sungup.moon@samsung.com>
From:   Sungup Moon <sungup.moon@samsung.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sungup Moon <sungup.moon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p6>
Date:   Thu, 01 Sep 2022 09:28:15 +0900
X-CMS-MailID: 20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhe78P/zJBu+/GVn0b+lisfi/5xib
        xdSbWxkt5h96x2qxcvVRJovHk5qYLKYeVbeYdOgao8XlXXPYLOYve8puse71exaLi0e7WS3u
        fnrJatG97Q+jxdFDU9kd+D0mNr9j9zh/byOLx6ZVnWwem5fUe+y+2cDm0bdlFaPH501yAexR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        9sz+z1KwSrhixaUtLA2Mz/i7GDk5JARMJL7MmsrUxcjFISSwg1Hi75yzQA4HB6+AoMTfHcIg
        NcICHhIvgb4FsYUEFCX+PutjhIjrSqz5P4UZxGYT0Ja4d+Yt2BwRgT5Gib7v51lBHGaB9YwS
        ty4sY4bYxisxo/0pC4QtLbF9+VZGCFtD4seyXqgaUYmbq9+yw9jvj82HqhGRaL13FqpGUOLB
        z91QcUmJpyc/QMXzJdp+L2IDWSwh0MEocf7hESaIhLnEn5fXwYbyCvhKrL35AOwIFgFVia75
        a6EOcpE4fOEl2FBmAXmJ7W/nMINCgllAU2L9Ln0QU0JAWeLILRaICj6JjsN/2WHe2jHvCdQm
        VYmLE3rYYF5cOa+BEaLVQ+LeWSNIGAZKrJ3Rxj6BUWEWIqRnIVk7C2HtAkbmVYxiqQXFuemp
        xUYFxvDITc7P3cQITsFa7jsYZ7z9oHeIkYmD8RCjBAezkgjv93M8yUK8KYmVValF+fFFpTmp
        xYcYTYEensgsJZqcD8wCeSXxhiaWBiZmZobmRqYG5krivC7ajMlCAumJJanZqakFqUUwfUwc
        nFINTF1fH0/7sMliU+08rukO89g79rxWlF25ZNPaS04i2VafTOexum7JP1o5S8tPOMPib8bT
        4G+/NpromC04c+tLx9G+afOt3e3+rV5UrmX9tOFUesDRBetL7skHsbErzXxgeiFncl5j55ws
        Tn6dPIeALcvcHAQue1xOmGiU9KHlOvOjQ8+3rJCOK5mafXr5sr2as0Vebf1519Kt7EX62/rq
        sF3TLyaKlx/P6cyw/52lpfg6zch9o1Z+jcLy6EAvvspF2b+9jii2Hb/Cu/9Vo7TekmMR0xJz
        914w0Y3cFhfW+McuoOqJzx4ORvfEvKuBC7juV8y9/pzz0LHZ+cvDd3iev8Jz/TBjJft5tY8M
        YT1aq5RYijMSDbWYi4oTAdWYkmlKBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
sub-system because of the bit size of ID. Current kernel check the
all IDs should have unique value in a sub-system and globally.
However, if an namespace has duplicate IDs (not all) in a sub-system,
current kernel raise "duplicate IDs in subsystem for nsid" error. But
NVMe Specification defines the namespace unique identifier like this:

When creating a namespace, the controller shall indicate a globally
unique value in one or more of the following:
a) the EUI64 field;
b) the NGUID field; or
c) a Namespace Identification Descriptor with the Namespace Identifier
Type field set to 3h
(reference: 7.11 Unique Identifier; NVM Express 1.4c spec)

So, I suggest the modified nvme_subsys_check_duplicate_ids function
checking uniqueness from all IDS to one more IDs.

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..15f4071fce9d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3902,24 +3902,35 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 	return NULL;
 }
 
+#define IDS_EQUAL(A, B) (memcmp(&(A), &(B), sizeof(A)) == 0)
+
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		struct nvme_ns_ids *ids)
 {
 	bool has_uuid = !uuid_is_null(&ids->uuid);
 	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
 	bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
+	bool duplicated;
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
-			return -EINVAL;
-		if (has_nguid &&
-		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
-			return -EINVAL;
-		if (has_eui64 &&
-		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
+		duplicated = false;
+
+		if (has_uuid)
+			duplicated = duplicated &&
+				uuid_equal(&ids->uuid, &h->ids.uuid);
+
+		if (has_nguid)
+			duplicated = duplicated &&
+				IDS_EQUAL(ids->nguid, h->ids.nguid);
+
+		if (has_eui64)
+			duplicated = duplicated &&
+				IDS_EQUAL(ids->eui64, h->ids.eui64);
+
+		if (duplicated)
 			return -EINVAL;
 	}
 
-- 
2.34.1

