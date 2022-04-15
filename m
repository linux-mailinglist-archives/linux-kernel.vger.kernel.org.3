Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792E502B90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354322AbiDOOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354321AbiDOOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:16:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3384CEE2D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:13:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w127so8479945oig.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7gbuOQcgVegOGgriZZtIkm8aICEvz3iCExryeuJnKc=;
        b=GvaYw9m9uZIuDmPB083S//D9z0YL2IzNOcCjm1pVtXOpEFOGXRHx+X57H1kiE59Nzb
         mP3GZU2c9czB//al48ZD4CELtIesdvPQrHTEj39DcZ3Eg7aMjW9iSZfnDzDVL/GdO0KG
         dNEHYTdI+4FX8KZ2SHSyqFy22CNQElYK1QbyBOaDESe/WJob8lGxEtc5r8rygJKiO3dr
         d/uKgtDagblI5ITRTB+4lac6E00qMJi9B0pOcNpzs4Lj9/hhov/MO8c0QCFVDMIOD27N
         xg11F34GLhQ2KnTp9NsVqgLJNqBe+a1+NCL71tdl7ueYhCe4bTLsms4oiEjNLtBtDdue
         GEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7gbuOQcgVegOGgriZZtIkm8aICEvz3iCExryeuJnKc=;
        b=rc7fjp1ifRDHLEeUrR+aLIQSsN6DjuQuu8b3OERdSXPS+iOr/1NBdVamnsgu5fqAtd
         A+u/kA+Zw8h+MOIRvvdJifu+u2qw4hEjPo60a9e+50nIhfu6juSg7uUSFW8+n37xR2zS
         4q0YRZsY0kj83Y+NkgJU2+vyjZUHPyvgOrNCMGvoeamRj/Lc3+ufQRBM1zCCwPzU/6XP
         95Q3WB59f7iNTK8V/Ir7qhC00mojtORcjaJrZHgTe3/xwx3WskygFOJ8i6Sl+gRSa6tR
         maV+lCG2ALu1CIwwwYmKoh2j5J936syFqfHSPDQ/gjxdb5v5N4ReyvlaKnB03U/cZ9Wp
         UVPw==
X-Gm-Message-State: AOAM5309Ao3mFqbloemlV9TXt+FnspwxKoPxSudSZuhBUby1lsDhu1TB
        iajVQhNo50MEUSN21cLyd6s=
X-Google-Smtp-Source: ABdhPJzmxuaSXWI7XfG/E+TLAHkj5AZu4f7ORrcmrqNx258nm0FlTJZYTbFYr++Yr4QtStSKgW7fIQ==
X-Received: by 2002:a05:6808:198c:b0:2f9:f118:9775 with SMTP id bj12-20020a056808198c00b002f9f1189775mr1627650oib.79.1650032038769;
        Fri, 15 Apr 2022 07:13:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm1156189oov.3.2022.04.15.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:13:58 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH v2 1/2] drm/vkms: check plane_composer->map[0] before using it
Date:   Fri, 15 Apr 2022 08:12:59 -0300
Message-Id: <20220415111300.61013-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415111300.61013-1-tales.aparecida@gmail.com>
References: <20220415111300.61013-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a copypasta error. The caller of compose_plane() already checks
primary_composer->map. In contrast, plane_composer->map is never
verified here before handling.

Fixes: 7938f4218168 ("dma-buf-map: Rename to iosys-map")
Reviewed-by: André Almeida <andrealmeid@riseup.net>
Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
---
v2: detail the commit message with more information

 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index c6a1036bf2ea..b47ac170108c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -157,7 +157,7 @@ static void compose_plane(struct vkms_composer *primary_composer,
 	void *vaddr;
 	void (*pixel_blend)(const u8 *p_src, u8 *p_dst);
 
-	if (WARN_ON(iosys_map_is_null(&primary_composer->map[0])))
+	if (WARN_ON(iosys_map_is_null(&plane_composer->map[0])))
 		return;
 
 	vaddr = plane_composer->map[0].vaddr;
-- 
2.35.1

