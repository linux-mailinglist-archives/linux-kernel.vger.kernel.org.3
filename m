Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599E4481BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhL3Lc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhL3Lc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:32:56 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:32:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id f9so21421383qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+3drHr85ha2baZful+nRJ7uBfrZaAbysA+5tvBlqBY=;
        b=qPtzEAgNBKbi3F8mzlujZv/gYnhOvqhIviEvIuYvKHcBnL1trShVtjmds0pGd2hf79
         liFxw3cM75vsuO4svQ2s3GgC7/2uBAes/Vcvy+/v8DC0tRhnv+4xSLcrxzptF2nmQkI8
         YV9aKyqADMLP1qpBgZStSDBs6fCLTe3qX08bvjMP+knZB3h1CIQ3XM7r/kBTqitdFn87
         Bw5NxzIQ2d6iDtHxBo5vVLZ0FF0dRuNApfGF2BlgH7O2YTETm2Y2eym5o3L7kZ9Gh3M9
         9rX2Jul5hJPmEiL37bWzrNIHOoIZFNdPajiUyeB0m96hmwVAT+udeMoeycCHtEzLGuwd
         LolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+3drHr85ha2baZful+nRJ7uBfrZaAbysA+5tvBlqBY=;
        b=OlaUx1LmUxYpgF1pJo1HuQkTFF3KGy19gv3rf/9dvBBdFAahrQOr6kZ8cAUOwbZGpm
         lzKEam7BA9ODH32loglhHoXkmJzpyXqXpkvga15qX9g3kRQdUjcySV7Mxv3TWsYKDH9j
         hodFFM0dVVm87mErwC3cyuelT43Glxf1MQ2dNrWuBmOkLAVowlJoVKsu5A5aFqprEl4d
         fVlmoF6Lqadn6wNy/+pobB4fSicCrknl3dQ5l0N6CLrOAZIY4PD8XLUrTSvS6kMMLGAB
         m2FSj+wzNDp3VAHb8NHCQyElW/JtsqJc0XpQeQeeb/woRkDXa9toDZO1pA54QiIVeEpu
         T3PQ==
X-Gm-Message-State: AOAM531xP1C7UnATRb2RrSZ/yE1w18P+0TCuXvHMO736J5qIOTG3Q4Bj
        mqKKv+y0li4W8ND40LWbbJU=
X-Google-Smtp-Source: ABdhPJycnyd4H24DA5r2pASiGfeQVL5PDTMuBWNjmfl03v0nt+qlhV0ox7sLYQwz0sd6ruO2U1lfQQ==
X-Received: by 2002:a05:622a:144:: with SMTP id v4mr25727272qtw.191.1640863975231;
        Thu, 30 Dec 2021 03:32:55 -0800 (PST)
Received: from localhost.localdomain ([181.23.70.139])
        by smtp.gmail.com with ESMTPSA id v5sm20348559qkp.126.2021.12.30.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 03:32:54 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH v2 2/3] staging: vc04_services: bcm2835-camera: avoid the use of typedef for function pointers
Date:   Thu, 30 Dec 2021 08:31:27 -0300
Message-Id: <0418e6e19e1580fff4abfc4bb2f4269dc206df44.1640776340.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1640776340.git.gascoar@gmail.com>
References: <cover.1640776340.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace typedef bm2835_mmal_v4l2_ctrl_cb with equivalent declaration to
better align with the linux kernel coding style.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/bcm2835-camera/controls.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index b096a12387f7..3696dfb5a020 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -65,13 +65,6 @@ enum bm2835_mmal_ctrl_type {
 	MMAL_CONTROL_TYPE_CLUSTER, /* special cluster entry */
 };
 
-struct bm2835_mmal_v4l2_ctrl;
-
-typedef	int(bm2835_mmal_v4l2_ctrl_cb)(
-				struct bm2835_mmal_dev *dev,
-				struct v4l2_ctrl *ctrl,
-				const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl);
-
 struct bm2835_mmal_v4l2_ctrl {
 	u32 id; /* v4l2 control identifier */
 	enum bm2835_mmal_ctrl_type type;
@@ -84,7 +77,8 @@ struct bm2835_mmal_v4l2_ctrl {
 	u64 step; /* step size of the control */
 	const s64 *imenu; /* integer menu array */
 	u32 mmal_id; /* mmal parameter id */
-	bm2835_mmal_v4l2_ctrl_cb *setter;
+	int (*setter)(struct bm2835_mmal_dev *dev, struct v4l2_ctrl *ctrl,
+		      const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl);
 };
 
 struct v4l2_to_mmal_effects_setting {
-- 
2.34.1

