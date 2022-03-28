Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD394EA1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbiC1UqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbiC1Un2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDA66ACC;
        Mon, 28 Mar 2022 13:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CEE1614E4;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA63C341D3;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500104;
        bh=SyuOG3Z1QPAkbNTL5cUolETwoh2n7rjaGSIvdhq209U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqE2zbQ9XzDEtybEs9zkltOZdJeTinYTOc7r+K/1cmygbYRD9scxyY5UwBmgahLMg
         NS/ZDjeH6leVr7ld96xWHGet4WiA/ikE0Op9EZi0aRqv3LG0Bj75ewfplmPWrvzVzs
         Z9/7Rkfi5i4TpUUQ2azXNgEs9fTsV8oDSzkRMZ8DU7kx2a3fbTN+pnxdgo/G37Wx8i
         ppvskFS0wdtFI82WXSdJc6/qXkfTpeKWEAkLomD0lWhqHKxyHNYUTDHgkpe0zpI286
         /y8WDwoka0k/XGazyU9OM3xyTkzdZ5JWgPwaG9Ps1pWICqN9bgRFBvvuNbvPTpTWPf
         YJunW3hQkVBYw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBJ-000ldU-9M; Mon, 28 Mar 2022 22:41:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 26/26] media: dvb-usb: dib0700_devices: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:38 +0200
Message-Id: <028699ec71158dbc49d710a4259eb8cdb7f673cb.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device number is currently a value that needs to be the same
on two separate tables, but the code doesn't actually enforce it,
leading to errors as boards get added or removed.

Fix it by using an enum.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/dib0700_devices.c | 428 ++++++++++++--------
 include/media/dvb-usb-ids.h                 |  17 +-
 2 files changed, 268 insertions(+), 177 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index 08fcf120daf1..7f8bebfa3e8e 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -3816,99 +3816,187 @@ static int xbox_one_attach(struct dvb_usb_adapter *adap)
 
 
 /* DVB-USB and USB stuff follows */
