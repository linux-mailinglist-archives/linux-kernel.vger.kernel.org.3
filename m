Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC9520E34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiEJHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiEJHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:00:43 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A90A74DD1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:56:45 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id EFC0F211A7;
        Tue, 10 May 2022 06:56:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id D368E2F;
        Tue, 10 May 2022 06:56:43 +0000 (UTC)
Message-ID: <c7048f814c000d5581cc5fda7c4e88361a56adc3.camel@perches.com>
Subject: [PATCH] HID: input: Reduce object size by minimizing repeated calls
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 09 May 2022 23:56:42 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D368E2F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: bparospwojgi3rooksnanq3dzmc8sc6e
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19U461M5NyINuXa7mxSWzSzjBAKgPAAdy8=
X-HE-Tag: 1652165803-614167
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce object size by using an automatic for various repeated calls
to map_abs, map_key_clear, and map_led in switch/case statements.

$ size drivers/hid/hid-input.o* (defconfig x86-64)
   text	   data	    bss	    dec	    hex	filename
  22042	     88	      0	  22130	   5672	drivers/hid/hid-input.o.new
  27589	     88	      0	  27677	   6c1d	drivers/hid/hid-input.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-input.c | 522 ++++++++++++++++++++++++++----------------------
 1 file changed, 278 insertions(+), 244 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c6b27aab90414..21d67866efb06 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -743,37 +743,44 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		map_key(code);
 		break;
 
-	case HID_UP_SIMULATION:
+	case HID_UP_SIMULATION: {
+		int abs;
+
 		switch (usage->hid & 0xffff) {
-		case 0xba: map_abs(ABS_RUDDER);   break;
-		case 0xbb: map_abs(ABS_THROTTLE); break;
-		case 0xc4: map_abs(ABS_GAS);      break;
-		case 0xc5: map_abs(ABS_BRAKE);    break;
-		case 0xc8: map_abs(ABS_WHEEL);    break;
+		case 0xba: abs = ABS_RUDDER;	break;
+		case 0xbb: abs = ABS_THROTTLE;	break;
+		case 0xc4: abs = ABS_GAS;	break;
+		case 0xc5: abs = ABS_BRAKE;	break;
+		case 0xc8: abs = ABS_WHEEL;	break;
 		default:   goto ignore;
 		}
+		map_abs(abs);
 		break;
+	}
 
 	case HID_UP_GENDESK:
 		if ((usage->hid & 0xf0) == 0x80) {	/* SystemControl */
+			int key;
+
 			switch (usage->hid & 0xf) {
-			case 0x1: map_key_clear(KEY_POWER);  break;
-			case 0x2: map_key_clear(KEY_SLEEP);  break;
-			case 0x3: map_key_clear(KEY_WAKEUP); break;
-			case 0x4: map_key_clear(KEY_CONTEXT_MENU); break;
-			case 0x5: map_key_clear(KEY_MENU); break;
-			case 0x6: map_key_clear(KEY_PROG1); break;
-			case 0x7: map_key_clear(KEY_HELP); break;
-			case 0x8: map_key_clear(KEY_EXIT); break;
-			case 0x9: map_key_clear(KEY_SELECT); break;
-			case 0xa: map_key_clear(KEY_RIGHT); break;
-			case 0xb: map_key_clear(KEY_LEFT); break;
-			case 0xc: map_key_clear(KEY_UP); break;
-			case 0xd: map_key_clear(KEY_DOWN); break;
-			case 0xe: map_key_clear(KEY_POWER2); break;
-			case 0xf: map_key_clear(KEY_RESTART); break;
+			case 0x1: key = KEY_POWER;	break;
+			case 0x2: key = KEY_SLEEP;	break;
+			case 0x3: key = KEY_WAKEUP;	break;
+			case 0x4: key = KEY_CONTEXT_MENU; break;
+			case 0x5: key = KEY_MENU;	break;
+			case 0x6: key = KEY_PROG1;	break;
+			case 0x7: key = KEY_HELP;	break;
+			case 0x8: key = KEY_EXIT;	break;
+			case 0x9: key = KEY_SELECT;	break;
+			case 0xa: key = KEY_RIGHT;	break;
+			case 0xb: key = KEY_LEFT;	break;
+			case 0xc: key = KEY_UP;		break;
+			case 0xd: key = KEY_DOWN;	break;
+			case 0xe: key = KEY_POWER2;	break;
+			case 0xf: key = KEY_RESTART;	break;
 			default: goto unknown;
 			}
+			map_key_clear(key);
 			break;
 		}
 
