Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5F57B071
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGTFmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGTFmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:42:17 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89B3C8C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:42:17 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so34800559fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVoUKQlwm/yv6Z3L0/jFWLZaGDmNOYrSPKQKqKpKuIU=;
        b=XPaCyj9Wh5VKhFBmtKwkuoU7O3F4OFPLSQcDzS5lWZY4a0jZ6Q6CyV7SvIXilpZ/y/
         mMnDdjxELgbZlCOoHKky9Uj0Wc8+A/FF7BAuOUsuzzCsBDuAcNLPDsk3ZcS1kNXZjER2
         B8+cSZa52oZee6UDPkGPO+rcR+HklIFH0s1NbPGCEccGGH4hZCesZgZridWVX59jqpHN
         Ug/DT73FLr4jqJMs5i2eZNGyC8yXUrAHWl6IXj9riBev6Of710kDwY/540pqn/xqisvc
         /Za32VKeVdBPZ3cH23NgB3gCNkPM+HGmS2u1S8HC68jySxCc0U2HWWuYDKdTyDlks6K6
         C+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVoUKQlwm/yv6Z3L0/jFWLZaGDmNOYrSPKQKqKpKuIU=;
        b=nMbRrN33sRJl1jt/02gKyWUPFxtxeoAsECYKWK7FWKf1YeYJXjD2hyW/YUTaQtYleP
         xtQENmPlZ0owb0ofKlMD6oyw10F7VkBHR0F9wC6qDbeUBjPhlBU8EemBwAVDmNjDIqtp
         3Rk0sVLwB1/p0ydV8ySbPJw8rXeEB431+fEUbQLWjeV+LjtVnD2nb/fTHrST8tpJ2sog
         NnJX4XO7A5kBVJID3On+AWbmiRZpRSdvZ+4ttLsxZlPc0Y8LIFKrm1dgW2NuFgOXQeQA
         hYTHuSlrIXdIYhbfFNveXEzy/KYheaWKHEYULM0L+9u4cWGvP0uR7FEf5X6fyUanbpEB
         FwOQ==
X-Gm-Message-State: AJIora8PeEzWq6LfTyUBYSLau/+iBnRGYZVtb4CyRe3qQwRaYZylM3Zn
        /IyVpebkwhtYsG53oME9nQ1Z3Q==
X-Google-Smtp-Source: AGRyM1tMDZuqnSAaDTRab2kmBYi2PvBr+UpWYHJAfRGE/yEVPs7ppPRY/TqvXBZpXnUYH/6Cuqhlwg==
X-Received: by 2002:a05:6870:e74d:b0:10c:759f:a079 with SMTP id t13-20020a056870e74d00b0010c759fa079mr1589514oak.184.1658295736484;
        Tue, 19 Jul 2022 22:42:16 -0700 (PDT)
Received: from localhost (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id bm51-20020a0568081ab300b003358e034f72sm6179069oib.7.2022.07.19.22.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 22:42:15 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel-edp: add IVO M133NW4J-R3 panel entry
Date:   Wed, 20 Jul 2022 00:41:52 -0500
Message-Id: <20220720054152.2450-1-steev@kali.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720052841.1630-1-steev@kali.org>
References: <20220720052841.1630-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an eDP panel entry for IVO M133NW4J-R3.

Due to lack of documentation, use the delay_200_500_e50 timings for now.

Signed-off-by: Steev Klimaszewski <steev@kali.org>

---
v2 - actually mark it as R3 in the change, not R2...

I'm basing my information gathering off what I could find for the IVO
M133NW4J panels on panelook.com.  R0 is glossy, and mine is not.  R2
says it is discontinued, and I am just guessing that I have the R3 as
the Thinkpad X13s just came out, roughly a month ago.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5024ba690abf..870b98041c60 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1883,6 +1883,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 
+	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
-- 
2.30.2

