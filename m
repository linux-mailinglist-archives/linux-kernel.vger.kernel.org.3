Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D09563294
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiGALaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiGALaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:30:05 -0400
X-Greylist: delayed 3041 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 04:30:05 PDT
Received: from smarthost06.digicable.hu (smarthost06.digicable.hu [94.21.128.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A074814BF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:30:05 -0700 (PDT)
Received: from [92.249.128.185] (helo=relay03.digicable.hu)
        by smarthost06.digicable.hu with esmtp
        id 1o7E3W-0000jp-GH for <linux-kernel@vger.kernel.org>;
        Fri, 01 Jul 2022 12:39:22 +0200
Received: from [178.164.181.62] (helo=root.otthon)
        by relay03.digicable.hu with esmtpa
        id 1o7E3W-0003wA-8a for <linux-kernel@vger.kernel.org>;
        Fri, 01 Jul 2022 12:39:22 +0200
Received: by root.otthon (Postfix, from userid 1000)
        id 1B2B680CDA38; Fri,  1 Jul 2022 12:39:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by root.otthon (Postfix) with ESMTP id 06ABF101FD73D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:39:22 +0200 (CEST)
Date:   Fri, 1 Jul 2022 12:39:21 +0200 (CEST)
From:   Greg T <greg.iforce@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: |Question] iforce Boeder Force Feedback Wheel
Message-ID: <495ce212-addc-8ab1-a851-4fd5f6c5c8d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Original: 178.164.181.62
X-Original: 92.249.128.185
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to make a Boeder Force Feedback Wheel work using its serial 
interface (/dev/ttyS0).

1. As iforce-main.c identifies it as "Unknown I-Force Device 
[%04x:%04x]", I think those placeholders should be replaced by vendor 
and product ids, but aren't.

2. Here's a patch to make it recognized:

--- drivers/input/joystick/iforce/iforce-main.c.orig	2022-06-14 19:21:30.000000000 +0200
+++ drivers/input/joystick/iforce/iforce-main.c	2022-06-30 18:52:38.022039742 +0200
@@ -50,6 +50,7 @@
 	{ 0x046d, 0xc291, "Logitech WingMan Formula Force",		btn_wheel, abs_wheel, ff_iforce },
 	{ 0x05ef, 0x020a, "AVB Top Shot Pegasus",			btn_joystick_avb, abs_avb_pegasus, ff_iforce },
 	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_wheel, abs_wheel, ff_iforce },
+	{ 0x05ef, 0x8886, "Boeder Force Feedback Wheel",		btn_wheel, abs_wheel, ff_iforce },
 	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },

3. There's a problem that the GAS and BRAKE values (in jstest) start 
from -32767, not 0, and it causes menus in games like RVGL to 
malfunction and you have to press the pedal halfway while using a 
menu with keyboard as a really unpleasant workaround.
The below patches eliminate that problem, but I'm not sure if it's a 
kernel or user space problem or just my ignorance. (With its Windows 
9x driver, by default, both pedals are on the Y-axis, but move away 
from 0 in the opposite directions.)

--- drivers/input/joystick/iforce/iforce-main.c.orig	2022-06-14 19:21:30.000000000 +0200
+++ drivers/input/joystick/iforce/iforce-main.c	2022-07-01 09:49:58.344970061 +0200
@@ -350,7 +351,7 @@
 		case ABS_THROTTLE:
 		case ABS_GAS:
 		case ABS_BRAKE:
-			input_set_abs_params(input_dev, t, 0, 255, 0, 0);
+			input_set_abs_params(input_dev, t, 0, 511, 0, 0);
 			break;
 
 		case ABS_RUDDER:

--- drivers/input/joystick/iforce/iforce-packets.c.orig	2022-06-14 19:21:30.000000000 +0200
+++ drivers/input/joystick/iforce/iforce-packets.c	2022-07-01 09:58:10.061354919 +0200
@@ -178,8 +178,8 @@
 	case 0x03:	/* wheel position data */
 		input_report_abs(dev, ABS_WHEEL,
 				 (__s16) get_unaligned_le16(data));
-		input_report_abs(dev, ABS_GAS,   255 - data[2]);
-		input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+		input_report_abs(dev, ABS_GAS,   510 - data[2]);
+		input_report_abs(dev, ABS_BRAKE, 510 - data[3]);
 
 		iforce_report_hats_buttons(iforce, data);
 
4. Force feedback seems to work from fftest (at least some of the 
functions), but when using ff in RVGL or VDrift, the system freezes 
and I can't find anything related in journalctl after hard resetting. 
How should I debug this problem?

It's on Fedora release 34. Kernel/iforce source is from 
https://gitlab.com/cki-project/kernel-ark/-/tree/fedora-5.17/drivers/input/joystick/iforce
and the kernel-devel-5.17.12-100.fc34.x86_64 package.