+enum {
+	DIBCOM_STK7700P,
+	DIBCOM_STK7700P_PC,
+	HAUPPAUGE_NOVA_T_500,
+	HAUPPAUGE_NOVA_T_500_2,
+	HAUPPAUGE_NOVA_T_STICK,
+	AVERMEDIA_VOLAR,
+	COMPRO_VIDEOMATE_U500,
+	UNIWILL_STK7700P,
+	LEADTEK_WINFAST_DTV_DONGLE_STK7700P,
+	HAUPPAUGE_NOVA_T_STICK_2,
+	AVERMEDIA_VOLAR_2,
+	PINNACLE_PCTV2000E,
+	TERRATEC_CINERGY_DT_XS_DIVERSITY,
+	HAUPPAUGE_NOVA_TD_STICK,
+	DIBCOM_STK7700D,
+	DIBCOM_STK7070P,
+	PINNACLE_PCTV_DVB_T_FLASH,
+	DIBCOM_STK7070PD,
+	PINNACLE_PCTV_DUAL_DIVERSITY_DVB_T,
+	COMPRO_VIDEOMATE_U500_PC,
+	AVERMEDIA_EXPRESS,
+	GIGABYTE_U7000,
+	ULTIMA_ARTEC_T14BR,
+	ASUS_U3000,
+	ASUS_U3100,
+	HAUPPAUGE_NOVA_T_STICK_3,
+	HAUPPAUGE_MYTV_T,
+	TERRATEC_CINERGY_HT_USB_XE,
+	PINNACLE_EXPRESSCARD_320CX,
+	PINNACLE_PCTV72E,
+	PINNACLE_PCTV73E,
+	YUAN_EC372S,
+	TERRATEC_CINERGY_HT_EXPRESS,
+	TERRATEC_CINERGY_T_XXS,
+	LEADTEK_WINFAST_DTV_DONGLE_STK7700P_2,
+	HAUPPAUGE_NOVA_TD_STICK_52009,
+	HAUPPAUGE_NOVA_T_500_3,
+	GIGABYTE_U8000,
+	YUAN_STK7700PH,
+	ASUS_U3000H,
+	PINNACLE_PCTV801E,
+	PINNACLE_PCTV801E_SE,
+	TERRATEC_CINERGY_T_EXPRESS,
+	TERRATEC_CINERGY_DT_XS_DIVERSITY_2,
+	SONY_PLAYTV,
+	YUAN_PD378S,
+	HAUPPAUGE_TIGER_ATSC,
+	HAUPPAUGE_TIGER_ATSC_B210,
+	YUAN_MC770,
+	ELGATO_EYETV_DTT,
+	ELGATO_EYETV_DTT_Dlx,
+	LEADTEK_WINFAST_DTV_DONGLE_H,
+	TERRATEC_T3,
+	TERRATEC_T5,
+	YUAN_STK7700D,
+	YUAN_STK7700D_2,
+	PINNACLE_PCTV73A,
+	PCTV_PINNACLE_PCTV73ESE,
+	PCTV_PINNACLE_PCTV282E,
+	DIBCOM_STK7770P,
+	TERRATEC_CINERGY_T_XXS_2,
+	DIBCOM_STK807XPVR,
+	DIBCOM_STK807XP,
+	PIXELVIEW_SBTVD,
+	EVOLUTEPC_TVWAY_PLUS,
+	PINNACLE_PCTV73ESE,
+	PINNACLE_PCTV282E,
+	DIBCOM_STK8096GP,
+	ELGATO_EYETV_DIVERSITY,
+	DIBCOM_NIM9090M,
+	DIBCOM_NIM8096MD,
+	DIBCOM_NIM9090MD,
+	DIBCOM_NIM7090,
+	DIBCOM_TFE7090PVR,
+	TECHNISAT_AIRSTAR_TELESTICK_2,
+	MEDION_CREATIX_CTX1921,
+	PINNACLE_PCTV340E,
+	PINNACLE_PCTV340E_SE,
+	DIBCOM_TFE7790P,
+	DIBCOM_TFE8096P,
+	ELGATO_EYETV_DTT_2,
+	PCTV_2002E,
+	PCTV_2002E_SE,
+	PCTV_DIBCOM_STK8096PVR,
+	DIBCOM_STK8096PVR,
+	HAMA_DVBT_HYBRID,
+	MICROSOFT_XBOX_ONE_TUNER,
+};
+
 struct usb_device_id dib0700_usb_id_table[] = {
-/* 0 */	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK7700P) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK7700P_PC) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_T_500) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_T_500_2) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_T_STICK) },
-/* 5 */	{ USB_DEVICE(USB_VID_AVERMEDIA, USB_PID_AVERMEDIA_VOLAR) },
-	{ USB_DEVICE(USB_VID_COMPRO,    USB_PID_COMPRO_VIDEOMATE_U500) },
-	{ USB_DEVICE(USB_VID_UNIWILL,   USB_PID_UNIWILL_STK7700P) },
-	{ USB_DEVICE(USB_VID_LEADTEK,   USB_PID_WINFAST_DTV_DONGLE_STK7700P) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_T_STICK_2) },
-/* 10 */{ USB_DEVICE(USB_VID_AVERMEDIA, USB_PID_AVERMEDIA_VOLAR_2) },
-	{ USB_DEVICE(USB_VID_PINNACLE,  USB_PID_PINNACLE_PCTV2000E) },
-	{ USB_DEVICE(USB_VID_TERRATEC,
-			USB_PID_TERRATEC_CINERGY_DT_XS_DIVERSITY) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_TD_STICK) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK7700D) },
-/* 15 */{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK7070P) },
-	{ USB_DEVICE(USB_VID_PINNACLE,  USB_PID_PINNACLE_PCTV_DVB_T_FLASH) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK7070PD) },
-	{ USB_DEVICE(USB_VID_PINNACLE,
-			USB_PID_PINNACLE_PCTV_DUAL_DIVERSITY_DVB_T) },
-	{ USB_DEVICE(USB_VID_COMPRO,    USB_PID_COMPRO_VIDEOMATE_U500_PC) },
-/* 20 */{ USB_DEVICE(USB_VID_AVERMEDIA, USB_PID_AVERMEDIA_EXPRESS) },
-	{ USB_DEVICE(USB_VID_GIGABYTE,  USB_PID_GIGABYTE_U7000) },
-	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ARTEC_T14BR) },
-	{ USB_DEVICE(USB_VID_ASUS,      USB_PID_ASUS_U3000) },
-	{ USB_DEVICE(USB_VID_ASUS,      USB_PID_ASUS_U3100) },
-/* 25 */{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_T_STICK_3) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_MYTV_T) },
-	{ USB_DEVICE(USB_VID_TERRATEC,  USB_PID_TERRATEC_CINERGY_HT_USB_XE) },
-	{ USB_DEVICE(USB_VID_PINNACLE,	USB_PID_PINNACLE_EXPRESSCARD_320CX) },
-	{ USB_DEVICE(USB_VID_PINNACLE,	USB_PID_PINNACLE_PCTV72E) },
-/* 30 */{ USB_DEVICE(USB_VID_PINNACLE,	USB_PID_PINNACLE_PCTV73E) },
-	{ USB_DEVICE(USB_VID_YUAN,	USB_PID_YUAN_EC372S) },
-	{ USB_DEVICE(USB_VID_TERRATEC,	USB_PID_TERRATEC_CINERGY_HT_EXPRESS) },
-	{ USB_DEVICE(USB_VID_TERRATEC,	USB_PID_TERRATEC_CINERGY_T_XXS) },
-	{ USB_DEVICE(USB_VID_LEADTEK,   USB_PID_WINFAST_DTV_DONGLE_STK7700P_2) },
-/* 35 */{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_TD_STICK_52009) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_NOVA_T_500_3) },
-	{ USB_DEVICE(USB_VID_GIGABYTE,  USB_PID_GIGABYTE_U8000) },
-	{ USB_DEVICE(USB_VID_YUAN,      USB_PID_YUAN_STK7700PH) },
-	{ USB_DEVICE(USB_VID_ASUS,	USB_PID_ASUS_U3000H) },
-/* 40 */{ USB_DEVICE(USB_VID_PINNACLE,  USB_PID_PINNACLE_PCTV801E) },
-	{ USB_DEVICE(USB_VID_PINNACLE,  USB_PID_PINNACLE_PCTV801E_SE) },
-	{ USB_DEVICE(USB_VID_TERRATEC,	USB_PID_TERRATEC_CINERGY_T_EXPRESS) },
-	{ USB_DEVICE(USB_VID_TERRATEC,
-			USB_PID_TERRATEC_CINERGY_DT_XS_DIVERSITY_2) },
-	{ USB_DEVICE(USB_VID_SONY,	USB_PID_SONY_PLAYTV) },
-/* 45 */{ USB_DEVICE(USB_VID_YUAN,      USB_PID_YUAN_PD378S) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_TIGER_ATSC) },
-	{ USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_TIGER_ATSC_B210) },
-	{ USB_DEVICE(USB_VID_YUAN,	USB_PID_YUAN_MC770) },
-	{ USB_DEVICE(USB_VID_ELGATO,	USB_PID_ELGATO_EYETV_DTT) },
-/* 50 */{ USB_DEVICE(USB_VID_ELGATO,	USB_PID_ELGATO_EYETV_DTT_Dlx) },
-	{ USB_DEVICE(USB_VID_LEADTEK,   USB_PID_WINFAST_DTV_DONGLE_H) },
-	{ USB_DEVICE(USB_VID_TERRATEC,	USB_PID_TERRATEC_T3) },
-	{ USB_DEVICE(USB_VID_TERRATEC,	USB_PID_TERRATEC_T5) },
-	{ USB_DEVICE(USB_VID_YUAN,      USB_PID_YUAN_STK7700D) },
-/* 55 */{ USB_DEVICE(USB_VID_YUAN,	USB_PID_YUAN_STK7700D_2) },
-	{ USB_DEVICE(USB_VID_PINNACLE,	USB_PID_PINNACLE_PCTV73A) },
-	{ USB_DEVICE(USB_VID_PCTV,	USB_PID_PINNACLE_PCTV73ESE) },
-	{ USB_DEVICE(USB_VID_PCTV,	USB_PID_PINNACLE_PCTV282E) },
-	{ USB_DEVICE(USB_VID_DIBCOM,	USB_PID_DIBCOM_STK7770P) },
-/* 60 */{ USB_DEVICE(USB_VID_TERRATEC,	USB_PID_TERRATEC_CINERGY_T_XXS_2) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK807XPVR) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK807XP) },
-	{ USB_DEVICE_VER(USB_VID_PIXELVIEW, USB_PID_PIXELVIEW_SBTVD, 0x000, 0x3f00) },
-	{ USB_DEVICE(USB_VID_EVOLUTEPC, USB_PID_TVWAY_PLUS) },
-/* 65 */{ USB_DEVICE(USB_VID_PINNACLE,	USB_PID_PINNACLE_PCTV73ESE) },
-	{ USB_DEVICE(USB_VID_PINNACLE,	USB_PID_PINNACLE_PCTV282E) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK8096GP) },
-	{ USB_DEVICE(USB_VID_ELGATO,    USB_PID_ELGATO_EYETV_DIVERSITY) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_NIM9090M) },
-/* 70 */{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_NIM8096MD) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_NIM9090MD) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_NIM7090) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_TFE7090PVR) },
-	{ USB_DEVICE(USB_VID_TECHNISAT, USB_PID_TECHNISAT_AIRSTAR_TELESTICK_2) },
-/* 75 */{ USB_DEVICE(USB_VID_MEDION,    USB_PID_CREATIX_CTX1921) },
-	{ USB_DEVICE(USB_VID_PINNACLE,  USB_PID_PINNACLE_PCTV340E) },
-	{ USB_DEVICE(USB_VID_PINNACLE,  USB_PID_PINNACLE_PCTV340E_SE) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_TFE7790P) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_TFE8096P) },
-/* 80 */{ USB_DEVICE(USB_VID_ELGATO,	USB_PID_ELGATO_EYETV_DTT_2) },
-	{ USB_DEVICE(USB_VID_PCTV,      USB_PID_PCTV_2002E) },
-	{ USB_DEVICE(USB_VID_PCTV,      USB_PID_PCTV_2002E_SE) },
-	{ USB_DEVICE(USB_VID_PCTV,      USB_PID_DIBCOM_STK8096PVR) },
-	{ USB_DEVICE(USB_VID_DIBCOM,    USB_PID_DIBCOM_STK8096PVR) },
-/* 85 */{ USB_DEVICE(USB_VID_HAMA,	USB_PID_HAMA_DVBT_HYBRID) },
-	{ USB_DEVICE(USB_VID_MICROSOFT,	USB_PID_XBOX_ONE_TUNER) },
-	{ 0 }		/* Terminating entry */
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK7700P),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK7700P_PC),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_T_500),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_T_500_2),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_T_STICK),
+	DVB_USB_DEV(AVERMEDIA, AVERMEDIA_VOLAR),
+	DVB_USB_DEV(COMPRO, COMPRO_VIDEOMATE_U500),
+	DVB_USB_DEV(UNIWILL, UNIWILL_STK7700P),
+	DVB_USB_DEV(LEADTEK, LEADTEK_WINFAST_DTV_DONGLE_STK7700P),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_T_STICK_2),
+	DVB_USB_DEV(AVERMEDIA, AVERMEDIA_VOLAR_2),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV2000E),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_DT_XS_DIVERSITY),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_TD_STICK),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK7700D),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK7070P),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV_DVB_T_FLASH),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK7070PD),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV_DUAL_DIVERSITY_DVB_T),
+	DVB_USB_DEV(COMPRO, COMPRO_VIDEOMATE_U500_PC),
+	DVB_USB_DEV(AVERMEDIA, AVERMEDIA_EXPRESS),
+	DVB_USB_DEV(GIGABYTE, GIGABYTE_U7000),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_ARTEC_T14BR),
+	DVB_USB_DEV(ASUS, ASUS_U3000),
+	DVB_USB_DEV(ASUS, ASUS_U3100),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_T_STICK_3),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_MYTV_T),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_HT_USB_XE),
+	DVB_USB_DEV(PINNACLE, PINNACLE_EXPRESSCARD_320CX),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV72E),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV73E),
+	DVB_USB_DEV(YUAN, YUAN_EC372S),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_HT_EXPRESS),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_T_XXS),
+	DVB_USB_DEV(LEADTEK, LEADTEK_WINFAST_DTV_DONGLE_STK7700P_2),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_TD_STICK_52009),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_NOVA_T_500_3),
+	DVB_USB_DEV(GIGABYTE, GIGABYTE_U8000),
+	DVB_USB_DEV(YUAN, YUAN_STK7700PH),
+	DVB_USB_DEV(ASUS, ASUS_U3000H),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV801E),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV801E_SE),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_T_EXPRESS),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_DT_XS_DIVERSITY_2),
+	DVB_USB_DEV(SONY, SONY_PLAYTV),
+	DVB_USB_DEV(YUAN, YUAN_PD378S),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_TIGER_ATSC),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_TIGER_ATSC_B210),
+	DVB_USB_DEV(YUAN, YUAN_MC770),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_DTT),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_DTT_Dlx),
+	DVB_USB_DEV(LEADTEK, LEADTEK_WINFAST_DTV_DONGLE_H),
+	DVB_USB_DEV(TERRATEC, TERRATEC_T3),
+	DVB_USB_DEV(TERRATEC, TERRATEC_T5),
+	DVB_USB_DEV(YUAN, YUAN_STK7700D),
+	DVB_USB_DEV(YUAN, YUAN_STK7700D_2),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV73A),
+	DVB_USB_DEV(PCTV, PCTV_PINNACLE_PCTV73ESE),
+	DVB_USB_DEV(PCTV, PCTV_PINNACLE_PCTV282E),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK7770P),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_T_XXS_2),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK807XPVR),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK807XP),
+	DVB_USB_DEV_VER(PIXELVIEW, PIXELVIEW_SBTVD, 0x000, 0x3f00),
+	DVB_USB_DEV(EVOLUTEPC, EVOLUTEPC_TVWAY_PLUS),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV73ESE),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV282E),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK8096GP),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_DIVERSITY),
+	DVB_USB_DEV(DIBCOM, DIBCOM_NIM9090M),
+	DVB_USB_DEV(DIBCOM, DIBCOM_NIM8096MD),
+	DVB_USB_DEV(DIBCOM, DIBCOM_NIM9090MD),
+	DVB_USB_DEV(DIBCOM, DIBCOM_NIM7090),
+	DVB_USB_DEV(DIBCOM, DIBCOM_TFE7090PVR),
+	DVB_USB_DEV(TECHNISAT, TECHNISAT_AIRSTAR_TELESTICK_2),
+	DVB_USB_DEV(MEDION, MEDION_CREATIX_CTX1921),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV340E),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV340E_SE),
+	DVB_USB_DEV(DIBCOM, DIBCOM_TFE7790P),
+	DVB_USB_DEV(DIBCOM, DIBCOM_TFE8096P),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_DTT_2),
+	DVB_USB_DEV(PCTV, PCTV_2002E),
+	DVB_USB_DEV(PCTV, PCTV_2002E_SE),
+	DVB_USB_DEV(PCTV, PCTV_DIBCOM_STK8096PVR),
+	DVB_USB_DEV(DIBCOM, DIBCOM_STK8096PVR),
+	DVB_USB_DEV(HAMA, HAMA_DVBT_HYBRID),
+	DVB_USB_DEV(MICROSOFT, MICROSOFT_XBOX_ONE_TUNER),
+	{ }
 };
