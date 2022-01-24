Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D049AB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254739AbiAYEqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1326491AbiAYDlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:41:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8820C058CAC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so481495wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WlZLLRyZ4SHViNVZB+Qp8/e8sMvx5dm6fDWzkhUMfA=;
        b=KnJ4zjcQovtXFpZCbP0Q+ORsiV5LQacEuJbwYuofIVx3UVUquWPp1580eEojCPQpB1
         9xg6AadcOeZuMxPLFV1oMccgbGqvKUjufVR97tUWiWrrUN6a0joTvhxUZ23fFWAXscQ1
         9mkuSxH9SbskZ75VDyNU2nTlsPuNpBbnpjZPZ40p6o67b0FC/EyJWpyVh+gUifRKAMKb
         QnIRzyJltJmvRFWf2SHWqbFjfRDx52tyFNgVlmBOMoIOAQ6B3Oa/AFFhTVe273VC5AVh
         /nJx58aHluzAvm7HPf2txJWLxJ+3hDOIPUIxifWG1pX7Sn4iHzK8n6rGcRkHc+iF1seK
         cpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WlZLLRyZ4SHViNVZB+Qp8/e8sMvx5dm6fDWzkhUMfA=;
        b=PpoXRkXXSnc+zekn/Ek1kugFULkgMf+PFgQ/dGIR9TOzvzotyz/Ol4dtmCvhODRNvR
         hX93xWFOL2E41DCqoBynuV1EO0eHd2cS7nDGYoQAZ6AX122BABe175X81s/KporGYpjN
         i/L+Z/ASV4Jp9O+7B9LKPIH8sXDfdMz/EsVCVHZXLiz1V4mbROF7z170dGNNQL4ZWHZf
         jgWCtMOr/g/FqRApfNiwbxPEmVk7GBzLgvMCGdERSV4cISqBPHHzLt7nCZQAokAwCOf6
         bcdnakYxMCeCmgg6TrWCUuVZ75nOHauseCs7jbsegzXiCzxYqxzbIovS+GT54Rc85SM3
         DgYQ==
X-Gm-Message-State: AOAM531ILDq0VfzZLI3Z6KkGpBYvagA7L2DXaJdL8oqvTxwp2/emd3x5
        3zayi86RwoqRu/BYQJiuaCoZQg==
X-Google-Smtp-Source: ABdhPJy0Kv8LQyCbfGKFVGYgrlmuE1mdpgNjOTTIqSmjamIsVI6D+5KGayuu/4y12KIkF9W+H6lWlQ==
X-Received: by 2002:a05:600c:4144:: with SMTP id h4mr416107wmm.0.1643064654064;
        Mon, 24 Jan 2022 14:50:54 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id g189sm624742wme.18.2022.01.24.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:50:53 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 04/10] staging: r8188eu: remove all DBG_88E calls from hal dir
Date:   Mon, 24 Jan 2022 22:50:26 +0000
Message-Id: <20220124225032.860-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124225032.860-1-phil@philpotter.co.uk>
References: <20220124225032.860-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from the hal directory. These calls do not
conform to kernel coding standards and are superfluous. Also restructure
where appropriate to remove no longer needed code left behind by removal
of these calls. This will allow the eventual removal of the DBG_88E macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  4 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |  3 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 43 ++-------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 94 ++++---------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  3 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  5 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  8 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 62 +-----------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 31 +-----
 9 files changed, 33 insertions(+), 220 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 47ad4ea273cc..5b91aec6a7e3 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -63,10 +63,8 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcmd[])
 				else
 					udelay(10);
 
-				if (poll_count++ > max_poll_count) {
-					DBG_88E("Fail to polling Offset[%#x]\n", offset);
+				if (poll_count++ > max_poll_count)
 					return false;
-				}
 			} while (!poll_bit);
 			break;
 		case PWR_CMD_DELAY:
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index fee3a598b59d..37935aef71ea 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -21,7 +21,6 @@ uint	 rtw_hal_init(struct adapter *adapt)
 			hal_notch_filter_8188e(adapt, 1);
 	} else {
 		adapt->hw_init_completed = false;
-		DBG_88E("rtw_hal_init: hal__init fail\n");
 	}
 
 	return status;
@@ -35,8 +34,6 @@ uint rtw_hal_deinit(struct adapter *adapt)
 
 	if (status == _SUCCESS)
 		adapt->hw_init_completed = false;
