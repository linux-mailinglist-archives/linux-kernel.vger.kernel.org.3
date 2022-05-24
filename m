Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F55532BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiEXOHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiEXOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:07:36 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0C220F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:07:32 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220524140727epoutp04521d1bab471a1e678541b36184f102b2~yD6yi-94q2696926969epoutp047
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:07:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220524140727epoutp04521d1bab471a1e678541b36184f102b2~yD6yi-94q2696926969epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653401247;
        bh=YlBwt+Z6/ickHEYUDf6IQe3LFIXVTCL/Q7iDU3Mb5UU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YShHnAUxZnKz4YBfj0FtS1tnTb3mssGOVc4lYFd9RLPT6lmrm3i4RS2GKN5lWJHqX
         UqINPLDFuv4mvOltLQ1eySgjB4B2JZXPn6HxZu2EXGOkIDfHoVZu/6skNYjrd0+V4g
         9M6XIZh8vMol54ISkuAZ7IPyBpsI11Fl/5KBJBV4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220524140722epcas5p436e42de7a2f948809da914f5c49f8162~yD6uB-Fod0788607886epcas5p4z;
        Tue, 24 May 2022 14:07:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L6wxf6Lqgz4x9Pp; Tue, 24 May
        2022 14:07:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.0E.09827.696EC826; Tue, 24 May 2022 23:07:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220524140211epcas5p1b9b61a0ea112beb2327848c37d3ba000~yD2L-B03w2789127891epcas5p11;
        Tue, 24 May 2022 14:02:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220524140210epsmtrp20c9c2dd06a7ed2cfd7144ee485a3d41e~yD2L45mks0117801178epsmtrp2W;
        Tue, 24 May 2022 14:02:10 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-21-628ce6969eb0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.BF.11276.265EC826; Tue, 24 May 2022 23:02:10 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220524140209epsmtip214c2c7ec37a0de4eb77763bf0671df2c~yD2KZBzm30200202002epsmtip2i;
        Tue, 24 May 2022 14:02:09 +0000 (GMT)
From:   Adithya K V <adithya.kv@samsung.com>
To:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, andi@etezian.org,
        broonie@kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, Adithya K V <adithya.kv@samsung.com>
Subject: [PATCH] spi: s3c64xx: requests spi-dma channel only during data
 transfer
Date:   Tue, 24 May 2022 19:31:32 +0530
Message-Id: <20220524140132.59300-1-adithya.kv@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmuu60Zz1JBhs/61scmPCK1eLBvG1s
        Fot/PGeymPrwCZvF3tdb2S02Pb7GanF51xw2ixnn9zFZNH68yW6xaOsXdgcuj+tLPjF7bFrV
        yeZx59oeNo/NS+o9+rasYvT4vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJ
        gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG3e3bWQt+yFfcOnyXuYFxtVQXIyeHhICJxJrtrexd
        jFwcQgK7GSVa+i8zQjifGCU2ta1gg3C+MUr0LGxjg2n59WUfVGIvo8TxjXeg+luYJN6s/MoC
        UsUmoCXRuqKHFcQWEXCW+PX+JAtIEbPAC0aJjkOrmUESwgLBEv0fZoHZLAKqEq/urWEHsXkF
        rCUmL5wJtU5eYvWGA8wQcUGJkzOfgC1gBoo3b53NDDJUQuAvu8Snq42sEA0uEvvbW5ggbGGJ
        V8e3sEPYUhKf3+2FGpos8WvpWUYIO0Pi9rpNLBC2vcSBK3OAbA6gBZoS63fpQ4RlJaaeWscE
        sZdPovf3E6jxvBI75sHYKhI7Nq1ihll1bucJqJEeEk/u/AVbKyQQK9G4bCfzBEb5WUjemYXk
        nVkImxcwMq9ilEwtKM5NTy02LTDKSy2HR21yfu4mRnAS1fLawfjwwQe9Q4xMHIyHGCU4mJVE
        eFPCepKEeFMSK6tSi/Lji0pzUosPMZoCw3gis5Rocj4wjeeVxBuaWBqYmJmZmVgamxkqifMK
        /G9MEhJITyxJzU5NLUgtgulj4uCUamDaxVtwptzPVGlb+ybtZWb3VLQ233xQNoXPXUJlZ/vT
        9ZenXXSOdb03d3/hAk2Wc+d9e7Sqr8+qmGMVdm/Lur93PLzuTNH0fLaCsYH1zs6ZL160Xnti
        9I4jLjF09obJ++s4TvC+d6y/suKS4flLdoxpvE6BO9esd/ujyOqxI/bEtV9d6XwqnK/WX78j
        LhXD+bNfXNDw6TaBJZoZlabHUm1/n9QIyjys94iFNfK+T6+E9rvrVpmPvmmzzt74It67K3DS
        wy2r7RoVk7XXz2R741j0V7GWSUN4Wt3BNmWrPcUHuF7+PsO2qIc/Yf38UI8za09NnBPb3NmR
        LLXx7AeF1coyvWsZZF58mLa71vZo/ZldSizFGYmGWsxFxYkAwpJ4MSsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvG7S054kgzlnjC0OTHjFavFg3jY2
        i8U/njNZTH34hM1i7+ut7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYtPULuwOXx/Uln5g9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXF3+3bWgh/yFbcO32VuYFwt
        1cXIySEhYCLx68s+ti5GLg4hgd2MEj8OtrNCJKQk2v7PZIOwhSVW/nvODlHUxCRx9c99FpAE
        m4CWROuKHqAGDg4RAVeJrrOFIDXMAh8YJf70PgarERYIlFi3qJ0JxGYRUJV4dW8NO4jNK2At
        MXkhzAJ5idUbDjBDxAUlTs58wgIyk1lAXWL9PCGQMDNQSfPW2cwTGPlnIamahVA1C0nVAkbm
        VYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwYGvpbmDcfuqD3qHGJk4GA8xSnAwK4nw
        poT1JAnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAJH18
        ltbEc6rXBBkDWY/OzTvWVVbp9CpOldmt7pz50YK1O1XF855PZ/7SXv8xhH97mMWuBTrlzkwz
        mqTNvzMYXbHbzhd8+kDL5KcrN0w+GZE71XDFIn/LA908Mp/6rJp37p76N9pbUIBVdlnQz466
        NerZ35PfJbTqvVLcaFGb0iPq85vh6Cmt/rvsF93PCyh4Fa60q56+cV5p5q/L9/NXMNVXyFcp
        H18anLDOS/r1Ps36832b4vIepLi3BM230vhY9TonOuLEyh+vDyY7znh1qj3Gqvfuo22rz67a
        tO3+VhaWRq+6bzO2Cv3ouHJ/8ga3BvVkVUG5w6oZn6eFXfm9ZvZp3befXCLXpbX/5pmkrsRS
        nJFoqMVcVJwIAKTaTbrrAgAA
