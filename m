Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112594E61B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349379AbiCXK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242686AbiCXK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:29:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA74D48;
        Thu, 24 Mar 2022 03:28:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t13so2228655pgn.8;
        Thu, 24 Mar 2022 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v18S/Wust0se2JgEJEHFd4XwP2b9IQYXjBP97AuU/xA=;
        b=iJz7SCSfrIT1x61BUDPExYbOCZAvpVuHFIpjaFFNxKSHYIH3fLRtvkcOaU7n76bXuq
         lxvZiH6FJhB+Ybj+TjwXSn1Y6MveLe4l3g2N9+ow9l4YtfJVpYEzjGXAm9N05O23FttO
         11LIr2UgtgdhOxAOrFH1BM0599H6Esy/dBgqQW3FqEfXnr+rDTLwOueyFvGQM5tUj/+4
         LND7eWQXU1eisGCwvcHbNoPDhvZquvK6c5OoHrEaiLv3uu5vhy/BR14ozIIoGHUysHp6
         0ZhXbhw/sfI0oZUOZLFaRQ6zi38QmuO6bOeYHnWyNouD3BMiZvUkm6XYA6YAEgr4G64r
         bCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v18S/Wust0se2JgEJEHFd4XwP2b9IQYXjBP97AuU/xA=;
        b=BeJhqX4DmbBztQT1Ly3rWEncHp9P5XTJWs7m4dZHtOJH8WDkVx16/mryd4/Jz0BPhC
         sUJQB7yshQzVtEm58C7gLZHxKznuslw4QGhKGwGJ942ROFo9C8NfwtCEp5VPW4QDcg6v
         7ZSqbq385/AxPzc5B1/qroEd4l32Sd/WPLw4XW4ns3Vn0INzpZwpOOA1W2hciYyq57xI
         5pD0EIvOcmB4/tIX2OiV+knWSX5Te1n+5/Y/HP9xvPbD4Smnz4K4r9hGwNl5S+XXv7vP
         4ohE2FVfhlQVFcyxTrwnvTYbvY0PQv/LzQU0fZyNxsDXAIWMi+wTT2CQSPs40V8HPeRG
         w1Tg==
X-Gm-Message-State: AOAM532wToKztt+5NDvXsNkTBuZekNrCeMV0a6LcYJ29RdC1jHi8luJE
        tfi3gCaXBKN7+zzvefl4GHM=
X-Google-Smtp-Source: ABdhPJy/b+fhtZNCm7gbm5YlutC9ZOiexbnJweTTLpAjoUkpDecrxVc6/YWWksnkR7gRS73UwCUaKQ==
X-Received: by 2002:a05:6a00:10cb:b0:4f7:942:6a22 with SMTP id d11-20020a056a0010cb00b004f709426a22mr4696445pfu.84.1648117683145;
        Thu, 24 Mar 2022 03:28:03 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.52])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm2879507pfu.150.2022.03.24.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 03:28:02 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] media: mc: delete redundant code in __media_device_unregister_entity
Date:   Thu, 24 Mar 2022 18:27:52 +0800
Message-Id: <20220324102752.47077-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

media_gobj_destroy has already set graph_obj.mdev to NULL. There is no need to
set it again.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/media/mc/mc-device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index cf5e459b1d96..7727c619043e 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -605,7 +605,6 @@ static void __media_device_unregister_entity(struct media_entity *entity)
 
 	/* invoke entity_notify callbacks to handle entity removal?? */
 
-	entity->graph_obj.mdev = NULL;
 }
 
 /**
-- 
2.25.1

