Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8A4D775A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiCMRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiCMRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:50:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0D1D0F6;
        Sun, 13 Mar 2022 10:49:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 17so16700611lji.1;
        Sun, 13 Mar 2022 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aNOtoxUHCb0R+KESTPgsr87yq5N4lTSTp2lSSMzcPw=;
        b=aMtcQYYRgDTSXkxROOkqe56zEM9wrnMzlyJtIpFFZepXvVEjwtT2iqnn4eIsZM0jF7
         50gLF7GvHSuVpfXXtXCx4oWftLBSaQGs3COv8w3UwBf8NS6lK1meeol6ByCwIDWOozkj
         v7xyB1fZHUvwQSFeTmFd4JzzMVcR31bZeqEXC9yfftjE2jFWhk9QJWO3+yl2hrMUaMQy
         dejGGThP9g/irY1qb9Kn3MMWYh3uooA8GfRlJvrEBFzzxeGg8ioHvJ79si1RIewtY6PG
         rtqr1MBOFkWBk3cwMe4uJ43dDIwwknPaWHR8g2VZr+N/VMUxJc2PWmAtRoWYtmcwFP3o
         fDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aNOtoxUHCb0R+KESTPgsr87yq5N4lTSTp2lSSMzcPw=;
        b=eIo8kK89MFkkQXdbcYJhBY/70F4I3wbWgM0KVKP1Eb7taxkwzfgScnLQ3pchXbkQwU
         /PG2rF7G+VI5do6XpGSR/5nvMJSiEZUMfLA++laGxc0e3Xufqy36M9OusUw+aZKu4QHi
         iwrXpqkqPSXmPrDV5eKonkevjvBGwquAuOa0vwf4y+qc+GPhk+HjUpN+B50qO64l/tkQ
         Giyk/v+AnsGBV0qcZJ/pNcH8cg0F/rqcMSfEd1/QEE3N6VQm12NVOUxj6b/Hlq9ogYjr
         TiAmu4ee8E/1oJJ5eYlUR6R1+al2eXHz5QyEzqqOint3zOOBnXWQcuX5aFPohVKrg40x
         KSHQ==
X-Gm-Message-State: AOAM530iJy6uCn9sUCBUbFC8U9XY8WreEEqDag+xzkkYG19Cbv8laUL5
        uOSrVyC6BslvPXQRCSB+Uo4=
X-Google-Smtp-Source: ABdhPJzCQ/Sglagv+y5fcy43fM1ulChzdSFyNH6UreTJH81A6rYgrmevL1bE3jNm7cS8WouKAxh6uQ==
X-Received: by 2002:a05:651c:a06:b0:246:71a3:556a with SMTP id k6-20020a05651c0a0600b0024671a3556amr12071288ljq.5.1647193778999;
        Sun, 13 Mar 2022 10:49:38 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id l26-20020a2e701a000000b002463f024de9sm3368907ljc.110.2022.03.13.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 10:49:38 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        hildawu@realtek.com, apusaka@chromium.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_uart: add missing NULL check in h5_enqueue
Date:   Sun, 13 Mar 2022 20:49:36 +0300
Message-Id: <20220313174936.1299-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot hit general protection fault in __pm_runtime_resume(). The problem
was in missing NULL check.

hu->serdev can be NULL and we should not blindly pass &serdev->dev
somewhere, since it will cause GPF.

Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 34286ffe0568..7ac6908a4dfb 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -629,9 +629,11 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		break;
 	}
 
-	pm_runtime_get_sync(&hu->serdev->dev);
-	pm_runtime_mark_last_busy(&hu->serdev->dev);
-	pm_runtime_put_autosuspend(&hu->serdev->dev);
+	if (hu->serdev) {
+		pm_runtime_get_sync(&hu->serdev->dev);
+		pm_runtime_mark_last_busy(&hu->serdev->dev);
+		pm_runtime_put_autosuspend(&hu->serdev->dev);
+	}
 
 	return 0;
 }
-- 
2.35.1

