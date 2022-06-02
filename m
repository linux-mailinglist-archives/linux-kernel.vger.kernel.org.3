Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D368C53B43C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiFBHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiFBHTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:19:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8078DBA6;
        Thu,  2 Jun 2022 00:19:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u4so1065368pgk.11;
        Thu, 02 Jun 2022 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AgL3mhclsRnOIjShcky6P/zYqYoTK5YEABahucPLqo=;
        b=XSLWBrUEed9Lolpsa7uO5CbaR4AjyTCecnUaFW3y4NL9c+E4gUNBk5OxOyK964p6/1
         7oHCe9/pZ7fI2Ty8Ps0Nyn6XXFbISwCb/KnD5tEsSR/JRssY0j9uVSmupr9OL5hch6Xl
         SfdubO4H9O2FRKMe8jCT1pnYCmj6Qn4Y9UI+CeqQzJyoZuldfgouaUXPh/NjCT+W6kXk
         Zw/ZdsRRnXKVw64lI9jysyfsn8h5oNJWRzmouJZBel28yszQhnTQnfcqDS7MOjyLwOaC
         yZcHvzvYuxiPP21sHFbaTmAQmQ4xBsX3YWLYdF00j+a9Xmusg8/AmRjkq8dvC5GJN23e
         VP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AgL3mhclsRnOIjShcky6P/zYqYoTK5YEABahucPLqo=;
        b=IrrGv8ISbRR+29jG/Y2q1as4C6lzsVhrVKYa4mGeB5x5EMVSivCBRuKDlTZtsCazs2
         h82Ejqnb8R/QyME38ySSm6VHAvXooAQ+a/QvBUGCKfmtuRmeiyl8I23/H0KjFs8GJ9ZT
         46D4SIM2T2/ZAcRxn/T1+qyOzN+YZ9v3DyvvfKv7fINcdKZeAd3stx261TMlC5gt4N/T
         SQZE07nRv6VhqKm0Qh8vGR+eyfLctLbGJw/3vdtshifsP3e17qa+OgwkjOFobPl6GSiJ
         EhDWHOOqHaC8an/GTCGvbcIxjb3SMoHVU+dNh43zJkd+9E6agYSGpG0KC6g06dSn8sG6
         2JUQ==
X-Gm-Message-State: AOAM531lAGLJteaNqIr3RJYXs5q/KzyXUsZMobL03Tl14Dj4jlpY4/ph
        h2Lmq7CkO4MAR7tijOFfTbM=
X-Google-Smtp-Source: ABdhPJyNCRxM1xVeTV9AnJRopo/U6+CXHO8H9eRsl8Qtk7uNHjQIPGjV+6Xm3bcluRIWA8q+ko47pA==
X-Received: by 2002:a63:187:0:b0:3fb:16f3:ac7f with SMTP id 129-20020a630187000000b003fb16f3ac7fmr3032548pgb.284.1654154353050;
        Thu, 02 Jun 2022 00:19:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b0015ec71f72d6sm2831603plg.253.2022.06.02.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:19:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/tegra: Remove redundant NULL check before kfree
Date:   Thu,  2 Jun 2022 07:19:09 +0000
Message-Id: <20220602071909.278279-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

kfree on NULL pointer is a no-op.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/tegra/submit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 6d6dd8c35475..54ac31bc80f6 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -639,8 +639,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		kfree(job_data->used_mappings);
 	}
 
-	if (job_data)
-		kfree(job_data);
+	kfree(job_data);
 put_bo:
 	gather_bo_put(&bo->base);
 unlock:
-- 
2.25.1


