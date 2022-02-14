Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE86B4B5C74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiBNVSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:18:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiBNVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:18:17 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE1F137591
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:18:06 -0800 (PST)
Received: from epcas3p2.samsung.com (unknown [182.195.41.20])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220214211801epoutp0103a521b3b01a7263318424e716b22de9~Tw7eCaop52838128381epoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:18:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220214211801epoutp0103a521b3b01a7263318424e716b22de9~Tw7eCaop52838128381epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644873481;
        bh=kLg3y1C57MGd7CXzhXTwI+7lw2u17ZSVQ9SR0owpbzU=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=dBF2VOqNcZ4j2L+Ow/qQgKwqFiInlx3/E1am2ekyouxZMQUsOlERyRyJwmmjbQM7N
         Z6XP4ro9JYhmbItyrvvV6HypJm7+POAEPA9VQZ16hK5n12gxA0k9juEFY1Jsn/GzDw
         HHq4oIoI/Y8T/gU2NboNhpFS+oroYhMykLZiWXag=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20220214211801epcas3p453913a49631a117b8d2f4955cfe6cfb4~Tw7dcAUIH2286722867epcas3p4_;
        Mon, 14 Feb 2022 21:18:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4JyHBK1N72z4x9Pv; Mon, 14 Feb 2022 21:18:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: Fix divide zero case in ufshcd_map_queues()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01644873481638.JavaMail.epsvc@epcpadp4>
Date:   Mon, 14 Feb 2022 19:33:52 +0900
X-CMS-MailID: 20220214103352epcms2p79697c0fcaa2755dd89af9de887ff14cd
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220214103352epcms2p79697c0fcaa2755dd89af9de887ff14cd
References: <CGME20220214103352epcms2p79697c0fcaa2755dd89af9de887ff14cd@epcms2p7>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling blk_mq_map_queues(), the mq_map and nr_queues belonging
to "struct blk_mq_queue_map" must be a vaild value.

If nr_queues is set to 0, the system may encounter the "divide zero"
depending on the type of architecture.

    blk_mq_map_queues() -> queue_index()

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 41d85b69fa50..36c5ca62ae0c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2674,21 +2674,21 @@ static int ufshcd_map_queues(struct Scsi_Host *shost)
 	for (i = 0; i < shost->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
 
 		switch (i) {
 		case HCTX_TYPE_DEFAULT:
 		case HCTX_TYPE_POLL:
 			map->nr_queues = 1;
 			break;
 		case HCTX_TYPE_READ:
 			map->nr_queues = 0;
-			break;
+			continue;
 		default:
 			WARN_ON_ONCE(true);
 		}
 		map->queue_offset = 0;
 		ret = blk_mq_map_queues(map);
 		WARN_ON_ONCE(ret);
 	}
 
 	return 0;
 }
-- 
2.25.1