-	else
-		DBG_88E("\n rtw_hal_deinit: hal_init fail\n");
 
 	return status;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index a491c37777df..ba5421daf56d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -54,10 +54,8 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	u32 h2c_cmd = 0;
 	u32 h2c_cmd_ex = 0;
 
-	if (!adapt->bFWReady) {
-		DBG_88E("FillH2CCmd_88E(): return H2C cmd because fw is not ready\n");
+	if (!adapt->bFWReady)
 		return _FAIL;
-	}
 
 	if (!pCmdBuffer || CmdLen > RTL88E_MAX_CMD_LEN || adapt->bSurpriseRemoved)
 		return _FAIL;
@@ -66,10 +64,8 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	do {
 		h2c_box_num = haldata->LastHMEBoxNum;
 
-		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
-			DBG_88E(" fw read cmd failed...\n");
+		if (!_is_fw_read_cmd_down(adapt, h2c_box_num))
 			return _FAIL;
-		}
 
 		*(u8 *)(&h2c_cmd) = ElementID;
 
@@ -115,7 +111,6 @@ u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
 
 		FillH2CCmd_88E(adapt, H2C_DM_MACID_CFG, 3, buf);
 	} else {
-		DBG_88E("==>%s fw dont support RA\n", __func__);
 		res = _FAIL;
 	}
 
@@ -157,9 +152,6 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 	struct pwrctrl_priv *pwrpriv = &adapt->pwrctrlpriv;
 	u8 RLBM = 0; /*  0:Min, 1:Max, 2:User define */
 
-	DBG_88E("%s: Mode=%d SmartPS=%d UAPSD=%d\n", __func__,
-		Mode, pwrpriv->smart_ps, adapt->registrypriv.uapsd_enable);
-
 	switch (Mode) {
 	case PS_MODE_ACTIVE:
 		H2CSetPwrMode.Mode = 0;
@@ -205,7 +197,6 @@ void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
 	opmode = (u8)mst_rpt;
 	macid = (u8)(mst_rpt >> 8);
 
-	DBG_88E("### %s: MStatus=%x MACID=%d\n", __func__, opmode, macid);
 	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
 }
 
@@ -285,10 +276,8 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 
 _ConstructBeacon:
 
