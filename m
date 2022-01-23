Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7E497650
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiAWXUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiAWXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:20:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8343C06173B;
        Sun, 23 Jan 2022 15:20:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h29so7733192wrb.5;
        Sun, 23 Jan 2022 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/+MzBPEwUeVy9YMiiZzeSURkIQk2JNPyEKNx23n8iE=;
        b=RV3DPjzUZjdGL0OESWJkr7mBfuZTqf7vGut/A3LFsRTsuZmRlMum6GVPD8Qzicehfo
         nEBGJSHPK9X6FhN+JKBZkrvTPQXtkuW3Anrm2b5HbajV2R+7PO8hsXj0KwxnU/C/sN5l
         DPk1jz84dBesBaMegMqpyb/dPGkZB5dnHW7Wz2LZVAu2vasO5SZV4M/8Fwn1Pdu+YUzv
         Z/+7e3sDWsoJ6HHs3nBlz+cTnLww9oTMmydHqvc1EyB3Q3Tv35UKzFFhlM2AMn5g3el4
         LoBKg4f/xpHNceUXpdlp1eIGz23nOuZiYxAdqNRl7/jkPOmQwu/gW/Z0AaiuTm4I/BL3
         TdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/+MzBPEwUeVy9YMiiZzeSURkIQk2JNPyEKNx23n8iE=;
        b=fkWUxUqRKn8W+N7wrMRS436hB6Rs5dF4+WPDXxwK6qrWB2JUGE3G7EtrjZSMbEL8vK
         AvYKIdZLyLqr3t27xlrfz8tuziNlO/7lE2iAZWEGm8OKlYGbYbpaErQ8Q4OJ8dIf8q39
         7cKz8LQ9PBOOqxEUPQc5+KnXOnNyMjq8SRbFk3fAX0XcQ1XaVGJcvYDSKsXAtaebRgaA
         xLAPwNJ5ffvA5o/ajI8GnVjsl7mjMIKRZ0jJlAi+dH80NgQzqGm37kv/MCpOGQQO6jbW
         6u6c94qOkAjjvM5ykKkG33OAy5ZGAGEb2DNMjaCMSOqunOa6XNjk6U6IQiWCDLyRlpwf
         MDHg==
X-Gm-Message-State: AOAM531rKJWZIc/yNc26M/7W+H8ZOwmg3ru989PwYaAURBsRA/HpbkRL
        362dJnsNa44RwDgOxXTOvh0=
X-Google-Smtp-Source: ABdhPJypbu8H4eQZF4Tts1MmqzfLcVBzL44VFGv9yJFatulhGOEERN/kYdI4y5ks0aGSYSbHk9vJQA==
X-Received: by 2002:adf:c542:: with SMTP id s2mr12053456wrf.237.1642980040384;
        Sun, 23 Jan 2022 15:20:40 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n13sm5335337wms.8.2022.01.23.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 15:20:39 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: make static read-only arrays modes and orangefs_modes const
Date:   Sun, 23 Jan 2022 23:20:39 +0000
Message-Id: <20220123232039.8036-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static arrays modes and orangefs_modes are read-only so it makes
sense to make them const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/orangefs/orangefs-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 46b7dcff18ac..87d83d08470d 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -538,13 +538,13 @@ __s32 ORANGEFS_util_translate_mode(int mode)
 {
 	int ret = 0;
 	int i = 0;
-	static int modes[NUM_MODES] = {
+	static const int modes[NUM_MODES] = {
 		S_IXOTH, S_IWOTH, S_IROTH,
 		S_IXGRP, S_IWGRP, S_IRGRP,
 		S_IXUSR, S_IWUSR, S_IRUSR,
 		S_ISGID, S_ISUID
 	};
-	static int orangefs_modes[NUM_MODES] = {
+	static const int orangefs_modes[NUM_MODES] = {
 		ORANGEFS_O_EXECUTE, ORANGEFS_O_WRITE, ORANGEFS_O_READ,
 		ORANGEFS_G_EXECUTE, ORANGEFS_G_WRITE, ORANGEFS_G_READ,
 		ORANGEFS_U_EXECUTE, ORANGEFS_U_WRITE, ORANGEFS_U_READ,
-- 
2.33.1

