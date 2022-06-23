Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C840558211
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiFWRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiFWRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:07:42 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED052E52;
        Thu, 23 Jun 2022 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=152u4q3NMpIj2Wsm3Qk7KzVbZsgV3dVUGwLtauzK8mM=; b=t7C5LRUUSlY4aK5FineuqobWBj
        IscnzFGg2xYa1BZrzHneaS8OtYzwbLzbmshMP6Q0nLbTnBFkxim26Vzy+6yYBGhIBi14T9ghnJxMA
        /Unqw+e74DS3OzM2WuIH6jfWswM4hY6gLHeiM5uKBGRv+3b28iMA8TMao8ZNlYHNOGYcHP+iP+uWJ
        OtuMQ3SpBUqBFlLpe5UC6VhTRANO2bmKoTjnR+GXmtNXKZfv3PxKoolErxspVOCczo0J+PQb+Andj
        FxQE6yNlqL20JxK50aEi3CTFwi35r2P0qh1aiK9idxmGimFlWJe35tdeOWCU8OTg7UXOCpG99mfPK
        wjEK/D/w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o4Q7d-00F4y1-05; Thu, 23 Jun 2022 10:56:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o4Q7b-000A46-5V; Thu, 23 Jun 2022 10:55:59 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        kernel test robot <lkp@intel.com>
Date:   Thu, 23 Jun 2022 10:55:52 -0600
Message-Id: <20220623165552.38645-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, logang@deltatee.com, lkp@intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] md/raid5: Fix divide type in raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day reports a build failure on the hexagon architecture:

  ld.lld: error: undefined symbol: __hexagon_udivdi3
     referenced by raid5.c
        md/raid5.o:(raid5_make_request) in archive drivers/built-in.a
     referenced by raid5.c
        md/raid5.o:(raid5_make_request) in archive drivers/built-in.a
     did you mean: __hexagon_udivsi3
        defined in: arch/hexagon/built-in.a(lib/udivsi3.o)

This is caused by using DIV_ROUND_UP on a sector_t type.

The actual value is known to be less than 256 so a wide 64bit divide
here is not desirable. Thus cast the argument to an int to ensure it
uses a 32bit divide.

Fixes: 681fb14a7100 ("md/raid5: Pivot raid5_make_request()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5723a497108a..9d25696b793d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6091,7 +6091,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	bi->bi_next = NULL;
 
 	bitmap_set(ctx.sectors_to_do, 0,
-		   DIV_ROUND_UP(ctx.last_sector - logical_sector,
+		   DIV_ROUND_UP((int)(ctx.last_sector - logical_sector),
 				RAID5_STRIPE_SECTORS(conf)));
 
 	pr_debug("raid456: %s, logical %llu to %llu\n", __func__,

base-commit: 57c19f921f8081c1a9444dc7f3f6b3ea43fe612e
-- 
2.30.2

