Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357D94884BF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiAHQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiAHQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:58:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B03AC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 08:58:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s1so17639852wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 08:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwgudjBV0Q9OuU6LjxXGZNHz2djTQPX0z94x7AWMsDs=;
        b=J7zpwWts951P7cyFXIO9rZFBy3Jb5BbE1wlNjj9t+NS+mkA59d/Mz5SwppBGR1Lw5J
         Xccku4xvzLCUOqaRCojDZK/fu+lRqAHRkE1s2vZFl9aMSkLlOJ+K4UmtLdUXbRKBtl/R
         R2ruWAmGnGf52ttJpG98KcES0Q2w9qoeVZXe+0iGSVpr5KqhakudbKhVvTZglPkNkOSY
         +iHChFEU0Xg9L5E9MV+sypvy5gBwTgd3MIeQad7f9cevtGycBZxdXQePvfOsSu9wGLvY
         ByDWVOi8DZ9zmZRwFYQYxcWPEwXioARQx07GkUJchmRi0qgzcTTPKqUR4GF8paGs8OdK
         kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwgudjBV0Q9OuU6LjxXGZNHz2djTQPX0z94x7AWMsDs=;
        b=PNodK7MZQIQKTGD1ZqDWACOumXO/P5iygwI0a63F6/BiPihJECXDQEls2wMOFDVjtq
         2TzgplNhUqbvHJ1M3T0/26gGfymTXMstV6elCS7TwjBWzz2E4TUax5fxeggEr9C66mkQ
         vQLbQpbAZ1ybyVhrtdycTZlwZ1cssK/nTnX8iXi5oZJ5g7uZzRJ7ds1QPgbZiYd+zl8F
         yIowtf1YwbjaS4H/e3rCWWMGYWWNVItHfnpCsINVbpA+HnUpOeX/dMj+gDJwd+m2Q+bo
         xliJv4DRQpsM/0hGOu7+fDArqkr/XLZ48cyOiBZTMEqlc1GuENpgbIuzNgzee22+1ojB
         h9gg==
X-Gm-Message-State: AOAM532HGlpih96kWqBQ1mg+GZ7NNe6/U1fHmGO8E2ct/CIpw41bSE9F
        Fx9GnFuA0NhxvEU+OaGfSoAeX9VCin9FdQ==
X-Google-Smtp-Source: ABdhPJwdNd7qRP1YLQiy8gs11DzHwPv1yjxGoy0OLq6yk4KX6pMbvSP854cGBp+9mxPevIN78My9+A==
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr59243951wrz.261.1641661097073;
        Sat, 08 Jan 2022 08:58:17 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id y8sm2219513wrd.10.2022.01.08.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:58:16 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] drm/selftests/test-drm_dp_mst_helper: Fix memory leak in sideband_msg_req_encode_decode
Date:   Sat,  8 Jan 2022 17:58:12 +0100
Message-Id: <20220108165812.46797-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid leaking the "out" variable if it is not possible to allocate
the "txmsg" variable.

Fixes: 09234b88ef55 ("drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap")
Addresses-Coverity-ID: 1475685 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Improve commit message
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

