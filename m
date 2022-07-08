Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8219256B027
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiGHBpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiGHBpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:45:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC7229821
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:44:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a15so22278874pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 18:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYkTz9x9VUJaLH+xBYwYdGx5P5J7JR2QlJUwNImcUNc=;
        b=aUuG+j1nS2xHGHrnk+Si61wPRhLQGcIZFUaN3yxiykuoYgH6Y2GH+mQkhhoBgBofsP
         e2CJaH7TJtROqj60+gnLPqYNzUJj1tyjDNjdSQ9LjLyzS+9DZASmBHdzzEQ3laqsKn61
         KCfzxph1z4tQE51sro0sJa7l6XrVVjext86xbexhcFVa9UPkkrIS/RE28XsdcVhm1UWV
         kuDXx5OFDmv+SOeernHly3cXd4UZINaFO35uLzArkhuuNY4PS4yECp5lmnEe9GRVXBHs
         2h+iOdzthLJ+xRydcwrhHoV4CFTl0XJRL9WyWOI0OJrv2psKNlSTz2tnglHTAKbXE0MD
         LgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYkTz9x9VUJaLH+xBYwYdGx5P5J7JR2QlJUwNImcUNc=;
        b=YyPtrDdGKOZFlQgMQGpEI47RZc2L9tP3oUf5C4bqXHw7Qzjcjpcn6bD3YwyPW293PU
         VFI5WlFYo8xV2vTBkqcrSIZSquaXzeX4kHeyOIF72mmmuXGbHIi/Kcp9Zpou8j1MpBKc
         I98vgyRwHnmyOFxgfzk3fkNS0yAZARlbQKMMkBycxV5Q0EWgwL3BBI8UHbkwJrKLOtqU
         C/mzwYzcmPPvgrSvhV3CfrCoGrvupgnc+KwgSm5bAOqg6BqeZSF9i6eaMaz8OeM7VQMk
         0g32vcREccfMUQim9N1km19pooqHxmlEyu1wE5FytUGT9lFLxGYJQrTgiy1HI4MiZ8aL
         2IrA==
X-Gm-Message-State: AJIora8RJ4//jchNw6dxxz6Ru5mCg/u+e+1tBBuGVsFMkqOQ3KMt5+1d
        r3M0AUCbSn5eVlHGEqkqz4Q=
X-Google-Smtp-Source: AGRyM1vBf0nppZ2iuKetbcWi0B4czZZad3GGeqXIQMBZRdrjZ7ZM7GLVOyNoraqoSqPbY0e+cmeO7w==
X-Received: by 2002:a63:7443:0:b0:40c:5a6e:3acf with SMTP id e3-20020a637443000000b0040c5a6e3acfmr928127pgn.557.1657244699271;
        Thu, 07 Jul 2022 18:44:59 -0700 (PDT)
Received: from localhost.localdomain ([122.162.197.95])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b0016beba9c3e6sm8629884plg.115.2022.07.07.18.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 18:44:58 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, tzimmermann@suse.de, nicholas.kazlauskas@amd.com,
        Jimmy.Kizito@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] drm/amd/display: Remove duplicate header.
Date:   Fri,  8 Jul 2022 07:14:34 +0530
Message-Id: <20220708014434.7513-1-jrdr.linux@gmail.com>
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

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

kernel test robot throws below warning ->

includecheck warnings: (new ones prefixed by >>)
 >> drivers/gpu/drm/amd/display/dc/os_types.h:
drm/drm_print.h is included more than once.

Remove duplicate header.

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 795dd486b6d6..6b88ae14f1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -39,8 +39,6 @@
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_print.h>
 
-#include <drm/drm_print.h>
-
 #include "cgs_common.h"
 
 #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
-- 
2.25.1

