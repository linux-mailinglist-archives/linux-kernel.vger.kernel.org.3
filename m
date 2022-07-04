Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D545658F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiGDOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiGDOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:52:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F11BEB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:52:43 -0700 (PDT)
Received: from dslb-178-004-207-027.178.004.pools.vodafone-ip.de ([178.4.207.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o8NRH-0004hD-8w; Mon, 04 Jul 2022 16:52:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: remove sdio definitions
Date:   Mon,  4 Jul 2022 16:52:20 +0200
Message-Id: <20220704145221.159949-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704145221.159949-1-martin@kaiser.cx>
References: <20220704145221.159949-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r8188eu chipset is connected via usb. We don't need the register
and bit field definitions for the sdio interface.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/rtl8188e_spec.h   | 136 ------------------
 1 file changed, 136 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index ef42c4b2f20c..d3651ec71dc4 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -1059,142 +1059,6 @@ Current IOREG MAP
 #define SCR_TXBCUSEDK		BIT(6)	/* Force Tx Bcast pkt Use Default Key */
 #define SCR_RXBCUSEDK		BIT(7)	/* Force Rx Bcast pkt Use Default Key */
 
-/* 	RTL8188E SDIO Configuration */
-
-/*  I/O bus domain address mapping */
-#define SDIO_LOCAL_BASE			0x10250000
-#define WLAN_IOREG_BASE			0x10260000
-#define FIRMWARE_FIFO_BASE		0x10270000
-#define TX_HIQ_BASE			0x10310000
-#define TX_MIQ_BASE			0x10320000
-#define TX_LOQ_BASE			0x10330000
-#define RX_RX0FF_BASE			0x10340000
-
-/*  SDIO host local register space mapping. */
-#define SDIO_LOCAL_MSK			0x0FFF
-#define WLAN_IOREG_MSK			0x7FFF
-#define WLAN_FIFO_MSK			0x1FFF	/*  Aggregation Length[12:0] */
-#define WLAN_RX0FF_MSK			0x0003
-
-/*  Without ref to the SDIO Device ID */
-#define SDIO_WITHOUT_REF_DEVICE_ID	0
-#define SDIO_LOCAL_DEVICE_ID		0	/*  0b[16], 000b[15:13] */
-#define WLAN_TX_HIQ_DEVICE_ID		4	/*  0b[16], 100b[15:13] */
-#define WLAN_TX_MIQ_DEVICE_ID		5	/*  0b[16], 101b[15:13] */
-#define WLAN_TX_LOQ_DEVICE_ID		6	/*  0b[16], 110b[15:13] */
-#define WLAN_RX0FF_DEVICE_ID		7	/*  0b[16], 111b[15:13] */
-#define WLAN_IOREG_DEVICE_ID		8	/*  1b[16] */
-
-/*  SDIO Tx Free Page Index */
-#define HI_QUEUE_IDX			0
-#define MID_QUEUE_IDX			1
-#define LOW_QUEUE_IDX			2
-#define PUBLIC_QUEUE_IDX		3
-
-#define SDIO_MAX_TX_QUEUE		3	/*  HIQ, MIQ and LOQ */
-#define SDIO_MAX_RX_QUEUE		1
-
-/*  SDIO Tx Control */
-#define SDIO_REG_TX_CTRL		0x0000
-/*  SDIO Host Interrupt Mask */
-#define SDIO_REG_HIMR			0x0014
-/*  SDIO Host Interrupt Service Routine */
-#define SDIO_REG_HISR			0x0018
-/*  HCI Current Power Mode */
-#define SDIO_REG_HCPWM			0x0019
-/*  RXDMA Request Length */
-#define SDIO_REG_RX0_REQ_LEN		0x001C
-/*  Free Tx Buffer Page */
-#define SDIO_REG_FREE_TXPG		0x0020
-/*  HCI Current Power Mode 1 */
-#define SDIO_REG_HCPWM1			0x0024
-/*  HCI Current Power Mode 2 */
-#define SDIO_REG_HCPWM2			0x0026
-/*  HTSF Informaion */
-#define SDIO_REG_HTSFR_INFO		0x0030
-/*  HCI Request Power Mode 1 */
-#define SDIO_REG_HRPWM1			0x0080
-/*  HCI Request Power Mode 2 */
-#define SDIO_REG_HRPWM2			0x0082
-/*  HCI Power Save Clock */
-#define SDIO_REG_HPS_CLKR		0x0084
-/*  SDIO HCI Suspend Control */
-#define SDIO_REG_HSUS_CTRL		0x0086
-/*  SDIO Host Extension Interrupt Mask Always */
-#define SDIO_REG_HIMR_ON		0x0090
-/*  SDIO Host Extension Interrupt Status Always */
-#define SDIO_REG_HISR_ON		0x0091
-
-#define SDIO_HIMR_DISABLED			0
-
-/*  RTL8188E SDIO Host Interrupt Mask Register */
-#define SDIO_HIMR_RX_REQUEST_MSK		BIT(0)
-#define SDIO_HIMR_AVAL_MSK			BIT(1)
-#define SDIO_HIMR_TXERR_MSK			BIT(2)
-#define SDIO_HIMR_RXERR_MSK			BIT(3)
-#define SDIO_HIMR_TXFOVW_MSK			BIT(4)
-#define SDIO_HIMR_RXFOVW_MSK			BIT(5)
-#define SDIO_HIMR_TXBCNOK_MSK			BIT(6)
-#define SDIO_HIMR_TXBCNERR_MSK			BIT(7)
-#define SDIO_HIMR_BCNERLY_INT_MSK		BIT(16)
-#define SDIO_HIMR_C2HCMD_MSK			BIT(17)
-#define SDIO_HIMR_CPWM1_MSK			BIT(18)
-#define SDIO_HIMR_CPWM2_MSK			BIT(19)
-#define SDIO_HIMR_HSISR_IND_MSK			BIT(20)
-#define SDIO_HIMR_GTINT3_IND_MSK		BIT(21)
-#define SDIO_HIMR_GTINT4_IND_MSK		BIT(22)
-#define SDIO_HIMR_PSTIMEOUT_MSK			BIT(23)
-#define SDIO_HIMR_OCPINT_MSK			BIT(24)
-#define SDIO_HIMR_ATIMEND_MSK			BIT(25)
-#define SDIO_HIMR_ATIMEND_E_MSK			BIT(26)
-#define SDIO_HIMR_CTWEND_MSK			BIT(27)
-
-/* RTL8188E SDIO Specific */
-#define	SDIO_HIMR_MCU_ERR_MSK			BIT(28)
-#define	SDIO_HIMR_TSF_BIT32_TOGGLE_MSK		BIT(29)
-
-/*  SDIO Host Interrupt Service Routine */
-#define SDIO_HISR_RX_REQUEST			BIT(0)
-#define SDIO_HISR_AVAL				BIT(1)
-#define SDIO_HISR_TXERR				BIT(2)
-#define SDIO_HISR_RXERR				BIT(3)
-#define SDIO_HISR_TXFOVW			BIT(4)
-#define SDIO_HISR_RXFOVW			BIT(5)
-#define SDIO_HISR_TXBCNOK			BIT(6)
-#define SDIO_HISR_TXBCNERR			BIT(7)
-#define SDIO_HISR_BCNERLY_INT			BIT(16)
-#define SDIO_HISR_C2HCMD			BIT(17)
-#define SDIO_HISR_CPWM1				BIT(18)
-#define SDIO_HISR_CPWM2				BIT(19)
-#define SDIO_HISR_HSISR_IND			BIT(20)
-#define SDIO_HISR_GTINT3_IND			BIT(21)
-#define SDIO_HISR_GTINT4_IND			BIT(22)
-#define SDIO_HISR_PSTIME			BIT(23)
-#define SDIO_HISR_OCPINT			BIT(24)
-#define SDIO_HISR_ATIMEND			BIT(25)
-#define SDIO_HISR_ATIMEND_E			BIT(26)
-#define SDIO_HISR_CTWEND			BIT(27)
-
-/* RTL8188E SDIO Specific */
-#define	SDIO_HISR_MCU_ERR			BIT(28)
-#define	SDIO_HISR_TSF_BIT32_TOGGLE		BIT(29)
-
-#define MASK_SDIO_HISR_CLEAR				\
-	(SDIO_HISR_TXERR | SDIO_HISR_RXERR | SDIO_HISR_TXFOVW |\
-	 SDIO_HISR_RXFOVW | SDIO_HISR_TXBCNOK | SDIO_HISR_TXBCNERR |\
-	 SDIO_HISR_C2HCMD | SDIO_HISR_CPWM1 | SDIO_HISR_CPWM2 |\
-	 SDIO_HISR_HSISR_IND | SDIO_HISR_GTINT3_IND | SDIO_HISR_GTINT4_IND |\
-	 SDIO_HISR_PSTIMEOUT | SDIO_HISR_OCPINT)
-
-/*  SDIO HCI Suspend Control Register */
-#define HCI_RESUME_PWR_RDY		BIT(1)
-#define HCI_SUS_CTRL			BIT(0)
-
-/*  SDIO Tx FIFO related */
-/*  The number of Tx FIFO free page */
-#define SDIO_TX_FREE_PG_QUEUE			4
-#define SDIO_TX_FIFO_PAGE_SZ			128
-
 /* 	0xFE00h ~ 0xFE55h	USB Configuration */
 
 /* 2 USB Information (0xFE17) */
-- 
2.30.2

