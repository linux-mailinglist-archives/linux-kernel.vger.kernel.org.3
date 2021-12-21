Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC11A47BDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhLUJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLUJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:53:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A270DC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:53:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id y9so11881086pgj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oK3WAQXq4KMVmjJzY459XHjk1tv43Y9AMYrE7wF3XA0=;
        b=khrt2vHn5FTNzojJ3/cPnZR2m7GpJyhn+hy5FnZrjEm1pESyOe1xINjyBXGQZMKy2h
         f+i/YBdnTUSxlwzq4G6dMQlCz8jzQvxMPHrYWmOQAPeEXPneoezSIYLDXTX/DovHavF4
         WZqXcuXIg3K135pX7Fy3gmahMXc4/yxrrrORU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oK3WAQXq4KMVmjJzY459XHjk1tv43Y9AMYrE7wF3XA0=;
        b=PX0Ldm8ihQyAswtWf/NjiJOp1PEH/NOKxV8zhwOHoiaKcX1mfZ2lDF6vYD2I+Drj7R
         8XmBRFGnBGdyDEWKxV0W4o2Tij6FhGVMjIzlXa2JjR0l3rmyzsQKPPnRsT8uhncLhr4x
         KYb85FhY/XcEcoBszX0vd03jCIzNMMyfbPUl1Hwkgy4z67l55W6PdeIraYzKZyur4rk2
         GHjtVFKt4BRJ+soa2qN7gEf8gimsW4pBl1f6T83FHleZG2gWX0CmjLG5Ulxox/jItnGy
         V3nNOI4lSrF38Y5WMcglEHNVACRifWD+2dPZoASe2xAZDlTvXOPFI/qsgLHjkZbI/RXL
         xNCA==
X-Gm-Message-State: AOAM530m3XPdype0I/QatcSWfsEptJ1MRS0YHZVmqlWBthO1KZc/Vm6Q
        HyfWxzEe4+qxHswImtBdN6+sDg==
X-Google-Smtp-Source: ABdhPJyTFOkYGeQ5iDajKKGKWD31oKtAmO/UIs3z+faNpR4zJ544YOPH3x9UPu9l7Wlib+9+ZGfDlA==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr2249421pgc.46.1640080410183;
        Tue, 21 Dec 2021 01:53:30 -0800 (PST)
Received: from zhuohao-z440.tpe.corp.google.com ([2401:fa00:1:10:2a75:4739:5568:50ad])
        by smtp.gmail.com with ESMTPSA id o62sm20887746pfb.211.2021.12.21.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:53:29 -0800 (PST)
From:   Zhuohao Lee <zhuohao@chromium.org>
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org,
        groeck@chromium.org, levinale@chromium.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhuohao Lee <zhuohao@chromium.org>
Subject: [PATCH v2] media: platform: Add brask to the match table
Date:   Tue, 21 Dec 2021 17:53:26 +0800
Message-Id: <20211221095326.383055-1-zhuohao@chromium.org>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Brask device uses the same approach as the Google Fizz
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 2d95e16cd248..8c8d8fc5e63e 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -215,6 +215,8 @@ struct cec_dmi_match {
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
 	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
+	/* Google Brask */
+	{ "Google", "Brask", "0000:00:02.0", "Port B" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.34.1.307.g9b7440fafd-goog

