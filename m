Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF54A4FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349941AbiAaUKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346109AbiAaUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:10:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E5C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:10:33 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id c188so18453429iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJiYJBDIsvc1XsOq0dzZC0zbm7Jkek42UwXJQ7TTqlo=;
        b=OgIw8xGrIQVAvOZAEU3oCu1DKy2/i3l9AW7t3W84x1h4NQ3PZza9acM+pnW/gEHcb/
         lXMGtCyztTKse3waGd7tlV/S25KYi+JTGsX3K40iXXqN4XTxm8vetd0Z4TEohjyXO1w7
         IMpY+COOMSGLnXSgsQxb/Q7NqSI3ye073QiGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJiYJBDIsvc1XsOq0dzZC0zbm7Jkek42UwXJQ7TTqlo=;
        b=6QEnHGSpNBHHtVO/1WRBD6LcmJpf8L3k1rsD6ZmDM6rwU4k2I+GSNzh5qJT7KgP7ei
         MibV2RH0hXZbIqaMvewQKUqc95KfZpmtML7ECCcDrGOl5XIQlEsiYmFuOr5s0ipDnJ0e
         B6I8mijwjZHhPnDRTdDIRqI49TnXe2qf35ejv7U0VQFFFBC0oWxLC9FLec+zfKO6Wb1b
         owa7tWVw7GE3yjqRbhEI9O2JLgIyTwtASsRJGWd4TknA9W5ahZ1aR7U6z8PSruH0QBYf
         gzqXWV2i4EYdq6WykaJzkOFuezPHa1db+nTDVk/2n5NIddOabFV5T+QRk1bX0d7ZJtKR
         /tew==
X-Gm-Message-State: AOAM530jKeZ0dDI775OWknzClK1r+L3+3+17m1sA7C1UCDz6cTRwRH67
        WCfPuLtXI9cHLEZ+98nR+YW0JNJnaFhpdQ==
X-Google-Smtp-Source: ABdhPJwK5B3kAHm8nYqI0teiKIkT3u7Ki6dVPuk+w3GKb8s5PizpKf+kZc3ycVsOR70O+WtAlNQSnQ==
X-Received: by 2002:a05:6602:8cd:: with SMTP id h13mr11996212ioz.138.1643659832810;
        Mon, 31 Jan 2022 12:10:32 -0800 (PST)
Received: from localhost.localdomain ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x24sm10346839iox.20.2022.01.31.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:10:32 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bristot@kernel.org, rostedt@goodmis.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: make doc build optional
Date:   Mon, 31 Jan 2022 13:10:30 -0700
Message-Id: <20220131201030.446407-1-skhan@linuxfoundation.org>
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

