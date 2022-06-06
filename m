Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB5553EDD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiFFSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiFFSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001391059F8;
        Mon,  6 Jun 2022 11:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC0161336;
        Mon,  6 Jun 2022 18:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6CEC341C0;
        Mon,  6 Jun 2022 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539801;
        bh=FuYn5OaBm/cdGtgDHAKwyk/NB5Y5Xx2dRB0uYwvqtbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTHVR2x65cV9HsW/o06kyp604ujtkTQmRbApF/mteXZb9eHjqhKmnuXWcYEHlCnV0
         uG4U1ETDaKCJWJLDC1+U6ibmwsX41DXZrlz5Ykx1WxkxFxr1mpOO0qglWWJPINaTmO
         gCO6OF+KZfvll4FZEn4kZX2wve2tNfgC3rNmoTcpeWvPkENWytqks6ck4QbcDdjrbx
         cB/X8Gk5dJbFUNsfW0eyVU/cF0oT39DRJruw2S1DVjbErlNXgInirmdDaxq0h4reA/
         NjomkYMDQCaoMCoJLdc8i1TftJA6JO5BQDo+r6z8ODW3TdFJVS6hPeScHtK7dLsQPa
         NEL/3ariFGPiA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/6] mm/damon/reclaim: add 'damon_reclaim_' prefix to 'enabled_store()'
Date:   Mon,  6 Jun 2022 18:23:10 +0000
Message-Id: <20220606182310.48781-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds 'damon_reclaim_' prefix to 'enabled_store()', so that
we can distinguish it easily from the stack trace using 'faddr2line.sh'
like tools.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 38da28803d75..e69b807fefe4 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -371,7 +371,7 @@ static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
 static bool damon_reclaim_initialized;
 
-static int enabled_store(const char *val,
+static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
 	int rc = param_set_bool(val, kp);
@@ -388,7 +388,7 @@ static int enabled_store(const char *val,
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
-	.set = enabled_store,
+	.set = damon_reclaim_enabled_store,
 	.get = param_get_bool,
 };
 
-- 
2.25.1