@@ -859,23 +866,27 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		break;
 
-	case HID_UP_LED:
-		switch (usage->hid & 0xffff) {		      /* HID-Value:                   */
-		case 0x01:  map_led (LED_NUML);     break;    /*   "Num Lock"                 */
-		case 0x02:  map_led (LED_CAPSL);    break;    /*   "Caps Lock"                */
-		case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
-		case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
-		case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
-		case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
-		case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
-		case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
-		case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
-		case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
-		case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
+	case HID_UP_LED: {
+		int led;
+
+		switch (usage->hid & 0xffff) {		/* HID-Value: */
+		case 0x01:  led = LED_NUML;	break;	/* Num Lock */
+		case 0x02:  led = LED_CAPSL;	break;	/* Caps Lock */
+		case 0x03:  led = LED_SCROLLL;	break;	/* Scroll Lock */
+		case 0x04:  led = LED_COMPOSE;	break;	/* Compose */
+		case 0x05:  led = LED_KANA;	break;	/* Kana */
+		case 0x27:  led = LED_SLEEP;	break;	/* Stand-By */
+		case 0x4c:  led = LED_SUSPEND;	break;	/* System Suspend */
+		case 0x09:  led = LED_MUTE;	break;	/* Mute */
+		case 0x4b:  led = LED_MISC;	break;	/* Generic Indicator */
+		case 0x19:  led = LED_MAIL;	break;	/* Message Waiting */
+		case 0x4d:  led = LED_CHARGING;	break;	/* External Power Connected */
 
 		default: goto ignore;
 		}
+		map_led(led);
 		break;
+	}
 
 	case HID_UP_DIGITIZER:
 		if ((field->application & 0xff) == 0x01) /* Digitizer */
@@ -976,218 +987,233 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		}
 		break;
 
