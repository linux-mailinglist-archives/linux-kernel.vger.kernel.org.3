Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB138463AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbhK3P4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhK3Px7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:53:59 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5FEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:50:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t9so28456488wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ki71kgvDOv0KGrYuXh0nHXTuZUrKgQ/CTTcYFqAyUsg=;
        b=lKji71Xs/8y5DfDD7PvnNCgKeBARF8EgY+YS1H2YceR9q5672S7Evr8JOpkPbNUNjA
         8CR5t6tcqubqke4qPHKx0XB1mKgNSBfzZn3VE1UDfU+ktWacb2/q0IgfClvO50Fhx0l2
         FkRgnbMQnHw/SC3mQPHUraxkxtvQyuWhJtq1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ki71kgvDOv0KGrYuXh0nHXTuZUrKgQ/CTTcYFqAyUsg=;
        b=SIJZ5YMDaFR/3OHxbAg4h+ViR3/7YDd2zZnk9EYBQFcXI4LL/nTNaTMyI142/MSlzd
         O5iLwfEi8sjLiW2ZO3oopXgAW8WKYJHXN3KLqCH14F+G5SD1QnW/uuGdPhIpvQt2DaH2
         5tHm/77z9ViHuLOLpEmRFs8IZfa8RmvWDnBGfeGax3ds1EJYnGxkSOQ2/8l58ZON6Phy
         f5BmVEBpnAqpP5ejzQYW7cSY3SS/94YXTolYkXAkkt5uuNy1MRi/fsirJzoHhw+O39i2
         1I3yz9zq5p3eTNBc7ZWPBnmyXBox3MlYwnBNTqnikjznf6KgOkPqm/F7pG/qgKjINQ/h
         uqTA==
X-Gm-Message-State: AOAM5300kZkvUmitzphazhYjOTvPLbANfWTy5cMQUeHHmiDkvyNT92Qh
        f029SLDDhlonCV9FZrEg7e77oSDn5DLU/w==
X-Google-Smtp-Source: ABdhPJxjdpi4fGSp6dC1DdNHBxwP2B+1uYeTKIK3I9eW9J02Mr4OLGpPXYeQ069+IKh3xJ//I+Tj8Q==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr43511564wrw.434.1638287428990;
        Tue, 30 Nov 2021 07:50:28 -0800 (PST)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id b13sm13555207wrh.32.2021.11.30.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:50:28 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 2/2] media: uvcvideo: Avoid returning invalid controls
Date:   Tue, 30 Nov 2021 15:50:26 +0000
Message-Id: <20211130155026.1082594-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
In-Reply-To: <20211130155026.1082594-1-ribalda@chromium.org>
References: <20211130155026.1082594-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory where ctrl_found is places has the value of uvc_ctrl and
__uvc_find_control does not find the control we will return and invalid
index.

Fixes: 6350d6a4ed487 ("media: uvcvideo: Set error_idx during ctrl_commit errors")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f7b7add3cfa59..f1f6bb14fb0a6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1639,7 +1639,7 @@ static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
 				  struct uvc_control *uvc_control)
 {
 	struct uvc_control_mapping *mapping = NULL;
-	struct uvc_control *ctrl_found;
+	struct uvc_control *ctrl_found = NULL;
 	unsigned int i;
 
 	if (!entity)
-- 
2.34.0.384.gca35af8252-goog