+
 MODULE_DEVICE_TABLE(usb, dib0700_usb_id_table);
 
 #define DIB0700_DEFAULT_DEVICE_PROPERTIES \
@@ -3962,35 +4050,35 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 8,
 		.devices = {
 			{   "DiBcom STK7700P reference design",
-				{ &dib0700_usb_id_table[0], &dib0700_usb_id_table[1] },
+				{ &dib0700_usb_id_table[DIBCOM_STK7700P], &dib0700_usb_id_table[DIBCOM_STK7700P_PC] },
 				{ NULL },
 			},
 			{   "Hauppauge Nova-T Stick",
-				{ &dib0700_usb_id_table[4], &dib0700_usb_id_table[9], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_NOVA_T_STICK], &dib0700_usb_id_table[HAUPPAUGE_NOVA_T_STICK_2], NULL },
 				{ NULL },
 			},
 			{   "AVerMedia AVerTV DVB-T Volar",
-				{ &dib0700_usb_id_table[5], &dib0700_usb_id_table[10] },
+				{ &dib0700_usb_id_table[AVERMEDIA_VOLAR], &dib0700_usb_id_table[AVERMEDIA_VOLAR_2] },
 				{ NULL },
 			},
 			{   "Compro Videomate U500",
-				{ &dib0700_usb_id_table[6], &dib0700_usb_id_table[19] },
+				{ &dib0700_usb_id_table[COMPRO_VIDEOMATE_U500], &dib0700_usb_id_table[COMPRO_VIDEOMATE_U500_PC] },
 				{ NULL },
 			},
 			{   "Uniwill STK7700P based (Hama and others)",
-				{ &dib0700_usb_id_table[7], NULL },
+				{ &dib0700_usb_id_table[UNIWILL_STK7700P], NULL },
 				{ NULL },
 			},
 			{   "Leadtek Winfast DTV Dongle (STK7700P based)",
-				{ &dib0700_usb_id_table[8], &dib0700_usb_id_table[34] },
+				{ &dib0700_usb_id_table[LEADTEK_WINFAST_DTV_DONGLE_STK7700P], &dib0700_usb_id_table[LEADTEK_WINFAST_DTV_DONGLE_STK7700P_2] },
 				{ NULL },
 			},
 			{   "AVerMedia AVerTV DVB-T Express",
-				{ &dib0700_usb_id_table[20] },
+				{ &dib0700_usb_id_table[AVERMEDIA_EXPRESS] },
 				{ NULL },
 			},
 			{   "Gigabyte U7000",
-				{ &dib0700_usb_id_table[21], NULL },
+				{ &dib0700_usb_id_table[GIGABYTE_U7000], NULL },
 				{ NULL },
 			}
 		},
