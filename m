Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7D514202
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354376AbiD2Fy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354315AbiD2Fyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:54:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD6B89AA;
        Thu, 28 Apr 2022 22:51:20 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id js10so4741581qvb.0;
        Thu, 28 Apr 2022 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDJuHsnb5EzH/lpZ47Oj8fmkH3usiQ2wqUINLtDi+c8=;
        b=Ye/6eHlQjd1t3TB0u3vmRazBP4a7XLeXMdJ1Rnhm3IbbOnJVrjRTMYYoH7mFIDlD98
         C0A1qidM9UjvmMemSlGxoli2t6CpOcGjR4bfXGEXmsu00Jp6xe53RvfkJ05P396gZ/rQ
         NJw/pMooJ2VKutmKBIYcuyGId2tVz/6m/Ebwltc/is+lAUfoHhhnY173siIkMqVxCHse
         hdrXVD+mxKCeoWqZ4BCMEPurb2KQaHudSQB6jFpFknCl7lyVD+u55HTBu+ZLVRw6lAhJ
         Mwb8WL6EV+5/jRpXwXdduh2t8j2oE3CFyE/el9k2vmvPZfo8huvRw82DQbMgLabJqrQY
         QSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDJuHsnb5EzH/lpZ47Oj8fmkH3usiQ2wqUINLtDi+c8=;
        b=BiR6XBUFCLz6fJmPviJ006u5kH64B1KINCS3KeknWrgG0sYGIleQQTFq3+U6ejj1OY
         QGXrJkb54AqiIoKP2eYedS9+cxPFFo/Zn7t5MGRf7Jie3fQ/z0VRZzZwe6gjmzjfxJ+o
         YjdS2Yefluo2gRJin4CF4Euqf6kVDtLCyQezAUcZb5dh+XOR2rtEZkhIXSv0KPA1W43C
         0ekutWfrajLAcnataWSy7yds4CqNH+/e1Mxqn7myvfRKpC9rLB+J1vO6cy0pxC7ntxCA
         3d9PzoQyCIg1S761hZ45a8c1Lse6allyUReZJSED1vbvQpqpNyMIhl+i+aTtVPZ2K28i
         eQ4w==
X-Gm-Message-State: AOAM530lg1oRXK50D0qCsAMhNikR6+UwxOT0cBFuFP4PknoC3FrAARBp
        uPirXmCWcrLuxDhfa7iTNFu8B0RiuKs=
X-Google-Smtp-Source: ABdhPJwixi6jHMC7bGvPnpTqiNSXfVsJOyc9CaKMVWXZvsnUu8ogEfLH6vW++steXpoKW/9kxxCI4g==
X-Received: by 2002:ad4:4345:0:b0:456:915e:9bcc with SMTP id q5-20020ad44345000000b00456915e9bccmr5240086qvs.109.1651211479166;
        Thu, 28 Apr 2022 22:51:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f10-20020a05622a104a00b002f35726ccd8sm1194328qte.86.2022.04.28.22.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:51:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     deller@gmx.de
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] omapfb: simplify the return expression of nec_8048_connect()
Date:   Fri, 29 Apr 2022 05:51:12 +0000
Message-Id: <20220429055112.3852209-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 .../fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c     | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
index be9910ff6e62..b407173e27b1 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
@@ -117,16 +117,11 @@ static int nec_8048_connect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
-	int r;
 
 	if (omapdss_device_is_connected(dssdev))
 		return 0;
 
-	r = in->ops.dpi->connect(in, dssdev);
-	if (r)
-		return r;
-
-	return 0;
+	return in->ops.dpi->connect(in, dssdev);
 }
 
 static void nec_8048_disconnect(struct omap_dss_device *dssdev)
-- 
2.25.1


