Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFF4ADDB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382016AbiBHPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382359AbiBHPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:54:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EEC061266;
        Tue,  8 Feb 2022 07:54:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E239BB81BD2;
        Tue,  8 Feb 2022 15:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349A4C340E9;
        Tue,  8 Feb 2022 15:54:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YoX924Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644335656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBP+JsWMxcggJGLLXQ2ZKVQO9bvMzdwL7er8u9wTpII=;
        b=YoX924QkkUedetsM5jg1+mO+UDCr37VPTT3iB1ap8nt+YrkKYiCo4Sg01f+x9cmOK4wxyX
        GNyFjY4WktOSa9gVYb5Zo3I+sjigoM/iTQ/Hs+w1C+AWdzIziay13fDveHZgYyW7YxDZl5
        MXVmILVdIWW3VUs9PXk2HHy6H+RpSNQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 838a1684 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:54:16 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v1 7/7] random: remove outdated INT_MAX >> 6 check in urandom_read()
Date:   Tue,  8 Feb 2022 16:53:35 +0100
Message-Id: <20220208155335.378318-8-Jason@zx2c4.com>
In-Reply-To: <20220208155335.378318-1-Jason@zx2c4.com>
References: <20220208155335.378318-1-Jason@zx2c4.com>
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
index ac22dc94b037..fa366ab38263 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1324,7 +1324,6 @@ static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
 {
 	int ret;
 
-	nbytes = min_t(size_t, nbytes, INT_MAX >> 6);
 	ret = get_random_bytes_user(buf, nbytes);
 	trace_urandom_read(8 * nbytes, 0, input_pool.entropy_count);
 	return ret;
-- 
2.35.0

