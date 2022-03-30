Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7C4EC93F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbiC3QGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348654AbiC3QGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:06:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C355238D18
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:04:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso255594pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4szRwWNDvZ7XOU+Kmwti8vyES5EGiVgA3+mW2sFThKE=;
        b=eLsot/bdo/qciErnhmm6+zfsN+rYVH36ltRx5tiW0+4htGYOYqrzreVAzgh0AWBGYQ
         IKGw1YxmkNOWs67XoLHeuAK/Sd4CtWKwgkUqFCP28l/OeoYZ2Cw58owdUH61o9P86FmB
         PruF+h7PwadsIiKJ1ro1vak+3ThGapcfw5xrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4szRwWNDvZ7XOU+Kmwti8vyES5EGiVgA3+mW2sFThKE=;
        b=hcOuX+CSTVtCwUDSRV5LSyW7ORN0OLivmueoAGOula/g3ZZprVxqkfxwYtAGcJu1he
         +9eq2LpMNjqIKgqJBCjZtiQsbO2/5C7LKX58JWocsdEtH02FQjfccV2BTygnRBT9J9QM
         ASJVvooutkqQ/SoqF29RchRcBiOwFy5Gc40fcHrbF5UGyVFVOBq2zlbAuXK/x95CEgA/
         x8OlXUCNhbs/doXHj5JH+5sPH2YtlR6WyQqXClUV3fwoN2uc74BF1+kRiiyuVemspMrW
         hLejQfbZ8fobEGZPetkG4QFSnlB1BPFCqX6NcTHjG45DXACKBuEumBuaL5UJYH4txfvk
         X+uw==
X-Gm-Message-State: AOAM530vpHsNeBIKwIopf+Ci/M+BM72dSXfh+o9WiLOhDwAh01f8f9wN
        YNYRamS9+SE/wYEiqMeegYb2h0iEZRTqkQ==
X-Google-Smtp-Source: ABdhPJz4XIzGXVOi8Xi15BEXtGOe7kw6pLeyZ+J75o/J6LblAlRFeoE/gg5n6XnfmlWXYKi/vsKYkQ==
X-Received: by 2002:a17:903:41d0:b0:154:de5:a240 with SMTP id u16-20020a17090341d000b001540de5a240mr350568ple.32.1648656291021;
        Wed, 30 Mar 2022 09:04:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d50d:daac:acf3:cda6])
        by smtp.gmail.com with UTF8SMTPSA id f16-20020a056a00229000b004fabe756ba6sm26268854pfe.54.2022.03.30.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 09:04:50 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] drm/panel-edp: Fix AUO B133UAN01 panel id
Date:   Wed, 30 Mar 2022 09:04:44 -0700
Message-Id: <20220330090435.1.Id1522250dd07a6b574c1cc7826023fc6acd141b4@changeid>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two digits are swapped in the AUO B133UAN01 panel id (0x8495 instead
of 0x8594). This went initially unnoticed because the panel is still
detected, though it is set up with a conservative default timing. Fix
the digit swap.

Fixes: ec57376fba5a ("drm/panel-edp: Add AUO B133UAN01")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index db4eea1d7f67..1732b4f56e38 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1847,7 +1847,7 @@ static const struct panel_delay delay_100_500_e200 = {
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8495, &delay_200_500_e50, "B133UAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
 
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
-- 
2.35.1.1094.g7c7d902a7c-goog

