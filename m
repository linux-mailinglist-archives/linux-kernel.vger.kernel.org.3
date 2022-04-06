Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE44F66A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiDFRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiDFRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:10:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912B4929E6;
        Wed,  6 Apr 2022 07:32:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id by7so3549825ljb.0;
        Wed, 06 Apr 2022 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ua3fT8F2HjRCi9HSGNUFXUuRGoKDbKCgfZ5rZHjpyG0=;
        b=SQPNXmNiW4rebr/QZg8/x5gtfvrgJQwi5YSckBhzcsA/q6ij9L10+3V6bYO0oKcSWn
         aTl+Fipv6314CwOeTNLPN1Ahw8+BbB+dF50viZA/mueApGxw5UJLAU2VkT7k+o7NpZ5R
         gFhNS1UeW3tSQaOThQB7mcdx0Gnmf7uvLMphjBKBGJe4imShimFp/K/y16Z2c76Jb6K7
         EqKwrVND/culdATDDuHsi4ocl0VyJtd5YzydEyeRM+UcVNoOnLEn/hEjyBIIdlkMKI58
         9fIncOk22Bat/fwnxRSOJttm1x2rivvj614Yh7GYRYxWuxjCaGEv4VqBCPrhzRdIGgC0
         yvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ua3fT8F2HjRCi9HSGNUFXUuRGoKDbKCgfZ5rZHjpyG0=;
        b=mQrukOgZJYpNUE3KVZZm4kC5fzUf1eNR7hkeeUy36GtPmYg4fmgamdgCJLLzDhDbHT
         HR/C4RS8E4LfqgWHoWKu6UJ9Is0oQgD7U6Jvw3ALdDXRRFAGVBbmAjwq+avJMD+eWELY
         vd+aLvhjO47A3y1j7nmSYgfz7PUSkbBe0qiw3vRiqodM2EH8rpFn4O7i4HWYGjK2NPK/
         PGQVIFKGCvLWbAUm1MVklToYdeuObBAjSJW/9FXx7ok3gTlGbm0x+mrQQ6YVkIr/9xs4
         8X0Q2i+ZoJUn3lE+tkaVn0nWnJFmUBATYEMEztFnfyXG0d9c+R6A3vn2LqBND+RzPMkn
         4KDw==
X-Gm-Message-State: AOAM532H6RBDRkgqDrtsrrKd9D6vAryuelJns+4AwA7uvU1fk1G7QqbB
        lCT/So9NZCwUgmKDNOby6V0=
X-Google-Smtp-Source: ABdhPJwtAaDgzqgeqxymEWZuhij4m770G+5LX+N8/5brJHxkfnLHz1BnJ76uIcXGJs0etWJRH5e16A==
X-Received: by 2002:a2e:bc19:0:b0:249:b29c:7f5e with SMTP id b25-20020a2ebc19000000b00249b29c7f5emr5677249ljf.312.1649255552987;
        Wed, 06 Apr 2022 07:32:32 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s2-20020a197702000000b0044a693649b9sm1843857lfc.131.2022.04.06.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:32:32 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] mtd: call of_platform_populate() for MTD partitions
Date:   Wed,  6 Apr 2022 16:32:24 +0200
Message-Id: <20220406143225.28107-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Until this change MTD subsystem supported handling partitions only with
MTD partitions parsers. That's a specific / limited API designed around
partitions.

Some MTD partitions may however require different handling. They may
contain specific data that needs to be parsed and somehow extracted. For
that purpose MTD subsystem should allow binding of standard platform
drivers.

An example can be U-Boot (sub)partition with environment variables.
There exist a "u-boot,env" DT binding for MTD (sub)partition that
requires an NVMEM driver.

Ref: 5db1c2dbc04c ("dt-bindings: nvmem: add U-Boot environment variables binding")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdpart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 357661b62c94..9fce946fa69c 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include "mtdcore.h"
 
@@ -593,6 +594,7 @@ static int mtd_part_of_parse(struct mtd_info *master,
 			continue;
 		ret = mtd_part_do_parse(parser, master, pparts, NULL);
 		if (ret > 0) {
+			of_platform_populate(np, NULL, NULL, &master->dev);
 			of_node_put(np);
 			return ret;
 		}
@@ -600,6 +602,7 @@ static int mtd_part_of_parse(struct mtd_info *master,
 		if (ret < 0 && !err)
 			err = ret;
 	}
+	of_platform_populate(np, NULL, NULL, &master->dev);
 	of_node_put(np);
 
 	/*
-- 
2.34.1