@@ -4030,7 +4118,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "Hauppauge Nova-T 500 Dual DVB-T",
-				{ &dib0700_usb_id_table[2], &dib0700_usb_id_table[3], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_NOVA_T_500], &dib0700_usb_id_table[HAUPPAUGE_NOVA_T_500_2], NULL },
 				{ NULL },
 			},
 		},
@@ -4078,23 +4166,23 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 5,
 		.devices = {
 			{   "Pinnacle PCTV 2000e",
-				{ &dib0700_usb_id_table[11], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV2000E], NULL },
 				{ NULL },
 			},
 			{   "Terratec Cinergy DT XS Diversity",
-				{ &dib0700_usb_id_table[12], NULL },
+				{ &dib0700_usb_id_table[TERRATEC_CINERGY_DT_XS_DIVERSITY], NULL },
 				{ NULL },
 			},
 			{   "Hauppauge Nova-TD Stick/Elgato Eye-TV Diversity",
-				{ &dib0700_usb_id_table[13], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_NOVA_TD_STICK], NULL },
 				{ NULL },
 			},
 			{   "DiBcom STK7700D reference design",
-				{ &dib0700_usb_id_table[14], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK7700D], NULL },
 				{ NULL },
 			},
 			{   "YUAN High-Tech DiBcom STK7700D",
-				{ &dib0700_usb_id_table[55], NULL },
+				{ &dib0700_usb_id_table[YUAN_STK7700D_2], NULL },
 				{ NULL },
 			},
 