-	if ((pktlen + TXDESC_SIZE) > 512) {
-		DBG_88E("beacon frame too large\n");
+	if ((pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	*pLength = pktlen;
 }
@@ -453,12 +442,9 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	u32 TotalPacketLen;
 	struct rsvdpage_loc RsvdPageLoc;
 
-	DBG_88E("%s\n", __func__);
 	ReservedPagePacket = kzalloc(1000, GFP_KERNEL);
-	if (!ReservedPagePacket) {
-		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
+	if (!ReservedPagePacket)
 		return;
-	}
 
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
@@ -535,7 +521,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 
 	rtl8188eu_mgnt_xmit(adapt, pmgntframe);
 
-	DBG_88E("%s: Set RSVD page location to Fw\n", __func__);
 	FillH2CCmd_88E(adapt, H2C_COM_RSVD_PAGE, sizeof(RsvdPageLoc), (u8 *)&RsvdPageLoc);
 
 exit:
@@ -552,8 +537,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	u8 DLBcnCount = 0;
 	u32 poll = 0;
 
-	DBG_88E("%s mstatus(%x)\n", __func__, mstatus);
-
 	if (mstatus == 1) {
 		/*  We should set AID, correct TSF, HW seq enable before set JoinBssReport to Fw in 88/92C. */
 		/*  Suggested by filen. Added by tynli. */
@@ -570,10 +553,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(4));
 
-		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
-			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
+		if (haldata->RegFwHwTxQCtrl & BIT(6))
 			bSendBeacon = true;
-		}
 
 		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
 		rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
@@ -596,12 +577,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 
-		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
-			;
-		else if (!bcn_valid)
-			DBG_88E("%s: 1 Download RSVD page failed! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
-		else
-			DBG_88E("%s: 1 Download RSVD success! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
 		/*  */
 		/*  We just can send the reserved page twice during the time that Tx thread is stopped (e.g. pnpsetpower) */
 		/*  because we need to free the Tx BCN Desc which is used by the first reserved page packet. */
@@ -624,10 +599,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		}
 
 		/*  Update RSVD page location H2C to Fw. */
-		if (bcn_valid) {
+		if (bcn_valid)
 			SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
-			DBG_88E("Set RSVD page location to Fw.\n");
-		}
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
@@ -646,11 +619,9 @@ void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
-		DBG_88E("P2P_PS_DISABLE\n");
 		memset(p2p_ps_offload, 0, 1);
 		break;
 	case P2P_PS_ENABLE:
-		DBG_88E("P2P_PS_ENABLE\n");
 		/*  update CTWindow value. */
 		if (pwdinfo->ctwindow > 0) {
 			p2p_ps_offload->CTWindow_En = 1;
@@ -690,11 +661,9 @@ void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 		}
 		break;
 	case P2P_PS_SCAN:
-		DBG_88E("P2P_PS_SCAN\n");
 		p2p_ps_offload->discovery = 1;
 		break;
 	case P2P_PS_SCAN_DONE:
-		DBG_88E("P2P_PS_SCAN_DONE\n");
 		p2p_ps_offload->discovery = 0;
 		pwdinfo->p2p_ps_state = P2P_PS_ENABLE;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b2d1e8c50543..f8b5f09a7fd1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -19,10 +19,8 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
-		if (!padapter->bFWReady) {
-			DBG_88E("bFWReady == false call reset 8051...\n");
+		if (!padapter->bFWReady)
 			_8051Reset88E(padapter);
-		}
 
 	} else {
 		/* disable initial offload */
@@ -77,16 +75,12 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	u8 u1temp = 0;
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
-	if (!efuseTbl) {
-		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
+	if (!efuseTbl)
 		goto exit;
-	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (!eFuseWord) {
-		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+	if (!eFuseWord)
 		goto exit;
-	}
 
 	/*  0. Refresh efuse init map as all oxFF. */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
@@ -102,7 +96,6 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
-		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
 		goto exit;
 	}
 
@@ -207,8 +200,6 @@ static void efuse_read_phymap_from_txpktbuf(
 	if (bcnhead < 0) /* if not valid */
 		bcnhead = rtw_read8(adapter, REG_TDECTRL + 1);
 
-	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
-
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 
 	dbg_addr = bcnhead * 128 / 8; /* 8-bytes addressing */
@@ -220,7 +211,6 @@ static void efuse_read_phymap_from_txpktbuf(
 		start = jiffies;
 		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
 		       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
-			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, rtw_read8(adapter, 0x106));
 			rtw_usleep_os(100);
 		}
 
@@ -229,18 +219,15 @@ static void efuse_read_phymap_from_txpktbuf(
 		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
 
 		if (i == 0) {
-			/* Although lenc is only used in a debug statement,
-			 * do not remove it as the rtw_read16() call consumes
+			/* Do not remove this as the rtw_read16() call consumes
 			 * 2 bytes from the EEPROM source.
 			 */
-			u16 lenc = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
+			rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
 
 			len = le32_to_cpu(lo32) & 0x0000ffff;
 
 			limit = (len - 2 < limit) ? len - 2 : limit;
 
-			DBG_88E("%s len:%u, lenc:%u\n", __func__, len, lenc);
-
 			memcpy(pos, ((u8 *)&lo32) + 2, (limit >= count + 2) ? 2 : limit - count);
 			count += (limit >= count + 2) ? 2 : limit - count;
 			pos = content + count;
@@ -261,7 +248,6 @@ static void efuse_read_phymap_from_txpktbuf(
 		i++;
 	}
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, DISABLE_TRXPKT_BUF_ACCESS);
-	DBG_88E("%s read count:%u\n", __func__, count);
 	*size = count;
 }
 
@@ -285,7 +271,6 @@ s32 rtl8188e_iol_efuse_patch(struct adapter *padapter)
 {
 	s32	result = _SUCCESS;
 
-	DBG_88E("==> %s\n", __func__);
 	if (rtw_IOL_applied(padapter)) {
 		iol_mode_enable(padapter, 1);
 		result = iol_execute(padapter, CMD_READ_EFUSE_MAP);
@@ -465,7 +450,6 @@ void _8051Reset88E(struct adapter *padapter)
 	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
-	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
 }
 
 static s32 _FWFreeToGo(struct adapter *padapter)
@@ -480,11 +464,8 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
-	if (counter >= POLLING_READY_TIMEOUT_COUNT) {
-		DBG_88E("%s: chksum report fail! REG_MCUFWDL:0x%08x\n", __func__, value32);
+	if (counter >= POLLING_READY_TIMEOUT_COUNT)
 		return _FAIL;
-	}
-	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
 
 	value32 = rtw_read32(padapter, REG_MCUFWDL);
 	value32 |= MCUFWDL_RDY;
@@ -497,14 +478,11 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	counter = 0;
 	do {
 		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & WINTINI_RDY) {
-			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
+		if (value32 & WINTINI_RDY)
 			return _SUCCESS;
-		}
 		udelay(5);
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
-	DBG_88E("%s: Polling FW ready fail!! REG_MCUFWDL:0x%08x\n", __func__, value32);
 	return _FAIL;
 }
 
@@ -602,22 +580,14 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 		if (rtStatus == _SUCCESS ||
 		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && writeFW_retry++ >= 3))
 			break;
-
-		DBG_88E("%s writeFW_retry:%u, time after fwdl_start_time:%ums\n",
-			__func__, writeFW_retry, rtw_get_passing_time_ms(fwdl_start_time)
-		);
 	}
 	_FWDownloadEnable(padapter, false);
