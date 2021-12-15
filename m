Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDDD47606F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbhLOSOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbhLOSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:14:17 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969CC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=wsq8cUBFjzgYgnMDS2RJHFOuvoD7tYl9ctoDcV6S2XU=; b=ma
        VHM7jnW3jr4hNhZHkDvbhYleitth2sQiAk9MQr4S21BANoKCUezlSV2fxfYr3Bxz+Lb3ETG6oFk76
        HRmLtccR3HooekJURkDGWIw6c+GSNADF8zBWZra7N9Mdxx9SgruBVu4nTIsaFBwdzm8gLPAdnqiLm
        PQeIyY69c7Zvex5/fSBnxfk02Zppy+OUgrQcIvmQyYJwFXCdlaOeO7G6mmaeOxsznh1Mp8tI+K8QV
        mh7e4n5xbv0n3NVvzkc7IyxmESBXtYyv14G8vcQVtqkN77EsAt2QP3Zg331QvenUtq8w+53T5+D/H
        1RueANeVYxJFgafLegyqTDY2wkvs41UQ==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mxYmz-0001lA-Au; Wed, 15 Dec 2021 18:14:05 +0000
From:   John Keeping <john@metanate.com>
To:     dri-devel@lists.freedesktop.org
Cc:     John Keeping <john@metanate.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop: duplicate subclassed state variables
Date:   Wed, 15 Dec 2021 18:13:58 +0000
Message-Id: <20211215181358.2950649-1-john@metanate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicating the CRTC state should copy all of the fields in the
subclassed state as well as the base state.  Switch to kmemdup to cover
all of these (which are all simple variables).

Most of the state variables are only used for .atomic_enable where they
will have been set in the initial check, and enable_afbc is always set
in the preceding .atomic_check, so the only issue here is inspecting the
state later when these field end up no longer reflecting what has been
programmed in the hardware.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f3975905599b..0efd79be8f3b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1552,7 +1552,7 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct rockchip_crtc_state *rockchip_state;
 
-	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	rockchip_state = kmemdup(crtc->state, sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
 
-- 
2.34.1

