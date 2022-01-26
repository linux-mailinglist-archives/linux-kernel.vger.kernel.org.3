Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBB049BFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiAZANJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiAZANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:13:06 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66234C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:13:06 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so407090otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJiYJBDIsvc1XsOq0dzZC0zbm7Jkek42UwXJQ7TTqlo=;
        b=DphUxChGLP7qZsi4i73+pTAM3u7NBJgMGWHQ9+ls95uhryI7FNpP7ZKXOiL4jUDzQX
         Nl6uzsL6U3tqCt5Z8+UgMznaN/ou+8P8uoGVSigXJni9VITDr5OqAn0FgrXMhb4fs6NW
         mCNKbC8bG6A8gPAJlmlbtbDlggrLo2c9GfSDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJiYJBDIsvc1XsOq0dzZC0zbm7Jkek42UwXJQ7TTqlo=;
        b=0NXk20yEDdVqPavrinELcDhiEx6g8SowKfWqztwlZjVZPtnsstzgvLanEC070jOOrE
         NyUoV4LUAYCacHqZ6vZ9nBKTn6146pJbHFECoVuKwgq6nS27/Oh5gYIwwWW1UTjzW5Ld
         mbp5S6kVOT/CNR/ePth4FDI0gKd1SxQyyzuGKdhtE7jtjNJxt6smufdetRfzvWvtU9Jo
         bi12mJ9rB9uNBEmdURREN2gnyyGF2xL4oa0d+xJZ0s66/IVaDTQ+N8m3DyO+QwZ0uQON
         yjzo6KJzqGgN3BMkwoyv0OOxILs8LSlWoQu/e4ZYcxpb9FfgFleIuxMJCkc68VEACZzE
         e8Vg==
X-Gm-Message-State: AOAM533p41iYjpKDEc0juiucJJ2AKhDBmcx/snySlp1kObkL0SwGLc8B
        Gc3xYv4KqgYEcXF+az9T+P5DQA==
X-Google-Smtp-Source: ABdhPJyPTqxlhePXSwxAO7b6OZpiTTKJPWvD78k7bjIkTN8zuuHVCDTbw5aPyCLzwgY56vY8uDvNkw==
X-Received: by 2002:a9d:60f:: with SMTP id 15mr15829288otn.266.1643155985426;
        Tue, 25 Jan 2022 16:13:05 -0800 (PST)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l1sm4031491otd.18.2022.01.25.16.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:13:05 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bristot@kernel.org, rostedt@goodmis.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: make doc build optional
Date:   Tue, 25 Jan 2022 17:13:01 -0700
Message-Id: <20220126001301.79096-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtla build fails due to doc build dependency on rst2man. Make
doc build optional so rtla could be built without docs. Leave
the install dependency on doc_install alone.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/tracing/rtla/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2d52ff0bff7d..7c39728d08de 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -59,7 +59,7 @@ endif
 .PHONY:	all
 all:	rtla
 
-rtla: $(OBJ) doc
+rtla: $(OBJ)
 	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
 
 static: $(OBJ)
-- 
2.32.0

