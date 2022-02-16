Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42D4B7C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbiBPBHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245279AbiBPBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04453F540A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so506763wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sIg3BV9tyTI60f71oJe0AuyH0e4O8yLVbZtdgQuv8g=;
        b=67k/oTcd41T/3ZTK37JMx0MalVfS/bQ1yVWnY8OsVGxXWmJd0IQZyLPVmc2heY/UTb
         V7BHIROQBlmbEXLp8Piutly5o32c1NxEDssGiyqJ3BNIfahnSsyWiOmO7QlfB+7H1f46
         A1M1FxzYXscyVqP7pbeEus4IlhcIX9rM2N8ydKLD1v7gacPvG0Etgez9b1t4o/cgfZcv
         av+jsTtlT2lN9e21nRLPVBZg/zwjRMZ0gUQo5suNyfh6txZOEv1fvGlvC4gQRhn4/f62
         mDkEfSU0/i4PJpTijK35Nre28soGT1HjqIqkmjaN5YT1lNLGvtSnK9roJBmKrX/t40kd
         t/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sIg3BV9tyTI60f71oJe0AuyH0e4O8yLVbZtdgQuv8g=;
        b=2LdeOC29JcLryOFJSq/ukIDL6R7adAtuDV9kifG7e50sd6nL+Pgpl0GW44XQgH7fPe
         h3XGlLbmpX388/ijjQwKL8B6wJde+at/oU6dBBJrR9LDnd3HV0nPg0BxzOFAdRt7i/bg
         JdPwN0omf+2ZzJwaGmbHwnV5K7fcRnPIPzs9ouswQsOURbatQisr3GlnUjTFUGmygKSF
         HxVGnylE8sv5vqV3suLKmGv0MhXqoajqzjz5ZTG1+XEV3eyjJKhqEOT2QOmU4Gh+x3br
         3XCx9VSYheQW+xsriJzhFW9TWZqB8oYegV18QvjPp8P6revqfWoUxa/vIg06hPwjLhXV
         JOYA==
X-Gm-Message-State: AOAM532H6eWxDWN03r9RT1CrtxZcZW9x65NnB6PqJY9qLYpz8Dez+40n
        tPw+7biKJCeYWgxdWXIRPu8ShQ==
X-Google-Smtp-Source: ABdhPJyadk1/exbOPhLMaxhpq8icKd3Nz0oc72Zdvn4CeSDgFAjMXJl5jvw4iL6d22fAwxak0zcvJg==
X-Received: by 2002:a05:600c:35cb:b0:37e:34c8:c375 with SMTP id r11-20020a05600c35cb00b0037e34c8c375mr21414wmq.78.1644973635415;
        Tue, 15 Feb 2022 17:07:15 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:14 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 05/15] staging: r8188eu: remove DBG_88E calls from hal subdir
Date:   Wed, 16 Feb 2022 01:06:59 +0000
Message-Id: <20220216010709.791-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all remaining DBG_88E calls from the hal subdirectory. After some
thought, it makes more sense to just entirely strip all of these calls,
so that debugging code in the driver can be more consistent and useful
going forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  1 -
 drivers/staging/r8188eu/hal/hal_intf.c        |  3 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 26 +-----------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 40 +-----------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  4 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  5 +--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 42 +------------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 17 --------
 9 files changed, 9 insertions(+), 131 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 47ad4ea273cc..eb22ac17c586 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -64,7 +64,6 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcmd[])
 					udelay(10);
 
 				if (poll_count++ > max_poll_count) {
-					DBG_88E("Fail to polling Offset[%#x]\n", offset);
 					return false;
 				}
 			} while (!poll_bit);
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index fee3a598b59d..008098040a07 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -21,7 +21,6 @@ uint	 rtw_hal_init(struct adapter *adapt)
 			hal_notch_filter_8188e(adapt, 1);
 	} else {
 		adapt->hw_init_completed = false;
-		DBG_88E("rtw_hal_init: hal__init fail\n");
 	}
 
 	return status;
@@ -36,7 +35,7 @@ uint rtw_hal_deinit(struct adapter *adapt)
 	if (status == _SUCCESS)
 		adapt->hw_init_completed = false;
 	else
