Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607D949F43F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346732AbiA1HT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiA1HTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:19:55 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:19:54 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e16so4497518qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0l1WhmeXUHVNto/szOni73pQDPwQLfU9rXUEAIxIulo=;
        b=UqE/xve7ob4iUosGLkLnnGanDqYXo2MvlRmysmzpH3702bfDBNuh8UXnKVBDmpU1+o
         ZQLVbgh2TSWrF2lKiG+zjBbxNlE+JIPkKoUn2SnaV9iOUPkn8daiYAcK2evhUG6zIlqo
         5Y4Er/PkrbSTgeFljL+puqSgKg9b9qOT7XOQp+TXPfeDTIGtrCEEdB1oAthBGVKu2KAv
         I2Mj4nWHTncPq8RSKuWLyT7wD3bFqWY8LfbaI5wLs/XDrwZ+vvnUptyxEcuOJPuQUlD3
         5Yivzlw3qqadkeuvx/rzrg6TwbMpLp1H/NLNo6U0T4iTG8eDq4WDfUhjYu4lLzSuIt8K
         cCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0l1WhmeXUHVNto/szOni73pQDPwQLfU9rXUEAIxIulo=;
        b=aznKQQ1fz4IgfDHE4zFpd9nZdmHcbE/7VkY5g5K9uFcDkgnuYPOCQnFPeJTOmoj8H5
         s4p41OUMI5ZojnrZT1y7l+18skgNn+xpX5IRa0cduOpYPjzc8TyZuLa3H7NHUKkttB+R
         6gnVuXypt3PX9zqmfp80WIlYthrj4XXtE5jPUGY+9uBjoB6tYSOyB85Y9Fb2QfG4bUt+
         eRYbwyxpHLJxMmzngMwxdcyMDXwuBUmYMoJOgdtqE8J6L6zCvnPWwHENrNenBatte9ln
         p0CyhZGHMr+Up5dRiTdaRBdYdiGA4CWdAWRPo3Mqt5ZfnJXFD83LdXpmMK7LvNKy6M56
         MlnA==
X-Gm-Message-State: AOAM532Gxbm3xygUbp7EqkGacR7o79WkqBwkP3MT71pzTNggeQQ35cUS
        KXZ+4v18Wy/n+xEoCahSB7w=
X-Google-Smtp-Source: ABdhPJyK6kIpqKiestuok+P9CdtwOtVWZWiqmr32VVy1ITQPs/f3gQ0QrTdwO4N2V+2Dh4gXrO9BoA==
X-Received: by 2002:ac8:7d13:: with SMTP id g19mr5199123qtb.590.1643354394076;
        Thu, 27 Jan 2022 23:19:54 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o21sm2661818qtv.68.2022.01.27.23.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 23:19:53 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     evan.quan@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        lijo.lazar@amd.com, luben.tuikov@amd.com, guchun.chen@amd.com,
        andrey.grodzovsky@amd.com, david.nieto@amd.com,
        darren.powell@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/pm: remove duplicate include in 'arcturus_ppt.c'
Date:   Fri, 28 Jan 2022 07:19:36 +0000
Message-Id: <20220128071936.1210682-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

'amdgpu_dpm.h' included in 'arcturus_ppt.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index ee296441c5bc..709c32063ef7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -46,7 +46,6 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 #include "smu_cmn.h"
-#include "amdgpu_dpm.h"

 /*
  * DO NOT use these for err/warn/info/debug messages.
--
2.25.1

