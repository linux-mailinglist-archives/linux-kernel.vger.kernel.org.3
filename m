Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF851F266
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiEIBbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiEIAee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:34:34 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042392DC9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:30:41 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.net.upcbroadband.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8DDC18209D;
        Mon,  9 May 2022 02:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652056239;
        bh=NOudDxdvb6caKhybL2UuE3gAFVOxP8ACs4W/GlDDIoE=;
        h=From:To:Cc:Subject:Date:From;
        b=PzkjOaKku6hrL29d9UyoXpsKFf+eWq84XIHpTlJZyqZOH/SuBRoPD+t5/dabDstv9
         IMuJUs5U9F9Wlrq5SGBctMNJdJgMEd36MHGvELVaOVENS+1ikweCRfwvIsU7SqTveA
         nxVS/LGpz4mLer8jCeSbetOtuf968+cMXWl91ifK3DhJcNtS39V6ety1YNB12CoBZH
         YDCjJOMp6KU5TXXIyDveYRE2vQhUDUs+lKt/UPqhdLe6jfowzksRXdFEVBOPKRst0c
         I8NgsTbZOF2KnrNWXpinz9Sk+blDUAeAVGp12EwYxr0GiF7rhRknFPaGmc+GYjLNQ/
         D+1T4uT8mcnSg==
From:   Marek Vasut <marex@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regmap: Add missing map->bus check
Date:   Mon,  9 May 2022 02:30:35 +0200
Message-Id: <20220509003035.225272-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The map->bus can be NULL here, add the missing NULL pointer check.

Fixes: d77e745613680 ("regmap: Add bulk read/write callbacks into regmap_config")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 879a87a6461be..2221d98638317 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1839,7 +1839,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				 map->format.reg_bytes +
 				 map->format.pad_bytes +
 				 val_len);
-	else if (map->bus->gather_write)
+	else if (map->bus && map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
-- 
2.35.1

