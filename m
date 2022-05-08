Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205351EEFC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiEHQvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiEHQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:51:40 -0400
Received: from relay3.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C162F9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:47:47 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id D35DDCA0;
        Sun,  8 May 2022 16:47:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id B2D1920028;
        Sun,  8 May 2022 16:47:45 +0000 (UTC)
Message-ID: <eeb32669c6641bc609d5b4460262b25e4b3d3f00.camel@perches.com>
Subject: Re: [PATCH] staging: drivers: hid: hid-asus.c: Fixed
 brace/formatting issues.
From:   Joe Perches <joe@perches.com>
To:     Johan Boger <jb@ip.fi>, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 08 May 2022 09:47:44 -0700
In-Reply-To: <20220508125056.354001-1-jb@ip.fi>
References: <20220508125056.354001-1-jb@ip.fi>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: m99qzcz5otr7jw1j8jq9665qcr9cnope
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B2D1920028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/+VzXIsHSXapGIOrF0fKhPIPVnNpOpIKU=
X-HE-Tag: 1652028465-192970
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-08 at 14:50 +0200, Johan Boger wrote:
> Fixed formatting issues based on recommendations from 
> scripts/checkpatch.pl, in accordance with coding style.
[]
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
[]
> @@ -852,47 +850,86 @@ static int asus_input_mapping(struct hid_device *hdev,
>  	/* ASUS-specific keyboard hotkeys and led backlight */
>  	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
>  		switch (usage->hid & HID_USAGE) {
> -		case 0x10: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
[...]

I think the break on the same line isn't that difficult a style.

All of these changes would be better with different code setting
a temporary then a single call to asus_map_key_clear(temp);

It'd also make the object code rather smaller.

$ size drivers/hid/hid-asus.o* (x86-64 defconfig with hid-asus)
   text	   data	    bss	    dec	    hex	filename
  10695	    420	      0	  11115	   2b6b	drivers/hid/hid-asus.o.new
  14108	    420	      0	  14528	   38c0	drivers/hid/hid-asus.o.old
---
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 08c9a9a60ae47..4702902ee4dad 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -827,6 +827,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		struct hid_usage *usage, unsigned long **bit,
 		int *max)
 {
+	int clear_key;
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 
 	if (drvdata->quirks & QUIRK_SKIP_INPUT_MAPPING) {
@@ -852,43 +853,43 @@ static int asus_input_mapping(struct hid_device *hdev,
 	/* ASUS-specific keyboard hotkeys and led backlight */
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
 		switch (usage->hid & HID_USAGE) {
-		case 0x10: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x20: asus_map_key_clear(KEY_BRIGHTNESSUP);		break;
-		case 0x35: asus_map_key_clear(KEY_DISPLAY_OFF);		break;
-		case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
-		case 0x7c: asus_map_key_clear(KEY_MICMUTE);		break;
-		case 0x82: asus_map_key_clear(KEY_CAMERA);		break;
-		case 0x88: asus_map_key_clear(KEY_RFKILL);			break;
-		case 0xb5: asus_map_key_clear(KEY_CALC);			break;
-		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
-		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
+		case 0x10: clear_key = KEY_BRIGHTNESSDOWN;	break;
+		case 0x20: clear_key = KEY_BRIGHTNESSUP;	break;
+		case 0x35: clear_key = KEY_DISPLAY_OFF;		break;
+		case 0x6c: clear_key = KEY_SLEEP;		break;
+		case 0x7c: clear_key = KEY_MICMUTE;		break;
+		case 0x82: clear_key = KEY_CAMERA;		break;
+		case 0x88: clear_key = KEY_RFKILL;		break;
+		case 0xb5: clear_key = KEY_CALC;		break;
+		case 0xc4: clear_key = KEY_KBDILLUMUP;		break;
+		case 0xc5: clear_key = KEY_KBDILLUMDOWN;	break;
 
 		/* ASUS touchpad toggle */
-		case 0x6b: asus_map_key_clear(KEY_F21);			break;
+		case 0x6b: clear_key = KEY_F21;			break;
 
 		/* ROG key */
-		case 0x38: asus_map_key_clear(KEY_PROG1);		break;
+		case 0x38: clear_key = KEY_PROG1;		break;
 
 		/* Fn+C ASUS Splendid */
-		case 0xba: asus_map_key_clear(KEY_PROG2);		break;
+		case 0xba: clear_key = KEY_PROG2;		break;
 
 		/* Fn+Space Power4Gear Hybrid */
-		case 0x5c: asus_map_key_clear(KEY_PROG3);		break;
+		case 0x5c: clear_key = KEY_PROG3;		break;
 
 		/* Fn+F5 "fan" symbol on FX503VD */
-		case 0x99: asus_map_key_clear(KEY_PROG4);		break;
+		case 0x99: clear_key = KEY_PROG4;		break;
 
 		/* Fn+F5 "fan" symbol on N-Key keyboard */
-		case 0xae: asus_map_key_clear(KEY_PROG4);		break;
+		case 0xae: clear_key = KEY_PROG4;		break;
 
 		/* Fn+Ret "Calc" symbol on N-Key keyboard */
-		case 0x92: asus_map_key_clear(KEY_CALC);		break;
+		case 0x92: clear_key = KEY_CALC;		break;
 
 		/* Fn+Left Aura mode previous on N-Key keyboard */
-		case 0xb2: asus_map_key_clear(KEY_PROG2);		break;
+		case 0xb2: clear_key = KEY_PROG2;		break;
 
 		/* Fn+Right Aura mode next on N-Key keyboard */
-		case 0xb3: asus_map_key_clear(KEY_PROG3);		break;
+		case 0xb3: clear_key = KEY_PROG3;		break;
 
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
@@ -896,6 +897,8 @@ static int asus_input_mapping(struct hid_device *hdev,
 			return -1;
 		}
 
+		asus_map_key_clear(clear_key);
+
 		/*
 		 * Check and enable backlight only on devices with UsagePage ==
 		 * 0xff31 to avoid initializing the keyboard firmware multiple
@@ -911,27 +914,29 @@ static int asus_input_mapping(struct hid_device *hdev,
 
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
 		switch (usage->hid & HID_USAGE) {
-		case 0xff01: asus_map_key_clear(BTN_1);	break;
-		case 0xff02: asus_map_key_clear(BTN_2);	break;
-		case 0xff03: asus_map_key_clear(BTN_3);	break;
-		case 0xff04: asus_map_key_clear(BTN_4);	break;
-		case 0xff05: asus_map_key_clear(BTN_5);	break;
-		case 0xff06: asus_map_key_clear(BTN_6);	break;
-		case 0xff07: asus_map_key_clear(BTN_7);	break;
-		case 0xff08: asus_map_key_clear(BTN_8);	break;
-		case 0xff09: asus_map_key_clear(BTN_9);	break;
-		case 0xff0a: asus_map_key_clear(BTN_A);	break;
-		case 0xff0b: asus_map_key_clear(BTN_B);	break;
-		case 0x00f1: asus_map_key_clear(KEY_WLAN);	break;
-		case 0x00f2: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x00f3: asus_map_key_clear(KEY_BRIGHTNESSUP);	break;
-		case 0x00f4: asus_map_key_clear(KEY_DISPLAY_OFF);	break;
-		case 0x00f7: asus_map_key_clear(KEY_CAMERA);	break;
-		case 0x00f8: asus_map_key_clear(KEY_PROG1);	break;
+		case 0xff01: clear_key = BTN_1;			break;
+		case 0xff02: clear_key = BTN_2;			break;
+		case 0xff03: clear_key = BTN_3;			break;
+		case 0xff04: clear_key = BTN_4;			break;
+		case 0xff05: clear_key = BTN_5;			break;
+		case 0xff06: clear_key = BTN_6;			break;
+		case 0xff07: clear_key = BTN_7;			break;
+		case 0xff08: clear_key = BTN_8;			break;
+		case 0xff09: clear_key = BTN_9;			break;
+		case 0xff0a: clear_key = BTN_A;			break;
+		case 0xff0b: clear_key = BTN_B;			break;
+		case 0x00f1: clear_key = KEY_WLAN;		break;
+		case 0x00f2: clear_key = KEY_BRIGHTNESSDOWN;	break;
+		case 0x00f3: clear_key = KEY_BRIGHTNESSUP;	break;
+		case 0x00f4: clear_key = KEY_DISPLAY_OFF;	break;
+		case 0x00f7: clear_key = KEY_CAMERA;		break;
+		case 0x00f8: clear_key = KEY_PROG1;		break;
 		default:
 			return 0;
 		}
 
+		asus_map_key_clear(clear_key);
+
 		set_bit(EV_REP, hi->input->evbit);
 		return 1;
 	}