@@ -4131,15 +4219,15 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 3,
 		.devices = {
 			{   "ASUS My Cinema U3000 Mini DVBT Tuner",
-				{ &dib0700_usb_id_table[23], NULL },
+				{ &dib0700_usb_id_table[ASUS_U3000], NULL },
 				{ NULL },
 			},
 			{   "Yuan EC372S",
-				{ &dib0700_usb_id_table[31], NULL },
+				{ &dib0700_usb_id_table[YUAN_EC372S], NULL },
 				{ NULL },
 			},
 			{   "Terratec Cinergy T Express",
-				{ &dib0700_usb_id_table[42], NULL },
+				{ &dib0700_usb_id_table[TERRATEC_CINERGY_T_EXPRESS], NULL },
 				{ NULL },
 			}
 		},
@@ -4176,51 +4264,51 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 12,
 		.devices = {
 			{   "DiBcom STK7070P reference design",
-				{ &dib0700_usb_id_table[15], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK7070P], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV DVB-T Flash Stick",
-				{ &dib0700_usb_id_table[16], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV_DVB_T_FLASH], NULL },
 				{ NULL },
 			},
 			{   "Artec T14BR DVB-T",
-				{ &dib0700_usb_id_table[22], NULL },
+				{ &dib0700_usb_id_table[ULTIMA_ARTEC_T14BR], NULL },
 				{ NULL },
 			},
 			{   "ASUS My Cinema U3100 Mini DVBT Tuner",
-				{ &dib0700_usb_id_table[24], NULL },
+				{ &dib0700_usb_id_table[ASUS_U3100], NULL },
 				{ NULL },
 			},
 			{   "Hauppauge Nova-T Stick",
-				{ &dib0700_usb_id_table[25], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_NOVA_T_STICK_3], NULL },
 				{ NULL },
 			},
 			{   "Hauppauge Nova-T MyTV.t",
-				{ &dib0700_usb_id_table[26], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_MYTV_T], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV 72e",
-				{ &dib0700_usb_id_table[29], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV72E], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV 73e",
-				{ &dib0700_usb_id_table[30], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV73E], NULL },
 				{ NULL },
 			},
 			{   "Elgato EyeTV DTT",
-				{ &dib0700_usb_id_table[49], NULL },
+				{ &dib0700_usb_id_table[ELGATO_EYETV_DTT], NULL },
 				{ NULL },
 			},
 			{   "Yuan PD378S",
-				{ &dib0700_usb_id_table[45], NULL },
+				{ &dib0700_usb_id_table[YUAN_PD378S], NULL },
 				{ NULL },
 			},
 			{   "Elgato EyeTV Dtt Dlx PD378S",
-				{ &dib0700_usb_id_table[50], NULL },
+				{ &dib0700_usb_id_table[ELGATO_EYETV_DTT_Dlx], NULL },
 				{ NULL },
 			},
 			{   "Elgato EyeTV DTT rev. 2",
-				{ &dib0700_usb_id_table[80], NULL },
+				{ &dib0700_usb_id_table[ELGATO_EYETV_DTT_2], NULL },
 				{ NULL },
 			},
 		},
