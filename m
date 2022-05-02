Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927D516D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384163AbiEBJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384177AbiEBJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:23:16 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEEF3BBEA;
        Mon,  2 May 2022 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651483186;
  x=1683019186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NeX9xgwCxAOelZqHBgSZs5bTcMxCCR6gaJ5rcDBAWXg=;
  b=QeP5ts13DKn5wi0OeWrUKQBmQlEr0vUP93tUN2WaGoj2U+1hKCYqv9Id
   wnY0yb6joxuxwHfidyKpEllAyfVPj2N+D4b7dcgqeszWW4XcUkyCVYLdP
   8JFf5dV5SAfiZlVz4J1b79HfKeOvOu9Cg8+nZlQFOqa82AFrR4bRjX6NM
   JWq15mx1y3GbS47jqnGwgI0D5pu3Q9hciLtAvHHykJ/FQ0Zzawf2TmGVJ
   0lCKr2zKNLmUsf/x8WoIbbZDlH8EHALlBgenMenUu+1kuAKD+ecA9Uts6
   cxL85EBZj2f7ilsaRfE8OFMs2yjljPy6PZIn1YIdPyUwofSLvpv4z8KTE
   Q==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     Camel Guo <camel.guo@axis.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: [PATCH v2] hwmon: (tmp401) Add of_match_table
Date:   Mon, 2 May 2022 11:19:42 +0200
Message-ID: <20220502091942.1083067-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tmp401 is built as kernel module, it won't be automatically loaded
even through there is a device node in the devicetree. e.g:
    i2c {
      #address-cells = <1>;
      #size-cells = <0>;

      sensor@4c {
        compatible = "ti,tmp401";
        reg = <0x4c>;
      };
    };
In order to make sure it is loaded automatically, this commit adds
of_match_table for tmp401.

Signed-off-by: Camel Guo <camel.guo@axis.com>
---

Notes:
    v2:
     - Put evidence and circumstances in commit message

 drivers/hwmon/tmp401.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index b86d9df7105d..52c9e7d3f2ae 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -708,10 +708,21 @@ static int tmp401_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id __maybe_unused tmp4xx_of_match[] = {
+	{ .compatible = "ti,tmp401", },
+	{ .compatible = "ti,tmp411", },
+	{ .compatible = "ti,tmp431", },
+	{ .compatible = "ti,tmp432", },
+	{ .compatible = "ti,tmp435", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tmp4xx_of_match);
+
 static struct i2c_driver tmp401_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "tmp401",
+		.of_match_table = of_match_ptr(tmp4xx_of_match),
 	},
 	.probe_new	= tmp401_probe,
 	.id_table	= tmp401_id,

base-commit: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
-- 
2.30.2