-	if (_SUCCESS != rtStatus) {
-		DBG_88E("DL Firmware failed!\n");
+	if (rtStatus != _SUCCESS)
 		goto Exit;
-	}
 
 	rtStatus = _FWFreeToGo(padapter);
-	if (_SUCCESS != rtStatus) {
-		DBG_88E("DL Firmware failed!\n");
+	if (rtStatus != _SUCCESS)
 		goto Exit;
-	}
 
 Exit:
 	return rtStatus;
@@ -690,22 +660,16 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
-	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) {/*  total E-Fuse table is 512bytes */
-		DBG_88E("Hal_EfuseReadEFuse88E(): Invalid offset(%#x) with read bytes(%#x)!!\n", _offset, _size_byte);
+	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) /*  total E-Fuse table is 512bytes */
 		goto exit;
-	}
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
-	if (!efuseTbl) {
-		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
+	if (!efuseTbl)
 		goto exit;
-	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (!eFuseWord) {
-		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+	if (!eFuseWord)
 		goto exit;
-	}
 
 	/*  0. Refresh efuse init map as all oxFF. */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
@@ -721,7 +685,6 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
-		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, *rtemp8);
 		goto exit;
 	}
 
@@ -851,24 +814,19 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet)
 	struct sta_info *psta = (struct sta_info *)pValue1;
 
 	if (bSet) {
-		DBG_88E("### Set STA_(%d) info\n", psta->mac_id);
 		podmpriv->pODM_StaInfo[psta->mac_id] = psta;
 		ODM_RAInfo_Init(podmpriv, psta->mac_id);
 	} else {
-		DBG_88E("### Clean STA_(%d) info\n", psta->mac_id);
 		podmpriv->pODM_StaInfo[psta->mac_id] = NULL;
 	}
 }
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
-	if (enable) {
-		DBG_88E("Enable notch filter\n");
+	if (enable)
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
-	} else {
-		DBG_88E("Disable notch filter\n");
+	else
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
-	}
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
@@ -1092,20 +1050,14 @@ static void hal_get_chnl_group_88e(u8 chnl, u8 *group)
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
 {
-	if (AutoLoadFail) {
+	if (AutoLoadFail)
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = false;
-	} else {
+	else
 		/* hw power down mode selection , 0:rf-off / 1:power down */
 
 		/*  decide hw if support remote wakeup function */
 		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
-
-		DBG_88E("%s , bSupportRemoteWakeup(%x)\n", __func__,
-			padapter->pwrctrlpriv.bSupportRemoteWakeup);
-
-		DBG_88E("### PS params =>  power_mgnt(%x), usbss_enable(%x) ###\n", padapter->registrypriv.power_mgnt, padapter->registrypriv.usbss_enable);
-	}
 }
 
 void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool AutoLoadFail)
@@ -1125,17 +1077,10 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 			pHalData->Index24G_BW40_Base[ch] = pwrInfo24G.IndexBW40_Base[0][4];
 		else
 			pHalData->Index24G_BW40_Base[ch] = pwrInfo24G.IndexBW40_Base[0][group];