-		DBG_88E("\n rtw_hal_deinit: hal_init fail\n");
+		;
 
 	return status;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index a491c37777df..93dfd3dee59b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -55,7 +55,6 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	u32 h2c_cmd_ex = 0;
 
 	if (!adapt->bFWReady) {
-		DBG_88E("FillH2CCmd_88E(): return H2C cmd because fw is not ready\n");
 		return _FAIL;
 	}
 
@@ -67,7 +66,6 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 		h2c_box_num = haldata->LastHMEBoxNum;
 
 		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
-			DBG_88E(" fw read cmd failed...\n");
 			return _FAIL;
 		}
 
@@ -115,7 +113,6 @@ u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
 
 		FillH2CCmd_88E(adapt, H2C_DM_MACID_CFG, 3, buf);
 	} else {
-		DBG_88E("==>%s fw dont support RA\n", __func__);
 		res = _FAIL;
 	}
 
@@ -157,9 +154,6 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 	struct pwrctrl_priv *pwrpriv = &adapt->pwrctrlpriv;
 	u8 RLBM = 0; /*  0:Min, 1:Max, 2:User define */
 
-	DBG_88E("%s: Mode=%d SmartPS=%d UAPSD=%d\n", __func__,
-		Mode, pwrpriv->smart_ps, adapt->registrypriv.uapsd_enable);
-
 	switch (Mode) {
 	case PS_MODE_ACTIVE:
 		H2CSetPwrMode.Mode = 0;
@@ -200,12 +194,8 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 
 void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
 {
-	u8 opmode, macid;
 	u16 mst_rpt = le16_to_cpu(mstatus_rpt);
-	opmode = (u8)mst_rpt;
-	macid = (u8)(mst_rpt >> 8);
 
-	DBG_88E("### %s: MStatus=%x MACID=%d\n", __func__, opmode, macid);
 	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
 }
 
@@ -286,7 +276,6 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 _ConstructBeacon:
 
 	if ((pktlen + TXDESC_SIZE) > 512) {
-		DBG_88E("beacon frame too large\n");
 		return;
 	}
 
@@ -453,10 +442,8 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	u32 TotalPacketLen;
 	struct rsvdpage_loc RsvdPageLoc;
 
-	DBG_88E("%s\n", __func__);
 	ReservedPagePacket = kzalloc(1000, GFP_KERNEL);
 	if (!ReservedPagePacket) {
-		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
 		return;
 	}
 
@@ -535,7 +522,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 
 	rtl8188eu_mgnt_xmit(adapt, pmgntframe);
 
-	DBG_88E("%s: Set RSVD page location to Fw\n", __func__);
 	FillH2CCmd_88E(adapt, H2C_COM_RSVD_PAGE, sizeof(RsvdPageLoc), (u8 *)&RsvdPageLoc);
 
 exit:
@@ -552,8 +538,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	u8 DLBcnCount = 0;
 	u32 poll = 0;
 
-	DBG_88E("%s mstatus(%x)\n", __func__, mstatus);
-
 	if (mstatus == 1) {
 		/*  We should set AID, correct TSF, HW seq enable before set JoinBssReport to Fw in 88/92C. */
 		/*  Suggested by filen. Added by tynli. */
@@ -571,7 +555,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(4));
 
 		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
-			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
 			bSendBeacon = true;
 		}
 
@@ -599,9 +582,9 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
 			;
 		else if (!bcn_valid)
