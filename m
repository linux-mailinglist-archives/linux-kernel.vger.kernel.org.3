Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30285488BB5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiAISmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 13:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiAISmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 13:42:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F35C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 10:42:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o3so22631687wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 10:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jn0u+te7zIQxHFsF/4HQOfQXP/h46v9vhoCHXHHc57E=;
        b=L/ToGy2JVc45aN1S8otB5yM6xrY1DVo+YF/OQVC9ftRg+4uFnESrbUPYVILiJaC/B+
         rzDCcAVJggQOraAbFF0xl3hSrrGPF4JmYPc9tacKG7GnHh2H0k22hYI3X+kqkaMiOMXr
         F/J5VzVBzRRE9FokJ6KITmDi/tSaz4YOTSiePwd2YjCV4ZFhenTrgUTd59W2ZCiUsUIb
         ml3t6WtA1fyU614c8eyLKCaTxG0PcQISBz6lJmnwgvczDFKp3Yf+M3wMgZ2Epk3i/MtZ
         /u2YR/rkhQcYPAj+jBinCBnbz8VREojF5MJiDuby98V8bywN1oeJ9ANrtc93Uy2zvx6H
         MwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jn0u+te7zIQxHFsF/4HQOfQXP/h46v9vhoCHXHHc57E=;
        b=TKdrSqR96VQ9cDY5UQ6S2U/JMawxmjlCxXSA9MvhmPhJTfYhoCpRnXjICJuLn7T2mJ
         c/55iIpXGFl14Xa70Cqq/+jSkV5UgrqcOxOuCWbxWoickbH+A7fwbwkz76vWDSudFA7m
         SPzLGofZUA25juJhTKjMmNJUaetOjbYCubq4M0+Kya5W85/OQgIHasjq60V4QrgV4j6P
         ImbGkYZSiSQ6Ggnx7PMv6ybz3wEWj+gtij15w+Fpe1JFhxk/uyM+NhOenflz6HNYn5TM
         4r3sPoHOO6aiPrS899tnigonzJq4CYcbonY3El2MNe+sSN+SQ34YA8GNC+zaQDDOH8Dg
         e4vQ==
X-Gm-Message-State: AOAM532q9ans38Oqmi7558L3u5gc0I2LUKn+TXpaHjf23UDLo0L9cqDk
        g4urBQHqeaW6oIMIRgFxkSA=
X-Google-Smtp-Source: ABdhPJym1kK0j3QoImwCAJUPh+lD8ErRuOsuUOU8oVTIbJXjQsEJPs04GUvk1T0BBf+0bSuRaJVoJg==
X-Received: by 2002:adf:ab59:: with SMTP id r25mr9771207wrc.321.1641753771561;
        Sun, 09 Jan 2022 10:42:51 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id n15sm5570075wmc.0.2022.01.09.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 10:42:51 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     shenshih@amd.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Anson.Jacob@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/amd/display: invalid parameter check in dmub_hpd_callback
Date:   Sun,  9 Jan 2022 19:42:45 +0100
Message-Id: <20220109184245.124850-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function performs a check on the "adev" input parameter, however, it
is used before the check.

Initialize the "dev" variable after the sanity check to avoid a possible
NULL pointer dereference.

Fixes: e27c41d5b0681 ("drm/amd/display: Support for DMUB HPD interrupt handling")
Addresses-Coverity-ID: 1493909 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e727f1dd2a9a..7fbded7a6d9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -656,7 +656,7 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
 	struct drm_connector_list_iter iter;
 	struct dc_link *link;
 	uint8_t link_index = 0;
-	struct drm_device *dev = adev->dm.ddev;
+	struct drm_device *dev;
 
 	if (adev == NULL)
 		return;
@@ -673,6 +673,7 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
 
 	link_index = notify->link_index;
 	link = adev->dm.dc->links[link_index];
+	dev = adev->dm.ddev;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
-- 
2.25.1

