Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D826A48F58C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 08:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiAOHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 02:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiAOHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 02:02:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 23:02:38 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so24378797pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 23:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqpF8BmL+D8ySHQ8HdO4dmpXZkNxvy3zHZ5nkJG5RfQ=;
        b=TbK944vTXTdEwPsFKOYqfD7tBmfL8PCwX99bNKK0lotwCj63N6DUo05XDfvk0jCO/A
         jZpTjtByDW46zWrFU56lG3JCBoW2DDEuCSk/o1LVAdpVq8DdSFS1qs6BY72ceUdwCiD7
         ZpNi9B+fhPmPJHiU6N6lFOF0k6O1qjzrwGdmsltsLjg2JN2zx7syv+4qETDiBaJxPLDZ
         8+H9ZT3OS5bsrEBhs76QAzTQByK8pehiMcPwnQBfDmuIN789TXfeQMbkxAUPhXwKsupH
         01/d21tFaJfXdzEm/dI3ct9LXFI31FZqqgcJt9TX4sFqV4AOa1MjLGaY6t/LVFhCjOvk
         VICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqpF8BmL+D8ySHQ8HdO4dmpXZkNxvy3zHZ5nkJG5RfQ=;
        b=1wUcot7FNrvBXddUPmXIB3qXNMFA3F0LQrEsBFYo8qT+Z3a4Ipz3fttbolWroce7iU
         Fb68FtaWzbyrZOAbpDXdS2rT+9EIZe5d4eTfpOjpeOIgzbe6XG8YMkkMahXlOJxcxnGN
         9ErqCvg0hcov74pSz7qtWSHQj2RDjSlba6c/AZ4R8XXFpT9ASoCeqjpoTV6ux7XRrGKK
         Y8TffLZ9+0E0p46oo+RbcKYp6OXEjLrQEp6U1XlM6DLDVrTsHYPy+OMH7MhftlbtEIz0
         K7nVSuWW5/ksocbXgpf1CROfiSK/Xs43NZC4TaBmUHW4dCIBsgM2vuc1XOzoDGrT0i11
         JoTw==
X-Gm-Message-State: AOAM533pCP7bp4NmvfgDoOdZ4T6SnE7P6qNad5yqZVmaKAp6//fyZUyp
        DiePBPQGuwdAoSpQyrFF3u8gAnFBcN4=
X-Google-Smtp-Source: ABdhPJxfclDoOikdDw14Ze4UiSx3vPLmUkDWFC0ENU8j0guatbP4J6JTvqDvrRvoO3lkLvaNKYmxtg==
X-Received: by 2002:a17:902:e544:b0:14a:555c:add3 with SMTP id n4-20020a170902e54400b0014a555cadd3mr12591881plf.102.1642230158467;
        Fri, 14 Jan 2022 23:02:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e5sm6694600pjr.53.2022.01.14.23.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 23:02:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Felix.Kuehling@amd.com, nirmoy.das@amd.com,
        Oak.Zeng@amd.com, jonathan.kim@amd.com, kevin1.wang@amd.com,
        tzimmermann@suse.de, Philip.Yang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: remove duplicate include
Date:   Sat, 15 Jan 2022 07:02:02 +0000
Message-Id: <20220115070202.850676-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

'drm/drm_drv.h' included in 'amdgpu_ttm.c' is duplicated. It is also
 included on 53 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 953d68b26f0b..ebd40d1a8aff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -43,7 +43,6 @@
 #include <linux/sizes.h>
 #include <linux/module.h>

-#include <drm/drm_drv.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
--
2.25.1

