Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47DB47591B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbhLOMwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:52:00 -0500
Received: from smtpbg701.qq.com ([203.205.195.86]:53096 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232543AbhLOMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:51:59 -0500
X-QQ-mid: bizesmtp50t1639572708t00r247s
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 15 Dec 2021 20:51:28 +0800 (CST)
X-QQ-SSF: B1400000002000B0G000B00B0000000
X-QQ-FEAT: 58s9QYSgpDhrLtfmaYHErVNqL2voqSNYm+1Xhddj9W8kxyoFUbhX+CSI1og2R
        NTCkcPK1DBhBB4Eu2GMW65Leg9JH8vlZmYUt6wBIbFka8iZX+iqk8nqBEGGDKZzG2hXh3Wc
        r6Z8AFq6zuUBvXi1EZm4ubIomNgK0QknxEYnXvE9lF4a2YgNcpxHfnMMZN2oRjE3qUcYsgT
        o1SPPov9CWpqO8nBTkWfC831JA7gi9RB//evSjkpo+/iMDkO9Df6Y1UZlLFxYJp4a0TUlaY
        TpWshQJqNfHEfnGicmPFB+3xfOW76ttBi2IspPXbgMIR+JlJZS8piiewH8GiUOKmPYaCiIU
        KpU/h/oXF1XN6er3vcpVinBLOTLGOMab4bAO0ve
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v22] tty: Fix the keyboard led light display problem
Date:   Wed, 15 Dec 2021 20:51:25 +0800
Message-Id: <20211215125125.10554-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
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

* The current patch is to solve these problems: When VT is switched,
  the keyboard led needs to be set once.Ensure that after the
  switch is completed, the state of the keyboard LED is consistent
  with the state of the keyboard lock.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 v22:
 Return to the v19 plan, remove the judgment condition in
 the vt_set_leds_compute_shiftstate() function.
 
 drivers/tty/vt/keyboard.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..00283ba9a9e4 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -153,6 +153,7 @@ static int shift_state = 0;
 
 static unsigned int ledstate = -1U;			/* undefined */
 static unsigned char ledioctl;
+static bool vt_switch;
 
 /*
  * Notifier list for console keyboard events
@@ -414,6 +415,12 @@ void vt_set_leds_compute_shiftstate(void)
 {
 	unsigned long flags;
 
+	/*
+	 * When VT is switched, the keyboard led needs to be set once.
+	 * Ensure that after the switch is completed, the state of the
+	 * keyboard LED is consistent with the state of the keyboard lock.
+	 */
+	vt_switch = true;
 	set_leds();
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
@@ -1255,6 +1262,11 @@ static void kbd_bh(struct tasklet_struct *unused)
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



