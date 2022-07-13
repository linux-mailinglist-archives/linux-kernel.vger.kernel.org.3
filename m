Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2805739CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiGMPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiGMPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41599422D1;
        Wed, 13 Jul 2022 08:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E91609FB;
        Wed, 13 Jul 2022 15:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2CBC34114;
        Wed, 13 Jul 2022 15:11:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rffq3UVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657725083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILStSx2CfJNQPjxxNEfvJuMlLS2qINdHOClU8pmeiTg=;
        b=Rffq3UVZZW4ivY0NLyk2p1BZtAn5ouHfzgklZHCHwepYiktIPPoZBMRfEyZvXUOAiTN51x
        IdgAz+UE8RDCjysX41Fv789WXF88qEBU3+VO+F5ushD0zRXKVz1hfH0GIGLFB9BUUeQHFA
        UFhDyFmFcazLGCBNgNpfQsZY/9FUtD4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c16bce5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 15:11:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     vladimir.murzin@arm.com, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, ebiggers@google.com, tytso@mit.edu,
        torvalds@linux-foundation.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: cap jitter samples per bit to factor of HZ
Date:   Wed, 13 Jul 2022 17:11:15 +0200
Message-Id: <20220713151115.1014188-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
References: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
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

Currently the jitter mechanism will require two timer ticks per
iteration, and it requires N iterations per bit. This N is determined
with a small measurement, and if it's too big, it won't waste time with
jitter entropy because it'd take too long or not have sufficient entropy
anyway.

With the current max N of 32, there are large timeouts on systems with a
small CONFIG_HZ. Rather than set that maximum to 32, instead choose a
factor of CONFIG_HZ. In this case, 1/30 seems to yield sane values for
different configurations of CONFIG_HZ.

Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Fixes: 78c768e619fb ("random: vary jitter iterations based on cycle counter speed")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Vladimir - Can you let me know if this appears to fix the issue you're
seeing? -Jason

 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e3dd1dd3dd22..a1af90bacc9f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1174,7 +1174,7 @@ static void __cold entropy_timer(struct timer_list *timer)
  */
 static void __cold try_to_generate_entropy(void)
 {
-	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = 32 };
+	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 30 };
 	struct entropy_timer_state stack;
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
-- 
2.35.1

