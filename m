Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DBC4A9259
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356635AbiBDCg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiBDCg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:36:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD4C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 18:36:57 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z131so3848771pgz.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 18:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fvgDP0TYA9Uqj5YBQvKBYTNhHlt3ZEDwRBizbD22wQ=;
        b=jhz0XailvBor/LX2Yz5XHonjexoUmussH+CEZZuTvmefJULpgg9mKoLxdKEhmgMb0U
         whxizg5ROUhedEYv3RtW4MUXeYtSuln4QigVN4zVVUTVv0LM4JrL0Pv/qMLZSrhJ6BLy
         Kb9nmvaZ+fVuC03o65rE8apnro5ClGj96h/PdwSgkSnBkYt8j34oJsPqeh0NO+nMfMix
         zbOLyet2WUrhXINJfAjp8NQ7CS3MhyAF4ldg1U24kYdV+kLxhncZeZiciBMUlKx/Bkku
         Fx/KwkUqY1qVasI24hb8hAPeSpt308h6QJg1CVWcnYFimvD42a3tqIhx3IpNUVU0YWDY
         CgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fvgDP0TYA9Uqj5YBQvKBYTNhHlt3ZEDwRBizbD22wQ=;
        b=bURHWOoxxDiZkwZqVwSh65aSgHoblLHGC2tIzDhYbBeen2q57NLwoC0zhbAPkG8nhe
         DWOs+pXd8KZuAgesgzVihiCsDHayYIG+bg8zTE8JyBh8aZZJz5hBuPFC1LsDsZTpqAoY
         oyWvBMBqosGRr2onZTMUCivnNwNauNJaYNCovV2EJH+NVIEVQY9HezUEOvQv2y82zif1
         sbwvDjko01JokMX5vp9Z0oGRSNVEneCETvoSID03pHCUWnde3hHRYhuRB0G57qFJJ7Ay
         LLydDCA37HndCQGXJunwyZMFWvkBJuo6f1jPbhbiJQWv6VZGJmGaMSFLitBUIUq40AAh
         m4HQ==
X-Gm-Message-State: AOAM530gUlx8K++6qCijK4F5ZRMEUJPjWPnffC2fgMq33luFxeEGUFSb
        UAEstNwPBTsuls3bwz1KJX/i9Q==
X-Google-Smtp-Source: ABdhPJxne2+hw31JZKM79eXKyu3bQhK0EUUnkvnzqUXoHRlqHJqV1qL+JhRQg8WAl9TOlQ5lSf/MLA==
X-Received: by 2002:a63:ed10:: with SMTP id d16mr756931pgi.17.1643942217191;
        Thu, 03 Feb 2022 18:36:57 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p21sm351507pfh.89.2022.02.03.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 18:36:56 -0800 (PST)
From:   Tomohito Esaki <etom@igel.co.jp>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Tang <kevin3.tang@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Tomohito Esaki <etom@igel.co.jp>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/sprd: remove allow_fb_modifiers setting
Date:   Fri,  4 Feb 2022 11:36:35 +0900
Message-Id: <20220204023635.15496-1-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove allow_fb_modifiers setting in this driver. The allow_fb_modifiers
flag was removed.

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
Fixes: 3d082157a242 ("drm: remove allow_fb_modifiers")
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/sprd/sprd_drm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d721..54c851bccf5b 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -43,7 +43,6 @@ static void sprd_drm_mode_config_init(struct drm_device *drm)
 	drm->mode_config.min_height = 0;
 	drm->mode_config.max_width = 8192;
 	drm->mode_config.max_height = 8192;
-	drm->mode_config.allow_fb_modifiers = true;
 
 	drm->mode_config.funcs = &sprd_drm_mode_config_funcs;
 	drm->mode_config.helper_private = &sprd_drm_mode_config_helper;
-- 
2.17.1

