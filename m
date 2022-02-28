Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC124C6CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiB1MpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiB1MpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:45:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EDD47548
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:44:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d15so7695126pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztR1ZgN3LqpzmgE/aV5hpMhENVc6hmHomH8afl5GlOs=;
        b=fMnNsff+yhkxaMSK6q8IusnnVADwZxpaeL/W10XThj/OXWnyCF+Ww9Zpggl4aag6yA
         R0Z2luR0re2zIrdofXf3DxSoXMZQOBCqt2ZXm7uBm/hTx1OUdSm9ID8DKHadvRd0g90s
         Hic+5mFsOUDWwLCxfDUyrpSl1QmQWwCf8YGh8pFIvdZ3poG7+ibtwe2O4Ly4ev19LPJ3
         VHckSDhOOAjxpql/xHMpqSDV7tu2f4kVTWPKzzs/QzcsNHlFrE1CVt0sLaQ8kCgZVpna
         UkzqEjc9XcFvybW3goKJ7Nqj5LvdpTU26+/8yEtwONjLOTneTj9cc73IM9KqKxaPvVDF
         BxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztR1ZgN3LqpzmgE/aV5hpMhENVc6hmHomH8afl5GlOs=;
        b=NYNr0Oe3soLhgYEk45XJnTSIfvBQ2B9+k33nI2Y4a35ZGs7PH5veZtkF0gKA/wXf1o
         FvT5x+hfB1jkKGuIqyMrXOFmKERozNM8raK3L5rSlaTteUrFRIPULTeqI0ktL0KKAIbe
         Y4GZKBbMSAoxcj87djct85Uyh2YuvA4XwgyhTnqW5cXqeTD/QWfXXZoGyqFgxQ6C4ngR
         7bXVr97uKLL4mpzET7UWczeeqSiKGchrxT6wr5YWqStaw9N0eRGfLOIa/t78sAycEoob
         icoSWIGfJly7osBRnv5V83LB6oAQ8GU2LB4SMkyJl0Iz57J/G/XFXg61pSi1KjlMavzz
         WVkA==
X-Gm-Message-State: AOAM532oDzpMWvE7TCU8LAes+HCikHusurneS8pIsjyYDzmu876pi4lO
        7VwM7F2AFYQaXYDiroT5Ib2x
X-Google-Smtp-Source: ABdhPJxCmTph9UQ/ZysPF/okRtyIduLlLhYhLMeHYg7TbRKbbmzxLbN+UAmfwLh42h23nB3EjREo7Q==
X-Received: by 2002:a17:90a:8595:b0:1bb:fbfd:bfbf with SMTP id m21-20020a17090a859500b001bbfbfdbfbfmr16374251pjn.125.1646052269943;
        Mon, 28 Feb 2022 04:44:29 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:44:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v4 06/27] bus: mhi: Cleanup the register definitions used in headers
Date:   Mon, 28 Feb 2022 18:13:23 +0530
Message-Id: <20220228124344.77359-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup includes:

1. Using the GENMASK macro for masks
2. Removing brackets for single values
3. Using lowercase for hex values
4. Using two digits for hex values where applicable
5. Aligning the defines on same column

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/host/internal.h | 413 +++++++++++++++-----------------
 1 file changed, 199 insertions(+), 214 deletions(-)

diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 1d1790e83a93..1c7a48be033f 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -12,134 +12,116 @@
 
 extern struct bus_type mhi_bus_type;
 
