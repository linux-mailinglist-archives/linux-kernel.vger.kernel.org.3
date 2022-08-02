Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414CC588174
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiHBR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbiHBR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:58:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854B9501A2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:58:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so14126935wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aw1T0LbIz46FjjhEEbnLK9sG6AnjTXA0RQTg3FMEtWM=;
        b=Ll4PnsHqjC5+Apl2W8TRgizSTL+qM2QieFGnFpMfahQhwmC8gZ/Kk8LM2I1Kc53PKK
         PEdle2T8rddCGvPtKyNMr+jtvzu6O8PICLizWGr66hyw4Qr3hNenamiKSwZKdNV9aUg2
         A/wQLuDOrowXD22RcDzolkucJsDFPQFaI9v+QkSOXx2I8hQXQUd6pB9qsA6vZy9v2yyy
         RYRyq2KzCZMdr0dSDzNzfxGvT0iL1p40OZCt9/k1GQsjyyDwXZCSYFRK8xdgKqurWJGp
         R6sOn0SdphcTQHt3uz8vHh/e+vaIVipucgnYy0XwGjaw24TJZtb50jxGxI4loltUZ1RI
         +CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aw1T0LbIz46FjjhEEbnLK9sG6AnjTXA0RQTg3FMEtWM=;
        b=PMeT12B8ZRmS2BluO6FL0mrYh+YOw2I87K+9pSUKfnt9QQz+AeuF72d277KQg6xWBg
         e4iWl0cRNSzH8LILb1CmSL/fXi6uyI0Y8ES7BpFl61T9j8+OEKXqPVDVd1vYrLUeha29
         YtWHBzE59o/dcZA/Q0RJ/yvBSrVfIDAqHMi0PAMxT3xKLFVFQqozbWqmpKq69lVAuilE
         F4L3vTru859NeAw5rNfDasUQ5y+mLjt+q+Yt1/aTN7rSTc4WKT7HRjOir1XAiOznoc69
         uUmq4UKgI261VJeqFBu4k+XbvoOvtf9C+UVdicwTJpDGE99VF5dM/yHaNzIt2zSBX/ec
         OUdg==
X-Gm-Message-State: ACgBeo2qaSlL2rjNcD+04Y/+ZQA4PMCTe4X5OphT5K6zHMGmBAPsEHL2
        StTiYsFRZ797xs2hi2oZVylvRg==
X-Google-Smtp-Source: AA6agR4sdG+OszyDwS/xWBJBhqDVwrVLMzLZwntiGrHw6bgHBiVdM59zNXn91whjJuu2BHpsFzgl7A==
X-Received: by 2002:adf:de05:0:b0:220:6c9e:5fd9 with SMTP id b5-20020adfde05000000b002206c9e5fd9mr3982511wrm.260.1659463124948;
        Tue, 02 Aug 2022 10:58:44 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:44 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 04/11] spi: dw: use TMOD_RO to read in enhanced spi modes
Date:   Tue,  2 Aug 2022 18:57:48 +0100
Message-Id: <20220802175755.6530-5-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are using the enhanced spi modes we can not use EEPROM Read.
The Synopsys datasheet mentions EEPROM Read is not applicable in
enhanced SPI modes. We will need to use Receive only mode.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 8c84a2e991b5..8e624620864f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -727,7 +727,10 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	cfg.dfs = 8;
 	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
 	if (op->data.dir == SPI_MEM_DATA_IN) {
-		cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
+		if (enhanced_spi)
+			cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
+		else
+			cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
 		cfg.ndf = op->data.nbytes;
 	} else {
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
-- 
2.30.2

