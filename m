Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD424EA22A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiC1VBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiC1VBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:01:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650426EB13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:59:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r23so18428635edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/zSPqmwF724vuIgv1AiC9fqBd4XFYW22ARZzgRtCYM=;
        b=N5tMMfS8Hfv3JbwfarORQ4RfR5BUoj/Y+Fkrzm3vA1qhiDTAl5B/TeKmEX3yZMIJhG
         u37j3CWzKQbtgrx/3s/nn757RUoUX7YmLhHMxp1ACXrI7doAQVeVylamgFwKHSwrDUNb
         FUp7trRflJN1tdcUzSkOZCw9fHT1KXstAUSzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/zSPqmwF724vuIgv1AiC9fqBd4XFYW22ARZzgRtCYM=;
        b=l8K/R5nu+iLYtoyfpufXV1so++OI4W3rAYHrOTvF7OoAnf27nVFQEWdr+5OTZ+Hkoi
         FAfdevxa53B3tmcoWt6qIQpIPc5b5SL5q0X3STekDc4hmVJFTC6QayH0fEgROBAL10dv
         is4MGHB6QEFu4j+aWLcyNH111CO1fGl9+hIHJh1AaXJEJ59q/Swhkbuj2SGp8eLJv2wG
         3JW4KGPHelVeIYU6xcgasv3vX3jjb5S43Un0Gu2Mhg2TOXNud8N2wVvYD67QEmZ+pvIz
         7RtHgW5rbZ7sG3oZ4GYE4hxVPrXUWEDCnBsKkJIOt5bP5FIZVanyzdc2D11HzcLVMgyn
         SjCA==
X-Gm-Message-State: AOAM532C6XzTZ/GiT5vhMH5H0PZ1586Q0jIlP63Bd3EXvavzfBdNG/7s
        KJIMrAhMk1HPT0wXDK2snwZJoQ==
X-Google-Smtp-Source: ABdhPJy1yI3tZA984XTLw01+7WsuvDx3NaF6PZwGFB4hCezzJQ8PiFZlJFX1oIAwNoVmJCohQPzW/A==
X-Received: by 2002:a50:9986:0:b0:413:bbdd:d5a1 with SMTP id m6-20020a509986000000b00413bbddd5a1mr18792517edb.26.1648501194995;
        Mon, 28 Mar 2022 13:59:54 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm6462259ejc.73.2022.03.28.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:59:54 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        syzbot <syzkaller@googlegroups.com>
Subject: [PATCH] media: uvc: Handle cameras with invalid descriptors
Date:   Mon, 28 Mar 2022 22:59:52 +0200
Message-Id: <20220328205952.584407-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the source entity does not contain any pads, do not create a link.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 7c4d2f93d351..1f730cb72e58 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 		source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
 		       ? (remote->vdev ? &remote->vdev->entity : NULL)
 		       : &remote->subdev.entity;
-		if (source == NULL)
+		if (source == NULL || source->num_pads == 0)
 			continue;
 
 		remote_pad = remote->num_pads - 1;
-- 
2.35.1.1021.g381101b075-goog