-#define MHIREGLEN (0x0)
-
-#define MHIVER (0x8)
-
-#define MHICFG (0x10)
-#define MHICFG_NHWER_MASK (GENMASK(31, 24))
-#define MHICFG_NER_MASK (GENMASK(23, 16))
-#define MHICFG_NHWCH_MASK (GENMASK(15, 8))
-#define MHICFG_NCH_MASK (GENMASK(7, 0))
-
-#define CHDBOFF (0x18)
-
-#define ERDBOFF (0x20)
-
-#define BHIOFF (0x28)
-
-#define BHIEOFF (0x2C)
-
-#define DEBUGOFF (0x30)
-
-#define MHICTRL (0x38)
-#define MHICTRL_MHISTATE_MASK (GENMASK(15, 8))
-#define MHICTRL_RESET_MASK (BIT(1))
-
-#define MHISTATUS (0x48)
-#define MHISTATUS_MHISTATE_MASK (GENMASK(15, 8))
-#define MHISTATUS_SYSERR_MASK (BIT(2))
-#define MHISTATUS_READY_MASK (BIT(0))
-
-#define CCABAP_LOWER (0x58)
-
-#define CCABAP_HIGHER (0x5C)
-
-#define ECABAP_LOWER (0x60)
-
-#define ECABAP_HIGHER (0x64)
-
-#define CRCBAP_LOWER (0x68)
-
-#define CRCBAP_HIGHER (0x6C)
-
-#define CRDB_LOWER (0x70)
-
-#define CRDB_HIGHER (0x74)
-
-#define MHICTRLBASE_LOWER (0x80)
-
-#define MHICTRLBASE_HIGHER (0x84)
-
-#define MHICTRLLIMIT_LOWER (0x88)
-
-#define MHICTRLLIMIT_HIGHER (0x8C)
-
-#define MHIDATABASE_LOWER (0x98)
-
-#define MHIDATABASE_HIGHER (0x9C)
-
-#define MHIDATALIMIT_LOWER (0xA0)
-
-#define MHIDATALIMIT_HIGHER (0xA4)
+/* MHI registers */
+#define MHIREGLEN					0x00
+#define MHIVER						0x08
+#define MHICFG						0x10
+#define CHDBOFF						0x18
+#define ERDBOFF						0x20
+#define BHIOFF						0x28
+#define BHIEOFF						0x2c
+#define DEBUGOFF					0x30
+#define MHICTRL						0x38
+#define MHISTATUS					0x48
+#define CCABAP_LOWER					0x58
+#define CCABAP_HIGHER					0x5c
+#define ECABAP_LOWER					0x60
+#define ECABAP_HIGHER					0x64
+#define CRCBAP_LOWER					0x68
+#define CRCBAP_HIGHER					0x6c
+#define CRDB_LOWER					0x70
+#define CRDB_HIGHER					0x74
+#define MHICTRLBASE_LOWER				0x80
+#define MHICTRLBASE_HIGHER				0x84
+#define MHICTRLLIMIT_LOWER				0x88
+#define MHICTRLLIMIT_HIGHER				0x8c
+#define MHIDATABASE_LOWER				0x98
+#define MHIDATABASE_HIGHER				0x9c
+#define MHIDATALIMIT_LOWER				0xa0
+#define MHIDATALIMIT_HIGHER				0xa4
 
 /* Host request register */
