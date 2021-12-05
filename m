Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF04688A4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhLEAUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhLEAUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:20:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C15DC061751;
        Sat,  4 Dec 2021 16:17:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u17so6726082wrt.3;
        Sat, 04 Dec 2021 16:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT8uH+WZYKbbbA52e1mD7F2y2MEMzSLs39hZ2g9wA4o=;
        b=KPbWipGF9NN5VmLf95S54L22RiZUamWDBWtWklREvuxwXPrnlh8NRSbAnpjKnX8EDj
         GlzYua17dO6Dx1Uiu7UMY8W2+8eCXIKh2o4bXqMO2ZjEJcprllnKkrOnH75FQEMqAdSa
         92ZGwM0B9DloU+dKbehCRq6dGDIWfurJmc1mL5EJho9cQr5b00TLvMiGbenXUtIuvfBH
         eOvW+89a2VVehNIdfvemNfrtFZ5/qqeGwO0wF+TfEGisYpF35d0zH/uEbCOPp8IN56ig
         idvpDlKglI3CayAycMeexGEY0oyN2r4ghxOppJ7AWR0yvujkDbW+Y/KnfSymHx2S/Kfh
         CagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT8uH+WZYKbbbA52e1mD7F2y2MEMzSLs39hZ2g9wA4o=;
        b=1etYmGb39k3KJmeKV/svCJIXm+He2a85uLet8B0CMwXlWOP1TPyLgHk8ixSMkjn27M
         il8BO1FeP6bLsZE1XQL+HhhcYp6729dDW237legWtbYBkwlGV49YCowsdT7P/WyOg66m
         ROuCp5a+/VIQsY0pxuQoXEjI7IsYl6QfR5r3L2lUdITEzcAk0EnD+yEB9uaNItKjPozh
         AIVhAAol7lAGk+K9dRlKFqt1FKyJfmO1XiSX1o1I2LXEfMCRYnN8duOuzC/wlMstVFBS
         dPAkzaDR1Vw20xHn+nFSm3NMSX9QJGZ4AG5K9CCDJI06465yUMCNxjTI8z0OWRTxzBxH
         anQQ==
X-Gm-Message-State: AOAM530R4g9VL+S29iXtqU0jN6obcveZgvOMpYdzM9uAJYn9g6Y09M3y
        cWle7dBU4yjCqbySlm8nkGO7TVrS9WMITQ==
X-Google-Smtp-Source: ABdhPJzIOV28vkE7Pge5Zpr2lvVGDACk/1izBZLlOk1DUonIBDpy4A/Sd2MgCq0qaQX92WqsvolTwg==
X-Received: by 2002:adf:8bd8:: with SMTP id w24mr32610946wra.540.1638663438766;
        Sat, 04 Dec 2021 16:17:18 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b11sm9053931wmj.35.2021.12.04.16.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 16:17:18 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7146: remove redundant assignments of i to zero
Date:   Sun,  5 Dec 2021 00:17:17 +0000
Message-Id: <20211205001717.178416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable i is assigned the value 0 and each time the value is
never read after it has been assigned. The assignments are redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/pci/saa7146/mxb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/pci/saa7146/mxb.c b/drivers/media/pci/saa7146/mxb.c
index 73fc901ecf3d..ae958ff206b2 100644
--- a/drivers/media/pci/saa7146/mxb.c
+++ b/drivers/media/pci/saa7146/mxb.c
@@ -340,7 +340,7 @@ static int mxb_init_done(struct saa7146_dev* dev)
 	struct tuner_setup tun_setup;
 	v4l2_std_id std = V4L2_STD_PAL_BG;
 
-	int i = 0, err = 0;
+	int i, err = 0;
 
 	/* mute audio on tea6420s */
 	tea6420_route(mxb, 6);
@@ -349,7 +349,6 @@ static int mxb_init_done(struct saa7146_dev* dev)
 	saa7111a_call(mxb, video, s_std, std);
 
 	/* select tuner-output on saa7111a */
-	i = 0;
 	saa7111a_call(mxb, video, s_routing, SAA7115_COMPOSITE0,
 		SAA7111_FMT_CCIR, 0);
 
-- 
2.33.1

