Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C948954CC79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbiFOPQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346960AbiFOPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:16:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF13C732
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:16:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 129so11673431pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJkUO3GXhAK6vs3h7aitXkeoHE4cFMbO6OuVCc2qRmw=;
        b=fgFvn3rbGElk2+5zmHS6Cg5hNBfxNnbBqn6Vf7tSMigefMBZ9OBCRSh5WNO8VXs2mf
         3glxS0E5ikGGq8+DggbsX6e2szIfkLqeZqFXNF7U3rSqfCOdMo9KJCs+3++g5qbDXpWj
         +0PX8gp4AAbQFu2e4ZNKHSOdiYArWBJs5loFiknl4cTH6xY0+Kd3LWXdJ+ZS4M/115Bk
         UEGknDTs+meTmliE2MRwSm9+XBNS/RwFm0pHPrheToemxIJ1J43uBRPbwW78vPff4oIK
         n9cnuhPxsVs2o7Z6RUG7BvVoyoBdgHy5dg40ez71JI/NjnuHS4uRJ7emeG/AhW8DgX8U
         4OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJkUO3GXhAK6vs3h7aitXkeoHE4cFMbO6OuVCc2qRmw=;
        b=PWJlxhK5zf2+Bxcy3bIGzp6TKjUJ56KUEKOqlJpRTpa5ahvT0+oaEJCFqBh3T156jo
         WtiaSGkyyyBx1kIo+HVOg9zOV+An9nDsREFcgswij9NgvssPhzgaC1YHdnTzq1URMf4F
         U4WuRGytaQ7gLHS+YeUv0yCR8OOniuuGWM+ZqwwXcA2L2GXYxKEJ0ViKxR9hjjfVeClb
         oRlCbP+5EH8hwF4PlOmEa5OG7VPITv4+BBFFbUZAgifFi2JGIprUpjKEB9oikzWesHjq
         xMn2NcxU50VG3pur6pLbU4Cna2lCYYJo2BY6fc/m30Op6j7IRNjQ14PTEO2wX/53J666
         CGFQ==
X-Gm-Message-State: AOAM533wM+fYMJT+MskL0e0jKoJb3lCiZf5pD9n0YHii8hN+lijvXeyD
        8mACjQtrE7kNAemhrYHdrFLWUo1GZwZNaQ==
X-Google-Smtp-Source: ABdhPJwTxjZMGlZEp6weHwt0cXG/LPz2n3tcXELBw+GZCHQBoZPtiXeBxjbNW93/Z6C1eOV0RizFug==
X-Received: by 2002:a05:6a00:84e:b0:51c:43a4:f351 with SMTP id q14-20020a056a00084e00b0051c43a4f351mr10320807pfk.86.1655306181276;
        Wed, 15 Jun 2022 08:16:21 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.156])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090ad50600b001e2d4ef6160sm1963523pju.27.2022.06.15.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:16:20 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH v3] isa: put_device after failing to device_register
Date:   Wed, 15 Jun 2022 23:15:58 +0800
Message-Id: <20220615151558.1766067-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() is used to register a device with the system.
We need to call put_device() to give up the reference initialized
in device_register() when it returns an error and this will clean
up correctly.

Fixes: a5117ba7da37 ("Driver model: add ISA bus")
Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
V1 -> V2: Fix up the changelog text correct.
V2 -> V3: Add a fixes tag line specifying the commit where this bug was
introduced.
---
 drivers/base/isa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 55e3ee2da98f..cf88f3d77b7d 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
 	error = bus_register(&isa_bus_type);
 	if (!error) {
 		error = device_register(&isa_bus);
-		if (error)
+		if (error) {
+			put_device(&isa_bus);
 			bus_unregister(&isa_bus_type);
+		}
 	}
 	return error;
 }
-- 
2.30.2