-#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
-#define MHI_SOC_RESET_REQ BIT(0)
-
-/* MHI BHI offfsets */
-#define BHI_BHIVERSION_MINOR (0x00)
-#define BHI_BHIVERSION_MAJOR (0x04)
-#define BHI_IMGADDR_LOW (0x08)
-#define BHI_IMGADDR_HIGH (0x0C)
-#define BHI_IMGSIZE (0x10)
-#define BHI_RSVD1 (0x14)
-#define BHI_IMGTXDB (0x18)
-#define BHI_TXDB_SEQNUM_BMSK (GENMASK(29, 0))
-#define BHI_RSVD2 (0x1C)
-#define BHI_INTVEC (0x20)
-#define BHI_RSVD3 (0x24)
-#define BHI_EXECENV (0x28)
-#define BHI_STATUS (0x2C)
-#define BHI_ERRCODE (0x30)
-#define BHI_ERRDBG1 (0x34)
-#define BHI_ERRDBG2 (0x38)
-#define BHI_ERRDBG3 (0x3C)
-#define BHI_SERIALNU (0x40)
-#define BHI_SBLANTIROLLVER (0x44)
-#define BHI_NUMSEG (0x48)
-#define BHI_MSMHWID(n) (0x4C + (0x4 * (n)))
-#define BHI_OEMPKHASH(n) (0x64 + (0x4 * (n)))
-#define BHI_RSVD5 (0xC4)
-#define BHI_STATUS_MASK (GENMASK(31, 30))
-#define BHI_STATUS_ERROR (3)
-#define BHI_STATUS_SUCCESS (2)
-#define BHI_STATUS_RESET (0)
-
-/* MHI BHIE offsets */
-#define BHIE_MSMSOCID_OFFS (0x0000)
-#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
-#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
-#define BHIE_TXVECSIZE_OFFS (0x0034)
-#define BHIE_TXVECDB_OFFS (0x003C)
-#define BHIE_TXVECDB_SEQNUM_BMSK (GENMASK(29, 0))
-#define BHIE_TXVECSTATUS_OFFS (0x0044)
-#define BHIE_TXVECSTATUS_SEQNUM_BMSK (GENMASK(29, 0))
-#define BHIE_TXVECSTATUS_STATUS_BMSK (GENMASK(31, 30))
-#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
-#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
-#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
-#define BHIE_RXVECSIZE_OFFS (0x0068)
-#define BHIE_RXVECDB_OFFS (0x0070)
-#define BHIE_RXVECDB_SEQNUM_BMSK (GENMASK(29, 0))
-#define BHIE_RXVECSTATUS_OFFS (0x0078)
-#define BHIE_RXVECSTATUS_SEQNUM_BMSK (GENMASK(29, 0))
-#define BHIE_RXVECSTATUS_STATUS_BMSK (GENMASK(31, 30))
-#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
-
-#define SOC_HW_VERSION_OFFS (0x224)
-#define SOC_HW_VERSION_FAM_NUM_BMSK (GENMASK(31, 28))
-#define SOC_HW_VERSION_DEV_NUM_BMSK (GENMASK(27, 16))
-#define SOC_HW_VERSION_MAJOR_VER_BMSK (GENMASK(15, 8))
-#define SOC_HW_VERSION_MINOR_VER_BMSK (GENMASK(7, 0))
-
-#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
-#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
-#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
+#define MHI_SOC_RESET_REQ_OFFSET			0xb0
+#define MHI_SOC_RESET_REQ				BIT(0)
+
+/* MHI register bits */
+#define MHICFG_NHWER_MASK				GENMASK(31, 24)
+#define MHICFG_NER_MASK					GENMASK(23, 16)
+#define MHICFG_NHWCH_MASK				GENMASK(15, 8)
+#define MHICFG_NCH_MASK					GENMASK(7, 0)
+#define MHICTRL_MHISTATE_MASK				GENMASK(15, 8)
+#define MHICTRL_RESET_MASK				BIT(1)
+#define MHISTATUS_MHISTATE_MASK				GENMASK(15, 8)
+#define MHISTATUS_SYSERR_MASK				BIT(2)
+#define MHISTATUS_READY_MASK				BIT(0)
+
+/* MHI BHI registers */
+#define BHI_BHIVERSION_MINOR				0x00
+#define BHI_BHIVERSION_MAJOR				0x04
+#define BHI_IMGADDR_LOW					0x08
+#define BHI_IMGADDR_HIGH				0x0c
+#define BHI_IMGSIZE					0x10
+#define BHI_RSVD1					0x14
+#define BHI_IMGTXDB					0x18
+#define BHI_RSVD2					0x1c
+#define BHI_INTVEC					0x20
+#define BHI_RSVD3					0x24
+#define BHI_EXECENV					0x28
+#define BHI_STATUS					0x2c
+#define BHI_ERRCODE					0x30
+#define BHI_ERRDBG1					0x34
+#define BHI_ERRDBG2					0x38
+#define BHI_ERRDBG3					0x3c
+#define BHI_SERIALNU					0x40
+#define BHI_SBLANTIROLLVER				0x44
+#define BHI_NUMSEG					0x48
+#define BHI_MSMHWID(n)					(0x4c + (0x4 * (n)))
+#define BHI_OEMPKHASH(n)				(0x64 + (0x4 * (n)))
+#define BHI_RSVD5					0xc4
+
+/* BHI register bits */
+#define BHI_TXDB_SEQNUM_BMSK				GENMASK(29, 0)
+#define BHI_STATUS_MASK					GENMASK(31, 30)
+#define BHI_STATUS_ERROR				0x03
+#define BHI_STATUS_SUCCESS				0x02
+#define BHI_STATUS_RESET				0x00
+
+/* MHI BHIE registers */
+#define BHIE_MSMSOCID_OFFS				0x00
+#define BHIE_TXVECADDR_LOW_OFFS				0x2c
+#define BHIE_TXVECADDR_HIGH_OFFS			0x30
+#define BHIE_TXVECSIZE_OFFS				0x34
+#define BHIE_TXVECDB_OFFS				0x3c
+#define BHIE_TXVECSTATUS_OFFS				0x44
+#define BHIE_RXVECADDR_LOW_OFFS				0x60
+#define BHIE_RXVECADDR_HIGH_OFFS			0x64
+#define BHIE_RXVECSIZE_OFFS				0x68
+#define BHIE_RXVECDB_OFFS				0x70
+#define BHIE_RXVECSTATUS_OFFS				0x78
+
+/* BHIE register bits */
+#define BHIE_TXVECDB_SEQNUM_BMSK			GENMASK(29, 0)
+#define BHIE_TXVECSTATUS_SEQNUM_BMSK			GENMASK(29, 0)
+#define BHIE_TXVECSTATUS_STATUS_BMSK			GENMASK(31, 30)
+#define BHIE_TXVECSTATUS_STATUS_RESET			0x00
+#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL		0x02
+#define BHIE_TXVECSTATUS_STATUS_ERROR			0x03
+#define BHIE_RXVECDB_SEQNUM_BMSK			GENMASK(29, 0)
+#define BHIE_RXVECSTATUS_SEQNUM_BMSK			GENMASK(29, 0)
+#define BHIE_RXVECSTATUS_STATUS_BMSK			GENMASK(31, 30)
+#define BHIE_RXVECSTATUS_STATUS_RESET			0x00
+#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL		0x02
+#define BHIE_RXVECSTATUS_STATUS_ERROR			0x03
+
+#define SOC_HW_VERSION_OFFS				0x224
+#define SOC_HW_VERSION_FAM_NUM_BMSK			GENMASK(31, 28)
+#define SOC_HW_VERSION_DEV_NUM_BMSK			GENMASK(27, 16)
+#define SOC_HW_VERSION_MAJOR_VER_BMSK			GENMASK(15, 8)
+#define SOC_HW_VERSION_MINOR_VER_BMSK			GENMASK(7, 0)
+
+#define EV_CTX_RESERVED_MASK				GENMASK(7, 0)
+#define EV_CTX_INTMODC_MASK				GENMASK(15, 8)
+#define EV_CTX_INTMODT_MASK				GENMASK(31, 16)
 struct mhi_event_ctxt {
 	__le32 intmod;
 	__le32 ertype;
@@ -151,10 +133,10 @@ struct mhi_event_ctxt {
 	__le64 wp __packed __aligned(4);
 };
 
-#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
-#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
-#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
-#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
+#define CHAN_CTX_CHSTATE_MASK				GENMASK(7, 0)
+#define CHAN_CTX_BRSTMODE_MASK				GENMASK(9, 8)
+#define CHAN_CTX_POLLCFG_MASK				GENMASK(15, 10)
+#define CHAN_CTX_RESERVED_MASK				GENMASK(31, 16)
 struct mhi_chan_ctxt {
 	__le32 chcfg;
 	__le32 chtype;
@@ -204,67 +186,71 @@ enum mhi_cmd_type {
 };
 
 /* No operation command */
-#define MHI_TRE_CMD_NOOP_PTR (0)
-#define MHI_TRE_CMD_NOOP_DWORD0 (0)
-#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_CMD_NOP)))
+#define MHI_TRE_CMD_NOOP_PTR		0
+#define MHI_TRE_CMD_NOOP_DWORD0		0
+#define MHI_TRE_CMD_NOOP_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_CMD_NOP))
 
 /* Channel reset command */
-#define MHI_TRE_CMD_RESET_PTR (0)
-#define MHI_TRE_CMD_RESET_DWORD0 (0)
-#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
-					FIELD_PREP(GENMASK(23, 16), MHI_CMD_RESET_CHAN))
+#define MHI_TRE_CMD_RESET_PTR		0
+#define MHI_TRE_CMD_RESET_DWORD0	0
+#define MHI_TRE_CMD_RESET_DWORD1(chid)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
+						    FIELD_PREP(GENMASK(23, 16),         \
+							       MHI_CMD_RESET_CHAN))
 
 /* Channel stop command */