-
-		DBG_88E("======= Path 0, Channel %d =======\n", ch);
-		DBG_88E("Index24G_CCK_Base[%d] = 0x%x\n", ch, pHalData->Index24G_CCK_Base[ch]);
-		DBG_88E("Index24G_BW40_Base[%d] = 0x%x\n", ch, pHalData->Index24G_BW40_Base[ch]);
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
 		pHalData->OFDM_24G_Diff[TxCount] = pwrInfo24G.OFDM_Diff[0][TxCount];
 		pHalData->BW20_24G_Diff[TxCount] = pwrInfo24G.BW20_Diff[0][TxCount];
-		DBG_88E("======= TxCount %d =======\n", TxCount);
-		DBG_88E("OFDM_24G_Diff[%d] = %d\n", TxCount, pHalData->OFDM_24G_Diff[TxCount]);
-		DBG_88E("BW20_24G_Diff[%d] = %d\n", TxCount, pHalData->BW20_24G_Diff[TxCount]);
 	}
 
 	/*  2010/10/19 MH Add Regulator recognize for CU. */
@@ -1146,7 +1091,6 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	} else {
 		pHalData->EEPROMRegulatory = 0;
 	}
-	DBG_88E("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory);
 }
 
 void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
@@ -1160,7 +1104,6 @@ void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoa
 	} else {
 		pHalData->CrystalCap = EEPROM_Default_CrystalCap_88E;
 	}
-	DBG_88E("CrystalCap: 0x%2x\n", pHalData->CrystalCap);
 }
 
 void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
@@ -1170,8 +1113,6 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool Auto
 					  hwinfo ? hwinfo[EEPROM_ChannelPlan_88E] : 0xFF,
 					  padapter->registrypriv.channel_plan,
 					  RT_CHANNEL_DOMAIN_WORLD_WIDE_13, AutoLoadFail);
-
-	DBG_88E("mlmepriv.ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan);
 }
 
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
@@ -1203,7 +1144,6 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 	} else {
 		pHalData->AntDivCfg = 0;
 	}
-	DBG_88E("EEPROM : AntDivCfg = %x, TRxAntDivType = %x\n", pHalData->AntDivCfg, pHalData->TRxAntDivType);
 }
 
 void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
@@ -1218,6 +1158,4 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 
 	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
-
-	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 302b15b2874d..c89b9526daf3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -761,9 +761,6 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	u32 param1, param2;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
-	if (Adapter->bNotifyChannelChange)
-		DBG_88E("[%s] ch = %d\n", __func__, channel);
-
 	/* s1. pre common command - CmdID_SetTxPowerLevel */
 	PHY_SetTxPowerLevel8188E(Adapter, channel);
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 8031ac9f9d43..6af72b3e7a7d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -106,12 +106,7 @@ void rtl8188eu_free_recv_priv(struct adapter *padapter)
 
 	kfree(precvpriv->pallocated_recv_buf);
 
-	if (skb_queue_len(&precvpriv->rx_skb_queue))
-		DBG_88E(KERN_WARNING "rx_skb_queue not empty\n");
 	skb_queue_purge(&precvpriv->rx_skb_queue);
 
-	if (skb_queue_len(&precvpriv->free_recv_skb_queue))
-		DBG_88E(KERN_WARNING "free_recv_skb_queue not empty, %d\n", skb_queue_len(&precvpriv->free_recv_skb_queue));
-
 	skb_queue_purge(&precvpriv->free_recv_skb_queue);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 293541db597d..169c6e5b1769 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -264,11 +264,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw5 |= cpu_to_le32(0x00300000);/* retry limit = 12 */
 
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
-	} else if ((pxmitframe->frame_tag & 0x0f) == TXAGG_FRAMETAG) {
-		DBG_88E("pxmitframe->frame_tag == TXAGG_FRAMETAG\n");
-	} else {
-		DBG_88E("pxmitframe->frame_tag = %d\n", pxmitframe->frame_tag);
-
+	} else if ((pxmitframe->frame_tag & 0x0f) != TXAGG_FRAMETAG) {
 		/* offset 4 */
 		ptxdesc->txdw1 |= cpu_to_le32((4) & 0x3f);/* CAM_ID(MAC_ID) */
 
@@ -567,8 +563,6 @@ static s32 xmitframe_direct(struct adapter *adapt, struct xmit_frame *pxmitframe
 	res = rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
 	if (res == _SUCCESS)
 		rtw_dump_xframe(adapt, pxmitframe);
-	else
-		DBG_88E("==> %s xmitframe_coalsece failed\n", __func__);
 	return res;
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 96db9a8e7667..b89c0befc846 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -37,7 +37,6 @@ static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 	default:
 		break;
 	}
-	DBG_88E("%s OutEpQueueSel(0x%02x), OutEpNumber(%d)\n", __func__, haldata->OutEpQueueSel, haldata->OutEpNumber);
 }
 
 static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPipe)
