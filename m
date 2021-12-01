Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4EF46467A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhLAFZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhLAFZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:25:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A375C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:22:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so96284963edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2q5Y52i+TnQJxEs/+WEn+DzboLw64HgEXvFydK4rUw=;
        b=UbiWQnmk2RY/uuR6K8HROMTkHZoIFyDmnU6YwmctDVzEOI7j4PqFL7E56r46BOrsr4
         56ZYlFT/dSVUX+IlkDhCplX5bEbNzOt1jwW+jDemAZv5pndv4u+Z894IZc1tkWn77/V+
         p15FUJLJL33/PSNOMDJ2WzJoUhkASzVWs9cG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2q5Y52i+TnQJxEs/+WEn+DzboLw64HgEXvFydK4rUw=;
        b=fof3ONUxLTNqvXDfITxlnFIAJ/SSrYyB9kTSvx82SJctQMlnQNxU22OpF/DZML+ksB
         fxaXOUvKpcy1TiJnbMWJPNs+VNL2nnOHASRp5y6x3VB7eG2Tp95x82LUG5gd1MKTUxrj
         jvFVHegdNGdVu9vvylOhld3NAD6/UWeB3GiSoStA9MhrsjVBl+NQgmPGO3qFALOWxN4m
         E2msJN2GLzsdt4CxVaCwkkZACNIlp0OyB4el3BmZfqTNAEz96eq4nlvBvvFKMsAp/I9c
         6leeJwBwuluEB1sCJY1bTOIcZBQuAPzf8aoPgvUuGRWmuC7kWt8Goagvin2npjDKSUom
         lcKg==
X-Gm-Message-State: AOAM53099waxjMRg0MfcfmH+qmu8zTI6WHp0R1MJBJKxAkUySkW/cla1
        6nITah8ilXd176cMUoEtRD9O8j5UprZ1cQ==
X-Google-Smtp-Source: ABdhPJySCMUkzcq6DiJYLNYpdpRrY1F/jMPOPRY8tPsJCXrpoTJGveX9XfjfqSaRkaZ4dXwPzKUzxg==
X-Received: by 2002:a17:907:118d:: with SMTP id uz13mr4642374ejb.334.1638336142146;
        Tue, 30 Nov 2021 21:22:22 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c11sm13977663ede.32.2021.11.30.21.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 21:22:21 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 2/2] media: uvcvideo: Avoid returning invalid controls
Date:   Wed,  1 Dec 2021 06:22:18 +0100
Message-Id: <20211201052218.689103-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211201052218.689103-1-ribalda@chromium.org>
References: <20211201052218.689103-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory where ctrl_found is placed has the value of uvc_ctrl and
__uvc_find_control does not find the control we will return an invalid
index.

Fixes: 6350d6a4ed487 ("media: uvcvideo: Set error_idx during ctrl_commit errors")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9a25d6029255..b4f6edf968bc 100644
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
2.34.0.rc2.393.gf8c9666880-goog

