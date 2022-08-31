Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05225A84FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiHaSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiHaSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E8E3983;
        Wed, 31 Aug 2022 11:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E3AB82273;
        Wed, 31 Aug 2022 18:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48530C433D6;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=j7Vt+WhUPkmdxBzO+D24Yf2KD8/sQg3Uw1rN8AJx8XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwI9B3r+CnqTXMKM5ybBKM/kKxZC0BwiGC+MLk85ckyYsA0g/s+tmuhe1SnCxrpBR
         hV2j2FGREwfxQ8ySaPlnI8p9/uZHyEZgcCAXUZ3goC3ifogzdf09qKf6claChLd84S
         ghDrcrHaOxX8iDjjfhJkTvxsbJRx8fExndJ2cL8CD2neyLxxHorM0VCGl4k6G+KNMX
         peLDis2g5qr5G/lsXoHmOYvCgIeEZAT7ukw1D6P97jR1s0i0rt3K0oWcIfHsZ6CW1O
         lc+BUXcJs883AbhVb07GNpibDI5K7FRJEh/YScwaBt8pVP6XAdIk21oyjAN0XxJ0ZU
         CsoVnuiASbO6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 034755C02A9; Wed, 31 Aug 2022 11:06:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/7] doc: Use rcu_barrier() to rate-limit RCU callbacks
Date:   Wed, 31 Aug 2022 11:06:21 -0700
Message-Id: <20220831180625.2692892-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checklist.rst document advises periodic synchronize_rcu() invocations
to prevent callback flooding.  However, rcu_barrier() is often a better
choice.  This commit therefore adds words to this effect.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2db206fc3465f..178ca7547b987 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -305,7 +305,8 @@ over a rather long period of time, but improvements are always welcome!
 		the machine.
 
 	d.	Periodically invoke synchronize_rcu(), permitting a limited
-		number of updates per grace period.
+		number of updates per grace period.  Better yet, periodically
+		invoke rcu_barrier() to wait for all outstanding callbacks.
 
 	The same cautions apply to call_srcu() and kfree_rcu().
 
-- 
2.31.1.189.g2e36527f23

