Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E9591B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiHMOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiHMOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:37:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B16B32B81
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1ED8B802BE
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A2C433D6;
        Sat, 13 Aug 2022 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660401432;
        bh=eUt5WPk2oDTRX7G+NlG6mkjLwzzTqD0BB5QjKnscQNU=;
        h=From:To:Cc:Subject:Date:From;
        b=AQwiGH7vJLTxQzv0F5T8WYPWfRmnackfU27q69GDawH+EAy6YzVQykTVtQTdEu6vP
         pft1aI4mfP5MbxkSNiK1S6PZ0eDPQKCxmPYpOGF27Z/iEHN8GbuLHaipFk8p02E3h0
         9NViWrL+ezh7DnqIVm6F2d4+OKEHUR8zK+mWneqtESc8NHllz0pzuJW3/o1w3IMPzy
         X3jZvhq2cjoV8+UYmfN2O8ej0vhcKHH/gxwxXDlWzvFYdXgThQYlwYf5aC5Rjm8pGN
         j2wb1Gq9SxB6rWhIfyArW4Wi9ekxnrnSQ9f1wJSHHEZ2B7khqzo/wl3432WGiRBzC6
         G+lOJUue56tWg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@kernel.org
Subject: [PATCH] f2fs: fix wrong continue condition in GC
Date:   Sat, 13 Aug 2022 07:37:09 -0700
Message-Id: <20220813143709.11909-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should decrease the frozen counter.

Cc: stable@kernel.org
Fixes: 325163e9892b ("f2fs: add gc_urgent_high_remaining sysfs node")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6da21d405ce1..7e4b41240d59 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -102,7 +102,7 @@ static int gc_thread_func(void *data)
 					sbi->gc_urgent_high_limited = false;
 					spin_unlock(&sbi->gc_urgent_high_lock);
 					sbi->gc_mode = GC_NORMAL;
-					continue;
+					goto next;
 				}
 				sbi->gc_urgent_high_remaining--;
 			}
-- 
2.37.1.595.g718a3a8f04-goog

