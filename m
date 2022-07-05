Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4154567561
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiGERRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiGERRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:17:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ECC1EEE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:17:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fz10so6715428pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blAv5bNRDxMQMrS0AACBNjdGlLvJX/SAvF1rEGuKF74=;
        b=AGx18rMcbp3dbF9psnpNSEtcdc9eRh8u0rb5xSOzE+z6FdcO7YJ0n7cRUuYgSvkipF
         NwYdtnIXdzBSsr2goKB2mnkw3W0xQdP7JnIEeX24+jZNviiKCNdORnVuBEuRMHhW1U0r
         8pAArYvRSCZqGIfBwZzkaI3m3xBJjs811aK6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blAv5bNRDxMQMrS0AACBNjdGlLvJX/SAvF1rEGuKF74=;
        b=ueti/CXg9p3lYCw1sbPSZLxogbMgyWTi+fx9uUrRP780heWrbD10GTlNFBn+XNx5FT
         2noB1NKV9r6ibVt+kgZNjjvSwtG1OuAY79OWZAZxiOIrjKaE65KUhpFwLa+pzdumr1J/
         9NyJ5fl4vRsqDysGCwzaTwb3olRmMDswJkM+eMVtkf0XD0H24FJckcdDUV2XadcI9B7O
         CoQpL2cM5s6YK/G9uRJfs4Pq+46bhFJy4KaDAZrx44yVbl2tKIfuN7ESG3ctTwEnvWby
         UaTVarpXJxga6BTp2DXo/nsAzk3Ztt9wKIKSpeBs7PpcqSl5ILm5H2GhFXnO7Bx4B/qQ
         7f4w==
X-Gm-Message-State: AJIora+qPuxoFedqeEgtqAhBSBpbhDCRkRVb9GD34upGFz79ShvthEbV
        EA9jwcI//8e1CDtVypH5nyoxAeXxhVmzHA==
X-Google-Smtp-Source: AGRyM1vOsmzdhrBc9QLvJCCkypT+YyW8d5stgSoMcetKE/ubV4xKYE1JgNPv5dGhIwSEXz3dP7+2Sw==
X-Received: by 2002:a17:902:b488:b0:16a:7013:69f0 with SMTP id y8-20020a170902b48800b0016a701369f0mr43725754plr.118.1657041420084;
        Tue, 05 Jul 2022 10:17:00 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:2dd7:54e9:d5d6:cad6])
        by smtp.gmail.com with ESMTPSA id k11-20020a6555cb000000b0040d87299ca3sm22452843pgs.54.2022.07.05.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:16:59 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: domains: Ensure genpd_debugfs_dir exists before remove
Date:   Wed,  6 Jul 2022 01:16:49 +0800
Message-Id: <20220705171649.969194-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both genpd_debug_add() and genpd_debug_remove() may be called
indirectly by other drivers while genpd_debugfs_dir is not yet
set. For example, drivers can call pm_genpd_init() in probe or
pm_genpd_init() in probe fail/cleanup path:

pm_genpd_init()
 --> genpd_debug_add()

pm_genpd_remove()
 --> genpd_remove()
   --> genpd_debug_remove()

At this time, genpd_debug_init() may not yet be called.

genpd_debug_add() checks that if genpd_debugfs_dir is NULL, it
will return directly. Make sure this is also checked
in pm_genpd_remove(), otherwise components under debugfs root
which has the same name as other components under pm_genpd may
be accidentally removed, since NULL represents debugfs root.

Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2: Add more context in commit message
---
 drivers/base/power/domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3e86772d5fac5..5a2e0232862e0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
 {
 	struct dentry *d;
 
+	if (!genpd_debugfs_dir)
+		return;
+
 	d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
 	debugfs_remove(d);
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