-#define MHI_TRE_CMD_STOP_PTR (0)
-#define MHI_TRE_CMD_STOP_DWORD0 (0)
-#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
-					FIELD_PREP(GENMASK(23, 16), MHI_CMD_STOP_CHAN))
+#define MHI_TRE_CMD_STOP_PTR		0
+#define MHI_TRE_CMD_STOP_DWORD0		0
+#define MHI_TRE_CMD_STOP_DWORD1(chid)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
+						    FIELD_PREP(GENMASK(23, 16),         \
+							       MHI_CMD_STOP_CHAN))
 
 /* Channel start command */
-#define MHI_TRE_CMD_START_PTR (0)
-#define MHI_TRE_CMD_START_DWORD0 (0)
-#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
-					FIELD_PREP(GENMASK(23, 16), MHI_CMD_START_CHAN))
+#define MHI_TRE_CMD_START_PTR		0
+#define MHI_TRE_CMD_START_DWORD0	0
+#define MHI_TRE_CMD_START_DWORD1(chid)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
+						    FIELD_PREP(GENMASK(23, 16),         \
+							       MHI_CMD_START_CHAN))
 
-#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
-#define MHI_TRE_GET_CMD_CHID(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
-#define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
+#define MHI_TRE_GET_DWORD(tre, word)	le32_to_cpu((tre)->dword[(word)])
+#define MHI_TRE_GET_CMD_CHID(tre)	FIELD_GET(GENMASK(31, 24), MHI_TRE_GET_DWORD(tre, 1))
+#define MHI_TRE_GET_CMD_TYPE(tre)	FIELD_GET(GENMASK(23, 16), MHI_TRE_GET_DWORD(tre, 1))
 
 /* Event descriptor macros */
