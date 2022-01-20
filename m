Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAF494B89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359812AbiATKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359807AbiATKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:17:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59AC061401
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:17:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so364607pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=rdBW0j5QQWhMLX1FKpoagwlaHny7USjq4sUZI4cs1fE=;
        b=okHs6cOUaGLya4BJJW9td244ZQrPan4DTQ8eym4VDUiEE/pliKgmIEijdwdyZbjKfX
         mbO9y0ZXTKOXQYlnj93QUnGFKN9hmMCtDgqaI2/kDRTchPd1qbd2ucbYDNhjHbtIrsSt
         v6c/JjbHE8QWG1HDSjc0kSuD7kbZr55DXGG3+KAJvJ0IPLaUz8p/ICXMN+zRSRtNjwYl
         dQkyi2xomTA+LhCVaw0GMNkuf4fPBbIgKcbQiptNED3agNqudbwo8oHzWg4tDbPfbe76
         XKVIGzCg9RPq6h636C4I77z7uWQIgLcuk+Tl+JcI0iwtvUApqjJraXuZGfvT7XSZWZ2L
         urcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=rdBW0j5QQWhMLX1FKpoagwlaHny7USjq4sUZI4cs1fE=;
        b=R2GO1Jar8zKjU3bgTF/FI6XisLQdZHAEcK+XB28rDVI3wyXHeYcbCWIQi832gEk3a/
         gfrrLsskR6JKkocqAcdu5H+E+u0P5UmMMjCQB+l5Rp4szxdmrOvVltHEzPwR4JBQl7s5
         +N9+B7ZCPmK8TKf9TeH8sCRVReHbW46iwIul5wVWSQprQIDtC7vJfbPfsJCIMU8sCc9s
         +oWBGKhZDkjtgQR05nfcBVhxuVkjpMTBHK0JwZ7wLumMy6ZJYC4KXSF1j2VBXwOPn3be
         yjrNnf3L1HA1xG0fcN0IfUuH9ZvlBOZTsUuZxXRCvxf76aDq/cpopAMqHcXuVsPo8bTG
         5l+g==
X-Gm-Message-State: AOAM532YrZCZ/yn5hMhQIBG6XidAzgrGPR57NS/7n0K3PIW7iBDtRaDL
        nWR2zDb2ucvNTe+y8XgH3ZY=
X-Google-Smtp-Source: ABdhPJyeMp9RNX3h2fsUBSP5ombifhj5R4/4Wk9OoG84WlguEkGvIfX/1cSt4nKN2RqGXj+FFM6WKA==
X-Received: by 2002:a17:90a:d154:: with SMTP id t20mr9972019pjw.43.1642673873398;
        Thu, 20 Jan 2022 02:17:53 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h12sm2070618pgh.79.2022.01.20.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:17:53 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Clements <john.clements@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Bernard Zhao <bernard@vivo.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix double free in amdgpu_get_xgmi_hive
Date:   Thu, 20 Jan 2022 10:17:43 +0000
Message-Id: <20220120101746.24847-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callback function amdgpu_xgmi_hive_release() in kobject_put()
calls kfree(hive), So we don't need call kfree(hive) again.

Fixes: 7b833d680481 ("drm/amd/amdgpu: fix potential memleak")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index e8b8f28c2f72..35d4b966ef2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -393,7 +393,6 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	if (ret) {
 		dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
 		kobject_put(&hive->kobj);
-		kfree(hive);
 		hive = NULL;
 		goto pro_end;
 	}
-- 
2.17.1