@@ -77,10 +76,8 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
-	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW)) {
-		DBG_88E(KERN_ERR "%s: run power on flow fail\n", __func__);
+	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW))
 		return _FAIL;
-	}
 
 	/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
 	/*  Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
@@ -559,7 +556,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 
 	if (haldata->AntDivCfg == 0)
 		return;
-	DBG_88E("==>  %s ....\n", __func__);
 
 	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
 	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
@@ -568,7 +564,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 		haldata->CurAntenna = Antenna_A;
 	else
 		haldata->CurAntenna = Antenna_B;
-	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
 }
 
 u32 rtl8188eu_hal_init(struct adapter *Adapter)
@@ -580,7 +575,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
-	u32 init_start_time = jiffies;
 
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
@@ -628,7 +622,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	status = rtl8188e_FirmwareDownload(Adapter);
 
 	if (status != _SUCCESS) {
-		DBG_88E("%s: Download Firmware failed!!\n", __func__);
 		Adapter->bFWReady = false;
 		haldata->fw_ractrl = false;
 		return status;
@@ -640,10 +633,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 #if (HAL_MAC_ENABLE == 1)
 	status = PHY_MACConfig8188E(Adapter);
-	if (status == _FAIL) {
-		DBG_88E(" ### Failed to init MAC ......\n ");
+	if (status == _FAIL)
 		goto exit;
-	}
 #endif
 
 	/*  */
@@ -651,25 +642,19 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  */
 #if (HAL_BB_ENABLE == 1)
 	status = PHY_BBConfig8188E(Adapter);
-	if (status == _FAIL) {
-		DBG_88E(" ### Failed to init BB ......\n ");
+	if (status == _FAIL)
 		goto exit;
-	}
 #endif
 
 #if (HAL_RF_ENABLE == 1)
 	status = PHY_RFConfig8188E(Adapter);
-	if (status == _FAIL) {
-		DBG_88E(" ### Failed to init RF ......\n ");
+	if (status == _FAIL)
 		goto exit;
-	}
 #endif
 
 	status = rtl8188e_iol_efuse_patch(Adapter);
-	if (status == _FAIL) {
-		DBG_88E("%s  rtl8188e_iol_efuse_patch failed\n", __func__);
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
 
@@ -790,8 +775,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
 
 exit:
-	DBG_88E("%s in %dms\n", __func__, rtw_get_passing_time_ms(init_start_time));
-
 	return status;
 }
 
