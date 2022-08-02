Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115F588177
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiHBR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiHBR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:58:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9251415
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:58:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p10so14610669wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZTeoa87dfvJFG/ev+WcWMi6pJYHv4C0u5fdzNHZAPI=;
        b=KFQxbUGkbdnNFcpFvYllrGe2i0Oqt50GRp+xE1pLOFLMhInNKQfn+3LZZGA/cGowMi
         t2EfJVFt5mxOPw7T0ZE8McatT2X2faWr9NAd7sR7tVZDPDPDpgL8WIs9cjr15H0gI9nf
         aeJziL/uxBJfcwY+IIY1wRxhP+Y07KO/IgsJzMMOVIPYCMR/G4k7QMyN3iaXmEoKPu0S
         5cEn2u8XF+bUkVehjle1MTjgz85hZf2O4nALxHMcgKsJ6MtDGbk5MBFTtbSq2xHYqd54
         Vnv5CGE4MQf/BO9OH4wRG1NGsgIrIk4LWRgt0/wLBER++g+wZm5dRt+XIMzf0V5ywZwf
         flPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZTeoa87dfvJFG/ev+WcWMi6pJYHv4C0u5fdzNHZAPI=;
        b=F1GWpaEl3NrwYbSXQeCx4q6lTtF1dOUeBBATs+kr6ZVM6XNjfIm8tU1Y0nCLoW+0vy
         jUoYnU/IXoZF46VoHEK5YLb3aBSKpNa+ssX409OaUjAHrRkkt3E1wMIhNjL8XkumGnzD
         EvcqzCaw8MCw2Zhe3Am/CjedxavR0tcAXN2hK8JQK9+f8/i69Jxu8qsJqJcI3rmOx4hL
         4puDxk/ey2xr1qJn9A4i5gmdG2gOrmQLfZ2k27OAu56kJiaya6pmw30yBgSL0kX1sHcX
         9PYMJgb6m3JIbZ7Vd2uBh2OwJIQ9OrknGdEVd1xuyOFVXBFkb2gC05MK/tDtHhXYpcH4
         /w+w==
X-Gm-Message-State: ACgBeo1V7RcIU76Jt8wMNPNNf5zLPiHDOi42B5FDImFJuQz/EAFTxfhz
        67SQmgmwINa1AxZgPbLOlyESaQ==
X-Google-Smtp-Source: AA6agR79yXvPO2icms6I7OLPLmvO8VuEh5kLencnb2xoh+3znDhpOEYXIDS0kCA0vjDXdTCpQd9ACw==
X-Received: by 2002:a05:6000:42:b0:21f:dc5:5ce0 with SMTP id k2-20020a056000004200b0021f0dc55ce0mr14429646wrx.12.1659463131961;
        Tue, 02 Aug 2022 10:58:51 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:51 -0700 (PDT)
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
Subject: [PATCH 05/11] spi: dw: define SPI_CTRLR0 register and its fields
Date:   Tue,  2 Aug 2022 18:57:49 +0100
Message-Id: <20220802175755.6530-6-sudip.mukherjee@sifive.com>
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

Synopsys SSI controllers supporting enhanced SPI mode of operation has
SPI Control Register at offset 0xf4 which controls the following:

CLK_STRETCH_EN: Enables clock stretching capability in SPI transfers.
In case of write, if the FIFO becomes empty DWC_ssi will stretch the
clock until FIFO has enough data to continue the transfer. In case of
read, if the receive FIFO becomes full DWC_ssi will stop the clock until
data has been read from the FIFO.

WAIT_CYCLES: Wait cycles in Dual/Quad/Octal mode between control frames
transmit and data reception.

INST_L: Dual/Quad/Octal mode instruction length in bits.

ADDR_L: defines Length of Address to be transmitted.

For now, we are only using 32bit Address length and 8 bit Instruction
length.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b8cc20e0deaa..a7a4637d6d32 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -63,6 +63,17 @@
 #define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_CS_OVERRIDE		0xf4
 
+/* Register offsets (Defined in DWC SSI 1.03a) */
+#define DW_HSSI_SPI_CTRLR0		0xf4
+
+/* Bit fields in SPI_CTRLR0 (Defined in DWC SSI 1.03a) */
+#define DW_HSSI_SPI_CTRLR0_CLK_STRETCH_EN	BIT(30)
+#define DW_HSSI_SPI_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
+#define DW_HSSI_SPI_CTRLR0_INST_L_MASK		GENMASK(9, 8)
+#define DW_HSSI_SPI_CTRLR0_INST_L8		0x2
+#define DW_HSSI_SPI_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
+#define DW_HSSI_SPI_CTRLR0_ADDR_L32		0x8
+
 /* Bit fields in CTRLR0 (DWC APB SSI) */
 #define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
 #define DW_PSSI_CTRLR0_DFS32_MASK		GENMASK(20, 16)
-- 
2.30.2

