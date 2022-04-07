Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6F4F7EED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbiDGM3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbiDGM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C15370F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9D060C09
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF2C385A7;
        Thu,  7 Apr 2022 12:26:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ON+pM72H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649334411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Gd4Dn8KEn0cJxQJEqAUk4T/B1mmtsdXfaxlOLVx/RQ=;
        b=ON+pM72HcdmO/1rJzG5kf/6SBE3CmHvX0YjIJGrCuto94WZ32WfCzMcEe97myqjl3JtHKT
        lkBOaL1VT00DOMR+hEJNUpsDiFxD1B4nH4VUteuKInYTtNj/kyPxyVHC3jZ5aaaKIRQ70s
        YDeQypLQASe+/2iKmIYxLCM9bMHLbZ0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f54a4e2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 12:26:50 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     david@redhat.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] /dev/mem: make reads and writes interruptible
Date:   Thu,  7 Apr 2022 14:26:38 +0200
Message-Id: <20220407122638.490660-1-Jason@zx2c4.com>
In-Reply-To: <d7b928b9-7be1-f129-ff03-6ec9fe083f34@redhat.com>
References: <d7b928b9-7be1-f129-ff03-6ec9fe083f34@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 8619e5bdeee8 ("/dev/mem: Bail out upon SIGKILL."), /dev/mem became
killable, and that commit noted:

  Theoretically, reading/writing /dev/mem and /dev/kmem can become
  "interruptible". But this patch chose "killable". Future patch will
  make them "interruptible" so that we can revert to "killable" if
  some program regressed.

So now we take the next step in making it "interruptible", by changing
fatal_signal_pending() into signal_pending().

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- The commit message mentions only /dev/mem now, not /dev/kmem which was
  removed.

 drivers/char/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..84ca98ed1dad 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -101,7 +101,7 @@ static inline bool should_stop_iteration(void)
 {
 	if (need_resched())
 		cond_resched();
-	return fatal_signal_pending(current);
+	return signal_pending(current);
 }
 
 /*
-- 
2.35.1

