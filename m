Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7D46DED2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbhLHXGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhLHXGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:06:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC7C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 15:02:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so6665768wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 15:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BO9nbrCqEDiSGWCUM5cTLwYHN/IOtl/sVUgALANPl0E=;
        b=qeCe964S7RjGD6PpPajxIZxCX8xfhqHb0es4v1b0LkIlutlBu8RTJp/9mhxjCjqGxv
         BKqdLrcezudsgERmC5Em3S7GPcq74AlNVf8ryeuhR8Q/dnTfuWnii+5DqxdWYMO6kcbo
         WYNYfEGox6PAZ/Ronf8geqC7zniIfXi6fWbMPV78fvvpQe6Ru14nfqpFPTX6OH6+OiTB
         K5zEoLkJ4GBoTc8Ez7jceGnHSohYuZJKE+uiFF5HdOSAQruwFZ8PG07TIG1UXEJS0vub
         IxxOTf+gRtjjC60i9u5Tf9OT9t9kfUHbS7EN7zVAConFDLwD7377JVlb+E6pKDsE2pqz
         8uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BO9nbrCqEDiSGWCUM5cTLwYHN/IOtl/sVUgALANPl0E=;
        b=oB/5ErfSWGooYcJOALOmKjygoDIJ/IP27lk0gFQvYH0q2PicgAqOguSeV8PJtwaivq
         mk5/GLm2EdC02JM6Vy2WXGgM4sOZEWiDcAxzk42ok00zuo40MR6lrsvN/sGMmEI9fjTB
         LBAx7KzVWC9HKHaGD/gsF8F029cTMUkBPJ1Lw3yQKV5RIORss2ShQHWNUgS7+eeT6paw
         qyMZPMGlRkdR6jKGSg7znZqXnGMBk2tHcDhKkzMIUjKNb2sf0D7tJTh5IJ9XU0LSUQQd
         VfIT6r8BRpBY9l4ej95cV+FH1bIS/ZV9d0ddFJyQl9b9ADzWbt//KkuMwzxFiJPLL+NI
         8N7Q==
X-Gm-Message-State: AOAM530gag5BUG3GDZPkNRPNvyOoild8dIWB3iuFd1XJ03gOO2RHql2H
        cBwT4a2tDg1LLwSujd2//Ko=
X-Google-Smtp-Source: ABdhPJy69Ek9fK5A5upGrRrqH5buKwRKgOq1FazUbo/B+CY9FooPqU8wpL0dBIvx0DgttEKtUlj5Cw==
X-Received: by 2002:adf:f151:: with SMTP id y17mr1910804wro.153.1639004565485;
        Wed, 08 Dec 2021 15:02:45 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id j8sm3733795wrh.16.2021.12.08.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:02:45 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/selftests/test-drm_dp_mst_helper: Fix memory leak in sideband_msg_req_encode_decode
Date:   Thu,  9 Dec 2021 00:02:38 +0100
Message-Id: <20211208230238.24541-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 09234b88ef55 ("drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap")
Addresses-Coverity-ID: 1475685 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..c491429f1a02 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -131,8 +131,10 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 		return false;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
-	if (!txmsg)
+	if (!txmsg) {
+		kfree(out);
 		return false;
+	}
 
 	drm_dp_encode_sideband_req(in, txmsg);
 	ret = drm_dp_decode_sideband_req(txmsg, out);
-- 
2.25.1