@@ -4257,15 +4345,15 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 3,
 		.devices = {
 			{   "Pinnacle PCTV 73A",
-				{ &dib0700_usb_id_table[56], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV73A], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV 73e SE",
-				{ &dib0700_usb_id_table[57], &dib0700_usb_id_table[65], NULL },
+				{ &dib0700_usb_id_table[PCTV_PINNACLE_PCTV73ESE], &dib0700_usb_id_table[PINNACLE_PCTV73ESE], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV 282e",
-				{ &dib0700_usb_id_table[58], &dib0700_usb_id_table[66], NULL },
+				{ &dib0700_usb_id_table[PCTV_PINNACLE_PCTV282E], &dib0700_usb_id_table[PINNACLE_PCTV282E], NULL },
 				{ NULL },
 			},
 		},
@@ -4314,15 +4402,15 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 3,
 		.devices = {
 			{   "Hauppauge Nova-TD Stick (52009)",
-				{ &dib0700_usb_id_table[35], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_NOVA_TD_STICK_52009], NULL },
 				{ NULL },
 			},
 			{   "PCTV 2002e",
-				{ &dib0700_usb_id_table[81], NULL },
+				{ &dib0700_usb_id_table[PCTV_2002E], NULL },
 				{ NULL },
 			},
 			{   "PCTV 2002e SE",
-				{ &dib0700_usb_id_table[82], NULL },
+				{ &dib0700_usb_id_table[PCTV_2002E_SE], NULL },
 				{ NULL },
 			},
 		},
@@ -4371,24 +4459,24 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 5,
 		.devices = {
 			{   "DiBcom STK7070PD reference design",
-				{ &dib0700_usb_id_table[17], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK7070PD], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV Dual DVB-T Diversity Stick",
-				{ &dib0700_usb_id_table[18], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV_DUAL_DIVERSITY_DVB_T], NULL },
 				{ NULL },
 			},
 			{   "Hauppauge Nova-TD-500 (84xxx)",
-				{ &dib0700_usb_id_table[36], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_NOVA_T_500_3], NULL },
 				{ NULL },
 			},
 			{  "Terratec Cinergy DT USB XS Diversity/ T5",
-				{ &dib0700_usb_id_table[43],
-					&dib0700_usb_id_table[53], NULL},
+				{ &dib0700_usb_id_table[TERRATEC_CINERGY_DT_XS_DIVERSITY_2],
+					&dib0700_usb_id_table[TERRATEC_T5], NULL},
 				{ NULL },
 			},
 			{  "Sony PlayTV",
-				{ &dib0700_usb_id_table[44], NULL },
+				{ &dib0700_usb_id_table[SONY_PLAYTV], NULL },
 				{ NULL },
 			},
 		},
@@ -4437,7 +4525,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "Elgato EyeTV Diversity",
-				{ &dib0700_usb_id_table[68], NULL },
+				{ &dib0700_usb_id_table[ELGATO_EYETV_DIVERSITY], NULL },
 				{ NULL },
 			},
 		},
@@ -4474,43 +4562,43 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 10,
 		.devices = {
 			{   "Terratec Cinergy HT USB XE",
-				{ &dib0700_usb_id_table[27], NULL },
+				{ &dib0700_usb_id_table[TERRATEC_CINERGY_HT_USB_XE], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle Expresscard 320cx",
-				{ &dib0700_usb_id_table[28], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_EXPRESSCARD_320CX], NULL },
 				{ NULL },
 			},
 			{   "Terratec Cinergy HT Express",
-				{ &dib0700_usb_id_table[32], NULL },
+				{ &dib0700_usb_id_table[TERRATEC_CINERGY_HT_EXPRESS], NULL },
 				{ NULL },
 			},
 			{   "Gigabyte U8000-RH",
-				{ &dib0700_usb_id_table[37], NULL },
+				{ &dib0700_usb_id_table[GIGABYTE_U8000], NULL },
 				{ NULL },
 			},
 			{   "YUAN High-Tech STK7700PH",
-				{ &dib0700_usb_id_table[38], NULL },
+				{ &dib0700_usb_id_table[YUAN_STK7700PH], NULL },
 				{ NULL },
 			},
 			{   "Asus My Cinema-U3000Hybrid",
-				{ &dib0700_usb_id_table[39], NULL },
+				{ &dib0700_usb_id_table[ASUS_U3000H], NULL },
 				{ NULL },
 			},
 			{   "YUAN High-Tech MC770",
-				{ &dib0700_usb_id_table[48], NULL },
+				{ &dib0700_usb_id_table[YUAN_MC770], NULL },
 				{ NULL },
 			},
 			{   "Leadtek WinFast DTV Dongle H",
-				{ &dib0700_usb_id_table[51], NULL },
+				{ &dib0700_usb_id_table[LEADTEK_WINFAST_DTV_DONGLE_H], NULL },
 				{ NULL },
 			},
 			{   "YUAN High-Tech STK7700D",
-				{ &dib0700_usb_id_table[54], NULL },
+				{ &dib0700_usb_id_table[YUAN_STK7700D], NULL },
 				{ NULL },
 			},
 			{   "Hama DVB=T Hybrid USB Stick",
-				{ &dib0700_usb_id_table[85], NULL },
+				{ &dib0700_usb_id_table[HAMA_DVBT_HYBRID], NULL },
 				{ NULL },
 			},
 		},
@@ -4542,11 +4630,11 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 2,
 		.devices = {
 			{   "Pinnacle PCTV HD Pro USB Stick",
-				{ &dib0700_usb_id_table[40], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV801E], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV HD USB Stick",
-				{ &dib0700_usb_id_table[41], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV801E_SE], NULL },
 				{ NULL },
 			},
 		},