X-CMS-MailID: 20220524140211epcas5p1b9b61a0ea112beb2327848c37d3ba000
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220524140211epcas5p1b9b61a0ea112beb2327848c37d3ba000
References: <CGME20220524140211epcas5p1b9b61a0ea112beb2327848c37d3ba000@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current s3c64xx SPI driver acquires DMA channel during driver
probe and holds on it even when channels are not used
(no DMA transfer). This is a problem especially when all the
DMA channels are exhausted (as other IPs on the same DMA
controller also acquires DMA channel) and if a new IP/Device
requests for a DMA channel (on the same DMA controller), it won’t
get DMA channel allocated.
The said issue can be avoided if s3c64xx driver request and
release DMA channel before and after data transfer. Let’s modify
the driver to request and release DMA channel before and after
DMA mode data transfer.

Signed-off-by: Adithya K V <adithya.kv@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 56 ++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c26440e9058d..82558e37c735 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -350,6 +350,23 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	if (is_polling(sdd))
 		return 0;
 
+	/* Requests DMA channels */
+	sdd->rx_dma.ch = dma_request_chan(&sdd->pdev->dev, "rx");
+	if (IS_ERR(sdd->rx_dma.ch)) {
+		dev_err(&sdd->pdev->dev, "Failed to get RX DMA channel\n");
+		sdd->rx_dma.ch = 0;
+		return 0;
+	}
+
+	sdd->tx_dma.ch = dma_request_chan(&sdd->pdev->dev, "tx");
+	if (IS_ERR(sdd->tx_dma.ch)) {
+		dev_err(&sdd->pdev->dev, "Failed to get TX DMA hannel\n");
+		dma_release_channel(sdd->rx_dma.ch);
+		sdd->tx_dma.ch = 0;
+		sdd->rx_dma.ch = 0;
+		return 0;
+	}
+
 	spi->dma_rx = sdd->rx_dma.ch;
 	spi->dma_tx = sdd->tx_dma.ch;
 
@@ -362,7 +379,12 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
-	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+		return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
+	} else {
+		return 0;
+	}
+
 }
 
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
@@ -697,7 +719,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		use_dma = 1;
 
-	} else if (is_polling(sdd) && xfer->len > fifo_len) {
+	} else if (xfer->len > fifo_len) {
 		tx_buf = xfer->tx_buf;
 		rx_buf = xfer->rx_buf;
 		origin_len = xfer->len;
@@ -782,6 +804,14 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		xfer->len = origin_len;
 	}
 
+	/* Releases DMA channels after data transfer is completed */
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+		dma_release_channel(sdd->rx_dma.ch);
+		dma_release_channel(sdd->tx_dma.ch);
+		sdd->rx_dma.ch = 0;
+		sdd->tx_dma.ch = 0;
+	}
+
 	return status;
 }
 
@@ -1167,22 +1197,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!is_polling(sdd)) {
-		/* Acquire DMA channels */
-		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");
-		if (IS_ERR(sdd->rx_dma.ch)) {
-			dev_err(&pdev->dev, "Failed to get RX DMA channel\n");
-			ret = PTR_ERR(sdd->rx_dma.ch);
-			goto err_disable_io_clk;
-		}
-		sdd->tx_dma.ch = dma_request_chan(&pdev->dev, "tx");
-		if (IS_ERR(sdd->tx_dma.ch)) {
-			dev_err(&pdev->dev, "Failed to get TX DMA channel\n");
-			ret = PTR_ERR(sdd->tx_dma.ch);
-			goto err_release_rx_dma;
-		}
-	}
-
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -1228,12 +1242,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	if (!is_polling(sdd))
-		dma_release_channel(sdd->tx_dma.ch);
-err_release_rx_dma:
-	if (!is_polling(sdd))
-		dma_release_channel(sdd->rx_dma.ch);
-err_disable_io_clk:
 	clk_disable_unprepare(sdd->ioclk);
 err_disable_src_clk:
 	clk_disable_unprepare(sdd->src_clk);

base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
-- 
2.17.1

