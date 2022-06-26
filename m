Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDDA55B26E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiFZOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiFZOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49EA5F5BB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656253268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ahf2yCApAVRKZIV4QgwQyLJ3X4VNm/eYrF4Rb3afHBs=;
        b=Qu/pwwpYTojMoVlTxOw8clwcq1wFxp4jA8rjXJLgEC8EfQXR/WrWib7moGfYSmAuHL0s1X
        VL8KRf90VeibRMjC4LnBzA+O6ywZPdf0FaWewdGeaHQ7egRZVc7RA8ungWw9r9yRTB/8lI
        4F88EsJHdFOyG5S6RFHFnPSYzrIdrHI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-lFdc5I9hP3agfcEcB092qg-1; Sun, 26 Jun 2022 10:21:05 -0400
X-MC-Unique: lFdc5I9hP3agfcEcB092qg-1
Received: by mail-qk1-f200.google.com with SMTP id w16-20020a376210000000b006af059b17b7so6966880qkb.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahf2yCApAVRKZIV4QgwQyLJ3X4VNm/eYrF4Rb3afHBs=;
        b=lHJcx0KVqI2G0im5Fp911FE3icYAFh9pV6J1CHKdhkwFXKEz8lcedaHgg90i++mjUg
         rVNISfIAtwturMKFevY43IBCsVLMbEuYjphI1KtXtw2CxipY/CPe0W+jrRMxdxzqlVvg
         elTRWKWLw2pCn/9/wIB/JhXxN4aOHgBt4bPTYENn0v0uZcz6n8duayhyIRxJHDwVfXh6
         8KyL1n4Hmv2QpNDVXqg4DnZNljQsc2u07/uesKd7aDfFffcgLGoP5u+4F9G9F9y4fY6n
         oM0++5BVYejNm4QqYDn2c5AlmAE+dLwps8YgWu+2xgZSnk6MnTwBLln9IYlTqotcjWx0
         00Og==
X-Gm-Message-State: AJIora8hubmwQUVKPi9kyBo3O8apUm8RnZ0OeIp0JmdvAc4BE8zfOiJU
        45iPfLAAogBaOeliOKLlTlaEkOPrENUBtPH5OqVwdltVjyjWZ7XEc3rTpf+EauUp0DYxDP7Nr8g
        DpRs3uftIvKOECZa+rz0Ovhc/
X-Received: by 2002:a05:620a:471f:b0:6a6:f574:8b78 with SMTP id bs31-20020a05620a471f00b006a6f5748b78mr5486445qkb.469.1656253264869;
        Sun, 26 Jun 2022 07:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1taraKCxi2XWY8/KIXCz5Sr4ylSIyPsZkkuTt119Zkfdt3zbyYiMOzX4TAVcI2CZmI4Sd2wRg==
X-Received: by 2002:a05:620a:471f:b0:6a6:f574:8b78 with SMTP id bs31-20020a05620a471f00b006a6f5748b78mr5486420qkb.469.1656253264652;
        Sun, 26 Jun 2022 07:21:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006aef641865esm6399256qkp.128.2022.06.26.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:21:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, wenjing.liu@amd.com, Jun.Lei@amd.com,
        George.Shen@amd.com, Jimmy.Kizito@amd.com, Jerry.Zuo@amd.com,
        michael.strauss@amd.com, aurabindo.pillai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: Remove unused globals FORCE_RATE and FORCE_LANE_COUNT
Date:   Sun, 26 Jun 2022 10:20:53 -0400
Message-Id: <20220626142053.3373970-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3885:6: warning: symbol 'FORCE_RATE' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3886:10: warning: symbol 'FORCE_LANE_COUNT' was not declared. Should it be static?

Neither of thse variables is used in dc_link_dp.c.  Reviewing the commit listed in
the fixes tag shows neither was used in the original patch.  So remove them.

Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index be1dcb0a2a06..f3421f2bd52e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3882,9 +3882,6 @@ static bool decide_mst_link_settings(const struct dc_link *link, struct dc_link_
 	return true;
 }
 
-bool FORCE_RATE = false;
-uint32_t FORCE_LANE_COUNT = 0;
-
 void decide_link_settings(struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting)
 {
-- 
2.27.0

