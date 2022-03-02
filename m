Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1E4CB16A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiCBVgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCBVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:36:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBEA52E53;
        Wed,  2 Mar 2022 13:35:36 -0800 (PST)
Date:   Wed, 02 Mar 2022 21:35:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646256935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOkbEA4jhlu4JFXzeCxXHoci/YJ8SQWQno1K5M/rivM=;
        b=yz0nyGJFthSuz/tCQqmlMgjMJ2YdlUE2YRWLZDo/MS8PHWgWt0+3Tzmis4hvYKyUZzQPUe
        SXu82GD3DQBw+LSScOdBgwa2nAtkPzs3K+IMg3yQD8+lRrqMzP24yOoQ9J5xdWiPo234i/
        NKW/aSsrgd4IgsrLmz0AImG+jtEnbc/MJRwEnxmYYtVnklpDrhzqTrBgctWuOujUFfh8qq
        iLyAjRj5OCH2f5Fp8Sei42jL0V7Q0BgTUN9F7x1DiLThJwnsH/KJWvvK5VMDlqdTEA+mzb
        AofKEWiO2XD31rY2mRCSNxw1rzFvqwKNkszWlKMA80RKNFMvqSEGTEx+UfzEzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646256935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOkbEA4jhlu4JFXzeCxXHoci/YJ8SQWQno1K5M/rivM=;
        b=uUXhMDpYmHIcYLKMUYIBReVrEXmkUJs7uHcl2RASQlPtbFvHZb2dYR223vIwUPqFLQFRG+
        1/Ggie8ARQNQLEAg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] staging: greybus: gpio: Use generic_handle_irq_safe().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220211181500.1856198-8-bigeasy@linutronix.de>
References: <20220211181500.1856198-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164625693367.16921.13135679559727131804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ff8dcfebe08dfb2524041116d4afce53ffe0b015
Gitweb:        https://git.kernel.org/tip/ff8dcfebe08dfb2524041116d4afce53ffe0b015
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 11 Feb 2022 19:15:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Mar 2022 22:28:51 +01:00

staging: greybus: gpio: Use generic_handle_irq_safe().

Instead of manually disabling interrupts before invoking use
generic_handle_irq_safe() which can be invoked with enabled and disabled
interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>
Link: https://lore.kernel.org/r/20220211181500.1856198-8-bigeasy@linutronix.de

---
 drivers/staging/greybus/gpio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 7e6347f..8a7cf1d 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -391,10 +391,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	local_irq_disable();
-	ret = generic_handle_irq(irq);
-	local_irq_enable();
-
+	ret = generic_handle_irq_safe(irq);
 	if (ret)
 		dev_err(dev, "failed to invoke irq handler\n");
 
