Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B806D48E753
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiANJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiANJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:20:43 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E30C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:20:43 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 8so2282327pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZQzRd0VbsHaxIU7D4AnLPiXbe02LXZ3YxcKNl1VWjs=;
        b=M/Chg9dJUvN6qpMe7QDxhG5BJNbfonhu5GT5edcZRA303Hpvm+UqtZWaJF18LFT2WQ
         0E5ENZCjmCHR+b4P1e8/tD3VE+nETZUec2YXpgzwl6K5sSNxpZQaytp62yIUpMrFz6Ec
         qQz+X0JCLUn2mFKvy6vmkym2uIrHwv1ggDIdjajNSHpcIgG/3qtTTwkbXnYX1CQgaYW9
         qVRWkYvwtBLvahcAXfAAAPEPjXZWsqtC39Yc32Aye/E1vvg83XJ3QR6HCnKo9IGsClPA
         +1q0LsbCyhTLIfNYVB+ph3UDoqjXXx+SdWj2/OJzHLFmCqOXWHerlC5pdFshhgtwi+Gr
         D5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZQzRd0VbsHaxIU7D4AnLPiXbe02LXZ3YxcKNl1VWjs=;
        b=MGODm8i9MbK0kCeO00+FK4tfzDRiPGNJohNSO3N6/fOM75yVHjyHh121qR9Sz0pxro
         2eE2ApDRWpdJOc8XQvCsIGNDuCHlgZ/2bga9kU3Oq3+niY8nP0wubLTO3c24WycHvXLA
         2DZnKh/cmj0dueZPq5uNMf0uTdVsovlmKq1vGR3VaC/tAa6RsdhvLdyl+MZSvMotY3LQ
         L0NEvWgiLR67/xQaM81NK5X8El/sP3jTBM8rloC9aAFqxsmqlVQVnz4WtHmpdar133q4
         qnVs+G38ou4k9AHsRB5jARWuILpmM46XK8QBpeBKF0OaEnWCClqCVEdcNmqm+TLNOYOH
         T0gw==
X-Gm-Message-State: AOAM532EFSvCZLj4YF1q/op2/zVdKXqYtCrdvmShnVAf5bOsdwFcPY7H
        0d5v0AIrKQftS+84TTyLUkQITTFT71I=
X-Google-Smtp-Source: ABdhPJzJfL6+i3WmhTTXxXpgK015TbekEJWKbcNe5Th80LrYI8zFseczAP6kZ/styUT1miChQVgqlw==
X-Received: by 2002:a05:6a00:a20:b0:4bb:95f6:93b3 with SMTP id p32-20020a056a000a2000b004bb95f693b3mr8040040pfh.77.1642152043047;
        Fri, 14 Jan 2022 01:20:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y69sm5110374pfg.171.2022.01.14.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:20:42 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     evan.quan@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        deng.changcheng@zte.com.cn, lijo.lazar@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/pm: Replace one-element array with flexible-array member
Date:   Fri, 14 Jan 2022 09:20:36 +0000
Message-Id: <20220114092036.766001-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use "flexible array members" for these cases. The older
style of one-element or zero-length arrays should no longer be used.
Reference:
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
index eb0f79f9c876..701aae598b58 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
@@ -121,7 +121,7 @@ typedef struct SMU_Task SMU_Task;
 
 struct TOC {
     uint8_t JobList[NUM_JOBLIST_ENTRIES];
-    SMU_Task tasks[1];
+    SMU_Task tasks[];
 };
 
 // META DATA COMMAND Definitions
-- 
2.25.1