-	case HID_UP_TELEPHONY:
+	case HID_UP_TELEPHONY: {
+		int key;
+
 		switch (usage->hid & HID_USAGE) {
-		case 0x2f: map_key_clear(KEY_MICMUTE);		break;
-		case 0xb0: map_key_clear(KEY_NUMERIC_0);	break;
-		case 0xb1: map_key_clear(KEY_NUMERIC_1);	break;
-		case 0xb2: map_key_clear(KEY_NUMERIC_2);	break;
-		case 0xb3: map_key_clear(KEY_NUMERIC_3);	break;
-		case 0xb4: map_key_clear(KEY_NUMERIC_4);	break;
-		case 0xb5: map_key_clear(KEY_NUMERIC_5);	break;
-		case 0xb6: map_key_clear(KEY_NUMERIC_6);	break;
-		case 0xb7: map_key_clear(KEY_NUMERIC_7);	break;
-		case 0xb8: map_key_clear(KEY_NUMERIC_8);	break;
-		case 0xb9: map_key_clear(KEY_NUMERIC_9);	break;
-		case 0xba: map_key_clear(KEY_NUMERIC_STAR);	break;
-		case 0xbb: map_key_clear(KEY_NUMERIC_POUND);	break;
-		case 0xbc: map_key_clear(KEY_NUMERIC_A);	break;
-		case 0xbd: map_key_clear(KEY_NUMERIC_B);	break;
-		case 0xbe: map_key_clear(KEY_NUMERIC_C);	break;
-		case 0xbf: map_key_clear(KEY_NUMERIC_D);	break;
+		case 0x2f: key = KEY_MICMUTE;		break;
+		case 0xb0: key = KEY_NUMERIC_0;		break;
+		case 0xb1: key = KEY_NUMERIC_1;		break;
+		case 0xb2: key = KEY_NUMERIC_2;		break;
+		case 0xb3: key = KEY_NUMERIC_3;		break;
+		case 0xb4: key = KEY_NUMERIC_4;		break;
+		case 0xb5: key = KEY_NUMERIC_5;		break;
+		case 0xb6: key = KEY_NUMERIC_6;		break;
+		case 0xb7: key = KEY_NUMERIC_7;		break;
+		case 0xb8: key = KEY_NUMERIC_8;		break;
+		case 0xb9: key = KEY_NUMERIC_9;		break;
+		case 0xba: key = KEY_NUMERIC_STAR;	break;
+		case 0xbb: key = KEY_NUMERIC_POUND;	break;
+		case 0xbc: key = KEY_NUMERIC_A;		break;
+		case 0xbd: key = KEY_NUMERIC_B;		break;
+		case 0xbe: key = KEY_NUMERIC_C;		break;
+		case 0xbf: key = KEY_NUMERIC_D;		break;
 		default: goto ignore;
 		}
+		map_key_clear(key);
 		break;
+	}
+
+	case HID_UP_CONSUMER: {	/* USB HUT v1.12, pages 75-84 */
+		int key;
+		bool clear = true;
 
-	case HID_UP_CONSUMER:	/* USB HUT v1.12, pages 75-84 */
 		switch (usage->hid & HID_USAGE) {
 		case 0x000: goto ignore;
-		case 0x030: map_key_clear(KEY_POWER);		break;
-		case 0x031: map_key_clear(KEY_RESTART);		break;
-		case 0x032: map_key_clear(KEY_SLEEP);		break;
-		case 0x034: map_key_clear(KEY_SLEEP);		break;
-		case 0x035: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
-		case 0x036: map_key_clear(BTN_MISC);		break;
-
-		case 0x040: map_key_clear(KEY_MENU);		break; /* Menu */
-		case 0x041: map_key_clear(KEY_SELECT);		break; /* Menu Pick */
-		case 0x042: map_key_clear(KEY_UP);		break; /* Menu Up */
-		case 0x043: map_key_clear(KEY_DOWN);		break; /* Menu Down */
-		case 0x044: map_key_clear(KEY_LEFT);		break; /* Menu Left */
-		case 0x045: map_key_clear(KEY_RIGHT);		break; /* Menu Right */
-		case 0x046: map_key_clear(KEY_ESC);		break; /* Menu Escape */
-		case 0x047: map_key_clear(KEY_KPPLUS);		break; /* Menu Value Increase */
-		case 0x048: map_key_clear(KEY_KPMINUS);		break; /* Menu Value Decrease */
-
-		case 0x060: map_key_clear(KEY_INFO);		break; /* Data On Screen */
-		case 0x061: map_key_clear(KEY_SUBTITLE);	break; /* Closed Caption */
-		case 0x063: map_key_clear(KEY_VCR);		break; /* VCR/TV */
-		case 0x065: map_key_clear(KEY_CAMERA);		break; /* Snapshot */
-		case 0x069: map_key_clear(KEY_RED);		break;
-		case 0x06a: map_key_clear(KEY_GREEN);		break;
-		case 0x06b: map_key_clear(KEY_BLUE);		break;
-		case 0x06c: map_key_clear(KEY_YELLOW);		break;
-		case 0x06d: map_key_clear(KEY_ASPECT_RATIO);	break;
-
-		case 0x06f: map_key_clear(KEY_BRIGHTNESSUP);		break;
-		case 0x070: map_key_clear(KEY_BRIGHTNESSDOWN);		break;
-		case 0x072: map_key_clear(KEY_BRIGHTNESS_TOGGLE);	break;
-		case 0x073: map_key_clear(KEY_BRIGHTNESS_MIN);		break;
-		case 0x074: map_key_clear(KEY_BRIGHTNESS_MAX);		break;
-		case 0x075: map_key_clear(KEY_BRIGHTNESS_AUTO);		break;
-
-		case 0x079: map_key_clear(KEY_KBDILLUMUP);	break;
-		case 0x07a: map_key_clear(KEY_KBDILLUMDOWN);	break;
-		case 0x07c: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
-
-		case 0x082: map_key_clear(KEY_VIDEO_NEXT);	break;
-		case 0x083: map_key_clear(KEY_LAST);		break;
-		case 0x084: map_key_clear(KEY_ENTER);		break;
-		case 0x088: map_key_clear(KEY_PC);		break;
-		case 0x089: map_key_clear(KEY_TV);		break;
-		case 0x08a: map_key_clear(KEY_WWW);		break;
-		case 0x08b: map_key_clear(KEY_DVD);		break;
-		case 0x08c: map_key_clear(KEY_PHONE);		break;
-		case 0x08d: map_key_clear(KEY_PROGRAM);		break;
-		case 0x08e: map_key_clear(KEY_VIDEOPHONE);	break;
-		case 0x08f: map_key_clear(KEY_GAMES);		break;
-		case 0x090: map_key_clear(KEY_MEMO);		break;
-		case 0x091: map_key_clear(KEY_CD);		break;
-		case 0x092: map_key_clear(KEY_VCR);		break;
-		case 0x093: map_key_clear(KEY_TUNER);		break;
-		case 0x094: map_key_clear(KEY_EXIT);		break;
-		case 0x095: map_key_clear(KEY_HELP);		break;
-		case 0x096: map_key_clear(KEY_TAPE);		break;
-		case 0x097: map_key_clear(KEY_TV2);		break;
-		case 0x098: map_key_clear(KEY_SAT);		break;
-		case 0x09a: map_key_clear(KEY_PVR);		break;
-
-		case 0x09c: map_key_clear(KEY_CHANNELUP);	break;
-		case 0x09d: map_key_clear(KEY_CHANNELDOWN);	break;
-		case 0x0a0: map_key_clear(KEY_VCR2);		break;
-
-		case 0x0b0: map_key_clear(KEY_PLAY);		break;
-		case 0x0b1: map_key_clear(KEY_PAUSE);		break;
-		case 0x0b2: map_key_clear(KEY_RECORD);		break;
-		case 0x0b3: map_key_clear(KEY_FASTFORWARD);	break;
-		case 0x0b4: map_key_clear(KEY_REWIND);		break;
-		case 0x0b5: map_key_clear(KEY_NEXTSONG);	break;
-		case 0x0b6: map_key_clear(KEY_PREVIOUSSONG);	break;
-		case 0x0b7: map_key_clear(KEY_STOPCD);		break;
-		case 0x0b8: map_key_clear(KEY_EJECTCD);		break;
-		case 0x0bc: map_key_clear(KEY_MEDIA_REPEAT);	break;
-		case 0x0b9: map_key_clear(KEY_SHUFFLE);		break;
-		case 0x0bf: map_key_clear(KEY_SLOW);		break;
-
-		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
-		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
-
-		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
-		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
-
-		case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
-		case 0x0e2: map_key_clear(KEY_MUTE);		break;
-		case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
-		case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
-		case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
-		case 0x0f5: map_key_clear(KEY_SLOW);		break;
-
-		case 0x181: map_key_clear(KEY_BUTTONCONFIG);	break;
-		case 0x182: map_key_clear(KEY_BOOKMARKS);	break;
-		case 0x183: map_key_clear(KEY_CONFIG);		break;
-		case 0x184: map_key_clear(KEY_WORDPROCESSOR);	break;
-		case 0x185: map_key_clear(KEY_EDITOR);		break;
-		case 0x186: map_key_clear(KEY_SPREADSHEET);	break;
-		case 0x187: map_key_clear(KEY_GRAPHICSEDITOR);	break;
-		case 0x188: map_key_clear(KEY_PRESENTATION);	break;
-		case 0x189: map_key_clear(KEY_DATABASE);	break;
-		case 0x18a: map_key_clear(KEY_MAIL);		break;
-		case 0x18b: map_key_clear(KEY_NEWS);		break;
-		case 0x18c: map_key_clear(KEY_VOICEMAIL);	break;
-		case 0x18d: map_key_clear(KEY_ADDRESSBOOK);	break;
-		case 0x18e: map_key_clear(KEY_CALENDAR);	break;
-		case 0x18f: map_key_clear(KEY_TASKMANAGER);	break;
-		case 0x190: map_key_clear(KEY_JOURNAL);		break;
-		case 0x191: map_key_clear(KEY_FINANCE);		break;
-		case 0x192: map_key_clear(KEY_CALC);		break;
-		case 0x193: map_key_clear(KEY_PLAYER);		break;
-		case 0x194: map_key_clear(KEY_FILE);		break;
-		case 0x196: map_key_clear(KEY_WWW);		break;
-		case 0x199: map_key_clear(KEY_CHAT);		break;
-		case 0x19c: map_key_clear(KEY_LOGOFF);		break;
-		case 0x19e: map_key_clear(KEY_COFFEE);		break;
-		case 0x19f: map_key_clear(KEY_CONTROLPANEL);		break;
-		case 0x1a2: map_key_clear(KEY_APPSELECT);		break;
-		case 0x1a3: map_key_clear(KEY_NEXT);		break;
-		case 0x1a4: map_key_clear(KEY_PREVIOUS);	break;
-		case 0x1a6: map_key_clear(KEY_HELP);		break;
-		case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
-		case 0x1ab: map_key_clear(KEY_SPELLCHECK);	break;
-		case 0x1ae: map_key_clear(KEY_KEYBOARD);	break;
-		case 0x1b1: map_key_clear(KEY_SCREENSAVER);		break;
-		case 0x1b4: map_key_clear(KEY_FILE);		break;
-		case 0x1b6: map_key_clear(KEY_IMAGES);		break;
-		case 0x1b7: map_key_clear(KEY_AUDIO);		break;
-		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
-		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
-		case 0x1bd: map_key_clear(KEY_INFO);		break;
-		case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
-		case 0x201: map_key_clear(KEY_NEW);		break;
-		case 0x202: map_key_clear(KEY_OPEN);		break;
-		case 0x203: map_key_clear(KEY_CLOSE);		break;
-		case 0x204: map_key_clear(KEY_EXIT);		break;
-		case 0x207: map_key_clear(KEY_SAVE);		break;
-		case 0x208: map_key_clear(KEY_PRINT);		break;
-		case 0x209: map_key_clear(KEY_PROPS);		break;
-		case 0x21a: map_key_clear(KEY_UNDO);		break;
-		case 0x21b: map_key_clear(KEY_COPY);		break;
-		case 0x21c: map_key_clear(KEY_CUT);		break;
-		case 0x21d: map_key_clear(KEY_PASTE);		break;
-		case 0x21f: map_key_clear(KEY_FIND);		break;
-		case 0x221: map_key_clear(KEY_SEARCH);		break;
-		case 0x222: map_key_clear(KEY_GOTO);		break;
-		case 0x223: map_key_clear(KEY_HOMEPAGE);	break;
-		case 0x224: map_key_clear(KEY_BACK);		break;
-		case 0x225: map_key_clear(KEY_FORWARD);		break;
-		case 0x226: map_key_clear(KEY_STOP);		break;
-		case 0x227: map_key_clear(KEY_REFRESH);		break;
-		case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
-		case 0x22d: map_key_clear(KEY_ZOOMIN);		break;
-		case 0x22e: map_key_clear(KEY_ZOOMOUT);		break;
-		case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
-		case 0x232: map_key_clear(KEY_FULL_SCREEN);	break;
-		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
-		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
+		case 0x030: key = KEY_POWER;		break;
+		case 0x031: key = KEY_RESTART;		break;
+		case 0x032: key = KEY_SLEEP;		break;
+		case 0x034: key = KEY_SLEEP;		break;
+		case 0x035: key = KEY_KBDILLUMTOGGLE;	break;
+		case 0x036: key = BTN_MISC;		break;
+
+		case 0x040: key = KEY_MENU;		break; /* Menu */
+		case 0x041: key = KEY_SELECT;		break; /* Menu Pick */
+		case 0x042: key = KEY_UP;		break; /* Menu Up */
+		case 0x043: key = KEY_DOWN;		break; /* Menu Down */
+		case 0x044: key = KEY_LEFT;		break; /* Menu Left */
+		case 0x045: key = KEY_RIGHT;		break; /* Menu Right */
+		case 0x046: key = KEY_ESC;		break; /* Menu Escape */
+		case 0x047: key = KEY_KPPLUS;		break; /* Menu Value Increase */
+		case 0x048: key = KEY_KPMINUS;		break; /* Menu Value Decrease */
+
+		case 0x060: key = KEY_INFO;		break; /* Data On Screen */
+		case 0x061: key = KEY_SUBTITLE;		break; /* Closed Caption */
+		case 0x063: key = KEY_VCR;		break; /* VCR/TV */
+		case 0x065: key = KEY_CAMERA;		break; /* Snapshot */
+		case 0x069: key = KEY_RED;		break;
+		case 0x06a: key = KEY_GREEN;		break;
+		case 0x06b: key = KEY_BLUE;		break;
+		case 0x06c: key = KEY_YELLOW;		break;
+		case 0x06d: key = KEY_ASPECT_RATIO;	break;
+
+		case 0x06f: key = KEY_BRIGHTNESSUP;		break;
+		case 0x070: key = KEY_BRIGHTNESSDOWN;		break;
+		case 0x072: key = KEY_BRIGHTNESS_TOGGLE;	break;
+		case 0x073: key = KEY_BRIGHTNESS_MIN;		break;
+		case 0x074: key = KEY_BRIGHTNESS_MAX;		break;
+		case 0x075: key = KEY_BRIGHTNESS_AUTO;		break;
+
+		case 0x079: key = KEY_KBDILLUMUP;	break;
+		case 0x07a: key = KEY_KBDILLUMDOWN;	break;
+		case 0x07c: key = KEY_KBDILLUMTOGGLE;	break;
+
+		case 0x082: key = KEY_VIDEO_NEXT;	break;
+		case 0x083: key = KEY_LAST;		break;
+		case 0x084: key = KEY_ENTER;		break;
+		case 0x088: key = KEY_PC;		break;
+		case 0x089: key = KEY_TV;		break;
+		case 0x08a: key = KEY_WWW;		break;
+		case 0x08b: key = KEY_DVD;		break;
+		case 0x08c: key = KEY_PHONE;		break;
+		case 0x08d: key = KEY_PROGRAM;		break;
+		case 0x08e: key = KEY_VIDEOPHONE;	break;
+		case 0x08f: key = KEY_GAMES;		break;
+		case 0x090: key = KEY_MEMO;		break;
+		case 0x091: key = KEY_CD;		break;
+		case 0x092: key = KEY_VCR;		break;
+		case 0x093: key = KEY_TUNER;		break;
+		case 0x094: key = KEY_EXIT;		break;
+		case 0x095: key = KEY_HELP;		break;
+		case 0x096: key = KEY_TAPE;		break;
+		case 0x097: key = KEY_TV2;		break;
+		case 0x098: key = KEY_SAT;		break;
+		case 0x09a: key = KEY_PVR;		break;
+
+		case 0x09c: key = KEY_CHANNELUP;	break;
+		case 0x09d: key = KEY_CHANNELDOWN;	break;
+		case 0x0a0: key = KEY_VCR2;		break;
+
+		case 0x0b0: key = KEY_PLAY;		break;
+		case 0x0b1: key = KEY_PAUSE;		break;
+		case 0x0b2: key = KEY_RECORD;		break;
+		case 0x0b3: key = KEY_FASTFORWARD;	break;
+		case 0x0b4: key = KEY_REWIND;		break;
+		case 0x0b5: key = KEY_NEXTSONG;		break;
+		case 0x0b6: key = KEY_PREVIOUSSONG;	break;
+		case 0x0b7: key = KEY_STOPCD;		break;
+		case 0x0b8: key = KEY_EJECTCD;		break;
+		case 0x0bc: key = KEY_MEDIA_REPEAT;	break;
+		case 0x0b9: key = KEY_SHUFFLE;		break;
+		case 0x0bf: key = KEY_SLOW;		break;
+
+		case 0x0cd: key = KEY_PLAYPAUSE;	break;
+		case 0x0cf: key = KEY_VOICECOMMAND;	break;
+
+		case 0x0d8: key = KEY_DICTATE;		break;
+		case 0x0d9: key = KEY_EMOJI_PICKER;	break;
+
+		case 0x0e0:
+			map_abs_clear(ABS_VOLUME);
+			clear = false;
+			break;
+		case 0x0e2: key = KEY_MUTE;		break;
+		case 0x0e5: key = KEY_BASSBOOST;	break;
+		case 0x0e9: key = KEY_VOLUMEUP;		break;
+		case 0x0ea: key = KEY_VOLUMEDOWN;	break;
+		case 0x0f5: key = KEY_SLOW;		break;
+
+		case 0x181: key = KEY_BUTTONCONFIG;	break;
+		case 0x182: key = KEY_BOOKMARKS;	break;
+		case 0x183: key = KEY_CONFIG;		break;
+		case 0x184: key = KEY_WORDPROCESSOR;	break;
+		case 0x185: key = KEY_EDITOR;		break;
+		case 0x186: key = KEY_SPREADSHEET;	break;
+		case 0x187: key = KEY_GRAPHICSEDITOR;	break;
+		case 0x188: key = KEY_PRESENTATION;	break;
+		case 0x189: key = KEY_DATABASE;		break;
+		case 0x18a: key = KEY_MAIL;		break;
+		case 0x18b: key = KEY_NEWS;		break;
+		case 0x18c: key = KEY_VOICEMAIL;	break;
+		case 0x18d: key = KEY_ADDRESSBOOK;	break;
+		case 0x18e: key = KEY_CALENDAR;		break;
+		case 0x18f: key = KEY_TASKMANAGER;	break;
+		case 0x190: key = KEY_JOURNAL;		break;
+		case 0x191: key = KEY_FINANCE;		break;
+		case 0x192: key = KEY_CALC;		break;
+		case 0x193: key = KEY_PLAYER;		break;
+		case 0x194: key = KEY_FILE;		break;
+		case 0x196: key = KEY_WWW;		break;
+		case 0x199: key = KEY_CHAT;		break;
+		case 0x19c: key = KEY_LOGOFF;		break;
+		case 0x19e: key = KEY_COFFEE;		break;
+		case 0x19f: key = KEY_CONTROLPANEL;	break;
+		case 0x1a2: key = KEY_APPSELECT;	break;
+		case 0x1a3: key = KEY_NEXT;		break;
+		case 0x1a4: key = KEY_PREVIOUS;		break;
+		case 0x1a6: key = KEY_HELP;		break;
+		case 0x1a7: key = KEY_DOCUMENTS;	break;
+		case 0x1ab: key = KEY_SPELLCHECK;	break;
+		case 0x1ae: key = KEY_KEYBOARD;		break;
+		case 0x1b1: key = KEY_SCREENSAVER;	break;
+		case 0x1b4: key = KEY_FILE;		break;
+		case 0x1b6: key = KEY_IMAGES;		break;
+		case 0x1b7: key = KEY_AUDIO;		break;
+		case 0x1b8: key = KEY_VIDEO;		break;
+		case 0x1bc: key = KEY_MESSENGER;	break;
+		case 0x1bd: key = KEY_INFO;		break;
+		case 0x1cb: key = KEY_ASSISTANT;	break;
+		case 0x201: key = KEY_NEW;		break;
+		case 0x202: key = KEY_OPEN;		break;
+		case 0x203: key = KEY_CLOSE;		break;
+		case 0x204: key = KEY_EXIT;		break;
+		case 0x207: key = KEY_SAVE;		break;
+		case 0x208: key = KEY_PRINT;		break;
+		case 0x209: key = KEY_PROPS;		break;
+		case 0x21a: key = KEY_UNDO;		break;
+		case 0x21b: key = KEY_COPY;		break;
+		case 0x21c: key = KEY_CUT;		break;
+		case 0x21d: key = KEY_PASTE;		break;
+		case 0x21f: key = KEY_FIND;		break;
+		case 0x221: key = KEY_SEARCH;		break;
+		case 0x222: key = KEY_GOTO;		break;
+		case 0x223: key = KEY_HOMEPAGE;		break;
+		case 0x224: key = KEY_BACK;		break;
+		case 0x225: key = KEY_FORWARD;		break;
+		case 0x226: key = KEY_STOP;		break;
+		case 0x227: key = KEY_REFRESH;		break;
+		case 0x22a: key = KEY_BOOKMARKS;	break;
+		case 0x22d: key = KEY_ZOOMIN;		break;
+		case 0x22e: key = KEY_ZOOMOUT;		break;
+		case 0x22f: key = KEY_ZOOMRESET;	break;
+		case 0x232: key = KEY_FULL_SCREEN;	break;
+		case 0x233: key = KEY_SCROLLUP;		break;
+		case 0x234: key = KEY_SCROLLDOWN;	break;
 		case 0x238: /* AC Pan */
 			set_bit(REL_HWHEEL, input->relbit);
 			map_rel(REL_HWHEEL_HI_RES);
+			clear = false;
 			break;
-		case 0x23d: map_key_clear(KEY_EDIT);		break;
-		case 0x25f: map_key_clear(KEY_CANCEL);		break;
-		case 0x269: map_key_clear(KEY_INSERT);		break;
-		case 0x26a: map_key_clear(KEY_DELETE);		break;
-		case 0x279: map_key_clear(KEY_REDO);		break;
+		case 0x23d: key = KEY_EDIT;		break;
+		case 0x25f: key = KEY_CANCEL;		break;
+		case 0x269: key = KEY_INSERT;		break;
+		case 0x26a: key = KEY_DELETE;		break;
+		case 0x279: key = KEY_REDO;		break;
 
-		case 0x289: map_key_clear(KEY_REPLY);		break;
-		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
-		case 0x28c: map_key_clear(KEY_SEND);		break;
+		case 0x289: key = KEY_REPLY;		break;
+		case 0x28b: key = KEY_FORWARDMAIL;	break;
+		case 0x28c: key = KEY_SEND;		break;
 
-		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
+		case 0x29d: key = KEY_KBD_LAYOUT_NEXT;	break;
 
-		case 0x2a2: map_key_clear(KEY_ALL_APPLICATIONS);	break;
+		case 0x2a2: key = KEY_ALL_APPLICATIONS;	break;
 
-		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
-		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
-		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
-		case 0x2ca: map_key_clear(KEY_KBDINPUTASSIST_NEXTGROUP);		break;
-		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
-		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
+		case 0x2c7: key = KEY_KBDINPUTASSIST_PREV;		break;
+		case 0x2c8: key = KEY_KBDINPUTASSIST_NEXT;		break;
+		case 0x2c9: key = KEY_KBDINPUTASSIST_PREVGROUP;		break;
+		case 0x2ca: key = KEY_KBDINPUTASSIST_NEXTGROUP;		break;
+		case 0x2cb: key = KEY_KBDINPUTASSIST_ACCEPT;		break;
+		case 0x2cc: key = KEY_KBDINPUTASSIST_CANCEL;		break;
 
-		case 0x29f: map_key_clear(KEY_SCALE);		break;
+		case 0x29f: key = KEY_SCALE;		break;
 
-		default: map_key_clear(KEY_UNKNOWN);
+		default: key = KEY_UNKNOWN;		break;
 		}
+
+		if (clear)
+			map_key_clear(key);
 		break;
+	}
 
 	case HID_UP_GENDEVCTRLS:
 		switch (usage->hid) {
@@ -1207,34 +1233,42 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		}
 		goto unknown;
 
