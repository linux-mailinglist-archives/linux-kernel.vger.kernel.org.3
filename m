Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7944446DA3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhLHRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhLHRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:45:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A45C061746;
        Wed,  8 Dec 2021 09:42:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y196so2342396wmc.3;
        Wed, 08 Dec 2021 09:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VhrYwP48UAqiV9TObLVTzDhXCitwHm97z2ea44Mx4M=;
        b=SqanebBhEUI592RBsmvyz3w3wiM1vg+N7B6CDf76bteFErSS4TWAmnAPFJj7WUJ24Z
         og2l0Y6mwtdebnCuGNmiFo0wNleUj6n7UlHaw7ckyJLzmtyV/WE6m6VW3k/ouXWb+URR
         QGvDlmkVgpIqrNNs+72112qDWa3aXzhunZJRl0ipZQIpK95DpI2t+LZAoenH+jKe+hJq
         pL+VD7ZOt9FIhsthSBGe9KAeCMmOg/iMYBoGz0qzvEhrFX0NwskFzFu4WizILMS4LByi
         XkaJiT4d6N1jv540/hgo13zOWnMXEULIpTOAp0qttm/2FHFf9ITSMqdLRvuG1i79M4nY
         iLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VhrYwP48UAqiV9TObLVTzDhXCitwHm97z2ea44Mx4M=;
        b=YLtSUBsNPz4tZBqiQkyy7K+Vd5/okrsAEJN+xIVZzR8BWTK/ISWIG3L0q5bAczu1Ik
         aF5D3xVPmKL8AZvUYSQMPOqGPCO5DfUX3ceQ9NCNarbf2nDlbVglAouq3mY2vsDf36m9
         ZyTtLMILXaVjctl+ec0BKIv0cW8Uud6fRkmU+KYh7EUU2L+CuKEhoksRnT+KzKslv2nP
         H45Ggrb3B/FoqBQRzdKLLRDxMc6J8O/68RMqFjPKkfhT6N1GRlwq1crUMWQabeEDjuUR
         caR7NT+SeUHvtEdhaOZ8eCowt/4PI3fnsVuf29fMeRYkvNAMftUuZDjkd1GkYR32T850
         XcDA==
X-Gm-Message-State: AOAM533CxHtOwwZhmuKnEm/f+sYl9g0nS54gjb6VClTxHLe8F/bwBU1H
        406YqBDZd/Lj5a6ww0VfOp28nystZLQGqA==
X-Google-Smtp-Source: ABdhPJwnC0YY4P1eecwv9Xx2rzdaVtKbdgl8R4rg0/OZw7UXLgX/QXyxWs6ZtjTFlRmn3QZHYTG++g==
X-Received: by 2002:a05:600c:4f8f:: with SMTP id n15mr200281wmq.70.1638985324428;
        Wed, 08 Dec 2021 09:42:04 -0800 (PST)
Received: from localhost.localdomain ([39.48.134.175])
        by smtp.gmail.com with ESMTPSA id 9sm4637252wry.0.2021.12.08.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:42:03 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ameer Hamza <amhamza.mgc@gmail.com>
Subject: [PATCH] media: uvcvideo: fix possible memory leak issue
Date:   Wed,  8 Dec 2021 22:41:58 +0500
Message-Id: <20211208174158.114122-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In uvc_ioctl_ctrl_map() implementation, there is a possibility of memory
leak if control id name is not listed and kmemdup() is failed somehow.
This is a rare scenario but possible.

Addresses-Coverity: 1494069 (Resource leak)
Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4e4aff8ddf7..711556d13d03 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -44,8 +44,10 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 	if (v4l2_ctrl_get_name(map->id) == NULL) {
 		map->name = kmemdup(xmap->name, sizeof(xmap->name),
 				    GFP_KERNEL);
-		if (!map->name)
-			return -ENOMEM;
+		if (!map->name) {
+			ret = -ENOMEM;
+			goto free_map;
+		}
 	}
 	memcpy(map->entity, xmap->entity, sizeof(map->entity));
 	map->selector = xmap->selector;
-- 
2.25.1

