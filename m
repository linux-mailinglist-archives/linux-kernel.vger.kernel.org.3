Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35D4E5997
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiCWUMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCWUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:12:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD77694AE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCEE5B8207D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 20:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14902C340E8;
        Wed, 23 Mar 2022 20:10:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o4aIXw3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648066224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtkyuG0hqTErbT1hHrW6eIZiMucD7+NPmbjercTm5/w=;
        b=o4aIXw3bmN5yphYd4aF6nEQFQzYDAhT+8kH2jCVUjRGHWEdeYQrNlEWo9c4dr8HB/uG0KO
        6+JyyPRTa4xGr7y4JFSv4nYvrJ3SZ5YAy+RnU0WpeJTEkwoguZHXOkbfLso5vc5rWmrO+D
        el7ir5WpDwnsfNRvKbmcaMaVfYo6TF4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a8650d78 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 20:10:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: re-add removed comment about get_random_{u32,u64} reseeding
Date:   Wed, 23 Mar 2022 14:10:18 -0600
Message-Id: <20220323201018.171141-1-Jason@zx2c4.com>
In-Reply-To: <Yjt6NJGromYyAb+/@owl.dominikbrodowski.net>
References: <Yjt6NJGromYyAb+/@owl.dominikbrodowski.net>
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

The comment about get_random_{u32,u64}() not invoking reseeding got
added in an unrelated commit, that then was recently reverted by
0313bc278dac ("Revert "random: block in /dev/urandom""). So this adds
that little comment snippet back, and improves the wording a bit too.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1d7aac2a9600..40107f8b9e9e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -224,9 +224,10 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
  *
  * These interfaces will return the requested number of random bytes
  * into the given buffer or as a return value. This is equivalent to
- * a read from /dev/urandom. The integer family of functions may be
- * higher performance for one-off random integers, because they do a
- * bit of buffering.
+ * a read from /dev/urandom. The u32, u64, int, and long family of
+ * functions may be higher performance for one-off random integers,
+ * because they do a bit of buffering and do not invoke reseeding
+ * until the buffer is emptied.
  *
  *********************************************************************/
 
-- 
2.35.1