-	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
+	case HID_UP_HPVENDOR: {	/* Reported on a Dutch layout HP5308 */
+		int key;
+
 		set_bit(EV_REP, input->evbit);
 		switch (usage->hid & HID_USAGE) {
-		case 0x021: map_key_clear(KEY_PRINT);           break;
-		case 0x070: map_key_clear(KEY_HP);		break;
-		case 0x071: map_key_clear(KEY_CAMERA);		break;
-		case 0x072: map_key_clear(KEY_SOUND);		break;
-		case 0x073: map_key_clear(KEY_QUESTION);	break;
-		case 0x080: map_key_clear(KEY_EMAIL);		break;
-		case 0x081: map_key_clear(KEY_CHAT);		break;
-		case 0x082: map_key_clear(KEY_SEARCH);		break;
-		case 0x083: map_key_clear(KEY_CONNECT);	        break;
-		case 0x084: map_key_clear(KEY_FINANCE);		break;
-		case 0x085: map_key_clear(KEY_SPORT);		break;
-		case 0x086: map_key_clear(KEY_SHOP);	        break;
+		case 0x021: key = KEY_PRINT;		break;
+		case 0x070: key = KEY_HP;		break;
+		case 0x071: key = KEY_CAMERA;		break;
+		case 0x072: key = KEY_SOUND;		break;
+		case 0x073: key = KEY_QUESTION;		break;
+		case 0x080: key = KEY_EMAIL;		break;
+		case 0x081: key = KEY_CHAT;		break;
+		case 0x082: key = KEY_SEARCH;		break;
+		case 0x083: key = KEY_CONNECT;	        break;
+		case 0x084: key = KEY_FINANCE;		break;
+		case 0x085: key = KEY_SPORT;		break;
+		case 0x086: key = KEY_SHOP;	        break;
 		default:    goto ignore;
 		}
+		map_key_clear(key);
 		break;
+	}
+
+	case HID_UP_HPVENDOR2: {
+		int key;
 
-	case HID_UP_HPVENDOR2:
 		set_bit(EV_REP, input->evbit);
 		switch (usage->hid & HID_USAGE) {
-		case 0x001: map_key_clear(KEY_MICMUTE);		break;
-		case 0x003: map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x004: map_key_clear(KEY_BRIGHTNESSUP);	break;
+		case 0x001: key = KEY_MICMUTE;		break;
+		case 0x003: key = KEY_BRIGHTNESSDOWN;	break;
+		case 0x004: key = KEY_BRIGHTNESSUP;	break;
 		default:    goto ignore;
 		}
+		map_key_clear(key);
 		break;
+	}
 
 	case HID_UP_MSVENDOR:
 		goto ignore;