-#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
-#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), code) | \
-						FIELD_PREP(GENMASK(15, 0), len)))
-#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
-						FIELD_PREP(GENMASK(23, 16), type)))
-#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
-#define MHI_TRE_GET_EV_CODE(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
-#define MHI_TRE_GET_EV_LEN(tre) (FIELD_GET(GENMASK(15, 0), (MHI_TRE_GET_DWORD(tre, 0))))
-#define MHI_TRE_GET_EV_CHID(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
-#define MHI_TRE_GET_EV_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
-#define MHI_TRE_GET_EV_STATE(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
-#define MHI_TRE_GET_EV_EXECENV(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
-#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
-#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
-#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
-#define MHI_TRE_GET_EV_VEID(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 0))))
-#define MHI_TRE_GET_EV_LINKSPEED(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
-#define MHI_TRE_GET_EV_LINKWIDTH(tre) (FIELD_GET(GENMASK(7, 0), (MHI_TRE_GET_DWORD(tre, 0))))
+#define MHI_TRE_EV_PTR(ptr)		cpu_to_le64(ptr)
+#define MHI_TRE_EV_DWORD0(code, len)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), code | \
+						    FIELD_PREP(GENMASK(15, 0), len)))
+#define MHI_TRE_EV_DWORD1(chid, type)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid | \
+						    FIELD_PREP(GENMASK(23, 16), type)))
+#define MHI_TRE_GET_EV_PTR(tre)		le64_to_cpu((tre)->ptr)
+#define MHI_TRE_GET_EV_CODE(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_TRE_GET_EV_LEN(tre)		FIELD_GET(GENMASK(15, 0), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_TRE_GET_EV_CHID(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1)))
+#define MHI_TRE_GET_EV_TYPE(tre)	FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1)))
+#define MHI_TRE_GET_EV_STATE(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_TRE_GET_EV_EXECENV(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_TRE_GET_EV_SEQ(tre)		MHI_TRE_GET_DWORD(tre, 0)
+#define MHI_TRE_GET_EV_TIME(tre)	MHI_TRE_GET_EV_PTR(tre)
+#define MHI_TRE_GET_EV_COOKIE(tre)	lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
+#define MHI_TRE_GET_EV_VEID(tre)	FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_TRE_GET_EV_LINKSPEED(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1)))
+#define MHI_TRE_GET_EV_LINKWIDTH(tre)	FIELD_GET(GENMASK(7, 0), (MHI_TRE_GET_DWORD(tre, 0)))
 
 /* Transfer descriptor macros */
-#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
-#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(FIELD_PREP(GENMASK(15, 0), len)))
-#define MHI_TRE_TYPE_TRANSFER 2
-#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
-							MHI_TRE_TYPE_TRANSFER) | \
-							FIELD_PREP(BIT(10), bei) | \
-							FIELD_PREP(BIT(9), ieot) | \
-							FIELD_PREP(BIT(8), ieob) | \
-							FIELD_PREP(BIT(0), chain)))
+#define MHI_TRE_DATA_PTR(ptr)		cpu_to_le64(ptr)
+#define MHI_TRE_DATA_DWORD0(len)	cpu_to_le32(FIELD_PREP(GENMASK(15, 0), len))
+#define MHI_TRE_TYPE_TRANSFER		2
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
+								MHI_TRE_TYPE_TRANSFER) |    \
+								FIELD_PREP(BIT(10), bei) |  \
+								FIELD_PREP(BIT(9), ieot) |  \
+								FIELD_PREP(BIT(8), ieob) |  \
+								FIELD_PREP(BIT(0), chain))
 
 /* RSC transfer descriptor macros */
