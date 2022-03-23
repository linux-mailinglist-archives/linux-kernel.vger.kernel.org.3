Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD44E4BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiCWEZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAF9FFB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 21:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B9F615A4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9B8C340E8;
        Wed, 23 Mar 2022 04:23:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AcESsR1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648009422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PVmN+Csx4tPuMVaLQNqemP4bzutHB4OzlkbQ+8b2rrQ=;
        b=AcESsR1W6KRpFfSId7EP9t9kcTFy6NXjXi3fOo72cbsQ89EEL6SqFL2YyalJvVomzVOzH2
        2pFJmAb8EbFN19M07zYOBFY64nO2YC7SJp8VGhtRXz+9qFuhdZuskh4i65Cd6rUrBFTDoe
        7aEzHKGast7IJYOy3/VEmIVZmLRAFsQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a93bd4a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 04:23:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: re-add removed comment about get_random_{u32,u64} reseeding
Date:   Tue, 22 Mar 2022 22:23:36 -0600
Message-Id: <20220323042336.148775-1-Jason@zx2c4.com>
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
added in an unrelated commit, that then was recently reverted. So this
adds that little comment snippet back.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1d7aac2a9600..82e37d7dd9f1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -226,7 +226,7 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
  * into the given buffer or as a return value. This is equivalent to
  * a read from /dev/urandom. The integer family of functions may be
  * higher performance for one-off random integers, because they do a
- * bit of buffering.
+ * bit of buffering and do not invoke reseeding.
  *
  *********************************************************************/
 
-- 
2.35.1