@@ -4578,11 +4666,11 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 2,
 		.devices = {
 			{   "Hauppauge ATSC MiniCard (B200)",
-				{ &dib0700_usb_id_table[46], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_TIGER_ATSC], NULL },
 				{ NULL },
 			},
 			{   "Hauppauge ATSC MiniCard (B210)",
-				{ &dib0700_usb_id_table[47], NULL },
+				{ &dib0700_usb_id_table[HAUPPAUGE_TIGER_ATSC_B210], NULL },
 				{ NULL },
 			},
 		},
@@ -4608,21 +4696,21 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 4,
 		.devices = {
 			{   "DiBcom STK7770P reference design",
-				{ &dib0700_usb_id_table[59], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK7770P], NULL },
 				{ NULL },
 			},
 			{   "Terratec Cinergy T USB XXS (HD)/ T3",
-				{ &dib0700_usb_id_table[33],
-					&dib0700_usb_id_table[52],
-					&dib0700_usb_id_table[60], NULL},
+				{ &dib0700_usb_id_table[TERRATEC_CINERGY_T_XXS],
+					&dib0700_usb_id_table[TERRATEC_T3],
+					&dib0700_usb_id_table[TERRATEC_CINERGY_T_XXS_2], NULL},
 				{ NULL },
 			},
 			{   "TechniSat AirStar TeleStick 2",
-				{ &dib0700_usb_id_table[74], NULL },
+				{ &dib0700_usb_id_table[TECHNISAT_AIRSTAR_TELESTICK_2], NULL },
 				{ NULL },
 			},
 			{   "Medion CTX1921 DVB-T USB",
-				{ &dib0700_usb_id_table[75], NULL },
+				{ &dib0700_usb_id_table[MEDION_CREATIX_CTX1921], NULL },
 				{ NULL },
 			},
 		},
@@ -4658,15 +4746,15 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 3,
 		.devices = {
 			{   "DiBcom STK807xP reference design",
-				{ &dib0700_usb_id_table[62], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK807XP], NULL },
 				{ NULL },
 			},
 			{   "Prolink Pixelview SBTVD",
-				{ &dib0700_usb_id_table[63], NULL },
+				{ &dib0700_usb_id_table[PIXELVIEW_SBTVD], NULL },
 				{ NULL },
 			},
 			{   "EvolutePC TVWay+",
-				{ &dib0700_usb_id_table[64], NULL },
+				{ &dib0700_usb_id_table[EVOLUTEPC_TVWAY_PLUS], NULL },
 				{ NULL },
 			},
 		},
@@ -4715,7 +4803,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom STK807xPVR reference design",
-				{ &dib0700_usb_id_table[61], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK807XPVR], NULL },
 				{ NULL },
 			},
 		},
@@ -4752,7 +4840,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom STK8096GP reference design",
-				{ &dib0700_usb_id_table[67], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_STK8096GP], NULL },
 				{ NULL },
 			},
 		},
@@ -4789,7 +4877,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom STK9090M reference design",
-				{ &dib0700_usb_id_table[69], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_NIM9090M], NULL },
 				{ NULL },
 			},
 		},
@@ -4826,7 +4914,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom NIM8096MD reference design",
-				{ &dib0700_usb_id_table[70], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_NIM8096MD], NULL },
 				{ NULL },
 			},
 		},
@@ -4863,7 +4951,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom NIM9090MD reference design",
-				{ &dib0700_usb_id_table[71], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_NIM9090MD], NULL },
 				{ NULL },
 			},
 		},
@@ -4900,7 +4988,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom NIM7090 reference design",
-				{ &dib0700_usb_id_table[72], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_NIM7090], NULL },
 				{ NULL },
 			},
 		},
@@ -4951,7 +5039,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom TFE7090PVR reference design",
-				{ &dib0700_usb_id_table[73], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_TFE7090PVR], NULL },
 				{ NULL },
 			},
 		},
@@ -4983,11 +5071,11 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 2,
 		.devices = {
 			{   "Pinnacle PCTV 340e HD Pro USB Stick",
-				{ &dib0700_usb_id_table[76], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV340E], NULL },
 				{ NULL },
 			},
 			{   "Pinnacle PCTV Hybrid Stick Solo",
-				{ &dib0700_usb_id_table[77], NULL },
+				{ &dib0700_usb_id_table[PINNACLE_PCTV340E_SE], NULL },
 				{ NULL },
 			},
 		},
@@ -5023,7 +5111,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom TFE7790P reference design",
-				{ &dib0700_usb_id_table[78], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_TFE7790P], NULL },
 				{ NULL },
 			},
 		},
@@ -5061,7 +5149,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom TFE8096P reference design",
-				{ &dib0700_usb_id_table[79], NULL },
+				{ &dib0700_usb_id_table[DIBCOM_TFE8096P], NULL },
 				{ NULL },
 			},
 		},
@@ -5114,8 +5202,8 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{   "DiBcom STK8096-PVR reference design",
-				{ &dib0700_usb_id_table[83],
-					&dib0700_usb_id_table[84], NULL},
+				{ &dib0700_usb_id_table[PCTV_DIBCOM_STK8096PVR],
+					&dib0700_usb_id_table[DIBCOM_STK8096PVR], NULL},
 				{ NULL },
 			},
 		},