-			DBG_88E("%s: 1 Download RSVD page failed! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
+			;
 		else
-			DBG_88E("%s: 1 Download RSVD success! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
+			;
 		/*  */
 		/*  We just can send the reserved page twice during the time that Tx thread is stopped (e.g. pnpsetpower) */
 		/*  because we need to free the Tx BCN Desc which is used by the first reserved page packet. */
@@ -626,7 +609,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  Update RSVD page location H2C to Fw. */
 		if (bcn_valid) {
 			SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
-			DBG_88E("Set RSVD page location to Fw.\n");
 		}
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
@@ -646,11 +628,9 @@ void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 
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
@@ -690,11 +670,9 @@ void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
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
index 8fe74e21992e..f83ae7a7e5d9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -20,7 +20,6 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
 		if (!padapter->bFWReady) {
-			DBG_88E("bFWReady == false call reset 8051...\n");
 			rtw_reset_8051(padapter);
 		}
 
@@ -78,13 +77,11 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuseTbl) {
-		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
 		goto exit;
 	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
 	if (!eFuseWord) {
-		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto exit;
 	}
 
@@ -102,7 +99,6 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
-		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
 		goto exit;
 	}
 
@@ -207,8 +203,6 @@ static void efuse_read_phymap_from_txpktbuf(
 	if (bcnhead < 0) /* if not valid */
 		bcnhead = rtw_read8(adapter, REG_TDECTRL + 1);
 
-	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
-
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 
 	dbg_addr = bcnhead * 128 / 8; /* 8-bytes addressing */
@@ -220,7 +214,6 @@ static void efuse_read_phymap_from_txpktbuf(
 		start = jiffies;
 		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
 		       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
-			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, rtw_read8(adapter, 0x106));
 			rtw_usleep_os(100);
 		}
 
@@ -233,14 +226,12 @@ static void efuse_read_phymap_from_txpktbuf(
 			 * do not remove it as the rtw_read16() call consumes
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
@@ -261,7 +252,6 @@ static void efuse_read_phymap_from_txpktbuf(
 		i++;
 	}
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, DISABLE_TRXPKT_BUF_ACCESS);
-	DBG_88E("%s read count:%u\n", __func__, count);
 	*size = count;
 }
 
@@ -285,7 +275,6 @@ s32 rtl8188e_iol_efuse_patch(struct adapter *padapter)
 {
 	s32	result = _SUCCESS;
 
-	DBG_88E("==> %s\n", __func__);
 	if (rtw_IOL_applied(padapter)) {
 		iol_mode_enable(padapter, 1);
 		result = iol_execute(padapter, CMD_READ_EFUSE_MAP);
@@ -385,19 +374,16 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
 	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) {/*  total E-Fuse table is 512bytes */
-		DBG_88E("Hal_EfuseReadEFuse88E(): Invalid offset(%#x) with read bytes(%#x)!!\n", _offset, _size_byte);
 		goto exit;
 	}
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuseTbl) {
-		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
 		goto exit;
 	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
 	if (!eFuseWord) {
-		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto exit;
 	}
 
@@ -415,7 +401,6 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
-		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, *rtemp8);
 		goto exit;
 	}
 
@@ -542,11 +527,9 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet)
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
@@ -554,10 +537,8 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet)
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
-		DBG_88E("Enable notch filter\n");
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
 	} else {
-		DBG_88E("Disable notch filter\n");
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
 	}
 }
@@ -791,11 +772,6 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 		/*  decide hw if support remote wakeup function */
 		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
-
-		DBG_88E("%s , bSupportRemoteWakeup(%x)\n", __func__,
-			padapter->pwrctrlpriv.bSupportRemoteWakeup);
-
-		DBG_88E("### PS params =>  power_mgnt(%x), usbss_enable(%x) ###\n", padapter->registrypriv.power_mgnt, padapter->registrypriv.usbss_enable);
 	}
 }
 
@@ -816,17 +792,10 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
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
@@ -837,7 +806,6 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	} else {
 		pHalData->EEPROMRegulatory = 0;
 	}
-	DBG_88E("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory);
 }
 
 void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
@@ -851,7 +819,6 @@ void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoa
 	} else {
 		pHalData->CrystalCap = EEPROM_Default_CrystalCap_88E;
 	}
-	DBG_88E("CrystalCap: 0x%2x\n", pHalData->CrystalCap);
 }
 
 void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
@@ -861,8 +828,6 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool Auto
 					  hwinfo ? hwinfo[EEPROM_ChannelPlan_88E] : 0xFF,
 					  padapter->registrypriv.channel_plan,
 					  RT_CHANNEL_DOMAIN_WORLD_WIDE_13, AutoLoadFail);
-
-	DBG_88E("mlmepriv.ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan);
 }
 
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
@@ -894,7 +859,6 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 	} else {
 		pHalData->AntDivCfg = 0;
 	}
-	DBG_88E("EEPROM : AntDivCfg = %x, TRxAntDivType = %x\n", pHalData->AntDivCfg, pHalData->TRxAntDivType);
 }
 
 void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
@@ -909,6 +873,4 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 
 	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