-#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr))
-#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
-#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_PKT_TYPE_COALESCING)
+#define MHI_RSCTRE_DATA_PTR(ptr, len)	cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr)
+#define MHI_RSCTRE_DATA_DWORD0(cookie)	cpu_to_le32(cookie)
+#define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
+							       MHI_PKT_TYPE_COALESCING))
 
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
@@ -369,44 +355,43 @@ enum mhi_pm_state {
 	MHI_PM_STATE_MAX
 };
 
-#define MHI_PM_DISABLE			BIT(0)
-#define MHI_PM_POR			BIT(1)
-#define MHI_PM_M0			BIT(2)
-#define MHI_PM_M2			BIT(3)
-#define MHI_PM_M3_ENTER			BIT(4)
-#define MHI_PM_M3			BIT(5)
-#define MHI_PM_M3_EXIT			BIT(6)
+#define MHI_PM_DISABLE					BIT(0)
+#define MHI_PM_POR					BIT(1)
+#define MHI_PM_M0					BIT(2)
+#define MHI_PM_M2					BIT(3)
+#define MHI_PM_M3_ENTER					BIT(4)
+#define MHI_PM_M3					BIT(5)
+#define MHI_PM_M3_EXIT					BIT(6)
 /* firmware download failure state */
-#define MHI_PM_FW_DL_ERR		BIT(7)
-#define MHI_PM_SYS_ERR_DETECT		BIT(8)
-#define MHI_PM_SYS_ERR_PROCESS		BIT(9)
-#define MHI_PM_SHUTDOWN_PROCESS		BIT(10)
+#define MHI_PM_FW_DL_ERR				BIT(7)
+#define MHI_PM_SYS_ERR_DETECT				BIT(8)
+#define MHI_PM_SYS_ERR_PROCESS				BIT(9)
+#define MHI_PM_SHUTDOWN_PROCESS				BIT(10)
 /* link not accessible */
-#define MHI_PM_LD_ERR_FATAL_DETECT	BIT(11)
-
-#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
-		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
-#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
-#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
-#define MHI_DB_ACCESS_VALID(mhi_cntrl) (mhi_cntrl->pm_state & \
-					mhi_cntrl->db_access)
-#define MHI_WAKE_DB_CLEAR_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
-						MHI_PM_M2 | MHI_PM_M3_EXIT))
-#define MHI_WAKE_DB_SET_VALID(pm_state) (pm_state & MHI_PM_M2)
-#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state) MHI_WAKE_DB_CLEAR_VALID(pm_state)
-#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
-					    MHI_PM_IN_ERROR_STATE(pm_state))
-#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
-					   (MHI_PM_M3_ENTER | MHI_PM_M3))
-
-#define NR_OF_CMD_RINGS			1
-#define CMD_EL_PER_RING			128
-#define PRIMARY_CMD_RING		0
-#define MHI_DEV_WAKE_DB			127
-#define MHI_MAX_MTU			0xffff
-#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
+#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(11)
+
+#define MHI_REG_ACCESS_VALID(pm_state)			((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
+						MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
+						MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
+						MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+#define MHI_PM_IN_ERROR_STATE(pm_state)			(pm_state >= MHI_PM_FW_DL_ERR)
+#define MHI_PM_IN_FATAL_STATE(pm_state)			(pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
+#define MHI_DB_ACCESS_VALID(mhi_cntrl)			(mhi_cntrl->pm_state & mhi_cntrl->db_access)
+#define MHI_WAKE_DB_CLEAR_VALID(pm_state)		(pm_state & (MHI_PM_M0 | \
+							MHI_PM_M2 | MHI_PM_M3_EXIT))
+#define MHI_WAKE_DB_SET_VALID(pm_state)			(pm_state & MHI_PM_M2)
+#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state)		MHI_WAKE_DB_CLEAR_VALID(pm_state)
+#define MHI_EVENT_ACCESS_INVALID(pm_state)		(pm_state == MHI_PM_DISABLE || \
+							MHI_PM_IN_ERROR_STATE(pm_state))
+#define MHI_PM_IN_SUSPEND_STATE(pm_state)		(pm_state & \
+							(MHI_PM_M3_ENTER | MHI_PM_M3))
+
+#define NR_OF_CMD_RINGS					1
+#define CMD_EL_PER_RING					128
+#define PRIMARY_CMD_RING				0
+#define MHI_DEV_WAKE_DB					127
+#define MHI_MAX_MTU					0xffff
+#define MHI_RANDOM_U32_NONZERO(bmsk)			(prandom_u32_max(bmsk) + 1)
 
 enum mhi_er_type {
 	MHI_ER_TYPE_INVALID = 0x0,
-- 
2.25.1

