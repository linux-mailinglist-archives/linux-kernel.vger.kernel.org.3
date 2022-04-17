Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE370504903
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiDQSua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiDQSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:50:28 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Apr 2022 11:47:52 PDT
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29362DD50
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1240; q=dns/txt; s=iport;
  t=1650221272; x=1651430872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+BCSFgpwz16cUwJFvXpZTH9edfgHzKDaLBpIEMjSMEU=;
  b=eoTYQrpWmM5zmhycbomNSN219faboxZVDV6sjNLlh0V480O2ZgJe7idB
   9DVwILjZGpzYMT5QfmHeKyAPrK6vWWwRCJm5UOl1seJt0gfPKHKTI/Slb
   bvB6e4XXdNOhkPdbdLAzkMkOMj3pPE/Tw7XNyZLCXeS23M5UkWnxyCM7e
   A=;
X-IronPort-AV: E=Sophos;i="5.90,267,1643673600"; 
   d="scan'208";a="841891360"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 Apr 2022 18:46:50 +0000
Received: from sjc-ads-3421.cisco.com (sjc-ads-3421.cisco.com [171.68.249.119])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id 23HIkn0t008765;
        Sun, 17 Apr 2022 18:46:49 GMT
From:   Oleksandr Ocheretnyi <oocheret@cisco.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oocheret@cisco.com
Subject: [PATCH] mtd: fix 'part' field data corruption in mtd_info
Date:   Sun, 17 Apr 2022 11:46:47 -0700
Message-Id: <20220417184649.449289-1-oocheret@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 171.68.249.119, sjc-ads-3421.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
X-Spam-Status: No, score=-13.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 46b5889cc2c5 ("mtd: implement proper partition handling")
started using "mtd_get_master_ofs()" in mtd callbacks to determine
memory offsets by means of 'part' field from mtd_info, what previously
was smashed accessing 'master' field in the mtd_set_dev_defaults() method.
That provides wrong offset what causes hardware access errors.

Just make 'part', 'master' as separate fields, rather than using
union type to avoid 'part' data corruption when mtd_set_dev_defaults()
is called.

Fixes: 46b5889cc2c5 ("mtd: implement proper partition handling")
Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
---
 include/linux/mtd/mtd.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..8a2c60235ebb 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -394,10 +394,8 @@ struct mtd_info {
 	/* List of partitions attached to this MTD device */
 	struct list_head partitions;
 
-	union {
-		struct mtd_part part;
-		struct mtd_master master;
-	};
+	struct mtd_part part;
+	struct mtd_master master;
 };
 
 static inline struct mtd_info *mtd_get_master(struct mtd_info *mtd)
-- 
2.26.2.Cisco

