Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1F597D94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiHREjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbiHREjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:39:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8F1647C5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:39:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w19so1097986ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yBqmSxAnRcpqm2zz2lw8eRpO4QXcSuMNWxiW1NaJjwA=;
        b=BCGfQPTgbND5UntMt01CBViwPYlvr3aykgQQ0zaAU4i0VCMB3wDiWH2BT8AUonyfa7
         gt+ERfvJajWt053YMCsAiu8Jwtr/sYkOqd4Ub15XKDd4SYUra0p8vtYrEsCBHfmVHaGO
         kwwlGR4GKbAtov7vWGXJH/EJYwWkDTwXsOITpV/sBQe0sQWW/EhZN+Xh8vBBsQi1i0+s
         bhbb8i6y2rHp/lzHyYSiwjxOfdgwRTdDmMg0K6KyAQjivGdhJ9KXzBOSdMv7Q46FNTqv
         WcCYFOj2Qy5W+v20sKIMCFRho1fM6Py6K1hjcTlmg4PuWZFNm1AS3YlQ/KZWFIa2FpwC
         RW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yBqmSxAnRcpqm2zz2lw8eRpO4QXcSuMNWxiW1NaJjwA=;
        b=F3vt6qZKG38HqIGRBBtXdaqRHjJsrzHAdx5i6jC1e59VPxdVjObxg2VGXgOu+DYdaW
         luoea8T7v6avYRlOBiqEn9E68j7wHhoFtseX94HU1ngfqH0Z2frYQjPysKnObFDA7U32
         8I+ZxLdHG8CvaSR33B+plJlDf7YMh05B8JMpKVcDivHcDTTcX89SmM7my79+MM/engYc
         dDplfEWA+cUaZPycGobPvZ7C+WdM/9xveRYegHYSx9BrsZJBlHtSjFwaUyF5UNsVpmrg
         B4YqtJyQTtUh9Z6tdDb8dW0LVdwZ1exYeRCQKbJV06+DoSIsWOlpJxlTTBIkvQWtMwwS
         1ewA==
X-Gm-Message-State: ACgBeo0aGmQFv5jVZLpdJhr8SDJAM7dMSdqkuJsM5Gud3o4CV7sdr3TM
        UV+h3aA9rzykBdbiM86kLQQ=
X-Google-Smtp-Source: AA6agR7PkllIscon00WWO9oLgUxoi5xF6WfCjFW4Kg2XhNdBhRf6w7M85RrfgJRwg/RWVhqoCPoWqw==
X-Received: by 2002:a17:907:6288:b0:72f:90ba:f0b2 with SMTP id nd8-20020a170907628800b0072f90baf0b2mr728137ejc.696.1660797539767;
        Wed, 17 Aug 2022 21:38:59 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b00718e4e64b7bsm244738ejx.79.2022.08.17.21.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 21:38:59 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmem: u-boot-env: fix crc32 casting type
Date:   Thu, 18 Aug 2022 06:38:37 +0200
Message-Id: <20220818043837.28698-1-zajec5@gmail.com>
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

This fixes:
drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment variables")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 9b9abfb8f187..fb993ef4249f 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -138,7 +138,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
 	}
-	crc32 = le32_to_cpu(*(uint32_t *)(buf + crc32_offset));
+	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
 	data_len = priv->mtd->size - data_offset;
 
-- 
2.34.1

