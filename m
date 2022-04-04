Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B44B4F182B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378507AbiDDPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378000AbiDDPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:22:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F8A3C4A6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB53EB8170E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C28C34111;
        Mon,  4 Apr 2022 15:20:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gttvBvkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649085640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPXw+SF6oh/aSPAZ/FK2hYnXFRdhBrMdSKRafLKv0CI=;
        b=gttvBvkg85rGdk42xtoKHtRtOJzVW8WMtbU+3ep8mgX1/g/2QJTgN07FA5PAUTjwu26cgB
        YACE9SSMrQz1T1/HXhpSb4L1i1WNmtXycP0bYTDxDcz/Js27XOLaI9Y+Lco99lnGy9NecC
        wFJrAr8DhWnYaqsdZkEY58RKu5rm6JU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54a69155 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 4 Apr 2022 15:20:40 +0000 (UTC)
Date:   Mon, 4 Apr 2022 17:20:36 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jan Varho <jan.varho@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: fix add_hwgenerator_randomness entropy accounting
Message-ID: <YksMxDLxPZtuYlFm@zx2c4.com>
References: <20220404150442.934496-1-jan.varho@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220404150442.934496-1-jan.varho@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, Apr 4, 2022 at 5:07 PM Jan Varho <jan.varho@gmail.com> wrote:
> add_hwgenerator_randomness tries to only use the required amound of input
> for fast init, but credits all the entropy if even a byte was left over.
>
> Fix by not crediting entropy if any input was consumed for fast init.

Yea, I'd seen this and wasn't really sure what the correct fix was. My
recent addition of `&& entropy < POOL_MIN_BITS` is a step in the right
direction of making your fix the desirable path, since it makes it less
likely that we'd wind up throwing away "good" entropy. So maybe it's
time we do that.

The alternative I had considered was something like `entropy -= ret *
entropy / buf`, with some additional care around rounding in the right
direction. But even then, that makes a big assumption about the
distribution of the entropy within the buffer bitstring. What if it's
all at the beginning and none at the end? The fact that entropy might
not be equal to count means all bets are off the table and we might well
be facing pretty meh input.

Anyway, if your approach is indeed the way forward, the fuller version
of this patch is probably something like the below, where we just get
rid of the now-useless return value, and then since we're now doing
partial mixing, we can change the way the account parameter bounds it.
This is untested, but if you want to test it and submit it at v2, I
think it might be an okay incarnation of the lazy approach.

Jason

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1d8242969751..de8040db426e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -437,11 +437,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
  * This shouldn't be set by functions like add_device_randomness(),
  * where we can't trust the buffer passed to it is guaranteed to be
  * unpredictable (so it might not have any entropy at all).
- *
- * Returns the number of bytes processed from input, which is bounded
- * by CRNG_INIT_CNT_THRESH if account is true.
  */
-static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
+static void crng_pre_init_inject(const void *input, size_t len, bool account)
 {
 	static int crng_init_cnt = 0;
 	struct blake2s_state hash;
@@ -455,15 +452,12 @@ static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
 		return 0;
 	}
 
-	if (account)
-		len = min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
-
 	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
 	blake2s_update(&hash, input, len);
 	blake2s_final(&hash, base_crng.key);
 
 	if (account) {
-		crng_init_cnt += len;
+		crng_init_cnt += min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
 		if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 			++base_crng.generation;
 			crng_init = 1;
@@ -474,8 +468,6 @@ static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
 
 	if (crng_init == 1)
 		pr_notice("fast init done\n");
-
-	return len;
 }
 
 static void _get_random_bytes(void *buf, size_t nbytes)
@@ -1141,12 +1133,9 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
 	if (unlikely(crng_init == 0 && entropy < POOL_MIN_BITS)) {
-		size_t ret = crng_pre_init_inject(buffer, count, true);
-		mix_pool_bytes(buffer, ret);
-		count -= ret;
-		buffer += ret;
-		if (!count || crng_init == 0)
-			return;
+		crng_pre_init_inject(buffer, count, true);
+		mix_pool_bytes(buffer, count);
+		return;
 	}
 
 	/*

