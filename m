Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287DF4A03EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348997AbiA1Wt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiA1WtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:49:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86843C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C8A61F09
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 22:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC3C340E7;
        Fri, 28 Jan 2022 22:49:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JT3dASoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643410154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k0/oajVcobGvb9YEN4Q2cDXAoaOwdD7CFJ2oFLDWlf0=;
        b=JT3dASoCkjkeEdxvSDDCFwO9cgjfidJfEIIxYH9YqaFsonFqKYQaSwg846Kwizr27G+r6Q
        Yw18AyM9+K3ZGsC9Si07+3RONcV/GlcCl62LH944Dr7RD+HQ6yAhbceFCUdnippKK8PeaM
        QUf01T3py6H3qlWDuun4MStKsNTG90E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 25bea80d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 28 Jan 2022 22:49:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: wake up /dev/random writers after zap
Date:   Fri, 28 Jan 2022 23:49:06 +0100
Message-Id: <20220128224906.104235-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When account() is called, and the amount of entropy dips below
random_write_wakeup_bits, we wake up the random writers, so that they
can write some more in. However, the RNDZAPENTCNT/RNDCLEARPOOL ioctl
sets the entropy count to zero -- a potential reduction just like
account() -- but does not unblock writers. This commit adds the missing
logic to that ioctl to unblock waiting writers.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6919837fe4e9..d4111220bbb0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1856,7 +1856,10 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		 */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		input_pool.entropy_count = 0;
+		if (xchg(&input_pool.entropy_count, 0) && random_write_wakeup_bits) {
+			wake_up_interruptible(&random_write_wait);
+			kill_fasync(&fasync, SIGIO, POLL_OUT);
+		}
 		return 0;
 	case RNDRESEEDCRNG:
 		if (!capable(CAP_SYS_ADMIN))
-- 
2.35.0

