Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5784ECDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350919AbiC3UOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350907AbiC3UOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:14:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8666F90
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:12:28 -0700 (PDT)
Received: from dslb-178-004-172-185.178.004.pools.vodafone-ip.de ([178.4.172.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nZefz-0007FS-Se; Wed, 30 Mar 2022 22:12:19 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: remove the "dump tx packet" fragments
Date:   Wed, 30 Mar 2022 22:12:10 +0200
Message-Id: <20220330201210.175941-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330201210.175941-1-martin@kaiser.cx>
References: <20220330201210.175941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the code fragments for printing outgoing packets.

There's only a hal variable HAL_DEF_DBG_DUMP_TXPKT and the bDumpTxPkt
component of struct hal_data_8188e.

The hal variable is set by a private ioctl, it's never read.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h     | 1 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c   | 4 ----
 4 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 0b6bf84acff6..2e6fe9885c16 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1401,9 +1401,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 	case HAL_DEF_DBG_DM_FUNC:
 		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
 		break;
-	case HAL_DEF_DBG_DUMP_TXPKT:
-		*((u8 *)pValue) = haldata->bDumpTxPkt;
-		break;
 	default:
 		break;
 	}
@@ -1433,9 +1430,6 @@ void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 			}
 		}
 		break;
-	case HAL_DEF_DBG_DUMP_TXPKT:
-		haldata->bDumpTxPkt = *((u8 *)pValue);
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 8ecb49c4f038..c18f130f8153 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -46,7 +46,6 @@ enum hal_def_variable {
 	HAL_DEF_IS_SUPPORT_ANT_DIV,
 	HAL_DEF_CURRENT_ANTENNA,
 	HAL_DEF_DBG_DM_FUNC,/* for dbg */
-	HAL_DEF_DBG_DUMP_TXPKT,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5bda353b6a41..d2a069d4e1cc 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -160,8 +160,6 @@ struct hal_data_8188e {
 	u8	AntDivCfg;
 	u8	TRxAntDivType;
 
-	u8	bDumpTxPkt;/* for debug */
-
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index a45d60a7c19b..7df213856d66 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3632,10 +3632,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			break;
 		case 0x09:
 			break;
-		case 0x0c:/* dump rx/tx packet */
-			if (arg == 1)
-				SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DUMP_TXPKT, &extra_arg);
-			break;
 		case 0x15:
 			break;
 		case 0x10:/*  driver version display */
-- 
2.30.2

