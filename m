Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FF58877A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiHCGiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiHCGh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:37:57 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE464332F;
        Tue,  2 Aug 2022 23:37:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 562E65C00F5;
        Wed,  3 Aug 2022 02:37:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 03 Aug 2022 02:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659508674; x=1659595074; bh=ec/uBSy6Li+Q68/BgBsPvhpml
        DzjV9tNKKH4sKLQzIw=; b=MI+LTI2PqdU+2e7jrhRBNCsTsl22Ps0v/qktVx/JA
        7bx/Zo6YioDbj0oiBRW3x2vs/bAEx5JModLnXGKA21PryJERiaP6fj4pvrXeztho
        UVCIvPtj937Do1ufU83DYlrppka9ZYPKNaCdu3+lb7dc2BYCpOGPF3ti6keqtgcd
        hwqa3ZhiqfacdHOsATWzq96B4ulE467Jt2IiVZAQxZ9uSE2jxp/YzUCUO7GE0pK3
        l8duceQHZE+ZbfkmvitxGoIurNqViC27uuCnpgcMC98gfL4Sk0A0nsL024jEjTQ5
        AEji/stVbmyFeYjitEJTQ614ZA2SU52bg5AOMAifePxwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659508674; x=1659595074; bh=ec/uBSy6Li+Q68/BgBsPvhpmlDzjV9tNKKH
        4sKLQzIw=; b=zPbNgjPh4xMKz657QG9j0qiGkDwOFops+7PsU9r0/aVuNMv+4g6
        DChDDmgJoyed99VZMOdxdnTT0YDrIZlaoFrqcwq6u4E7Y36XQ3M+lZ5JhSNz7dta
        0Zw60c4bn78E1zaGRGdHyRzZqA3MmYLiP4/EL05XjRKGEmpHVWj4Vjrymx+izugb
        BnOD12i8MG7A2y9X3xy9H7ysVuYOu6r5tIzUx6FYHNUOSBWNH+1mrgyx696zZYKP
        kRPcPWtv/1UobF3eDDogDduPW4XdwI1pSE3NmOLD2TPPJ2Kix+NinC1yQcMB4idV
        dbNVeAxajZ5W6GStE26n47KMFljZd9MbHww==
X-ME-Sender: <xms:whfqYo52YUXfY_TyqoawFbXAw6F9UrT_MxD65GDlSTiQPmotTMMdfw>
    <xme:whfqYp4q4dF1vP4Yxdnec-SzDl_KuLSVsH4DmgOQTgu7CfBFnwsdHoDZ-YUbrC5KC
    U6ChJ2Rx9y06Pih2Es>
X-ME-Received: <xmr:whfqYndxMe7HM4jG0uRCPRO4UZmbP1RVrExXPmuw-hhjOvMC5-0_mefCJIVP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:whfqYtKlledgpuwn3miEyyE_ug8jsC4-26-0Fzxyf0_RPjq2cDCFJw>
    <xmx:whfqYsIKjkOy1G6pjkwYfIt0niUNVEHwezAL7Ch9vezEn35zGzPGSg>
    <xmx:whfqYux84wjd4xj9LYHfQ2M47JANcbOQX-iOK9lPGLJcS2SWmR160g>
    <xmx:whfqYjXu0raEaiOY6DcTJFIPBsTm1Qs3rDW5N5Ci8yxT_iLiQzQNKg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 02:37:51 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/1] asus-wmi: Add support for ROG X13 tablet mode
Date:   Wed,  3 Aug 2022 18:37:34 +1200
Message-Id: <20220803063734.765614-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c         | 16 ++++++++++++++++
 drivers/platform/x86/asus-wmi.c            | 16 +++++++++++++++-
 drivers/platform/x86/asus-wmi.h            |  1 +
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 478dd300b9c9..1ce8924d0474 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -123,6 +123,12 @@ static struct quirk_entry quirk_asus_use_lid_flip_devid = {
 	.use_lid_flip_devid = true,
 };
 
+static struct quirk_entry quirk_asus_gv301 = {
+	.wmi_backlight_set_devstate = true,
+	.use_lid_flip_devid = true,
+	.enodev_as_tablet_mode = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -471,6 +477,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_use_lid_flip_devid,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
+		},
+		.driver_data = &quirk_asus_gv301,
+	},
 	{},
 };
 
@@ -581,6 +596,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
+	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on rog flow laptops */
 	{ KE_END, 0},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 62ce198a3463..0458e9107ca7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_KBD_FBM			0x99
 #define NOTIFY_KBD_TTP			0xae
 #define NOTIFY_LID_FLIP			0xfa
+#define NOTIFY_LID_FLIP_GV301	0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -516,6 +517,12 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 
 	if (asus->driver->quirks->use_lid_flip_devid) {
 		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
+		if (result < 0)
+			result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GV301_LID_FLIP);
+
+		if (result == -ENODEV && asus->driver->quirks->enodev_as_tablet_mode)
+			result = 1;
+
 		if (result < 0)
 			asus->driver->quirks->use_lid_flip_devid = 0;
 		if (result >= 0) {
@@ -553,6 +560,12 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 {
 	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
 
+	if (result < 0)
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GV301_LID_FLIP);
+
+	if (result == -ENODEV && asus->driver->quirks->enodev_as_tablet_mode)
+		result = 1;
+
 	if (result >= 0) {
 		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
 		input_sync(asus->inputdev);
@@ -3094,7 +3107,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
+	if (asus->driver->quirks->use_lid_flip_devid &&
+			(code == NOTIFY_LID_FLIP || code == NOTIFY_LID_FLIP_GV301)) {
 		lid_flip_tablet_mode_get_state(asus);
 		return;
 	}
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index b302415bf1d9..ac9023aae838 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -35,6 +35,7 @@ struct quirk_entry {
 	bool wmi_force_als_set;
 	bool use_kbd_dock_devid;
 	bool use_lid_flip_devid;
+	bool enodev_as_tablet_mode;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..79bd06628a8b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
+#define ASUS_WMI_DEVID_GV301_LID_FLIP	0x00060077
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.37.1

