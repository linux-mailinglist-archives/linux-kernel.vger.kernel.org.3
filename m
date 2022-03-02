Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1B4CB175
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiCBVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiCBVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:38:42 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81031229
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:37:58 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso3519783ooi.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39y1JmWcKgDkVIZCA/4u9cM4DjLQrzKHYaevJAooNPE=;
        b=AH8ueK28p6pMJytSWAUsygXRasrNFt/rufhA7WrD4agv/SPSDMBsKBsat3+QsLGRnb
         YO3NZ+23JUKmEtoHWVVvpgsHzGwlXNVY9QKT3YcKungAI8rzTTRZwNiQ8dJp0uraiPjP
         ju4w02XAxGa2QphVfNC6s4if/sLwX2Gt8JJi1x3/XRB4kOo3eWraIiKmEiVjQTPG2BgP
         qrKwBFH+DBG0rGDXj8COcM90liOClnUDWQMFGfUn3iibJDd4uUicxYSSfNzhyaqFu5x7
         P9f9bcyybZmqS1ktvLZh3DXxZiezJsSVEPnOO6o0PmRnNoc7Pe8sWvSKNVA8mrNEE1Aa
         9gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39y1JmWcKgDkVIZCA/4u9cM4DjLQrzKHYaevJAooNPE=;
        b=IW91P69uFJ410KiQYJArCqLXa0Kw2bbEHGc7KrBiDQCMbCT6qnmhXEsm92cm9IjETF
         bajk2e+9wDlz2aFZJGxOc6SHqAtCuMSpJJ2gFwkwcD7IkX+K69/3f0POwIRrgWTSR54g
         moB6OMOstMcoiiusMt8YcfFHD2SgX59at7MpTVxN4bWnRAGP9G7kP8Q65XZulYUEWEV3
         MiCKDQJyd2R0CFj/6pDYeHj4bq5dEzfrqHVowAdu1nq6ZvU8IjwgLjat8uxhaXlLxXox
         hPcyKm+B3u+eY/zugmtW7RtaZkB4YsfjLLCor+TK2FUEgK0NVQHnhYg13Xbebb33FvuT
         Gi9A==
X-Gm-Message-State: AOAM5311eEVByydXJ/MUO4mjD4U+7KVkHagkdMIzohWPQ03EN8f2UzFF
        BIt2cmmiMLYoKU3jv/2KAew=
X-Google-Smtp-Source: ABdhPJx5YFHmvUhcSIDSxDbWRjt7BMPVnB2sQ0swaLBzOkzp5cyI6uZkDS1I0+Dwcr/asDsfWTk3GQ==
X-Received: by 2002:a05:6870:a2d0:b0:d9:ae66:b8e2 with SMTP id w16-20020a056870a2d000b000d9ae66b8e2mr1240660oak.7.1646257077997;
        Wed, 02 Mar 2022 13:37:57 -0800 (PST)
Received: from localhost.localdomain ([181.23.87.56])
        by smtp.gmail.com with ESMTPSA id s12-20020a0568302a8c00b005b010d92dadsm69132otu.69.2022.03.02.13.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:37:57 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 1/2] staging: vchiq_arm: make vchiq_platform_get_arm_state() static
Date:   Wed,  2 Mar 2022 18:36:36 -0300
Message-Id: <216ad30d674b80e0051ecc233ac26ddb1d3e0e75.1646255044.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646255044.git.gascoar@gmail.com>
References: <cover.1646255044.git.gascoar@gmail.com>
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

Fix "no previous prototype" W=1 warning by making the function
vchiq_platform_get_arm_state() static.

While at it, realign the function declaration in one line and reposition
the asterisk symbol to fulfill the 'foo *bar' syntax.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 54ab6208ddae..f0bfacfdea80 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -593,8 +593,7 @@ vchiq_platform_init_state(struct vchiq_state *state)
 	return 0;
 }
 
-struct vchiq_arm_state*
-vchiq_platform_get_arm_state(struct vchiq_state *state)
+static struct vchiq_arm_state *vchiq_platform_get_arm_state(struct vchiq_state *state)
 {
 	struct vchiq_2835_state *platform_state;
 
-- 
2.35.1

