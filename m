Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96370474587
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhLNOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhLNOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:48:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:48:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so13715963plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Iulmly40W1bDkhduoNsg+HBkwz1jkiNj6QQWr6cyxGI=;
        b=bVQ0yxfqR4gM8cvY3QfzVLBcKqhQI0nJLVV4RQfceHzyjSNcQpSou3zvsdx2WTGUGv
         xl3xVudr5Oeu4DaGKSB+/bmFlRpfPZkzOnRa1H6aIbsC1m4MCmw5UJhLd6/5njKfU0Wv
         LVuCbgS74ETHCAJ5Thx3+b+i0JoWHn5tSodY/IzyHg61gXSXY8uALr9Nh4fcM31JEPyY
         HEBkle6Lq92XyrBc94TZ4k6SoKkLl9hNzQO9/skGJZLIlcdpmU59AxMo6gNScBMD6plH
         DgvRUzAY6bJ7HJoTd8IjJnw/tfzo/NgepRbYNbEOp0JGh8owSwHG7t/iSAMYsdI8LBHa
         TdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Iulmly40W1bDkhduoNsg+HBkwz1jkiNj6QQWr6cyxGI=;
        b=lhCCgOpsqf436JZ4wS6VdkUrEV9o7HISveZaemFvDB258ou69Xrl21KJpU1S83MkAj
         psIYlVXlakS+7RzFqfn87t2q5Yihalh1jwEX/60BmDrIdsA1G5t5u62mVk4xXl0V2hJL
         dpsOqnnsC/h25WnUqFdFlhhZZpA4jnByn+kKufOUo2Nn/sadBWtMOEoEH1rGZf3sr3+i
         vP8BHSnUFoItmDQmOUmcyYjhfqq9CWilwNtiuGZba9XCXOeVXcD6Ddf0Vmx6iaPY1MOX
         ytRPw9DLc82lpeKlE1uUxr0kac4vOjwp5JiSeKJueQuzuebMsoC04OouCnwj/6GXq+k2
         3d0Q==
X-Gm-Message-State: AOAM531++zRDTFXtFNYBY4NO5H8VsejonH3IZRk0wjcNxvyorU+1H6VW
        jJga4SmoEZHG7pnIzoPaTqA=
X-Google-Smtp-Source: ABdhPJwZ1uKUDFQaXtTUt03NxX7hd0yKn9NTGJLMfjB3K+xhXU208vU7PYQTDnm0wNMJOYtiw2zB7Q==
X-Received: by 2002:a17:90b:1c8d:: with SMTP id oo13mr6164377pjb.139.1639493309906;
        Tue, 14 Dec 2021 06:48:29 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d9sm2556776pjs.2.2021.12.14.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:48:29 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix missing check in kfd_parse_subtype_iolink
Date:   Tue, 14 Dec 2021 14:48:23 +0000
Message-Id: <20211214144823.16057-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmemdup() function may return NULL in case of error.
Add NULL checking to prevent potential null deference.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cfedfb1e8596..59d55f752aa7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1060,6 +1060,8 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			return -ENODEV;
 		/* same everything but the other direction */
 		props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
+		if (!props2)
+			return -ENOMEM;
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-- 
2.17.1