@@ -5145,7 +5233,7 @@ struct dvb_usb_device_properties dib0700_devices[] = {
 		.num_device_descs = 1,
 		.devices = {
 			{ "Microsoft Xbox One Digital TV Tuner",
-				{ &dib0700_usb_id_table[86], NULL },
+				{ &dib0700_usb_id_table[MICROSOFT_XBOX_ONE_TUNER], NULL },
 				{ NULL },
 			},
 		},
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 4dba939760ed..1b7d10f3d4aa 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -110,7 +110,6 @@
 #define USB_PID_ANUBIS_LIFEVIEW_TV_WALKER_TWIN_WARM	0x0513
 #define USB_PID_ANUBIS_MSI_DIGI_VOX_MINI_II		0x1513
 #define USB_PID_ANYSEE					0x861f
-#define USB_PID_ARTEC_T14BR				0x810f
 #define USB_PID_ASUS_U3000				0x171f
 #define USB_PID_ASUS_U3000H				0x1736
 #define USB_PID_ASUS_U3100				0x173f
@@ -158,7 +157,6 @@
 #define USB_PID_CONCEPTRONIC_CTVDIGRCU			0xe397
 #define USB_PID_CONEXANT_D680_DMB			0x86d6
 #define USB_PID_CPYTO_REDI_PC50A			0xa803
-#define USB_PID_CREATIX_CTX1921 			0x1921
 #define USB_PID_CTVDIGDUAL_V2				0xe410
 #define USB_PID_CYPRESS_DW2101				0x2101
 #define USB_PID_CYPRESS_DW2102				0x2102
@@ -226,6 +224,7 @@
 #define USB_PID_EMPIA_DIGIVOX_MINI_SL_WARM		0xe361
 #define USB_PID_EMPIA_VSTREAM_COLD			0x17de
 #define USB_PID_EMPIA_VSTREAM_WARM			0x17df
+#define USB_PID_EVOLUTEPC_TVWAY_PLUS			0x0002
 #define USB_PID_EVOLVEO_XTRATV_STICK			0xa115
 #define USB_PID_FREECOM_DVBT				0x0160
 #define USB_PID_FREECOM_DVBT_2				0x0161
@@ -288,10 +287,15 @@
 #define USB_PID_KYE_DVB_T_COLD				0x701e
 #define USB_PID_KYE_DVB_T_WARM				0x701f
 #define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_COLD 	0x6025
+#define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_H		0x60f6
+#define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_STK7700P	0x6f00
+#define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_STK7700P_2	0x6f01
 #define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_WARM 	0x6026
 #define USB_PID_LITEON_DVB_T_COLD			0xf000
 #define USB_PID_LITEON_DVB_T_WARM			0xf001
+#define USB_PID_MEDION_CREATIX_CTX1921			0x1921
 #define USB_PID_MEDION_MD95700				0x0932
+#define USB_PID_MICROSOFT_XBOX_ONE_TUNER		0x02d5
 #define USB_PID_MIGLIA_WT220U_ZAP250_COLD		0x0220
 #define USB_PID_MSI_DIGIVOX_DUO 			0x8801
 #define USB_PID_MSI_DIGI_VOX_MINI_III			0x8807
@@ -313,6 +317,9 @@
 #define USB_PID_PCTV_200E				0x020e
 #define USB_PID_PCTV_78E				0x025a
 #define USB_PID_PCTV_79E				0x0262
+#define USB_PID_PCTV_DIBCOM_STK8096PVR			0x1faa
+#define USB_PID_PCTV_PINNACLE_PCTV282E			0x0248
+#define USB_PID_PCTV_PINNACLE_PCTV73ESE 		0x0245
 #define USB_PID_PINNACLE_EXPRESSCARD_320CX		0x022e
 #define USB_PID_PINNACLE_PCTV2000E			0x022c
 #define USB_PID_PINNACLE_PCTV282E			0x0248
@@ -408,10 +415,10 @@
 #define USB_PID_TREKSTOR_DVBT				0x901b
 #define USB_PID_TREKSTOR_TERRES_2_0			0xC803
 #define USB_PID_TURBOX_DTT_2000 			0xd3a4
-#define USB_PID_TVWAY_PLUS				0x0002
 #define USB_PID_TWINHAN_VP7021_WARM			0x3208
 #define USB_PID_TWINHAN_VP7041_COLD			0x3201
 #define USB_PID_TWINHAN_VP7041_WARM			0x3202
+#define USB_PID_ULTIMA_ARTEC_T14BR			0x810f
 #define USB_PID_ULTIMA_ARTEC_T14_COLD			0x810b
 #define USB_PID_ULTIMA_ARTEC_T14_WARM			0x810c
 #define USB_PID_ULTIMA_TVBOX_AN2235_COLD		0x8107
@@ -450,13 +457,9 @@
 #define USB_PID_WINFAST_DTV2000DS			0x6a04
 #define USB_PID_WINFAST_DTV2000DS_PLUS			0x6f12
 #define USB_PID_WINFAST_DTV_DONGLE_GOLD 		0x6029
-#define USB_PID_WINFAST_DTV_DONGLE_H			0x60f6
 #define USB_PID_WINFAST_DTV_DONGLE_MINID		0x6f0f
-#define USB_PID_WINFAST_DTV_DONGLE_STK7700P		0x6f00
-#define USB_PID_WINFAST_DTV_DONGLE_STK7700P_2		0x6f01
 #define USB_PID_WINTV_SOLOHD				0x0264
 #define USB_PID_WINTV_SOLOHD_2				0x8268
-#define USB_PID_XBOX_ONE_TUNER				0x02d5
 #define USB_PID_XTENSIONS_XD_380			0x0381
 #define USB_PID_YUAN_EC372S				0x1edc
 #define USB_PID_YUAN_MC770				0x0871
-- 
2.35.1

