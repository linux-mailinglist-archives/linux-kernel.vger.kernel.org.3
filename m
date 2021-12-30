Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D12481E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhL3QvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbhL3QvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:51:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80CC061574;
        Thu, 30 Dec 2021 08:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E498DB81C6E;
        Thu, 30 Dec 2021 16:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B4CC36AE9;
        Thu, 30 Dec 2021 16:51:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LbXlV06V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640883059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NItrL/aIHsIgAZesBZH/PKbW+5wd31K/1C4cnt9PMXQ=;
        b=LbXlV06V12wjOT5pyEuwFAuWcN8DVcHH+TLaaqmMFdgOMbWXv3P/nHNy+TeX0hUeZp4B7A
        gOKeLQ0Kjzy6SoRlLGeuC9PVN/RYJvSyvLCGmZLBrXwM0TKqWFWB3KHvGJ3IdzYw3XUk6A
        HxLz+dYQTcarYS/X7gSb3deAPqhxkks=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ed670bdc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 16:50:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: avoid superfluous call to RDRAND in CRNG extraction
Date:   Thu, 30 Dec 2021 17:50:52 +0100
Message-Id: <20211230165052.2698-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RDRAND is not fast. RDRAND is actually quite slow. We've known this for
a while, which is why functions like get_random_u{32,64} were converted
to use batching of our ChaCha-based CRNG instead.

Yet CRNG extraction still includes a call to RDRAND, in the hot path of
every call to get_random_bytes(), /dev/urandom, and getrandom(2).

This call to RDRAND here seems quite superfluous. CRNG is already
extracting things based on a 256-bit key, based on good entropy, which
is then reseeded periodically, updated, backtrack-mutated, and so
forth. The CRNG extraction construction is something that we're already
relying on to be secure and solid. If it's not, that's a serious
problem, and it's unlikely that mixing in a measly 32 bits from RDRAND
is going to alleviate things.

There is one place, though, where such last-ditch moves might be
quasi-sensible, and that's before the CRNG is actually ready. In that case,
we're already very much operating from a position of trying to get
whatever we can, so we might as well throw in the RDRAND call because
why not.

But once the CRNG is actually up, it's simply not sensible. Removing the
call there improves performance on an i7-11850H by 370%. In other words,
the vast majority of the work done by extract_crng() prior to this commit
was devoted to fetching 32 bits of RDRAND.

This commit fixes the issue by only making that call to RDRAND when the
CRNG is not yet ready.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 54086e9da05b..239b1455b1a8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1030,7 +1030,7 @@ static void _extract_crng(struct crng_state *crng,
 				    &input_pool : NULL);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	if (arch_get_random_long(&v))
+	if (unlikely(!crng_ready()) && arch_get_random_long(&v))
 		crng->state[14] ^= v;
 	chacha20_block(&crng->state[0], out);
 	if (crng->state[12] == 0)
-- 
2.34.1

