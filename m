Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955B049C017
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiAZAWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiAZAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:22:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A33C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:22:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n17so9907559iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ts39vwt4NggLyhQYO/HPTQQc0RWeahjKGAmz31/muqU=;
        b=GmHVlghzVxYcjb3GD+x5WznNuajgVVhWEMdNwcb8c971GByF0B2PRveHCMExbTy9Vq
         5HFfhGJdJd0544D8QWwhWT55G8j1vazChIOKMh1x9kA5lhz0CXLj3ZlRGPfTeqtCEDcd
         gSBo9nofC2mWCv23uCiFUWyrfpenvfd4XB5X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ts39vwt4NggLyhQYO/HPTQQc0RWeahjKGAmz31/muqU=;
        b=Gc6EtTE6fNme51y/qPrSkgdhfg086Xvtl9IyoyCkEi1Rv3lCqLxTvK3Zi/rAIoipSe
         HiOOjWHY62EO7z7ejRFfALjPJPUevaCmKt0FN9bnXKy+qd1otUEyTnxnUwXD2Vf6gAHE
         bPlQoNou20B/ygbSFCe7eOzLsnQg7agUkrTVc7YtOb/rBJEJpuS47wr3I4CvUw/XDwte
         Ju+udLf0R0ZgwrZZ0SUD/Zjdh05ov8vkjChXupokdO16hbZsOzJwiYM5Mf7xZyyCkJPL
         tw6G62+jUhTaTFlvAggcYQ/rG+wLX31VrjPcQomaSF88iAPyjy8tTbgabCUR/vw0ZUcT
         JwyQ==
X-Gm-Message-State: AOAM530n6Zr5B8hJGlbbA37kW9j0mYiDLeYOlZy5e31a7KX73Rw9b5ps
        QLa3OJ9cq2k5CIWGOxU0Zn0thg==
X-Google-Smtp-Source: ABdhPJxroxnynJ8bfdiHjOYtEsKIdppS3W1yJPTNisN7antjTdbIzwbCl9lePcNaBEFsLvSgJw3D/Q==
X-Received: by 2002:a05:6602:3412:: with SMTP id n18mr479993ioz.123.1643156557152;
        Tue, 25 Jan 2022 16:22:37 -0800 (PST)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i15sm9029729iog.14.2022.01.25.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:22:36 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bristot@kernel.org, rostedt@goodmis.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/tracing: Update Makefile to build rtla
Date:   Tue, 25 Jan 2022 17:22:34 -0700
Message-Id: <20220126002234.79337-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update tracing Makefile to build/install/clean rtla tragets.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/tracing/Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
index 87e0ec48e2e7..95e485f12d97 100644
--- a/tools/tracing/Makefile
+++ b/tools/tracing/Makefile
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 
-all: latency
+all: latency rtla
 
-clean: latency_clean
+clean: latency_clean rtla_clean
 
-install: latency_install
+install: latency_install rtla_install
 
 latency:
 	$(call descend,latency)
@@ -16,4 +16,14 @@ latency_install:
 latency_clean:
 	$(call descend,latency,clean)
 
-.PHONY: all install clean latency latency_install latency_clean
+rtla:
+	$(call descend,rtla)
+
+rtla_install:
+	$(call descend,rtla,install)
+
+rtla_clean:
+	$(call descend,rtla,clean)
+
+.PHONY: all install clean latency latency_install latency_clean \
+	rtla rtla_install rtla_clean
-- 
2.32.0

