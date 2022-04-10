Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA04FADB0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbiDJLuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiDJLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 07:50:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93A2E6A7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:48:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso2061508pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Wa9XPtQomZw9/qSdanoMdYPd0EpQEW8XKYDlUj1N1w=;
        b=O/u0lYLdcpcBNSW+V5qHCpVsK0bkoX0+2w7PwPl0iwR+07qiSOkjoL9BCtT7LPIR7k
         lCQpcZc6HaYgAaD/PDoHWkalH+1h3BMaNI1dSkQt8QAzy4hETCfgN+ixb6T1Qqrs3pLy
         mR6c5cp1eUeCMmyY0JxQyMZpZlHCmkyVSArKkiMF7F745retyg1CpzOax7U4SR01XQt8
         bk0gSUKnhD94Sj3w7mZ4PpwPJgf4/UUoSZp+Y8ttGWXq/SG3cp82vC9msTmU6sTi9mz9
         Z5P/zPHQP/T0D8jTsE/yISA3mvEjdg2Mhs/Zd8oVCQVvFRQtdE437C5Ae++9fpvJ1u/a
         +Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Wa9XPtQomZw9/qSdanoMdYPd0EpQEW8XKYDlUj1N1w=;
        b=NOJNbKf8OOetkP6kY3oQ+Tt9FwaecXGKzGYQrE2PgYhSNWdeErSzc6BgdmIIt4oLRh
         dJZ33v2aVsfsHTnTeGnAFwoewxFbrNHcbDzMCDNIccA2yzBFA73r7RqAGRWdMYttAkOZ
         gpernjwwDMP+LW92KiMzj44XJaaBm8cvtg1nJwbRUjjyMXs6Cfq7lLgH3z2p9e7Vlrur
         ocOE4k2BbKRgOAW56WLHUXDrkH+m4VyVROGNJJAF6UYz1f55MCj82geVEY2mW10+ncsD
         mGWoF3joB0wKwtUxi+tCp9WNcHeew7Cr7dVXHNLpQuDdGJP7OSR1Y826h1k+xwfQK+Ga
         O4/A==
X-Gm-Message-State: AOAM5336Cl+KY4bXxdLWBH63S3heTNqD5d2o3x8PPbTjtTeV1EkfKK5/
        7lL891p1pVMmz2vmSXKmrQ==
X-Google-Smtp-Source: ABdhPJzg3V1MNZAFs4oTOJwzWdkxsaLklLwaK/R2HsgboUKWbtiManpRTf1wLVJjTrQTImu6rF9igQ==
X-Received: by 2002:a17:90b:4c0f:b0:1c7:d2de:5aec with SMTP id na15-20020a17090b4c0f00b001c7d2de5aecmr31515353pjb.110.1649591305160;
        Sun, 10 Apr 2022 04:48:25 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id t31-20020a056a00139f00b00505b8a8ac08sm1307119pfg.160.2022.04.10.04.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:48:24 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()
Date:   Sun, 10 Apr 2022 19:48:14 +0800
Message-Id: <20220410114814.3920474-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver fails at alloc_hdlcdev(), and then we remove the driver
module, we will get the following splat:

[   25.065966] general protection fault, probably for non-canonical address 0xdffffc0000000182: 0000 [#1] PREEMPT SMP KASAN PTI
[   25.066914] KASAN: null-ptr-deref in range [0x0000000000000c10-0x0000000000000c17]
[   25.069262] RIP: 0010:detach_hdlc_protocol+0x2a/0x3e0
[   25.077709] Call Trace:
[   25.077924]  <TASK>
[   25.078108]  unregister_hdlc_device+0x16/0x30
[   25.078481]  slgt_cleanup+0x157/0x9f0 [synclink_gt]

Fix this by checking whether the 'info->netdev' is a null pointer first.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/tty/synclink_gt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25c558e65ece..9bc2a9265277 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1746,6 +1746,8 @@ static int hdlcdev_init(struct slgt_info *info)
  */
 static void hdlcdev_exit(struct slgt_info *info)
 {
+	if (!info->netdev)
+		return;
 	unregister_hdlc_device(info->netdev);
 	free_netdev(info->netdev);
 	info->netdev = NULL;
-- 
2.25.1

