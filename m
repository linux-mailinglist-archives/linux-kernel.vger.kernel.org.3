Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE93516EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384682AbiEBLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379775AbiEBLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:17:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA04DE93;
        Mon,  2 May 2022 04:13:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t6so19179217wra.4;
        Mon, 02 May 2022 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=SC8skA+OBCO4ttnMU6A69mO02uNTXym35DLsl/48diU=;
        b=JTQTr1GnJeZgk06pN6GhaUb2czWsZHnh/AlHrbSZz19/kw5xmFBnm05PNJiBpsipKw
         WiPO8kbX3nazhOCZLjBYTRoSdC5iXl/YjAIxGxjexHt5VTWk21U5T7oQ+auduHMgFcJd
         yXT4Yt1+ssKjfnOtJuDrE4tOA0x1zSpqQAH4DhhN5SJurEMG7vQ9JrQmHEMbJlNeG1xy
         1GD/aklFtrnsasmbWmYey4hFJg446lYncvxLLK5pDP8rSMz8vZuvisuwWR98b1xsc4Qk
         rxOzCV2A5UVCHoL5E/UwbFSrgbOIo+7JLx+75cjBsGJ4jmQWVrsbDo3WjCUCxN++sId9
         wx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SC8skA+OBCO4ttnMU6A69mO02uNTXym35DLsl/48diU=;
        b=FjheUtmZGwH3HXmLsKGSmjltdcO6sXb2wGSLeapOHwzqugIIrVzMutrF2LvdnDCoUq
         qZ6um+wovnaXBGaEPadGDdmC08InREzalwagq5WFqPriU8XZHb7U/FNbuUtoRufYsLJT
         BegYd3NZOTFolvs6ihwjKBe6rb5bWlHwSkLdw55kga1oP7ORuUBHMHX4Nd3W2SCBW8IS
         lTRviPLBQW6Jva/M4rsHovYeBhEzlHtuQmE72Z/FnS/zL8zkyBUMbya62u0T2oZ9O3Vr
         Ei7y6An3Re/PuWaq5tW9rcaBANm3imUrYrp8dyU/QnQhUd8HsCACI83GjUGh5PLxyM5o
         EW8A==
X-Gm-Message-State: AOAM530B9JVv6OgCAcuoTp1zP3TsdcBp8BJUdFcYXfRzVm0pF9/6UVaq
        EgOZtTODfPe4hr1u1AaBJrKfATwQI34=
X-Google-Smtp-Source: ABdhPJwAZjweYGcKXuo+OPnc4VEy9KNTspk7hnk96q2DV2S8nKCINtxuBB5vrZYuZtadYwOzOTolVA==
X-Received: by 2002:adf:e10a:0:b0:20a:86a3:d06f with SMTP id t10-20020adfe10a000000b0020a86a3d06fmr9415372wrz.249.1651490011107;
        Mon, 02 May 2022 04:13:31 -0700 (PDT)
Received: from localhost.localdomain ([213.215.174.110])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa70b000000b0020c5253d90esm9082836wrd.90.2022.05.02.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 04:13:30 -0700 (PDT)
From:   Andrea Zanotti <andreazanottifo@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Zanotti <andreazanottifo@gmail.com>
Subject: [PATCH] spi: omap2-mcspi: add support for interword delay
Date:   Mon,  2 May 2022 13:13:00 +0200
Message-Id: <20220502111300.24754-1-andreazanottifo@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module omap2-mcspi does not support the interword delay
parameter present in the spi transfer. On one side, if the module
is instructed to use the dma, this parameter is correctly ignored.
However, without the usage of the dma, that parameter should be
used.

The patch introduce the handling of such delay in the omap2-mcspi
module, using standard spi_delay struct. The patch has been tested
using as benchmark a DM3730.

The delay function used (spi_delay_exec) is already present in the
kernel and it checks on its own the validity of the input, as such,
no additional checks are present.

The range of usage of the udelay function is incremented to 200 us,
as the change from udelay to usleep_range introduces not
neglectible delays.

Signed-off-by: Andrea Zanotti <andreazanottifo@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 6 ++++++
 drivers/spi/spi.c             | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d4c9510af393..a79934be7037 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -758,6 +758,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %02x\n",
 						word_len, *(rx - 1));
 			}
+			/* Add word delay between each word */
+			spi_delay_exec(&xfer->word_delay, xfer);
 		} while (c);
 	} else if (word_len <= 16) {
 		u16		*rx;
@@ -805,6 +807,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
 			}
+			/* Add word delay between each word */
+			spi_delay_exec(&xfer->word_delay, xfer);
 		} while (c >= 2);
 	} else if (word_len <= 32) {
 		u32		*rx;
@@ -852,6 +856,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %08x\n",
 						word_len, *(rx - 1));
 			}
+			/* Add word delay between each word */
+			spi_delay_exec(&xfer->word_delay, xfer);
 		} while (c >= 4);
 	}
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 419de3d40481..5fa36c469ba0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1143,7 +1143,7 @@ static void _spi_transfer_delay_ns(u32 ns)
 	} else {
 		u32 us = DIV_ROUND_UP(ns, 1000);
 
-		if (us <= 10)
+		if (us <= 200)
 			udelay(us);
 		else
 			usleep_range(us, us + DIV_ROUND_UP(us, 10));
-- 
2.17.1

