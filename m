Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473444C5414
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 07:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiBZGGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 01:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBZGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 01:06:23 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA12BAF35
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 22:05:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o23so6548681pgk.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 22:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcQPKgRsqsSOnkNkdxhwfPzLlsx5xji74yj4U1p5jco=;
        b=cm+Q1awpuqT+FSC/EQ7UnBVOWblFFnvf1rOpz4Y7JRYFu1NWAoDdKWixNYgkcwEWNw
         FccroqMS9//axkOvOxV0q4s89mR4e0mzrasejtLAAmD2Xn2Sh4cx3D/fxxz+8Vgo0W45
         V0ngWW1ADlJgjdFcpg2sO9qy5vFWmvAUjXla+CSo8qZA1P0M/Q+sAI9FABO3Si0QUQWm
         0VN/Rf6z1ah53qv5dkoHLuGDL7UdruL+Zbn61SBDtlFLwPfUCLmRcS0Oxtz2ZPQEGwF3
         vZkwe03pLd8n1ctA92l7th+Krf6kwa7qoYoQsnH1q1b80v5iFvN3dW/uL5JBo8+IHAjb
         v3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcQPKgRsqsSOnkNkdxhwfPzLlsx5xji74yj4U1p5jco=;
        b=NFc/7mQfXRMdB9i9DT4zE3OhkSFaNGlBnI7IRgGhmOz7vJEaSI0V6w9lVcNOL+dJwb
         uJIjYdwsq+X/11sW7CquZVzqoq7Bfg9mv+TJET7FFwq0B5pE2bmtGTZ2yNuvlaxcdItd
         Pw54+JwIIvo0M4mmx+ZHTccIoz7USvIXxu1Pjn++j2Q9sR3oQ35aa+irKrsUCw8mAoXR
         OTRANqX9Ne7OH9NW382MH9rzGJogURl6Jr4kVHh3zwRHDeBEjrzq+t7niu76Ymf6heFS
         RlpuntBA22CJl2dWDlZQ686H9otVFdjVT9T24idW77FqnyzFqpjcJqcAfM9bjaFVS8q6
         gxzw==
X-Gm-Message-State: AOAM531yukzi7vN1GNXpRKs5+nYW2lzlPt4a4CgFttBY04PNPa/qFedn
        y4l1pWVMreNoXGXWoLRwndEycf1T7oeSiKLo
X-Google-Smtp-Source: ABdhPJx1z/HTEn7R8lVj0VLCevSUsheGrcTFEhqYgZmpNstM/0pbGcpjgV96k4EA+JB+IiketAJPlA==
X-Received: by 2002:a63:e617:0:b0:34d:ba06:d1a2 with SMTP id g23-20020a63e617000000b0034dba06d1a2mr8946354pgh.451.1645855548761;
        Fri, 25 Feb 2022 22:05:48 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id t8-20020a6549c8000000b00372eb3a7fb3sm4258615pgs.92.2022.02.25.22.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 22:05:48 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] tools build: Remove duplicate initialization
Date:   Sat, 26 Feb 2022 14:03:22 +0800
Message-Id: <20220226060322.495149-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The subdir-y variable is initialized twice, remove the first one.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 tools/build/Makefile.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 715092fc6a23..b151055de39a 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -42,7 +42,6 @@ include $(build-dir)/Build.include
 # Init all relevant variables used in build files so
 # 1) they have correct type
 # 2) they do not inherit any value from the environment
-subdir-y     :=
 obj-y        :=
 subdir-y     :=
 subdir-obj-y :=
-- 
2.35.1

