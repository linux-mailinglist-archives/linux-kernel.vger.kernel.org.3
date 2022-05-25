Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A66533BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbiEYLy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiEYLyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:54:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56028A2069
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:54:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s68so2413316pgs.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yxWvcY2SALhCu7O1YfNmzl9qm4kjTTfVDTmiCC4+Dk=;
        b=q5+JawkNSA+SJWs7Kaab97339qddNR/hzU/H6kDcQ4pirilP6uf+8B+PyDh47W3e8d
         ihdx6zfJyu8iF/4osmZ8BmYiqhYGJzFdb40929Lp7xuhUpCAvffX5qEh0cLe1cCL2ARx
         shfLl4DKC4gMpQRWU9wjluyCU/RK2dVgeRMaUNTxEAqWyZEoBatwRT46tBoXGB76ZwQj
         T8Gv1DI9kV+Wqs3i2YOn8+dE66MXiYrMr7e+CnpNs64XHQYRQiR9L4JeZz1u1bugz6hl
         IX3HumOGRa1IPyYxCmtm4PjNjnQuMGE7rYWREj8prbV/wKLXUAuWqR02HYTEc6sSdjeA
         exNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yxWvcY2SALhCu7O1YfNmzl9qm4kjTTfVDTmiCC4+Dk=;
        b=E+DQ9PdhdPSmWYirCqCuNQ+62qOJ9XfoufCd36WM1Os65TadR/I5LeOTyPp+kEiJoV
         EPHZfjitjfq32JfSBTcjgMbXfAHs4Su846RaRsnwmd2zoIm/8cK5BCAyiOyzIYtLNBvj
         A1ip9EYf06zsCjoYfV3++I/h6Wj9bSjI3aWfFaJCObqGyO9+CvyESenTeRlslrSUuuxm
         FZ0xDGwFZjHoI3SMuwqSsid7EGVp7L0vlF2fVE77wFpLB8p6vJrwS9Bwqr/s+Cr0zowz
         NKJCzvMEMaSeiB/8Q9bGrM3ClLqPNharOfORRKYu1RhpqrepoF/6b/umtHpkMfd9b9ow
         B64A==
X-Gm-Message-State: AOAM532ng5oDnsubVzuIJ4ldyHssucGPNqrghi/wtZxgaf1yfHzThaHF
        zu+JoRVs8hQd0EdHNXlsNwq8vH4K2VFONA==
X-Google-Smtp-Source: ABdhPJym/TjfU6YuFpUgkO1ZxmprHrgC5PQcEiARQ+48NCFRNJ8Q73Y7W+gum6ApxrbSM5L8w+T58Q==
X-Received: by 2002:a63:95:0:b0:3da:ec5a:141 with SMTP id 143-20020a630095000000b003daec5a0141mr28135869pga.480.1653479660841;
        Wed, 25 May 2022 04:54:20 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x15-20020a170902a38f00b00162496617b9sm3326519pla.286.2022.05.25.04.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:54:19 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/mcde: Fix refcount leak in mcde_dsi_bind
Date:   Wed, 25 May 2022 15:54:11 +0400
Message-Id: <20220525115411.65455-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every iteration of for_each_available_child_of_node() decrements
the reference counter of the previous node. There is no decrement
when break out from the loop and results in refcount leak.
Add missing of_node_put() to fix this.

Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 5651734ce977..9f9ac8699310 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -1111,6 +1111,7 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 			bridge = of_drm_find_bridge(child);
 			if (!bridge) {
 				dev_err(dev, "failed to find bridge\n");
+				of_node_put(child);
 				return -EINVAL;
 			}
 		}
-- 
2.25.1