@@ -853,13 +836,9 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
 {
-
-	DBG_88E("==> %s\n", __func__);
-
 	rtw_write32(Adapter, REG_HIMR_88E, IMR_DISABLED_88E);
 	rtw_write32(Adapter, REG_HIMRE_88E, IMR_DISABLED_88E);
 
-	DBG_88E("bkeepfwalive(%x)\n", Adapter->pwrctrlpriv.bkeepfwalive);
 	if (!Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (Adapter->hw_init_completed) {
 			CardDisableRTL8188EU(Adapter);
@@ -928,9 +907,6 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM);
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
-	DBG_88E("Boot from %s, Autoload %s !\n", (eeprom->EepromOrEfuse ? "EEPROM" : "EFUSE"),
-		(eeprom->bautoload_fail_flag ? "Fail" : "OK"));
-
 	if (!is_boot_from_eeprom(Adapter))
 		EFUSE_ShadowMapUpdate(Adapter);
 
@@ -991,8 +967,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 	val8 |= mode;
 	rtw_write8(Adapter, MSR, val8);
 
-	DBG_88E("%s()-%d mode = %d\n", __func__, __LINE__, mode);
-
 	if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
 		StopTxBeacon(Adapter);
 
@@ -1113,7 +1087,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  For 8190, we select only 24M, 12M, 6M, 11M, 5.5M, 2M, and 1M from the Basic rate. */
 			/*  We do not use other rates. */
 			HalSetBrateCfg(Adapter, val, &BrateCfg);
-			DBG_88E("HW_VAR_BASIC_RATE: BrateCfg(%#x)\n", BrateCfg);
 
 			/* 2011.03.30 add by Luke Lee */
 			/* CCK 2M ACK should be disabled for some BCM and Atheros AP IOT */
@@ -1410,7 +1383,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			else
 				AcmCtrl &= (~AcmHw_BeqEn);
 
-			DBG_88E("[HW_VAR_ACM_CTRL] Write 0x%X\n", AcmCtrl);
 			rtw_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
 		}
 		break;
@@ -1552,8 +1524,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 					if (!(rtw_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
-				if (trycnt == 0)
-					DBG_88E("Stop RX DMA failed......\n");
 
 				/* RQPN Load 0 */
 				rtw_write16(Adapter, REG_RQPN_NPQ, 0x0);
@@ -1564,12 +1534,10 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_APFM_ON_MAC:
 		haldata->bMacPwrCtrlOn = *val;
-		DBG_88E("%s: bMacPwrCtrlOn=%d\n", __func__, haldata->bMacPwrCtrlOn);
 		break;
 	case HW_VAR_TX_RPT_MAX_MACID:
 		{
 			u8 maxMacid = *val;
-			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid + 1);
 			rtw_write8(Adapter, REG_TX_RPT_CTRL + 1, maxMacid + 1);
 		}
 		break;
@@ -1698,19 +1666,6 @@ u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 		*((u32 *)pValue) = MAX_AMPDU_FACTOR_64K;
 		break;
 	case HW_DEF_RA_INFO_DUMP:
-		{
-			u8 entry_id = *((u8 *)pValue);
-			if (check_fwstate(&Adapter->mlmepriv, _FW_LINKED)) {
-				DBG_88E("============ RA status check ===================\n");
-				DBG_88E("Mac_id:%d , RateID = %d, RAUseRate = 0x%08x, RateSGI = %d, DecisionRate = 0x%02x ,PTStage = %d\n",
-					entry_id,
-					haldata->odmpriv.RAInfo[entry_id].RateID,
-					haldata->odmpriv.RAInfo[entry_id].RAUseRate,
-					haldata->odmpriv.RAInfo[entry_id].RateSGI,
-					haldata->odmpriv.RAInfo[entry_id].DecisionRate,
-					haldata->odmpriv.RAInfo[entry_id].PTStage);
-			}
-		}
 		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
@@ -1740,15 +1695,12 @@ u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 
 			if (dm_func == 0) { /* disable all dynamic func */
 				podmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
-				DBG_88E("==> Disable all dynamic function...\n");
 			} else if (dm_func == 1) {/* disable DIG */
 				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DIG);
-				DBG_88E("==> Disable DIG...\n");
 			} else if (dm_func == 2) {/* disable High power */
 				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DYNAMIC_TXPWR);
 			} else if (dm_func == 3) {/* disable tx power tracking */
 				podmpriv->SupportAbility  &= (~DYNAMIC_RF_CALIBRATION);
-				DBG_88E("==> Disable tx power tracking...\n");
 			} else if (dm_func == 5) {/* disable antenna diversity */
 				podmpriv->SupportAbility  &= (~DYNAMIC_BB_ANT_DIV);
 			} else if (dm_func == 6) {/* turn on all dynamic func */
@@ -1757,7 +1709,6 @@ u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 					pDigTable->CurIGValue = rtw_read8(Adapter, 0xc50);
 				}
 				podmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
-				DBG_88E("==> Turn on all dynamic function...\n");
 			}
 		}
 		break;
@@ -1824,8 +1775,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 
 	rate_bitmap = 0x0fffffff;
 	rate_bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, mac_id, mask, rssi_level);
-	DBG_88E("%s => mac_id:%d, networkType:0x%02x, mask:0x%08x\n\t ==> rssi_level:%d, rate_bitmap:0x%08x\n",
-		__func__, mac_id, networkType, mask, rssi_level, rate_bitmap);
 
 	mask &= rate_bitmap;
 
@@ -1839,7 +1788,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 		if (shortGIrate)
 			arg |= BIT(5);
 		mask |= ((raid << 28) & 0xf0000000);
-		DBG_88E("update raid entry, mask=0x%x, arg=0x%x\n", mask, arg);
 		psta->ra_mask = mask;
 		mask |= ((raid << 28) & 0xf0000000);
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 4a0ab4053e90..5e751336a224 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -209,10 +209,8 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
-		if (!precvframe) {
-			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
+		if (!precvframe)
 			goto _exit_recvbuf2recvframe;
-		}
 
 		INIT_LIST_HEAD(&precvframe->list);
 		precvframe->precvbuf = NULL;	/* can't access the precvbuf for new arch. */
