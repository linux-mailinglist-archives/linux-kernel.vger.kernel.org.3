Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0FB527E72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiEPHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiEPHTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:19:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E713E2D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:19:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k16so6504861pff.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qyLHbvhHFnCVFcl2COEIHo1ekgk1vr9Xt9RbCWp5UFQ=;
        b=gWZ/uLYoxu/kOyjLksLZcv+dOHRs0RxWiRMgL/e3NTe/zcuWfZE4OwVyRl82B25GPk
         5yxu81Tf/5re2BOnhJ9tM9zb1UjjOUbu8dokeAvyAPhIJ21m4sfR6tPMQEirHKic66IK
         hR+2onUKYpC4USUs2SUPmp1zU+CayVUEpfoighxjx25a1B1z8uNxUu4xr1YM+z7BK2ql
         JM8yKK9hWUSfu6d/b5zUL1k8iselDYAynzv6DFpEOL2O7MvKLWPg85+cbAK7GIupAmAL
         AoEDPl3m4f376euhRP87SKBZ1SFae/y39Jv96okMDaZev7rxI4DHoZAD/W7BE99DmpyO
         AcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qyLHbvhHFnCVFcl2COEIHo1ekgk1vr9Xt9RbCWp5UFQ=;
        b=UFRFeTX52qnAl3tk3U3jOBzRdAu1tDTygUKGyNd8gMWii6U7xzCQHbTvnZvArdpGQI
         6iBvYz3bFPBtrbSXKzzxu22oGDXMIIvxluJJdC9feNxeuPZbRZvDcFElaqEAzPli6l+f
         Q/VgoDkQsgPM2pBE9O+zyqBoxEWNWfcX4eWSzlEfuSHT/iaPn6eq4EVamcV9zJWR31vL
         ZU9nbm0NFVJEe0BmjE61E2ICpSVANU0iUX1Bi4g5peJF6r0L7sr8dm6Lp0Rc4M1vyzFh
         nkuFBrjkhIB3XbuFlZ7bvJHZdCR0b6i8XrMNJ8cdgu8Rj160VcdumRZDzwkOQj7dtzlG
         bPwQ==
X-Gm-Message-State: AOAM5313/3Hu6wj79oQagoxjCunY9hO099POeIwty7aq/4A+xnk8bLL3
        4VX/1D7fC9bMY0UpqrvLeZHN2MAxX2s0SA==
X-Google-Smtp-Source: ABdhPJweiKIlidVaFIASEcdabrwZzHCL4vm7fIHzGiDCKcF8TnRwifNYRCrEeShRqttSrbTd3azeHQ==
X-Received: by 2002:a05:6a00:1c53:b0:50d:5860:5b58 with SMTP id s19-20020a056a001c5300b0050d58605b58mr15944850pfw.85.1652685576873;
        Mon, 16 May 2022 00:19:36 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id z7-20020a170902d54700b0015e8d4eb2e8sm2527500plf.306.2022.05.16.00.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:19:36 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        jose.souza@intel.com, Bhawanpreet.Lakha@amd.com,
        matthew.d.roper@intel.com, heying24@huawei.com,
        anshuman.gupta@intel.com, james.ausmus@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] drm: i915: fix a possible refcount leak in intel_dp_add_mst_connector()
Date:   Mon, 16 May 2022 15:19:22 +0800
Message-Id: <20220516071922.22955-1-hbh25y@gmail.com>
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

If drm_connector_init fails, intel_connector_free will be called to take 
care of proper free. So it is necessary to drop the refcount of port 
before intel_connector_free.

Fixes: 091a4f91942a ("drm/i915: Handle drm-layer errors in intel_dp_add_mst_connector")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index e30e698aa684..f7d46ea3afb9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -841,6 +841,7 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 	ret = drm_connector_init(dev, connector, &intel_dp_mst_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	if (ret) {
+		drm_dp_mst_put_port_malloc(port);
 		intel_connector_free(intel_connector);
 		return NULL;
 	}
-- 
2.25.1

