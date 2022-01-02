Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC9482B00
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiABMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiABMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 07:02:10 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B98AC061574
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 04:02:10 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id r6so28487910qvr.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 04:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=giNV2075gDEg5+v4iNG0NypwhzHYGunkPAo5/HPLi/w=;
        b=YpOicduLSBimY9O7Jc0BEMhHhyUhGg0R1wQ9uWjr9kv9cpxpuKGJxd7DtidWPx1+u8
         0bkKI/KZxWn7Tus+Skjlbv0OqxazGWHbq0iGxV5NsJFBnZ7l8lSbKO7CcIfy5v6IXVyI
         eDUZu6sy+42jqlZKZrWMUM4EHeYDZH6mDfy++KraEmOQka0OVFGspJkxSU30d4HuWVc/
         4/nPa1d8TXltLgjb+8kVyfzeL2Dm1VsBcXq0emwb+GU1nECEg/2Zv2FY9UqgUAWsAWl4
         EXjdFeSQKLv/seKMZbgtoV6V3ea4/al893kSrzOxIkap2F6AnNn7eZhLK88qJlri9AUs
         Zigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=giNV2075gDEg5+v4iNG0NypwhzHYGunkPAo5/HPLi/w=;
        b=4DZDs4qcgih7rR5M9MR+uB76Uyjsn27aGtb6VUISI40fhJPG2ZzVjkID5OrOXhdQFe
         ztEgXOOj7DaKHc6HRvndGVgZitnpK9nJBKN1psVW4L7InMkTvEtBE05mMl2s3SdHnLSx
         5Hia2eLlO9/2CcQS5YzCwaweKgVxkwr+bNvI6r1uaNSQxUxQ3FQGdYFbV/Xgm//Di4iW
         92DdA10zDyG0h7NJcCfeCHFNc0JC0519/mArczH7fjDis4p9BXHB73RBdXwDCNQhgGyU
         5mJUcoSbq7Rro04jIx3EzYmNnJ76vCi6ABn65VH6aOVMC0pRQB3pGa/0QBdBSt9JThbf
         6ung==
X-Gm-Message-State: AOAM532+IVibEgWHdhp5eiz25Z8epNoq53dp21CMiRcwch6ZgBmqMudt
        B0UmKt04+mtP6UDzjbLJd/tOnIH7wlw=
X-Google-Smtp-Source: ABdhPJyrZ/HeawXYxDPqeibxcFyfxrth+Ezl/N8Mr/HYaaUEE8cBMWowC9DIKfOrb1iGoIc1Cs4ecQ==
X-Received: by 2002:ad4:5bc3:: with SMTP id t3mr38168464qvt.47.1641124929530;
        Sun, 02 Jan 2022 04:02:09 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3sm25758323qko.78.2022.01.02.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 04:02:08 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     torvalds@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, keescook@chromium.org
Cc:     wang.yong12@zte.com.cn, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools: compiler-gcc.h: Keep compatible with older GCC versions
Date:   Sun,  2 Jan 2022 12:02:01 +0000
Message-Id: <20220102120201.594408-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When HOST CC = gcc (GCC) 4.8.5, we found that there is an error occurring:
Undefined __has_attribute as we built the whole kernel and tools.

To solve this, this patch is given to keep the compatibility with older
GCC versions.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Co-developed-by: wangyong <wang.yong12@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 tools/include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 8816f06fc6c7..333ed16b3b12 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -16,6 +16,10 @@
 # define __fallthrough __attribute__ ((fallthrough))
 #endif
 
+#ifndef __has_attribute
+# define __has_attribute(x) 0  /* Compatibility with GCC versions < 5.x */
+#endif
+
 #if __has_attribute(__error__)
 # define __compiletime_error(message) __attribute__((error(message)))
 #endif
-- 
2.25.1

