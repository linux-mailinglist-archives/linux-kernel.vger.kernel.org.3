Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850B4AE753
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345607AbiBICpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242735AbiBIBUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:20:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C79C061576;
        Tue,  8 Feb 2022 17:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 144E0617E7;
        Wed,  9 Feb 2022 01:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02137C004E1;
        Wed,  9 Feb 2022 01:20:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f3g58zfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644369615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Epo8j6f82VaiElGEK+cLsKCLLv1wK/ngSXClGzK93nI=;
        b=f3g58zfEZIQTrFf4x5mRH7JVgKrccFTPWeYFBA2Oo8yebDy+QRlHo3Z3cFQ4scSdGamyhL
        wHR6p5y9eYFELn9MDC7NHtM8SePk1HrqavpcAZ/ZCNbNJIAKzYDZ6o9zYBU2d5WGyQzNKG
        wsqMinQevWdxzvwP0PoKuvhVg6baThk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a4f5ce73 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 01:20:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, linux@dominikbrodowski.net, ebiggers@kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 9/9] random: remove outdated INT_MAX >> 6 check in urandom_read()
Date:   Wed,  9 Feb 2022 02:19:19 +0100
Message-Id: <20220209011919.493762-10-Jason@zx2c4.com>
In-Reply-To: <20220209011919.493762-1-Jason@zx2c4.com>
References: <20220209011919.493762-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 79a8468747c5 ("random: check for increase of entropy_count because of
signed conversion"), a number of checks were added around what values
were passed to account(), because account() was doing fancy fixed point
fractional arithmetic, and a user had some ability to pass large values
directly into it. One of things in that commit was limiting those values
to INT_MAX >> 6.

However, for several years now, urandom reads no longer touch entropy
accounting, and so this check serves no purpose. The current flow is:

urandom_read_nowarn()-->get_random_bytes_user()-->chacha20_block()

We arrive at urandom_read_nowarn() in the first place either via
ordinary fops, which limits reads to MAX_RW_COUNT, or via getrandom()
which limits reads to INT_MAX.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index f7f9cbfe13f7..e09874c511d0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1305,7 +1305,6 @@ static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
 {
 	int ret;
 
-	nbytes = min_t(size_t, nbytes, INT_MAX >> 6);
 	ret = get_random_bytes_user(buf, nbytes);
 	trace_urandom_read(8 * nbytes, 0, input_pool.entropy_count);
 	return ret;
-- 
2.35.0

