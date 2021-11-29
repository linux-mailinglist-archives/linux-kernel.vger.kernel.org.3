Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0FD462206
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhK2UUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhK2URG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:17:06 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FF8C08ED49
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:22 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id l190so16709059pge.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AM+KUQ9CyYeI9bAWldEYM9d8tnORsxrJ/LfIV/izBLQ=;
        b=CYW+M11BxT00w22dAon+zs+Vo8v5gpfJxc7JHdNA2rwcK3PaoLtPmn+MUURVQ81z+H
         HCB7fQ0fFjx7HGOA6YZ0M5gDyq2PMBtkf9gGJh8utvJHfspcrQ7JRMpD72BqO5DwgCEp
         tfRGa0CfUi9UKyrKC/kkQGZWE5MV7ia6wOv2+nL4BZPPdFzJvQe6Y0OXysZUE2TH78bq
         Gk+r+t4OR4BLceXXCaDOwEVmnS7OT9EP/6oCrrG0XFOyLdjfcECD4KgqcHuE6k9yVc5T
         a8jQB1Y31bf2TJBSDkMboi5kdIR0pcSDnm5DOYLOuuu23GlU9jo3HKXn9T/3EcA4eR65
         HpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM+KUQ9CyYeI9bAWldEYM9d8tnORsxrJ/LfIV/izBLQ=;
        b=trjk+ngiqYVh1bjAB7Rlk1lDD+OttJINlpW6Uu7+3COIfnaiTCulqGYBnzpD/gjg2N
         n7zuFBrgyyiChdAPfllaMCY1LiKjUR2y4G6Lo3JedWDQZbvQ6RQAPkKn60F5pHf1QNR8
         JUok4ed2P0HvmxxAQA75wvkJ/7QsqBEPqh2RnCmfAwaqzF5mdV7c/w4GOm/ZaLiSJ3RG
         148iLeZ5Uh3okrm4UwH/HpuMlYedD0jrhLefPuQM7tU/LySutbfyI33s9f3xnTyQVMAT
         MJaSxxNtCw7+rapKFWHHqcnlCCOousUGUToKcZJwYy5oFsr7hSmRwvD8qkPCae58RVqw
         Wvvg==
X-Gm-Message-State: AOAM533INOe/ddQJcfo1kS4pHirW/BOXu50ulsos1JlSgbef0OfCYehp
        F++ro8/WGd4REr0I1Agh+ioLAyUPaS21fA==
X-Google-Smtp-Source: ABdhPJzTtwQiOt9bFa4qv9iv9rKbLQv4zz2JoWdyY8q9ntLIV+rrb3BYe5jg3hfGVnVzisjdaBGAdg==
X-Received: by 2002:aa7:950f:0:b0:4a2:54da:3a73 with SMTP id b15-20020aa7950f000000b004a254da3a73mr39755057pfp.18.1638204621902;
        Mon, 29 Nov 2021 08:50:21 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id mr2sm14044211pjb.25.2021.11.29.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:50:21 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v6 3/5] trace/README: Document objtrace trigger syntax
Date:   Tue, 30 Nov 2021 00:49:49 +0800
Message-Id: <20211129164951.220511-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129164951.220511-1-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a short description of the use of objtrace trigger.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b..a84b6813769e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5590,6 +5590,9 @@ static const char readme_msg[] =
 	"\t            enable_hist:<system>:<event>\n"
 	"\t            disable_hist:<system>:<event>\n"
 #endif
+#ifdef CONFIG_TRACE_OBJECT
+	"\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
+#endif
 #ifdef CONFIG_STACKTRACE
 	"\t\t    stacktrace\n"
 #endif
-- 
2.25.1

