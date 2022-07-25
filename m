Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD15A580193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiGYPTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiGYPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:19:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080C1EAE5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:16:21 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:16:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658762177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P33YtHMgl2bIxHCGXheabYqxEWw48Aq4FFEore11rZU=;
        b=JyJuqUpdivPn+qr8aN+9SoCs/L0lZQdkhKv5SHdzeNr7CXQrtdIRCxD3TP7jvlJd24/lvI
        f2aLXdLw3Q4Xytt7NMz6of01dThuJ0nHI7la5fNB7rKzDtsBzQyUdu3OLf+ypMNiJYBEw9
        8E34kj9cdxvDkfGZ95U8yng/4a6AQQXpqDpTR2KNVzyuHRRFyNS+DDBqV2DW1Jt3JsXKed
        g0WA8mB6rEU9cPy0yPvvl+nn6recs5hq5odHBfY+fchwJlrOcjsim2YSlNoD67cLYks7Ok
        yVlDe6F0kmJni64uZWqqs9RcAMDrAVTVkidm+NSebGvC7nK5iAZAJyf2EtGLaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658762177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P33YtHMgl2bIxHCGXheabYqxEWw48Aq4FFEore11rZU=;
        b=OquDrbSJHxBTVvKm+LaqgTt81CmI3ivRZTMWv8yAJf/MiNvw3jQfc6EIDW/0iWihOMTyVa
        1i6cf4b1Tpt0agDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Yt6zwP9xSdUhsoQ9@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
 <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley>
 <Yt6gxxRxDZ/wFHrA@linutronix.de>
 <Yt6nlaSrfZ+fn80x@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yt6nlaSrfZ+fn80x@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk might be invoked in a context with disabled interrupts and or
preemption and additionally disables interrupts before it invokes the
console drivers. This behaviour is not desired on PREEMPT_RT:
- The console driver are using spinlock_t based locking which become sleepi=
ng
  locks on PREEMPT_RT and must not be acquired with disabled interrupts (or
  preemption).

- The locks within the console drivers must remain sleeping locks and they =
must
  not disable interrupts. Printing (and polling for its completion) at 1152=
00
  baud on an UART takes too long for PREEMPT_RT in general and so raises the
  latency of the IRQ-off time of the system beyond acceptable levels.

Skip printing to the console as temporary workaround until the printing thr=
eads
and atomic consoles have been introduced or another solution which is
compatible with the PREEMPT_RT approach.
With this change, the user will not see any kernel message printed to the
console but can retrieve the printk buffer from userland (via the dmesg
command). This allows enable PREEMPT_RT as a whole without disabling printk=
 and
loosing all kernel output.

Disable console printing on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3:
  - Reword commit message by adding a few details/ explanations.

v1=E2=80=A6v2:
   - Use __console_unlock() as suggested by John.

 kernel/printk/printk.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2843,6 +2843,16 @@ void console_unlock(void)
 	}
=20
 	/*
+	 * On PREEMPT_RT it is not possible to invoke console drivers with
+	 * disabled interrupts and or preemption. Therefore all drivers are
+	 * skipped and the output can be retrieved from the buffer.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		__console_unlock();
+		return;
+	}
+
+	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
