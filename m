Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625214C9080
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiCAQhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiCAQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:37:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580C63C4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:36:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ay5so11070167plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/VXPALyA4qT4fV6+jSbzh6LzjJgkQPPGIwaFX4UPSY=;
        b=UdkXz2dJzg/IVxJxavt2YG7rRfA1LZCMbdyM5TucpptJ6P/MTZNC0M9Vuiaxn0/Mfw
         IFam9vMb8tuIkX5m1eLKSzlcWIrQSqc5Fm+5VqzBRRlwqM6xdWt+SiJlkS9ffHn4rveZ
         hx/XG/o5NzH4WipPvV9hrk3aHO4QJDTafxUaD+1iurUDEiMozOZw+Ex3nqBdVow8rQj/
         K4j/oih4om8zavE+KkL4om2RjZAc/zDCkMm0ET6+WRV8Uw6Zck4Z3ZWgAJYi5sITu/mE
         cTgYB9Ovi5UHAZKq01Kq6APpf/1ikNLqVDcx9E8YwT+3ZJSiKVoyXVLtYasG8odlPfFJ
         0H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/VXPALyA4qT4fV6+jSbzh6LzjJgkQPPGIwaFX4UPSY=;
        b=7Wf3E7xT+enTVd5nsfbvyrjntZux7bmuF74qTC7U7VQLEtBDwOEs9t29Lh0aVtBy5V
         xeMso1f+y0IY3/1l+vhNQWsc+JAO2zvs1zULEu9vu8RE1L7EnAuuxo6YMf8pwNpFu2X9
         SVqYwIH9kNk5qMMRdNsyn63hQKoNcbFeA5Ne870/w1sXtG83SVAcKMP45NOLHCHOxyDD
         vkq08pzoj2L50PuenjBoJX62cT8yMyqqWLS/YjKvv1Ms6Mu1r/YPl7ccoF9vPwHFQ6i1
         1kk5Af4V4PFMGZ9kdFxvkHKx+eF1HIbMKerlsRre3QlESX533wdU3rM1lojHnCaplQPR
         vYWQ==
X-Gm-Message-State: AOAM532B/zDmdNNoHawg3xVJ/Ym6DYxfPyIWonPJtIgZuqUiCSanQJ0+
        BHOj6g9Cw4ARHF3fVAdy4lE=
X-Google-Smtp-Source: ABdhPJzYpDmzE1X26H7kMQ0jTDlnFonv1JcA30J3bLBq1DKFf3un5BYohba20Lz6y9A06SJipHl9sQ==
X-Received: by 2002:a17:90b:3cc:b0:1bc:692b:ad8 with SMTP id go12-20020a17090b03cc00b001bc692b0ad8mr22456843pjb.90.1646152617227;
        Tue, 01 Mar 2022 08:36:57 -0800 (PST)
Received: from localhost.localdomain ([115.27.208.93])
        by smtp.gmail.com with ESMTPSA id k20-20020a056a00135400b004ecc81067b8sm19180965pfu.144.2022.03.01.08.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2022 08:36:56 -0800 (PST)
From:   cz18811105578@gmail.com
To:     jpoimboe@redhat.com, peterz@infradead.org, mingo@kernel.org,
        bp@suse.de
Cc:     linux-kernel@vger.kernel.org, Zong Cao <cz18811105578@gmail.com>
Subject: [PATCH] objtool: Fix memory leak in objtool_create_backup
Date:   Wed,  2 Mar 2022 00:36:51 +0800
Message-Id: <20220301163651.50346-1-cz18811105578@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zong Cao <cz18811105578@gmail.com>

The error handling branch did not properly free the memory before
return, which would cause memory leak.

Fixes: 8ad15c690084 ("objtool: Add --backup")
Signed-off-by: Zong Cao <cz18811105578@gmail.com>
---
 tools/objtool/objtool.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index bdf699f6552b..1f4734c84382 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -62,19 +62,19 @@ static bool objtool_create_backup(const char *_objname)
 	d = open(name, O_CREAT|O_WRONLY|O_TRUNC, 0644);
 	if (d < 0) {
 		perror("failed to create backup file");
-		return false;
+		goto free_name;
 	}
 
 	s = open(_objname, O_RDONLY);
 	if (s < 0) {
 		perror("failed to open orig file");
-		return false;
+		goto close_d;
 	}
 
 	buf = malloc(4096);
 	if (!buf) {
 		perror("failed backup data malloc");
-		return false;
+		goto close_s;
 	}
 
 	while ((l = read(s, buf, 4096)) > 0) {
@@ -83,7 +83,7 @@ static bool objtool_create_backup(const char *_objname)
 			t = write(d, base, l);
 			if (t < 0) {
 				perror("failed backup write");
-				return false;
+				goto free_buf;
 			}
 			base += t;
 			l -= t;
@@ -92,7 +92,7 @@ static bool objtool_create_backup(const char *_objname)
 
 	if (l < 0) {
 		perror("failed backup read");
-		return false;
+		goto free_buf;
 	}
 
 	free(name);
@@ -101,6 +101,17 @@ static bool objtool_create_backup(const char *_objname)
 	close(s);
 
 	return true;
+
+free_buf:
+	free(buf);
+close_s:
+	close(s);
+close_d:
+	close(d);
+free_name:
+	free(name);
+	return false;
+
 }
 
 struct objtool_file *objtool_open_read(const char *_objname)
-- 
2.30.1 (Apple Git-130)

