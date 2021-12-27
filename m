Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EA47FB33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhL0JGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhL0JGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:06:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0AC06173E;
        Mon, 27 Dec 2021 01:06:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gj24so12997866pjb.0;
        Mon, 27 Dec 2021 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3D8vbQ9qKo6LF9O+DoOS9tr7PDla/HO9+uH+KuCqSe0=;
        b=DEWSsmmMFYIswFxycNafQNmYpClD1/S/NAHUHAsIqJQhh0/T+dazeQt4K7m+rnfElJ
         s86k7SLS5Ey2p7jyb7DQKyBs5YRi2x/+aWsRaV7dOfrlqBNyRrgPqXjLN4JiwjWALcTw
         29s0uPeVemwTmgaYbISKBE/Fmgta9+wNElhUbheCTnQJeM+Ck4EZwC7oZlbRqrXqtvrX
         QJ0/v63yqR0sm6lTf9jQbfbDogL6or48G0wIcsxhZ8jY7dPDLrukue/w4KlL7o3rOYsi
         v3v9Q1UmEClroFrkhiygrgy61UKHhB7Li8OiDNhkyQMHmpG70X8tarJ98rK3ZSE2xDU9
         Ee1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3D8vbQ9qKo6LF9O+DoOS9tr7PDla/HO9+uH+KuCqSe0=;
        b=J4XwUQegR9WKPpBAAHkyti6GMX794F763r5e1Yck5zsw5kmVR6KJAhYQeXC8zEm/Zj
         MDqQsZcORB5I2XU3a6X0Gg6v/KsOWQ6r9IlePURjjpOlNOxKt9ih4TXG4+FaanUhqD1D
         wSPHaOZ7HBDukJNnIrUx36K7V5Wxua2dZxBHlvKMsQLeKvDoWJGyJ4Mql5I0dSlAaXoy
         OYdFV4MwZsqm1HF1uDM0LAYXrPa9rlXS12BWM9A18ZjPT8tJLyOMHhaQmXn0ITmiDRUL
         PvdAaIlm1Xb6Fn9VKZsKlKZMZBkCQZrViiovxedDk+8fL1f1K7KNRjz4/ITCT1skUm/e
         vWEw==
X-Gm-Message-State: AOAM532/VGmd87kbtpOXWnCmoM3y42mdXeVr+eHyYZEqP5UTrQq7BxxF
        Mt2tLnJkbZ5AjnZnCupQijjATB72qUf3ew0X
X-Google-Smtp-Source: ABdhPJxwbV5ca35CixfpCV/cxi6L+U4E2RoEC7FsSMO/PFEwMOpcgDcOU77nFWtukdxfxVjciUHxmA==
X-Received: by 2002:a17:90a:c68a:: with SMTP id n10mr20140084pjt.119.1640596010318;
        Mon, 27 Dec 2021 01:06:50 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l1sm13679029pgn.35.2021.12.27.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 01:06:50 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: Fix NULL vs IS_ERR() checking in rproc_create_trace_file
Date:   Mon, 27 Dec 2021 09:06:45 +0000
Message-Id: <20211227090645.18600-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_file() function doesn't return NULL.
It returns error pointers.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/remoteproc/remoteproc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b5a1e3b697d9..a2409fe2f57b 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -390,7 +390,7 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 
 	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
 				    &trace_rproc_ops);
-	if (!tfile) {
+	if (IS_ERR(tfile)) {
 		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
 		return NULL;
 	}
-- 
2.17.1

