Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C391527C49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiEPDVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiEPDVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:21:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF519F95
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:21:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so2857678pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpDUSimbrzEPEd3o17+4lNfr+RdsexkUxYvwoe9kHpY=;
        b=GDhlqPSck9+19ik3Lm/u0hqP35Hb8ewA/ihWbx7jo6/1gXcOdZGFtJ6qNk37b3tCDG
         75YQHEwjHW1ZN+gLhtfo1Tq2Dm4yUQbwAtEtS2mw4HSYwz2nZdRijXpY3nVtSjjdzsjn
         N0UOPUDbdKJ4VnVkQeYp/Au63B8n9pUmodp2Q69+xanZwOd/UlHqeyGm/TqMbeQ1wp31
         U/MfQ+x1yz5ATrFThS4Y9x5+pBL4WEeJUCQ67q3XU3gOD9wbAiIdH3SdMauzXwPLourS
         wYts5dagziiVEjjxrpvRA+uupjMCvjlR7lC+rb7+GjOrK6D1Y+HF/X4SRlIJPJaopWyG
         bNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpDUSimbrzEPEd3o17+4lNfr+RdsexkUxYvwoe9kHpY=;
        b=R0+TDQz3jd7NJ/qHcFLBPbKJjFJdbFbnsd7eN1MwrVrD+BQCnu6ExbUWEEmkjBYPFg
         HXzR5X/45NOlEI78uPp214Vqow0e9IlpRPouG0EcVm+Tk+jHDzLy8uxc+QLBxnw6tGkS
         3052uIWSnhda1gHApJD7eoewJ+ft0D9tLAz3bGwbp7YMo65IbXDgS03CpZFTy6RqM955
         ZBUSpRLx3whvPj6LRK77X8IQLyN+/1BOTmXPp1nefAtKtxqjK2AGqySpURa5fsFuVW3+
         JZBIXf2Y2PoS8ue3RZYhOufLyIP0fhRNW7udTKSaPOyLUU30j8+IJF7/PFxuK73ei0DH
         JjLQ==
X-Gm-Message-State: AOAM533D1LTT5deK+vGCrT/rzlZYoHBwA4oajik75RBhcPzke9we47so
        FQrfG6l6DsJpgnpLIoajFqA=
X-Google-Smtp-Source: ABdhPJx78R8siU/VX2wrXmCmzFaypYMY6otsvG0bnoou/lanFR0mXroANYhKF69EHrKcre9eNMwCsQ==
X-Received: by 2002:a17:90a:ba88:b0:1df:4302:4970 with SMTP id t8-20020a17090aba8800b001df43024970mr5159325pjr.227.1652671273709;
        Sun, 15 May 2022 20:21:13 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id y200-20020a6264d1000000b0050dc76281easm5604430pfb.196.2022.05.15.20.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:21:13 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, lyude@redhat.com,
        tzimmermann@suse.de, jani.nikula@intel.com,
        Bhawanpreet.Lakha@amd.com, Wayne.Lin@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] drm: dp: fix a possible memory leak in fetch_monitor_name()
Date:   Mon, 16 May 2022 11:20:42 +0800
Message-Id: <20220516032042.13166-1-hbh25y@gmail.com>
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

drm_dp_mst_get_edid call kmemdup to create mst_edid. So mst_edid need to be
freed after use.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/dp/drm_dp_mst_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/dp/drm_dp_mst_topology.c b/drivers/gpu/drm/dp/drm_dp_mst_topology.c
index 11300b53d24f..7a7cc44686f9 100644
--- a/drivers/gpu/drm/dp/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/dp/drm_dp_mst_topology.c
@@ -4852,6 +4852,7 @@ static void fetch_monitor_name(struct drm_dp_mst_topology_mgr *mgr,
 
 	mst_edid = drm_dp_mst_get_edid(port->connector, mgr, port);
 	drm_edid_get_monitor_name(mst_edid, name, namelen);
+	kfree(mst_edid);
 }
 
 /**
-- 
2.25.1

