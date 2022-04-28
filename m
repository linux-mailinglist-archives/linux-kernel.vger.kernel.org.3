Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65BB512924
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiD1B7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiD1B7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:59:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD3134B8D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:56:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so6401870pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lq+qsTK8ZKVPJL9HA4iiJLZNw7TQSOzy8Rchv+NWZvU=;
        b=R33oQZqWEqgeKBDM/HXVhBJUted9XBZhqVBxj/BaOz3dIiBa3WHrFRbMzJ6oRrywRv
         BMPuSxFZ+sbaIPgbdfx0Go/FFdawlVbulYcv0VVFxVaa6dbsTvbijIkdqLUfAUVzwxtg
         xTl0BJ5HjqYNyHCX1H8oAKtomrgYXP8meQCwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lq+qsTK8ZKVPJL9HA4iiJLZNw7TQSOzy8Rchv+NWZvU=;
        b=jpZadAfhF0IWkq035YtmYdMv/kq8HBSq6F1n9WZh5AsP/g8PFeFWrdqtuT3pswAhek
         CQ0kXXw7yy3xt64yLyqf5LHZ3yrCQD/CSgud798YjXuTFLxYbE72t6RuM7Jie/Gm6eV2
         ND/sZoUoJ9xPQw0qGUGEUdgKF/NxsvmLYRAbhgSwLzwU7ruhZQ99pDFJ2Oz9cQg3LTO9
         hxkTVs6K4VeEWZUkpdGULQUwhY01pWj+cIECMYZQMa2xl6iBh7bvlC1cdYiV6ugFeps+
         kuExA2+cuu4TN38fMz4fVh/RsxaT7UpnGhxULfbD1sDySiaq3a2PCov+KheyjtjE83vq
         1WLQ==
X-Gm-Message-State: AOAM531hnVO+2sDHdwhDmrfPBgtUblYzKouNbdLEvLynWesCdxkR7TDr
        lLcaWZ4CyMdBhIvZF20c1VUgxc+biH45nA==
X-Google-Smtp-Source: ABdhPJzHTKAjszOy+oeRzvRr7T+RkPRHjbTtIoYsLz/1URMqXa6euublePemom2BA1H+48yRxLF8qQ==
X-Received: by 2002:a17:90a:db45:b0:1d9:29d0:4c6e with SMTP id u5-20020a17090adb4500b001d929d04c6emr28909345pjx.46.1651110962835;
        Wed, 27 Apr 2022 18:56:02 -0700 (PDT)
Received: from localhost.localdomain ([69.53.254.5])
        by smtp.gmail.com with ESMTPSA id y14-20020a63ce0e000000b003c14af505edsm637814pgf.5.2022.04.27.18.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 18:56:01 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/2] seccomp: Use FIFO semantics to order notifications
Date:   Wed, 27 Apr 2022 18:54:46 -0700
Message-Id: <20220428015447.13661-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the seccomp notifier used LIFO semantics, where each
notification would be added on top of the stack, and notifications
were popped off the top of the stack. This could result one process
that generates a large number of notifications preventing other
notifications from being handled. This patch moves from LIFO (stack)
semantics to FIFO (queue semantics).

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index db10e73d06e0..2cb3bcd90eb3 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1101,7 +1101,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	n.data = sd;
 	n.id = seccomp_next_notify_id(match);
 	init_completion(&n.ready);
-	list_add(&n.list, &match->notif->notifications);
+	list_add_tail(&n.list, &match->notif->notifications);
 	INIT_LIST_HEAD(&n.addfd);
 
 	up(&match->notif->request);
-- 
2.25.1

