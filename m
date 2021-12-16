Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71066477B56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbhLPSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhLPSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:14:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F200C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:14:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e5so12296619wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtPwtxAGo9FP3gqEMBTVlal35wg1gkU0IMdnXpO1YIY=;
        b=qPbvgBnB4Ps57YXOlUBT8THBHb9B9I4bIU6U2FfUOm+I5+8mjWKtM8y3/i8yuyZyog
         J4yM5rHmm/8q21PBUrpaM3URNXuR/hOMfWqc+3kC1jTdD6y6aeTzZQtedjkJafR/TYgB
         uZjtBpHUsNmSLeaYzgo5AmV60nU/8TjN14/FMYF8Y1wAzTr1a4byeNTa2uSdJ1Vli+xT
         N/kwXcY1YbzbDqrsNc7wOY6h8AIpF90W9jYCVQsyNDi1Ua/Y1675jiKsLCd9WDClpTyr
         03so3LEtGnxH3odnx3Hm4KfhsUlk8dZejgeUXt9SbGHm9BBAhgs//iDrTtnF4vg6ZWJf
         mJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtPwtxAGo9FP3gqEMBTVlal35wg1gkU0IMdnXpO1YIY=;
        b=R3qz5daeGZZ0Cvobfz2yVhkjPNUTFelOKdepf7vk/pbysJ5y7V6eBSaSMkxM7aPNZ8
         3INbvMHO7Me+GfH4lGX163PKaTwqHNkPcyP2ksjtZ5P79kXCBlPYa+p5jZXBv9icZL/2
         XsohF+iwDDH2t4Vxk1OKVt4S8iq3kcmLitPBgx+rngXuIVqSN/kmPWmv46YdZRJD1Jxf
         3OLCm9SsiafsN0uKk8FqicMwW6qxtSV18aaGbwbtkty6+luI98EOEbVnzc81Vl/o9cLc
         YNXVs9CbbFYW36S59lkmtlM/w1//jFHl03YiURJVSPFyxk+bzCTbsSayWRDHyHCc7vJ/
         3mIg==
X-Gm-Message-State: AOAM533XsWuNTu/eUmRFk4nhzLk9J5DK4UfUVBn0eGC9G9QDIL36BTGm
        a92ODAj+yQNygtx7liLwmmw=
X-Google-Smtp-Source: ABdhPJxR7WLvfsS72q/POLmYuOdmDhvLzYXlsceQLGweFVHzBWLm83PVrHJScIusJdPU3OF0Y7gT+w==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr1694049wrr.465.1639678492922;
        Thu, 16 Dec 2021 10:14:52 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id p14sm8325293wms.29.2021.12.16.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:14:52 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, charlene.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/amd/display: fix dereference before NULL check
Date:   Thu, 16 Dec 2021 19:14:43 +0100
Message-Id: <20211216181443.38155-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "plane_state" pointer was access before checking if it was NULL.

Avoid a possible NULL pointer dereference by accessing the plane
address after the check.

Addresses-Coverity-ID: 1474582 ("Dereference before null check")
Fixes: 3f68c01be9a22 ("drm/amd/display: add cyan_skillfish display support")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index cfd09b3f705e..fe22530242d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -134,11 +134,12 @@ void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 	PHYSICAL_ADDRESS_LOC addr;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dce_hwseq *hws = dc->hwseq;
-	struct dc_plane_address uma = plane_state->address;
+	struct dc_plane_address uma;
 
 	if (plane_state == NULL)
 		return;
 
+	uma = plane_state->address;
 	addr_patched = patch_address_for_sbs_tb_stereo(pipe_ctx, &addr);
 
 	plane_address_in_gpu_space_to_uma(hws, &uma);
-- 
2.25.1

