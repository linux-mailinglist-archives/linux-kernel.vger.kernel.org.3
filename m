Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9E547917
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiFLGlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 02:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLGlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 02:41:00 -0400
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795C4BB90
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
Received: by mail-pj1-f66.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so1336451pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGrF/sve7KFTJf3GJ9QVEDMMBvkar/b8XuDD6PWfLjk=;
        b=qJKDzgnW5w6YmHO2M5rSgf4FwprKlutZX1LGQBV/A+MnzFYw9M8FhoUBs/M9D+I9bR
         ocNWzfgyeuP/h3x8K8Pm+901j+s+m7JRAjjte9t3/Zo37xLiK8DFZv3VRg9qb3cqnOFj
         TGghmYGqKmssWYIJVAE5mlyN/MaDTZc2IJC5+5kkbe2kCShNlHOJuwypyezfYgo1prXg
         AiBBkcUG8PePPUvucIRmCIpgP9ph1iHcfzhb0I6GA50IhiMNVV1ngv8lvErAutuWjr39
         iXz+t/OKnUF+IcU5oyaapGVwbb8LMv+S0qWJJBc/nWA8D8IFjJ3Jf+90FFmbs92uGmQ2
         q8GQ==
X-Gm-Message-State: AOAM531Hk5sukHBoJ4GJQtK/WNlswJKlsob7nqM5Qm9CPHjN876MFmjd
        PK8WpDUuqvNoevmoESE+h9uXzLYErQ==
X-Google-Smtp-Source: ABdhPJwFLlxOzFRm3zYN+pfdVaQQ14/wpp5IKt/Iov6tYmXs3jpaO5Ajn67yFNmbIkCe3meGlR22Rg==
X-Received: by 2002:a17:902:d2c1:b0:165:d4cd:e118 with SMTP id n1-20020a170902d2c100b00165d4cde118mr54076180plc.4.1655016058351;
        Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000a0a00b0051c157f83e3sm2691628pfh.96.2022.06.11.23.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     Ramesh.Errabolu@amd.com, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sunliming@kylinos.cn, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdkfd: Add missing #if defined(CONFIG_HSA_AMD_P2P)
Date:   Sun, 12 Jun 2022 14:40:50 +0800
Message-Id: <20220612064050.1175083-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'i' in function kfd_dev_create_p2p_links is only used in
codes that gaurded by '#if defined(CONFIG_HSA_AMD_P2P)' check. So adding
CONFIG_HSA_AMD_P2P #ifdef check around variable 'i' too.

Fixes the following w1 warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11: warning: variable 'i' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 304322ac39e6..4bfce71f7fa9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1539,7 +1539,10 @@ static int kfd_dev_create_p2p_links(void)
 {
 	struct kfd_topology_device *dev;
 	struct kfd_topology_device *new_dev;
-	uint32_t i, k;
+	uint32_t k;
+#if defined(CONFIG_HSA_AMD_P2P)
+	uint32_t i = 0;
+#endif
 	int ret = 0;
 
 	k = 0;
@@ -1553,7 +1556,6 @@ static int kfd_dev_create_p2p_links(void)
 		return 0;
 
 	k--;
-	i = 0;
 
 	/* create in-direct links */
 	ret = kfd_create_indirect_link_prop(new_dev, k);
-- 
2.25.1

