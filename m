Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218A7464476
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbhLAB0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:26:18 -0500
Received: from smtpbg701.qq.com ([203.205.195.86]:59447 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230476AbhLAB0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:26:16 -0500
X-QQ-mid: bizesmtp39t1638321764tifc4nqq
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 01 Dec 2021 09:22:37 +0800 (CST)
X-QQ-SSF: B1400000002000B0F000B00A0000000
X-QQ-FEAT: vmnbzJorTWRQRDrIygrNEvTzLiNNfZ5tYDRGmltR1qMBfFoiQFVswCeU7873i
        7qEcAkZzxiK73dvRvz2Vu3P7KGgrA+DiWQXeRi7COBnbjQUJwRX+l+vdN5HKWJD8zs8GGlq
        B5grKiJpDLybMCRDUu4yeMc7iCKj3Xr3Nim8NuAL+fpynaiTdC2i0t4mtO9Bj3sW6algI8x
        8q8X0JG04MHbY61h8eEaIgcN1tUwUKirAbEn1oYq5dyxW5OhXdIMZVxSKO8Z7yZczASjxG2
        cmtAr5yV4+EZrYO7RE+F0+lVvnDinIyMGrnH2O3X4FXzofqfunPWwheU5ir3sXQx19MOffE
        sc8EONc3Yu853Ol5ZOWrnxuGd36tobIyz3zChn+
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        dan.carpenter@oracle.com, lkp@intel.com, 282827961@qq.com,
        lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v19] tty: Fix the keyboard led light display problem
Date:   Wed,  1 Dec 2021 09:22:35 +0800
Message-Id: <20211201012235.9472-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "ctrl+alt+Fn" key combination to switch the system from tty to
desktop or switch the system from desktop to tty. After the switch is
completed, it is found that the state of the keyboard lock is
inconsistent with the state of the keyboard Led light.The reasons are
as follows:

* The desktop environment (Xorg and other services) is bound to a tty
  (assuming it is tty1), and the kb->kbdmode attribute value of tty1
  will be set to VC_OFF. According to the current code logic, in the
  desktop environment, the values of ledstate and kb->ledflagstate
  of tty1 will not be modified anymore, so they are always 0.

* When switching between each tty, the final value of ledstate set by
  the previous tty is compared with the kb->ledflagstate value of the
  current tty to determine whether to set the state of the keyboard
  light. The process of switching between desktop and tty is also the
  process of switching between tty1 and other ttys. There are two
  situations:

  - (1) In the desktop environment, tty1 will not set the ledstate,
  which will cause when switching from the desktop to other ttys,
  if the desktop lights up the keyboard's led, after the switch is
  completed, the keyboard's led light will always be on;

  - (2) When switching from another tty to the desktop, this
  mechanism will trigger tty1 to set the led state. If other tty
  lights up the led of the keyboard before switching to the desktop,
  the led will be forcibly turned off. This situation should
  be avoided.

* The current patch is to solve these problems: by judging the
  kb->kbdmode value of the current tty, it is determined whether
  the led state is forced to be set when the VT switch is completed.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 v19:
 Solve an error: drivers/tty/vt/keyboard.c:425 vt_set_leds_compute
 _shiftstate() warn: was && intended here instead of ||
 
 drivers/tty/vt/keyboard.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..ca088d259b63 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -153,6 +153,7 @@ static int shift_state = 0;
 
 static unsigned int ledstate = -1U;			/* undefined */
 static unsigned char ledioctl;
+static bool vt_switch;
 
 /*
  * Notifier list for console keyboard events
@@ -412,9 +413,21 @@ static void do_compute_shiftstate(void)
 /* We still have to export this method to vt.c */
 void vt_set_leds_compute_shiftstate(void)
 {
+	struct kbd_struct *kb;
 	unsigned long flags;
 
-	set_leds();
+	/*
+	 * When switching VT, according to the value of kb->kbdmode,
+	 * judge whether it is necessary to force the keyboard light
+	 * state to be issued.
+	 */
+	kb = kbd_table + fg_console;
+	if (kb->kbdmode != VC_RAW &&
+		 kb->kbdmode != VC_MEDIUMRAW &&
+		 kb->kbdmode != VC_OFF) {
+		vt_switch = true;
+		set_leds();
+	}
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
 	do_compute_shiftstate();
@@ -1255,6 +1268,11 @@ static void kbd_bh(struct tasklet_struct *unused)
 	leds |= (unsigned int)kbd->lockstate << 8;
 	spin_unlock_irqrestore(&led_lock, flags);
 
+	if (vt_switch) {
+		ledstate = ~leds;
+		vt_switch = false;
+	}
+
 	if (leds != ledstate) {
 		kbd_propagate_led_state(ledstate, leds);
 		ledstate = leds;
-- 
2.20.1