@@ -223,8 +221,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pattrib = &precvframe->attrib;
 
 		if ((pattrib->crc_err) || (pattrib->icv_err)) {
-			DBG_88E("%s: RX Warning! crc_err=%d icv_err=%d, skip!\n", __func__, pattrib->crc_err, pattrib->icv_err);
-
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -235,7 +231,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_offset = RXDESC_SIZE + pattrib->drvinfo_sz + pattrib->shift_sz + pattrib->pkt_len;
 
 		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
-			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfoer_len\n", __func__, __LINE__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -276,7 +271,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 			precvframe->rx_data = pkt_copy->data;
 		} else {
 			if ((pattrib->mfrag == 1) && (pattrib->frag_num == 0)) {
-				DBG_88E("recvbuf2recvframe: alloc_skb fail , drop frag frame\n");
 				rtw_free_recvframe(precvframe, pfree_recv_queue);
 				goto _exit_recvbuf2recvframe;
 			}
@@ -287,7 +281,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 				precvframe->rx_data = precvframe->rx_tail;
 				precvframe->rx_end =  pbuf + pattrib->drvinfo_sz + RXDESC_SIZE + alloc_sz;
 			} else {
-				DBG_88E("recvbuf2recvframe: skb_clone fail\n");
 				rtw_free_recvframe(precvframe, pfree_recv_queue);
 				goto _exit_recvbuf2recvframe;
 			}
@@ -351,7 +344,6 @@ void rtl8188eu_recv_tasklet(unsigned long priv)
 
 	while (NULL != (pskb = skb_dequeue(&precvpriv->rx_skb_queue))) {
 		if ((adapt->bDriverStopped) || (adapt->bSurpriseRemoved)) {
-			DBG_88E("recv_tasklet => bDriverStopped or bSurpriseRemoved\n");
 			dev_kfree_skb_any(pskb);
 			break;
 		}
@@ -372,9 +364,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (adapt->bSurpriseRemoved || adapt->bDriverStopped || adapt->bReadPortCancel) {
 		precvbuf->reuse = true;
-		DBG_88E("%s() RX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bReadPortCancel(%d)\n",
-			__func__, adapt->bDriverStopped,
-			adapt->bSurpriseRemoved, adapt->bReadPortCancel);
 		return;
 	}
 
@@ -382,7 +371,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
 			precvbuf->reuse = true;
 			rtw_read_port(adapt, (unsigned char *)precvbuf);
-			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
 		} else {
 			rtw_reset_continual_urb_error(adapter_to_dvobj(adapt));
 
@@ -398,7 +386,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			rtw_read_port(adapt, (unsigned char *)precvbuf);
 		}
 	} else {
-		DBG_88E("###=> usb_read_port_complete => urb status(%d)\n", purb->status);
 		skb_put(precvbuf->pskb, purb->actual_length);
 		precvbuf->pskb = NULL;
 
@@ -418,9 +405,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			precvbuf->reuse = true;
 			rtw_read_port(adapt, (unsigned char *)precvbuf);
 			break;
-		case -EINPROGRESS:
-			DBG_88E("ERROR: URB IS IN PROGRESS!/n");
-			break;
 		default:
 			break;
 		}
@@ -458,10 +442,8 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	/* re-assign for linux based on skb */
 	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
-		if (!precvbuf->pskb) {
-			DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
+		if (!precvbuf->pskb)
 			return _FAIL;
-		}
 
 		tmpaddr = (size_t)precvbuf->pskb->data;
 		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
@@ -496,11 +478,8 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 			  precvbuf);/* context is precvbuf */
 
 	err = usb_submit_urb(purb, GFP_ATOMIC);
-	if ((err) && (err != (-EPERM))) {
-		DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
-			err, purb->status);
+	if ((err) && (err != (-EPERM)))
 		ret = _FAIL;
-	}
 
 	return ret;
 }
@@ -517,10 +496,8 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
 	while (1) {
 		if ((adapt->bDriverStopped) ||
 		    (adapt->bSurpriseRemoved) ||
-		    (adapt->bWritePortCancel)) {
-			DBG_88E("xmit_tasklet => bDriverStopped or bSurpriseRemoved or bWritePortCancel\n");
+		    (adapt->bWritePortCancel))
 			break;
-		}
 
 		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv, NULL);
 
-- 
2.34.1