-
-	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index b0e5b9f6a005..5c8d43014603 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -685,7 +685,7 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	if (Adapter->bNotifyChannelChange)
-		DBG_88E("[%s] ch = %d\n", __func__, channel);
+		;
 
 	/* s1. pre common command - CmdID_SetTxPowerLevel */
 	PHY_SetTxPowerLevel8188E(Adapter, channel);
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 8031ac9f9d43..08bdf715d872 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -107,11 +107,11 @@ void rtl8188eu_free_recv_priv(struct adapter *padapter)
 	kfree(precvpriv->pallocated_recv_buf);
 
 	if (skb_queue_len(&precvpriv->rx_skb_queue))
-		DBG_88E(KERN_WARNING "rx_skb_queue not empty\n");
+		;
 	skb_queue_purge(&precvpriv->rx_skb_queue);
 
 	if (skb_queue_len(&precvpriv->free_recv_skb_queue))
-		DBG_88E(KERN_WARNING "free_recv_skb_queue not empty, %d\n", skb_queue_len(&precvpriv->free_recv_skb_queue));
+		;
 
 	skb_queue_purge(&precvpriv->free_recv_skb_queue);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index f2555c97b0c4..db6ad97d6a2b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -265,10 +265,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
 	} else if ((pxmitframe->frame_tag & 0x0f) == TXAGG_FRAMETAG) {
-		DBG_88E("pxmitframe->frame_tag == TXAGG_FRAMETAG\n");
 	} else {
-		DBG_88E("pxmitframe->frame_tag = %d\n", pxmitframe->frame_tag);
-
 		/* offset 4 */
 		ptxdesc->txdw1 |= cpu_to_le32((4) & 0x3f);/* CAM_ID(MAC_ID) */
 
@@ -573,7 +570,7 @@ static s32 xmitframe_direct(struct adapter *adapt, struct xmit_frame *pxmitframe
 	if (res == _SUCCESS)
 		rtw_dump_xframe(adapt, pxmitframe);
 	else
-		DBG_88E("==> %s xmitframe_coalsece failed\n", __func__);
+		;
 	return res;
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3b8869455166..cc11ddac86b7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -33,7 +33,6 @@ static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 	default:
 		break;
 	}
-	DBG_88E("%s OutEpQueueSel(0x%02x), OutEpNumber(%d)\n", __func__, haldata->OutEpQueueSel, haldata->OutEpNumber);
 }
 
 static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPipe)
@@ -59,7 +58,6 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 		return _SUCCESS;
 
 	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW)) {
-		DBG_88E(KERN_ERR "%s: run power on flow fail\n", __func__);
 		return _FAIL;
 	}
 
@@ -495,7 +493,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 
 	if (haldata->AntDivCfg == 0)
 		return;
-	DBG_88E("==>  %s ....\n", __func__);
 
 	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
 	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
@@ -504,7 +501,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 		haldata->CurAntenna = Antenna_A;
 	else
 		haldata->CurAntenna = Antenna_B;
-	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
 }
 
 static void hw_var_set_macaddr(struct adapter *Adapter, u8 *val)
@@ -527,7 +523,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
-	u32 init_start_time = jiffies;
 
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
@@ -575,7 +570,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	status = rtl8188e_firmware_download(Adapter);
 
 	if (status != _SUCCESS) {
-		DBG_88E("%s: Download Firmware failed!!\n", __func__);
 		Adapter->bFWReady = false;
 		haldata->fw_ractrl = false;
 		return status;
@@ -589,7 +583,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	status = PHY_MACConfig8188E(Adapter);
 	if (status == _FAIL) {
-		DBG_88E(" ### Failed to init MAC ......\n ");
 		goto exit;
 	}
 
@@ -598,19 +591,16 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  */
 	status = PHY_BBConfig8188E(Adapter);
 	if (status == _FAIL) {
-		DBG_88E(" ### Failed to init BB ......\n ");
 		goto exit;
 	}
 
 	status = PHY_RFConfig8188E(Adapter);
 	if (status == _FAIL) {
-		DBG_88E(" ### Failed to init RF ......\n ");
 		goto exit;
 	}
 
 	status = rtl8188e_iol_efuse_patch(Adapter);
 	if (status == _FAIL) {
-		DBG_88E("%s  rtl8188e_iol_efuse_patch failed\n", __func__);
 		goto exit;
 	}
 
@@ -731,8 +721,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
 
 exit:
-	DBG_88E("%s in %dms\n", __func__, rtw_get_passing_time_ms(init_start_time));
-
 	return status;
 }
 
