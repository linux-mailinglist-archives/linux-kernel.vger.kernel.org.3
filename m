Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF956B005
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiGHBbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiGHBbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:31:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DB72EDB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:31:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2681VU1E033076;
        Thu, 7 Jul 2022 20:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657243890;
        bh=OPU/FEXF1OZ7e78AGxI45y2Hs2e8lTo+nO3wH3PsGX0=;
        h=From:To:CC:Subject:Date;
        b=NgNkGcIaYslilGN4cxX95HuLpUHX538oCWMvT+rft15HcX9UlnaEb4Eo8kKtKG/H9
         s+3or0tlJEZixAwK/wI4WwRz9OMsmMeG03xFsmSf9rljp9aeB3O8j2Pz8NCuKIJFQl
         5LN9xUuWMGJ6U9ydSDOe3BOdbknKcVfsmCQsRqkE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2681VUo9040305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 20:31:30 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 20:31:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 20:31:29 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2681VQfb045825;
        Thu, 7 Jul 2022 20:31:27 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <mranostay@ti.com>, Mark Brown <broonie@kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] regmap: add WARN_ONCE when invalid mask is provided to regmap_field_init()
Date:   Thu, 7 Jul 2022 18:31:25 -0700
Message-ID: <20220708013125.313892-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In regmap_field_init() when a invalid mask is provided it still
initializes with any warnings.

An example of this is when the LSB is greater than MSB a mask of zero
is produced.

WARN_ONCE() is not ideal for this but requires less changes to core regmap
code.

Cc: Mark Brown <broonie@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/base/regmap/regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4cf59e10d01b..0caa5690c560 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1298,6 +1298,9 @@ static void regmap_field_init(struct regmap_field *rm_field,
 	rm_field->reg = reg_field.reg;
 	rm_field->shift = reg_field.lsb;
 	rm_field->mask = GENMASK(reg_field.msb, reg_field.lsb);
+
+	WARN_ONCE(rm_field->mask == 0, "invalid empty mask defined\n");
+
 	rm_field->id_size = reg_field.id_size;
 	rm_field->id_offset = reg_field.id_offset;
 }
-- 
2.36.1

