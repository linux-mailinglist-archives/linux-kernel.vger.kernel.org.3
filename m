Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263247B943
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhLUFEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhLUFE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:04:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC0C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 21:04:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 8so10637159pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 21:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=roO/zjlz7hlayqobSlKBJ+EHSvXCzlAQjwxwfUokloc=;
        b=jDLj6QJsuRh1MP+VUcVWNnIwCAwGMhRyqIKohOFIYw6wdLuhrnezokTmGB4SQlNCwu
         VU4kk5q7UHdX5Ax7TenNiYT0mPd5iA5UD1m0Jpbotiqv+QtYv0VYAqkGvnjhPGsALO6s
         T1NBkhDIPo2rEjZR5i8d/mwQbHyMUKBPleWMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=roO/zjlz7hlayqobSlKBJ+EHSvXCzlAQjwxwfUokloc=;
        b=6zgkyk9dtGAQvujLnvPMkLNs+14iL1IouyDQ+691+xVKorLQnd89LwfJKJlj4p1nFW
         hmdsRAlaidLDarGk1V5CjWvXGEC658jPR1Qt6dN23XNUEGNSkOjuy03fgy8KEcgqLXr2
         Mse3QFOeOfMqVbPWnqh5QtqMEY7QoDgJj9AybnH2luImlQ+6EeuVaDOruf6vRghnfPOV
         tBnAomJGxu2+B7Q+9301BtRhkaMFlhLxw1MMRUatdzAnk7wMiW3Q94dXyxHqzHlarebi
         d/IZEPqyRYrfC6500rRC2MpMY3GSIhKlOssPgQVTdb8TJavWSoTSfaQMw1yyRU+FrldW
         dT0A==
X-Gm-Message-State: AOAM533LgtnuaJhhh9r+tgw7bjueOmGcj3p5TO2A+uIrHD8YkaAJn742
        1VGR5UX11mUhJ9NfZnzB0/AEUg==
X-Google-Smtp-Source: ABdhPJwolfmaO34aPmud1iRzBZsl782Fs/z6/go6YKARoLUS1XZitiZPdvObbKc/NtkuKhlW2sFqtQ==
X-Received: by 2002:aa7:8283:0:b0:49f:a0d0:abcf with SMTP id s3-20020aa78283000000b0049fa0d0abcfmr1476967pfm.70.1640063068583;
        Mon, 20 Dec 2021 21:04:28 -0800 (PST)
Received: from zhuohao-z440.tpe.corp.google.com ([2401:fa00:1:10:2a75:4739:5568:50ad])
        by smtp.gmail.com with ESMTPSA id e35sm17892462pgm.92.2021.12.20.21.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 21:04:28 -0800 (PST)
From:   Zhuohao Lee <zhuohao@chromium.org>
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org,
        groeck@chromium.org, levinale@chromium.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhuohao Lee <zhuohao@chromium.org>
Subject: [PATCH] media: platform: Add brask to the match table
Date:   Tue, 21 Dec 2021 13:04:20 +0800
Message-Id: <20211221050420.238376-1-zhuohao@chromium.org>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Brask device uses the same approach as the Google Fix
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

