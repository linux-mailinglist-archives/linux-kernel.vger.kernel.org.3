Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD7548300
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiFMJG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbiFMJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:06:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27560E0BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s1so6232808wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JoHUOEEsym0bbNaaz1gIS34DqInnU0CnHnvicjiK9AQ=;
        b=6kQzZ4JPNI1I1irKlJsrc9+BW15KaOe6Zi6SLEvPGOhprfzISc6QlKp7y+qfKHlk5l
         6Z8Qbkl8/8UxhLz00kdDrPL3UohxDrudbZ4eoOVTuCHbpkpFLQ3yNV+pXNTauj0/HN5W
         RcKRmMGUL1oRpR3bRoIzevUO7by1C+cE2GsK1wIr7qA6nPMs3pJXdPXcZhqg3Fb8bpyF
         MnrbfHJVj0LefQBiF6wr0J+MDByAUcfAxcvq59RUx4LR3vX3I4pyms57xdR4DWojEC+a
         6+Ql1225dOUhYy6DLT157E5BjJpPGxEdt502SZlMBZRbt/687HAhz4T8LLOo89uB/1ce
         rM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JoHUOEEsym0bbNaaz1gIS34DqInnU0CnHnvicjiK9AQ=;
        b=ycL/PKhgIMtHlzb00SitdKvg9Et7Th0nn+c2d24Np/6e+ekBlspLVNCF8VDi3EbzJx
         TF1GlutA998fr70tTR8o7tIdsFQDtoFPByiQdU2QOTfE9M4eGg6CHHcFb1xOP09QhNJW
         rzudgZZ21HfiTBdd8Cz7NGhJJhLOXF0kB2EZAb5StCgxK2wkwIdH7C1rWKiq/c5bepGV
         o0Pw1ZXxnNQob4jKTahEwLjAQvG2xUf8EAmHDpZcbvGXcT3F4D85gT0MB6kvQJonlEX3
         t8/CaCsRgbuv7TEJU5qxaYrxDLlAi9CTGmQsJOhmmP55mcxkstuwEf6gQ3rBk7xJEHMP
         iDzw==
X-Gm-Message-State: AOAM530sg6b2P6Q/9ruSxNtvKXZGVOQHUbxNtcHuiL69f4IY2LvbFGQ8
        6r7N6Pi90DhQXdmubOn36Dslaw==
X-Google-Smtp-Source: ABdhPJzCE7+VLrda3vF9q34zrbCuvdRMA6R7EZeyGpxNUcBog2S3yjIwFBI//VX8uuXacmoQXgwMOw==
X-Received: by 2002:a5d:4849:0:b0:218:3f35:5336 with SMTP id n9-20020a5d4849000000b002183f355336mr37656889wrs.26.1655111175751;
        Mon, 13 Jun 2022 02:06:15 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id d9-20020adffd89000000b002102d4ed579sm7806465wrr.39.2022.06.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:06:15 -0700 (PDT)
From:   Jerome NEANNE <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, will@kernel.org,
        lee.jones@linaro.org, jneanne@baylibre.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 4/5] arm64: Kconfig: Introduce CONFIG_MFD_TPS65219 and CONFIG_REGULATOR_TPS65219
Date:   Mon, 13 Jun 2022 11:06:03 +0200
Message-Id: <20220613090604.9975-5-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613090604.9975-1-jneanne@baylibre.com>
References: <20220613090604.9975-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a Kconfig option to support TPS65219 PMIC, MFD and Regulators

Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 08c6f769df9a..8d9b359a6663 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -609,6 +609,7 @@ CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
+CONFIG_MFD_TPS65219=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -634,6 +635,7 @@ CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_TPS65132=m
+CONFIG_REGULATOR_TPS65219=m
 CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
-- 
2.17.1