@@ -794,13 +782,9 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
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
@@ -869,9 +853,6 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM);
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
-	DBG_88E("Boot from %s, Autoload %s !\n", (eeprom->EepromOrEfuse ? "EEPROM" : "EFUSE"),
-		(eeprom->bautoload_fail_flag ? "Fail" : "OK"));
-
 	if (!is_boot_from_eeprom(Adapter))
 		EFUSE_ShadowMapUpdate(Adapter);
 
@@ -932,8 +913,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
 	val8 |= mode;
 	rtw_write8(Adapter, MSR, val8);
 
-	DBG_88E("%s()-%d mode = %d\n", __func__, __LINE__, mode);
-
 	if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
 		StopTxBeacon(Adapter);
 
@@ -1010,7 +989,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  For 8190, we select only 24M, 12M, 6M, 11M, 5.5M, 2M, and 1M from the Basic rate. */
 			/*  We do not use other rates. */
 			HalSetBrateCfg(Adapter, val, &BrateCfg);
-			DBG_88E("HW_VAR_BASIC_RATE: BrateCfg(%#x)\n", BrateCfg);
 
 			/* 2011.03.30 add by Luke Lee */
 			/* CCK 2M ACK should be disabled for some BCM and Atheros AP IOT */
@@ -1220,7 +1198,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			else
 				AcmCtrl &= (~AcmHw_BeqEn);
 
-			DBG_88E("[HW_VAR_ACM_CTRL] Write 0x%X\n", AcmCtrl);
 			rtw_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
 		}
 		break;
@@ -1360,7 +1337,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 						break;
 				} while (trycnt--);
 				if (trycnt == 0)
-					DBG_88E("Stop RX DMA failed......\n");
+					;
 
 				/* RQPN Load 0 */
 				rtw_write16(Adapter, REG_RQPN_NPQ, 0x0);
@@ -1372,7 +1349,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_TX_RPT_MAX_MACID:
 		{
 			u8 maxMacid = *val;
-			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid + 1);
 			rtw_write8(Adapter, REG_TX_RPT_CTRL + 1, maxMacid + 1);
 		}
 		break;
@@ -1456,16 +1432,7 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 		break;
 	case HW_DEF_RA_INFO_DUMP:
 		{
-			u8 entry_id = *((u8 *)pValue);
 			if (check_fwstate(&Adapter->mlmepriv, _FW_LINKED)) {
-				DBG_88E("============ RA status check ===================\n");
-				DBG_88E("Mac_id:%d , RateID = %d, RAUseRate = 0x%08x, RateSGI = %d, DecisionRate = 0x%02x ,PTStage = %d\n",
-					entry_id,
-					haldata->odmpriv.RAInfo[entry_id].RateID,
-					haldata->odmpriv.RAInfo[entry_id].RAUseRate,
-					haldata->odmpriv.RAInfo[entry_id].RateSGI,
-					haldata->odmpriv.RAInfo[entry_id].DecisionRate,
-					haldata->odmpriv.RAInfo[entry_id].PTStage);
 			}
 		}
 		break;
@@ -1493,15 +1460,12 @@ void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 
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
@@ -1510,7 +1474,6 @@ void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 					pDigTable->CurIGValue = rtw_read8(Adapter, 0xc50);
 				}
 				podmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
-				DBG_88E("==> Turn on all dynamic function...\n");
 			}
 		}
 		break;
@@ -1574,8 +1537,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 
 	rate_bitmap = 0x0fffffff;
 	rate_bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, mac_id, mask, rssi_level);
-	DBG_88E("%s => mac_id:%d, networkType:0x%02x, mask:0x%08x\n\t ==> rssi_level:%d, rate_bitmap:0x%08x\n",
-		__func__, mac_id, networkType, mask, rssi_level, rate_bitmap);
 
 	mask &= rate_bitmap;
 
@@ -1589,7 +1550,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 		if (shortGIrate)
 			arg |= BIT(5);
 		mask |= ((raid << 28) & 0xf0000000);
