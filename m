Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD147513A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhLODJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhLODJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:09:02 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5BEC061574;
        Tue, 14 Dec 2021 19:09:02 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so20471630qtx.5;
        Tue, 14 Dec 2021 19:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzp/wcscQsMwsU4fPHCV3jboG2Ku6zTojXJHLMEcHp4=;
        b=acbgfZg8AY6c6lJBct7ljN36aAYCBhtQtOYDh2+09xOQUX6qQIaIlh75zhTOr5qPm2
         IrnN6rM4TCLqv7airAIHOvKND93oHnm793vII12Rl55hzbonagvXcfKceRZQOUw99+uM
         T4MbdoJlEJ3BrlkfpChzyxFN+R0Wq/5XyBlCPwwYiwEyzIz8mljceMhkmN4Lbo3fnmi/
         xCfmWnsAS5iTuTt8x74c+q7Emy09Qw0fb+CdRwrNv1r6XlrJofFrUnX4L7GqFrotHvQp
         YxJytYhmP35TR3cYFCFNppJMQJus+y7Bys/EmpQZg5yqD6/6H0Intk2FJtXkXG8odfIG
         chWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzp/wcscQsMwsU4fPHCV3jboG2Ku6zTojXJHLMEcHp4=;
        b=i3FfI2rigPZQHDSODI61Z8usJtbk3MaIBL3NfriYmkMDLaZmzryZSMA3vKctJ/93Sr
         HF8Pt0WAWsoHFNuIn3nSvAPkeIOghNi5vH24zUmoEQ8c9M7FnPakXF9nwmvB8MIL5AQp
         zHIFmkCJY0T/esMg+VUwhLZdbOHwhqV0HfaYdBdZ+XkDgISHZkfN5MuwwPZ9zvHf6s4U
         zlzlSc1wQnS7848/33re/qoyPzQheFu9qxVY4a0ZPEKeFU+YAQG4gGLa1HfTI7H5akDa
         SOjUaQ/vi9vtwTzRcfrhKNsYrPYdtPXfn4cgaeSt+ndjb44q0FzgdUZn//scZKQ9nOxO
         WSyw==
X-Gm-Message-State: AOAM531hyC7guSmhI7LUnJuJtlGdCz2agV4c26FpSvGqq+0Iz/aWXDr0
        SJQ20pi7Z2d+bdo5Gl7WSIckURtWbug=
X-Google-Smtp-Source: ABdhPJxLZR4cE/pRWRZqNyL9/PUDPojI+HIwQGj/zYUzpFbvUgr/jU/fTJg3cBtHUdQMSFxm0gM1YA==
X-Received: by 2002:a05:622a:1447:: with SMTP id v7mr10071339qtx.92.1639537741258;
        Tue, 14 Dec 2021 19:09:01 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.248.238])
        by smtp.gmail.com with ESMTPSA id w14sm423776qkp.54.2021.12.14.19.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 19:09:00 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-kernel@vger.kernel.org,
        lsahlber@redhat.com, Thiago Rafael Becker <trbecker@gmail.com>
Subject: [PATCH 1/1] cifs: sanitize multiple delimiters in prepath
Date:   Wed, 15 Dec 2021 00:08:31 -0300
Message-Id: <20211215030831.24058-1-trbecker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mount.cifs can pass a device with multiple delimiters in it. This will
cause rename(2) to fail with ENOENT.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2031200
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 fs/cifs/fs_context.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 6a179ae753c1..4ce8a7df3a02 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -434,6 +434,34 @@ int smb3_parse_opt(const char *options, const char *key, char **val)
 	return rc;
 }
 
+/*
+ * remove duplicate path delimiters. Windows is supposed to do that
+ * but there are some bugs that prevent rename from working if there are
+ * multiple delimiters.
+ */
+void sanitize_path(char *path) {
+        char *pos = path, last = *path;
+        unsigned int offset = 0;
+
+        while(*(++pos)) {
+                if ((*pos == '/' || *pos == '\\') && (last == '/' || last == '\\')) {
+                        offset++;
+                        continue;
+                }
+
+                last = *pos;
+                *(pos - offset) = *pos;
+        }
+
+        pos = pos - offset - 1;
+
+        /* At this point, there should be only zero or one delimiter at the end of the string */
+        if (*pos != '/' && *pos != '\\')
+                pos++;
+
+        *pos = '\0';
+}
+
 /*
  * Parse a devname into substrings and populate the ctx->UNC and ctx->prepath
  * fields with the result. Returns 0 on success and an error otherwise
@@ -497,6 +525,8 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 	if (!ctx->prepath)
 		return -ENOMEM;
 
+	sanitize_path(ctx->prepath);
+
 	return 0;
 }
 
-- 
2.31.1

