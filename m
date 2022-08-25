Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C975A1D11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiHYXXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiHYXXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:23:11 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24137C3F4C;
        Thu, 25 Aug 2022 16:23:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F19CF3200A1B;
        Thu, 25 Aug 2022 19:23:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Aug 2022 19:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661469789; x=1661556189; bh=S9
        kA9f3RrN4pzDILQYmWRcHqGqYS1qPA1S5oVRNyBgg=; b=FWg34/D0Jxlyyieryq
        M/2mlcJNFyS8bAQE5Vg4Q443kmzaGl0y7o70ZPP1wmWzQa1177yCt8Cvynms+MIG
        pQxoY62+fQHPO1vn41roxpmAAAO7OI9IF9AMaU+pvBAf3gJjVZWMjYH5GotptX/L
        tSu31Bd3XBfp5kvEVPJoNH8uLymoTOoR4DYQUf6rI0lWaxD1tmtX2XNY9tvQBwUF
        iFVOB7gzwTagZ78/IkL9etCzvDHHUw4CKKrRG2T34ReYIIF3fEftwoFXjs1HUa4e
        raXDSW74IAJ/7/ZcbcY6vJl1L0BgKUKkx0pJ93p6xu1kbMw9caHP5We3gmjG7UBj
        RiVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661469789; x=1661556189; bh=S9kA9f3RrN4pz
        DILQYmWRcHqGqYS1qPA1S5oVRNyBgg=; b=t2+6zCPuwt9LB7JQ8kBpKtz9QwhVF
        qUwSb4u1jJXetgwGY+OX1g5WOkBG1rYCiAMTsbERVCg9WR41EuUeBBaKwDZRkGFN
        f+m3HhhOn/cSfmXMQea10kR1SL4bsSoGB58Flqi/+EQS8v3XMY/wykBn5lxWiDpa
        ixYUX9ZtIJej1uTa72BOG4PWzcoW+J00M/uTvCaU2Rr5KPLGRshq2GBk+Dvt/aH7
        XUNk8wPamEH7TPunsmFkOByTm8zHZIK+5QpRVwhjq4hGINTGAYJV8317wZF1IwAj
        mOBkC+lFUHFsrb46NuTeTSlPjXm/cvhBVz9GB2kWbTrF7+0NI40u2tgiQ==
X-ME-Sender: <xms:XQQIY7O2LqoFHFHh0NsDWvlleXXqv3FvHUgGeWx6ESR4olTPVWbURg>
    <xme:XQQIY1-4Al0VUFuu-MzHFGnGr3f_uPmMxR5FLRU-JH5fDYNSHVulxaXUL1u_xhkTu
    MM9uJKQ3J5S_e2p2Ww>
X-ME-Received: <xmr:XQQIY6QywlzSJVSAIUW97bqjy5aPBwNe5DPLKxLUhs8BQGht-ZsqgK3xyCCZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:XQQIY_tTQiQjQpLFpU1FXFQ-03YrBNEmzrpZah3GnIAfUuipSMgKQQ>
    <xmx:XQQIYzcIWVkTlYiFoYWUXpUx7gQOfQHv1s86lLI1DkKJLC9Y6dO8_w>
    <xmx:XQQIY72F5M3pA_Q-qbH195GDPKf5v9LDQu2kqoenG_t-qi1mo5Plxg>
    <xmx:XQQIY0F0bRX4PQqKT1acVf-wDarwWM6Lm8KlD3pcoPaDxEqmS9BfMg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 19:23:05 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 1/2] asus-wmi: Implement TUF laptop keyboard LED modes
Date:   Fri, 26 Aug 2022 11:22:50 +1200
Message-Id: <20220825232251.345893-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825232251.345893-1-luke@ljones.dev>
References: <20220825232251.345893-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for changing the laptop keyboard LED mode and colour.

The modes are visible effects such as static, rainbow, pulsing,
colour cycles.

These sysfs attributes are added to asus::kbd_backlight:
- kbd_rgb_mode
- kbd_rgb_mode_index

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 76 +++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0f9f79f249c7..92f16bb9b4ef 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -237,6 +237,8 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
 
+	bool kbd_rgb_mode_available;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -720,6 +722,69 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(gpu_mux_mode);
 
+/* TUF Laptop Keyboard RGB Modes **********************************************/
+static ssize_t kbd_rgb_mode_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	u32 cmd, mode, r, g,  b,  speed;
+	int err;
+
+	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
+		return -EINVAL;
+
+	cmd = !!cmd;
+
+	/* These are the known usable modes across all TUF/ROG */
+	if (mode >= 12 || mode == 9)
+		mode = 10;
+
+	switch (speed) {
+	case 0:
+		speed = 0xe1;
+		break;
+	case 1:
+		speed = 0xeb;
+		break;
+	case 2:
+		speed = 0xf5;
+		break;
+	default:
+		speed = 0xeb;
+	}
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_WO(kbd_rgb_mode);
+
+static ssize_t kbd_rgb_mode_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "cmd mode red green blue speed");
+}
+static DEVICE_ATTR_RO(kbd_rgb_mode_index);
+
+static struct attribute *kbd_rgb_mode_attrs[] = {
+	&dev_attr_kbd_rgb_mode.attr,
+	&dev_attr_kbd_rgb_mode_index.attr,
+	NULL,
+};
+
+static const struct attribute_group kbd_rgb_mode_group = {
+	.attrs = kbd_rgb_mode_attrs,
+};
+
+const struct attribute_group *kbd_rgb_mode_groups[] = {
+	NULL,
+	NULL,
+};
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -1038,7 +1103,10 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
 
 static int asus_wmi_led_init(struct asus_wmi *asus)
 {
-	int rv = 0, led_val;
+	int rv = 0, num_rgb_groups = 0, led_val;
+
+	if (asus->kbd_rgb_mode_available)
+		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_mode_group;
 
 	asus->led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!asus->led_workqueue)
@@ -1066,6 +1134,9 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 		asus->kbd_led.brightness_get = kbd_led_get;
 		asus->kbd_led.max_brightness = 3;
 
+		if (num_rgb_groups != 0)
+			asus->kbd_led.groups = kbd_rgb_mode_groups;
+
 		rv = led_classdev_register(&asus->platform_device->dev,
 					   &asus->kbd_led);
 		if (rv)
@@ -3253,6 +3324,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
 		ok = asus->gpu_mux_mode_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
@@ -3519,6 +3592,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
+	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 
 	err = fan_boost_mode_check_present(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 6e8a95c10d17..3d861477cb20 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -103,6 +103,9 @@
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 
+/* TUF laptop RGB modes/colours */
+#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.2

