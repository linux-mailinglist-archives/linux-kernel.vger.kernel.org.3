Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58734EE9D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbiDAIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:38:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07CC2128F8;
        Fri,  1 Apr 2022 01:36:44 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b18so1574288qtk.13;
        Fri, 01 Apr 2022 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mSCDYPk3U9vdhqL8Gmqs9PhseJMmr9FU0irA0rfjxE=;
        b=VmgqgP1xI/S/P3HIba5wPAeNYZvDDOjgpzdyQ3g3xGbRgAIgVIP1NgrAoq7n1yhYzx
         Vu3FBKquivjAHibTaQ+JPAv2MEBuBs2yCf9+oMG63qo7I5S8UOLnLspAVW3gWXyb2IxT
         FCxJSXdRVEVZMjdQILJyD6oUMc+NXX9LEJpgUnaHwV/6esJ1hbVR4AanILYLR9DsC94+
         eIRo5CsT1co60Xbr47DdRIcKYkm9cWZ6X9ESEBGCBb58EcsiD/F7PaiPPACbIPK+/drs
         2whc1NRQmUbHgrxiTUNrrpuX1/xmMzCFr711kIvpmq5fxVzAxTTsx2eAEMP78MrYdL7s
         SFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mSCDYPk3U9vdhqL8Gmqs9PhseJMmr9FU0irA0rfjxE=;
        b=1eENoY98QhAnEaNt4CaWF4ycp8rh3fxf/lZ3N2dlzrVZG/CPDcJ/UXPMDNzrJdZO2u
         p1MIdal94ya6Q/PaKbqUVlA4i2m5muvUxdlFoy+XRKagwKJw7qnn3UyF/F4MJ7/7S18q
         9VvY9L2mH9/sZ2PTiIn5fpdkrViS+DBHvb+7EDUm0tkBe+jvyJFCQOV2szRj25zTevpH
         RoAATLzfxp75EzFnx+udfd2mQ42pSMieEqBu/9DIJ+iepOBDgHnw1tFE+19mr5xLMbr0
         kPEXYJVk2Zu8IGABeFcTp9e3dMf0kchxUCMF7z007cNibWxbFsS2fKTwkHriaXUL13u7
         oCDw==
X-Gm-Message-State: AOAM53046Hdnhn0Q1SvYcCsqt/DesjtMjj0k7GU1EkTGxR2qhDU4p5yk
        eHlwp0LTOhCykreJLq6sLFNYcCOeYi4=
X-Google-Smtp-Source: ABdhPJzOWkUlQCyJVlzJDVTy84GLdOju1HdNzkPqrDqJ6+tAitfS8ZsYVSOZu/6Y9Eg2vjaf+7S9Dw==
X-Received: by 2002:a05:622a:1786:b0:2e1:f1b9:8a1d with SMTP id s6-20020a05622a178600b002e1f1b98a1dmr7603681qtk.443.1648802204065;
        Fri, 01 Apr 2022 01:36:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a111c00b0067d3b9ef388sm891887qkk.98.2022.04.01.01.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:36:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     philipp.reisner@linbit.com
Cc:     lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] block: fix potential dereference null pointer
Date:   Fri,  1 Apr 2022 08:36:37 +0000
Message-Id: <20220401083637.2407766-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

rcu_dereference may return NULL, so check the returned pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/block/drbd/drbd_req.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e1e58e91ee58..8ab6da155e2f 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -577,6 +577,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		D_ASSERT(device, !(req->rq_state & RQ_NET_MASK));
 		rcu_read_lock();
 		nc = rcu_dereference(connection->net_conf);
+		if (!nc) {
+			rcu_read_unlock();
+			break;
+		}
 		p = nc->wire_protocol;
 		rcu_read_unlock();
 		req->rq_state |=
@@ -690,6 +694,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		/* close the epoch, in case it outgrew the limit */
 		rcu_read_lock();
 		nc = rcu_dereference(connection->net_conf);
+		if (!nc) {
+			rcu_read_unlock();
+			break;
+		}
 		p = nc->max_epoch_size;
 		rcu_read_unlock();
 		if (connection->current_tle_writes >= p)
-- 
2.25.1