-		DBG_88E("update raid entry, mask=0x%x, arg=0x%x\n", mask, arg);
 		psta->ra_mask = mask;
 		mask |= ((raid << 28) & 0xf0000000);
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index b7b51af7f2c3..2f3cdc356d2a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -210,7 +210,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
 		if (!precvframe) {
-			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
 			goto _exit_recvbuf2recvframe;
 		}
 
@@ -223,8 +222,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pattrib = &precvframe->attrib;
 
 		if ((pattrib->crc_err) || (pattrib->icv_err)) {
-			DBG_88E("%s: RX Warning! crc_err=%d icv_err=%d, skip!\n", __func__, pattrib->crc_err, pattrib->icv_err);
-
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -235,7 +232,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_offset = RXDESC_SIZE + pattrib->drvinfo_sz + pattrib->shift_sz + pattrib->pkt_len;
 
 		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
-			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfoer_len\n", __func__, __LINE__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -276,7 +272,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 			precvframe->rx_data = pkt_copy->data;
 		} else {
 			if ((pattrib->mfrag == 1) && (pattrib->frag_num == 0)) {
-				DBG_88E("recvbuf2recvframe: alloc_skb fail , drop frag frame\n");
 				rtw_free_recvframe(precvframe, pfree_recv_queue);
 				goto _exit_recvbuf2recvframe;
 			}
@@ -287,7 +282,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 				precvframe->rx_data = precvframe->rx_tail;
 				precvframe->rx_end =  pbuf + pattrib->drvinfo_sz + RXDESC_SIZE + alloc_sz;
 			} else {
-				DBG_88E("recvbuf2recvframe: skb_clone fail\n");
 				rtw_free_recvframe(precvframe, pfree_recv_queue);
 				goto _exit_recvbuf2recvframe;
 			}
@@ -341,7 +335,6 @@ void rtl8188eu_recv_tasklet(unsigned long priv)
 
 	while (NULL != (pskb = skb_dequeue(&precvpriv->rx_skb_queue))) {
 		if ((adapt->bDriverStopped) || (adapt->bSurpriseRemoved)) {
-			DBG_88E("recv_tasklet => bDriverStopped or bSurpriseRemoved\n");
 			dev_kfree_skb_any(pskb);
 			break;
 		}
@@ -362,9 +355,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (adapt->bSurpriseRemoved || adapt->bDriverStopped || adapt->bReadPortCancel) {
 		precvbuf->reuse = true;
-		DBG_88E("%s() RX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bReadPortCancel(%d)\n",
-			__func__, adapt->bDriverStopped,
-			adapt->bSurpriseRemoved, adapt->bReadPortCancel);
 		return;
 	}
 
@@ -372,7 +362,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
 			precvbuf->reuse = true;
 			rtw_read_port(adapt, (unsigned char *)precvbuf);
-			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
 		} else {
 			rtw_reset_continual_urb_error(adapter_to_dvobj(adapt));
 
@@ -388,7 +377,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			rtw_read_port(adapt, (unsigned char *)precvbuf);
 		}
 	} else {
-		DBG_88E("###=> usb_read_port_complete => urb status(%d)\n", purb->status);
 		skb_put(precvbuf->pskb, purb->actual_length);
 		precvbuf->pskb = NULL;
 
@@ -409,7 +397,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			rtw_read_port(adapt, (unsigned char *)precvbuf);
 			break;
 		case -EINPROGRESS:
-			DBG_88E("ERROR: URB IS IN PROGRESS!/n");
 			break;
 		default:
 			break;
@@ -449,7 +436,6 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
 		if (!precvbuf->pskb) {
-			DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
 			return _FAIL;
 		}
 
@@ -487,8 +473,6 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 
 	err = usb_submit_urb(purb, GFP_ATOMIC);
 	if ((err) && (err != (-EPERM))) {
-		DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
-			err, purb->status);
 		ret = _FAIL;
 	}
 
@@ -508,7 +492,6 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
 		if ((adapt->bDriverStopped) ||
 		    (adapt->bSurpriseRemoved) ||
 		    (adapt->bWritePortCancel)) {
-			DBG_88E("xmit_tasklet => bDriverStopped or bSurpriseRemoved or bWritePortCancel\n");
 			break;
 		}
 
-- 
2.34.1

