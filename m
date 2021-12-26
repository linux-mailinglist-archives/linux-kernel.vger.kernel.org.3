Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B76347F687
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhLZLQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhLZLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:16:21 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D69C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:16:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t26so26466441wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jj3k2tDdeSx/BsoBelPrwmrWZexaJcdDyDAY1RR5zAQ=;
        b=YZpU3OBfpN/+symJnUmZtabhMa/pjVcHwcM4xC33+hHJEH7CCm56QMYlLUFjuVqlVc
         9iUyCYaViXZ3O4u7CZHAWUvdVM4QcaZxudBudY04MLMrQwmlwcWBDxLaMz6VfT01NRbR
         gbGXXSDQpyL0dmKjnUMq8RojQJCA6Ga6WxoYdE4/T3H9KLd34nBrG+AWYxyr8Red6p8a
         545L6pZKDDkIObEs91TBBWEHNspTa2NK1aHQ9LDAyOR+8rHMxslLJdx6Op5ZZoSVFNT/
         YtRtEz3xDz3l4WsmnuDb0yfXaKfDkk783esmpvHemkSzRwbCEkHaaaamdPQbx6+SPYFZ
         hWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jj3k2tDdeSx/BsoBelPrwmrWZexaJcdDyDAY1RR5zAQ=;
        b=ajM7ITq5ZZb/kNN16ACC/Kdy3gBYXUqdJb0vXHLjSvTRcM8crRuXx5RAeVD0ZKYcXz
         qlncjjT9iLheFONAXpWMgyc7WPz/mgDfmYO0LzIBdH0Slgmh+H3l5CK94qHnDWxvtBTV
         Am16wq1+WDjDBruIolo8OxZLM+MqK4U5Tx/4bLikUymjmWczPtJfCGmsiYuVbVZaSX0h
         fdMtsX2Q3Bb7H7zcbpOD9VQUiN5y3UuRUWCQ/7WgbqfnfZByoFlh0K/0xIrFHEpn0euh
         obu/AgwQlNK9DSqytEMnYVplKE447Tu4ma/DZaxhMDRSy54657BogRR9wi4c5zIYgjXW
         EQQw==
X-Gm-Message-State: AOAM532mXd+W5b/NihkmmGZ/n88cb63eGmqKlAMhMzwyORddGc6TRe/s
        /WY9ZrvYtGdagi87NgzbZsc=
X-Google-Smtp-Source: ABdhPJw3XmJrevJy7W+aPh/znb58D6OMM5X1Tn2zxf2cedtzA96DwOGxBfdAYnbPMGpjPPPIa6IV0A==
X-Received: by 2002:adf:ef81:: with SMTP id d1mr9596588wro.132.1640517379728;
        Sun, 26 Dec 2021 03:16:19 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id l14sm6925425wrr.53.2021.12.26.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:16:19 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, charlene.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] drm/amd/display: fix dereference before NULL check
Date:   Sun, 26 Dec 2021 12:16:14 +0100
Message-Id: <20211226111614.30181-1-jose.exposito89@gmail.com>
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

Addresses-Coverity-ID: 1493892 ("Dereference before null check")
Fixes: 3f68c01be9a22 ("drm/amd/display: add cyan_skillfish display support")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

---

v2:

 - Fix coverity report ID

 - Add Reviewed-by tag (thanks to Harry Wentland)
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

