Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8846AF43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378564AbhLGAmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378493AbhLGAmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:42:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C2CC061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:38:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t5so50035844edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5ttIxz5XV1R8mB4AQEIj3LEMb5zIef+xA+it1IYM0A=;
        b=fxULTE43khr6HR3nEpuNEBCZ3vxOtIjvgO+qsh/t/MYiz/pcjcUm4ceQBaCIbt6V1O
         9VQN3PxhCSxhe7UPODei/pT+cZPxVQ3rLFSHnyAzZmrA680WCK2162MoEHFS4Q5E5clu
         ficTuYn6q11h/+4WmiPEWa4D1M1601MnTRwx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5ttIxz5XV1R8mB4AQEIj3LEMb5zIef+xA+it1IYM0A=;
        b=WUu52FE5CSfxVtFDOzEgTiaQ3ACvfb7kcnNueof2jJ2OQ2f8iPutS++3lSgfldgvno
         ynWz+tMxDlhpDHemhOF19BjPk1Fk/d+/dS16hd8Yhd1kTKD9vcBWunUKiCAatEKsl5Ty
         xmZvXLGm4IhZWN0XOYHAJZYwsYAjMQlFhb7ZbE63CYTiJ71s4DKkFSWn9pZhcptCHYwe
         gTY9jSpFceG6HjCHfxBWQtyVWp3Vx5WFX0c2sLdrEJRzPsOsL4uvkW9q5BB8CROL66M7
         IsXCxy8SyItg/pRODecF9DlgvewU6noQEWsJIdEvcTQrvT3ToKL6JYK6qccYQZTTLrZ6
         cGDQ==
X-Gm-Message-State: AOAM530lYLLcwc1hknAiZQO0CPQty9fGC1LM+tzVUq0LPAdyZ29C5NHU
        mfv/qIJMIF+gakBdd3GkGQB4Uw==
X-Google-Smtp-Source: ABdhPJzyB/H3kstbdpwZhrTKrE9GYUydqXMwZxZnch221LvMd/xWTQsQ2dnz4mfV4fFPDTx23odp/Q==
X-Received: by 2002:a17:906:c9d2:: with SMTP id hk18mr47496273ejb.523.1638837522949;
        Mon, 06 Dec 2021 16:38:42 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hg19sm7422531ejc.1.2021.12.06.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:38:42 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 2/4] media: v4l2-dev.c: Allow driver-defined entity names
Date:   Tue,  7 Dec 2021 01:38:38 +0100
Message-Id: <20211207003840.1212374-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211207003840.1212374-1-ribalda@chromium.org>
References: <20211207003840.1212374-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver provides an name for an entity, use it.
This is particularly useful for drivers that export multiple video
devices for the same hardware (i.e. metadata and data).

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index d03ace324db0..4c00503b9349 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -832,7 +832,9 @@ static int video_register_media_controller(struct video_device *vdev)
 	}
 
 	if (vdev->entity.function != MEDIA_ENT_F_UNKNOWN) {
-		vdev->entity.name = vdev->name;
+		/* Use entity names provided by the driver, if available. */
+		if (!vdev->entity.name)
+			vdev->entity.name = vdev->name;
 
 		/* Needed just for backward compatibility with legacy MC API */
 		vdev->entity.info.dev.major = VIDEO_MAJOR;
-- 
2.34.1.400.ga245620fadb-goog

