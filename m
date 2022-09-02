Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40665AA995
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiIBIMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiIBIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:12:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5A0BD08E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:12:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so4780825pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Sp6uHF5Iwvu00Tbj0ZOEc8ZB60lUbaBAN+8ZZ79Xoug=;
        b=A6F63bK7HuYUTHZh1eppDTtnh1ZFOzfBh3saxCb2SKKPs7fBu3CdSWfk/Arg/V3f7Q
         9SmP4JRE56f0w+5xIrPjQyuqDDSMUd3hlqDaApWjOLNUFIfPT6qDUILmb/+fEdw9MSQG
         F2ZRFaAu95IQ4ueeHQRzV3Ae6WHh6oionqyVy3mJnE8LIXcw+ZJhNmXsLh2GOTrrQlXu
         bd+ub7Rb/AptqI+yxDlkIcIjPeceWNocciUkVHoOXWXGJksMyJGmEiDFpTi7INytCBRw
         hRmhzEXnyH7d534du13VS6TJ/tQNzFdB1DPubpm0uOXpy09qOaYNmLON4qH5glrWFYb+
         8ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Sp6uHF5Iwvu00Tbj0ZOEc8ZB60lUbaBAN+8ZZ79Xoug=;
        b=sgIcHEkYRh0e8Mpa1F7HS6xi0Jr6Va3QbmSBKTrcNnEmmmMMvcB1Rd3GcVUMVThIrE
         o3BRDbSoYc2kvROmUmQeFTNhzL+Wx2wDPyr2eqNcx5f23lp0dCI6rGY7c8sf8v2ZgoaC
         fJ4qFk7J1T35rz+WBKUs1AkWVHO3tAYGK/UT3bX9+67otGHSIcKoSMwD3U6PqMgkk/FO
         o2MG3ksqT3d3TJPDT2ou4EiQIJRcgx2WBo3PJdvxk/gtK5dQWWYiP1l4I4vT6Oi/nOhw
         lDk+Erj2Td44iGZhloiTUlBr/xTAP6+TpyXmbrIzQ7Y4j81ws2JgedgNOSpLphCkCLXK
         MtHQ==
X-Gm-Message-State: ACgBeo2DEZN8bFwqqXhrkUwkGtFQd/2fYnX/DYtGYM8ALJAdFmTYeDaO
        XJt9P5kZZ/HKMfon4JDMUnk=
X-Google-Smtp-Source: AA6agR7tT9ErYh2E5Np94U1vZlfLy+m04TJYCSxWQ5NWkn48/4IAiJ5neS7k/0wnjmYs8aHsR23Jqw==
X-Received: by 2002:a17:902:d509:b0:16f:1e1:2063 with SMTP id b9-20020a170902d50900b0016f01e12063mr34155758plg.131.1662106330062;
        Fri, 02 Sep 2022 01:12:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b0017550eaa3eesm978052plg.71.2022.09.02.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:12:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, lyude@redhat.com,
        tzimmermann@suse.de, imre.deak@intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/dp_helper: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 08:12:03 +0000
Message-Id: <20220902081203.320165-1-zhang.songyi@zte.com.cn>
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

From: zhang songyi <zhang.songyi@zte.com.cn>

Return the drm_dp_dpcd_writeb() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 92990a3d577a..09b282b704fa 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2925,16 +2925,13 @@ EXPORT_SYMBOL(drm_dp_get_pcon_max_frl_bw);
  */
 int drm_dp_pcon_frl_prepare(struct drm_dp_aux *aux, bool enable_frl_ready_hpd)
 {
-	int ret;
 	u8 buf = DP_PCON_ENABLE_SOURCE_CTL_MODE |
 		 DP_PCON_ENABLE_LINK_FRL_MODE;
 
 	if (enable_frl_ready_hpd)
 		buf |= DP_PCON_ENABLE_HPD_READY;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
-
-	return ret;
+	return drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
 }
 EXPORT_SYMBOL(drm_dp_pcon_frl_prepare);
 
-- 
2.25.1


