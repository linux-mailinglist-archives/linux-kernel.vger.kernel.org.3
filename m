Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A634FEE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiDMFNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMFNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:13:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55084833E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:11:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 32so788620pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kXceBWICMkqVzxZbbXouRUuh+7IRurVzl1HZ/UYHcmM=;
        b=CoDD+vum6WiHck6Yru57/HXqzuYL1H4hsZAx1F3Bhx7HHps1kvenvPkHL6jA32tJFH
         6NwEiBa2fCAsiR5SAwQieocAHm4PQxCJhD507jcgj8Db2MD7bLUgOMQj3KVGqVOJoRAa
         kPOc1Iqz4lReIV1suIKTD4utwV7uoTspJ62KtuQ4JayVWcaeY1g4y1oJ2UMZAAnwNu9i
         4IX+GAf4V/KaIyE9/r35ILcoZDrlOE64BO3Ip0mb+4woorVYC5fK/sNdNIBF/GYRZiIe
         TEfNTPdlHMtiVndnMj/2Z/MJYoK5ePT1nzrbmG3OMdbLiiiRix4iCCxZIHdjwvyQL0Dp
         pw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXceBWICMkqVzxZbbXouRUuh+7IRurVzl1HZ/UYHcmM=;
        b=rtJUuIVpCX69NavbokVW9iGGdJgUExtfulkMxXtybplEysNwGsXzjjmK9vd7f8DG3/
         RQ569m93YPiAmzZR6IenTUI6Z8Ea1/ImaidZ8xb7xS1i/jUbgKsS2p2Vhcz+d+yQHnov
         0MYQw6gd9YGSou/PUiG+SIvHpCmbXBc7DVBVFbJkiZ6M8XyeyGz1/dibpDPvU37+BSI7
         PQ10ynxIImj280PrPUsiSqMTalFFx0/sPyLQ00pS09TaNqWH7ffk1GqM6nosry+EAj7B
         JaLYaeFB5tTmKiimgIUPTUuYDY9uXpxgePOH8tkB4QzeQSXuyQXCOyGW4SdXBy1Ly23M
         pp4g==
X-Gm-Message-State: AOAM533FSCSt5PTBmo5ktSlmkcEwXCRjv9sPYj8eoaquuo/0qFWKasiF
        ZnfgUrjQYtkcVhBAb0pQHcU=
X-Google-Smtp-Source: ABdhPJwxZ04TU3nO4liFW+32dbNCALzgUg5LhTx5Uq5S8/oIGF/9ns0Gquc/Qd5KiLYJ7QXcTaHU2Q==
X-Received: by 2002:a63:4b5b:0:b0:39d:3808:c226 with SMTP id k27-20020a634b5b000000b0039d3808c226mr14062083pgl.603.1649826675192;
        Tue, 12 Apr 2022 22:11:15 -0700 (PDT)
Received: from localhost.localdomain ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm4414824pfc.101.2022.04.12.22.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:11:14 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v3] drm/gma500: fix a potential repeat execution in psb_driver_load
Date:   Wed, 13 Apr 2022 13:11:05 +0800
Message-Id: <20220413051105.5612-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
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
goto outside the loop when found entry by replacing switch/case with
if statement.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v2:
 - replace switch with if statement (Patrik Jakobsson)

changes since v1:
 - goto outside the loop (Xiaomeng Tong)

v2: https://lore.kernel.org/dri-devel/20220406113143.10699-1-xiam0nd.tong@gmail.com/
v1: https://lore.kernel.org/lkml/20220401115811.9656-1-xiam0nd.tong@gmail.com/
---
 drivers/gpu/drm/gma500/psb_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 2aff54d505e2..85211ec16e52 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -396,9 +396,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	drm_for_each_connector_iter(connector, &conn_iter) {
 		gma_encoder = gma_attached_encoder(connector);
 
-		switch (gma_encoder->type) {
-		case INTEL_OUTPUT_LVDS:
-		case INTEL_OUTPUT_MIPI:
+		if (gma_encoder->type == INTEL_OUTPUT_LVDS ||
+			gma_encoder->type == INTEL_OUTPUT_MIPI) {
 			ret = gma_backlight_init(dev);
 			break;
 		}
-- 
2.17.1

