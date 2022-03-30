Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D44EC3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbiC3MU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbiC3MGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:06:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690EBBF46
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j8so10073916pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48w9cCcHfu4RFzRm5PZAyw72DdxLC63ffgBHswIn+j4=;
        b=e2oys9YHS1G4ibMgjW99OE3iDzMIYL6l9CnklayAdF2/xl9anpeDhLfh2+ycju7pkk
         jVM8SwJI7cy6FAd+qP9m9lafilhptX+dnPyU/ogkIn2Q+w2gPG+PM96hKg+sDnGLgYHS
         Mh9UTHx7rAA4iTqN0e6oweEDLKGUJ/IsGLmkxDHTid4PHkzEGi/JNsV7282VfYeWex1Q
         KcaAlOY/6cD1PVyEXlXiSTqh7No95xKZuDfxGaP2Xl7IkShsybZwVKftzdBqrRjzwt9U
         /hD2+lGydFDG7xj1RAV5R1VQahPryrV4INhY8Ps9tS/2P6o9rtSl0P7xJ79plT1OjGxj
         m8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48w9cCcHfu4RFzRm5PZAyw72DdxLC63ffgBHswIn+j4=;
        b=dsrdqMl0rLXTq3EyDZ5GXmuuVY9QPRy8DHQ6F0cbkllIZSJWl8xwuf8DBXQtM1WWlD
         LkXnPotwy8wu/v855rsYH36J6Y4UAdVt6vwL7Oib232MTE5WJ5ZRF4wzcDiUTZaBLeq0
         LAVIJAuzkzEcAqVdeRQ9mybWVwkZo7SmZjYPK+cJbPOuVhfFJnZej3/LrvPTefO+iupt
         sZX8I23d8P0GCvwVAA1k8LJPh7TM8nRB8f88KQ7QoCsmZvf4m1sx5JRgGaG9y9KXH/Po
         FGiizcUW9dzVjmm+iEtPp20wD92GUBFRtyv1Xd7p6XrFEnWzwWaVwdb9O9Z8AcTXQFHz
         3VQw==
X-Gm-Message-State: AOAM532BubOPCJlwca92wUhBG5wjsWviML4tTSqT6F2KgpSiwVwNzjwT
        ZGue85qhCiQKXK8myrwKkqY=
X-Google-Smtp-Source: ABdhPJwbqJd5wNulvaZLttMt50ldtMVPaMlLpVaNrun46JlZVZd5PnTlSq49PePx/8vUsZI1mYU89A==
X-Received: by 2002:a17:90b:1c07:b0:1c7:5324:c68e with SMTP id oc7-20020a17090b1c0700b001c75324c68emr4691633pjb.202.1648641815737;
        Wed, 30 Mar 2022 05:03:35 -0700 (PDT)
Received: from localhost ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b004faeae3a291sm22940884pfk.26.2022.03.30.05.03.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 05:03:35 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     rob@ti.com, yakui.zhao@intel.com, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH 5/5] gma500: fix a missing break in psb_driver_load
Date:   Wed, 30 Mar 2022 20:02:46 +0800
Message-Id: <20220330120246.25580-6-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exiting the loop as expected when an entry is found, the
list_for_each_entry() continues until the traversal is complete. To
avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
add a break after the switch statement.

Fixes: 5c49fd3aa0ab0 ("gma500: Add the core DRM files and headers")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 65cf1c79dd7c..d65a68811bf7 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -398,6 +398,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 			ret = gma_backlight_init(dev);
 			break;
 		}
+
+		break;
 	}
 
 	if (ret)
-- 
2.17.1

