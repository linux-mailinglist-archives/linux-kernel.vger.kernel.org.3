Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950FD49B5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578226AbiAYORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386528AbiAYOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:14:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A5EC061751;
        Tue, 25 Jan 2022 06:14:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so62988487edj.7;
        Tue, 25 Jan 2022 06:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pip/ynndQDsKYwfFpC0FwgQbF11giMSuPMZqW57FgsY=;
        b=JhfKOo/i4Fe29ouAHZzU4+psdXV+0xA48c4c0lvpjN5WMKYJJ1LcpUFH5mRwD/ZRvQ
         wvE6vzkVnOsGWq9JOsLOIXLLrFDFT3hkyQgl+JIlgo3AZNqeHOopkcKOVkJ5PnE6XuXf
         teiZd1ZKMEQ3XJoMu9QBD6j0jXIo2OsJ9S/MofgHPhH6/kuNOjumhQ5eDMh3feiGa96L
         DpyGP3sdFR2cNlxbUO/fNEt4GTJz5QU4HJw19lRM0hAH990jvl5YspsZW5KtAHdE14TG
         PjxBFZReLu0F+gs/kY0nBnlCLMiq6tu5jXp5k9TqI0+aDv6p7AEK5U1yK+PnF1IkFulQ
         ofTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pip/ynndQDsKYwfFpC0FwgQbF11giMSuPMZqW57FgsY=;
        b=C1uTw/8FJUgEr3xp5xbi+pugCwWhOXqTVaidimx5rmPkDk7+puZZHrSdiX76nc/Rgb
         J/wYtWs7FQrvjLHxQAx6IP+Kux/Mef19IpRbD24ktcgXM/S9wTkNI3sIAUsezo07tIaT
         ftiaSfmNjihyY5hcnJNjl+gSOCuUZhv+iqHgiN2ob6dGg2clqC7FdstUEwN5v63JhkYm
         NzeHUeJ7nzM6aV54pvxQfc8lrH7APZzdkLm0YUXv5yHZjEvV204udJ2vkcQ7OCNy9tew
         GK/5W13aVUPiaCA79Q9oyqpfCl1rCnsLrHpUmWueu2DVg4c4pE8MssgYD5C5BBMwFE2O
         cM7Q==
X-Gm-Message-State: AOAM5335kLDq+30JwUa55gJ3sj93K7CoYk0gTMfQNrlBT2icFACPMqUi
        NtTB6GCs57As+H5jpQdC7EP/vkemWlEgWA==
X-Google-Smtp-Source: ABdhPJz2vAlFtIVwKW+yQfoJzKfPoR9YkgY+Wx8tpFHbshf2R4FZ/56EvcY6WDsY3muCdewvaf0v/g==
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr16557083ejc.655.1643120089679;
        Tue, 25 Jan 2022 06:14:49 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:14:48 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/9] selinux: declare path parameters of _genfs_sid const
Date:   Tue, 25 Jan 2022 15:14:12 +0100
Message-Id: <20220125141422.32655-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The path parameter is only read from in security_genfs_sid(),
selinux_policy_genfs_sid() and __security_genfs_sid(). Since a string
literal is passed as argument, declare the parameter const.
Also align the parameter names in the declaration and definition.

Reported by clang [-Wwrite-strings]:

    security/selinux/hooks.c:553:60: error: passing 'const char [2]' to parameter of type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
            rc = security_genfs_sid(&selinux_state, sb->s_type->name, /,
                                                                      ^~~
    ./security/selinux/include/security.h:389:36: note: passing argument to parameter 'name' here
                           const char *fstype, char *name, u16 sclass,
                                                     ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h | 4 ++--
 security/selinux/ss/services.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ac0ece01305a..6482e0efb368 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -386,11 +386,11 @@ int security_get_allow_unknown(struct selinux_state *state);
 int security_fs_use(struct selinux_state *state, struct super_block *sb);
 
 int security_genfs_sid(struct selinux_state *state,
-		       const char *fstype, char *name, u16 sclass,
+		       const char *fstype, const char *path, u16 sclass,
 		       u32 *sid);
 
 int selinux_policy_genfs_sid(struct selinux_policy *policy,
-		       const char *fstype, char *name, u16 sclass,
+		       const char *fstype, const char *path, u16 sclass,
 		       u32 *sid);
 
 #ifdef CONFIG_NETLABEL
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8e92af7dd284..5a7df45bdab1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2875,7 +2875,7 @@ int security_get_user_sids(struct selinux_state *state,
  */
 static inline int __security_genfs_sid(struct selinux_policy *policy,
 				       const char *fstype,
-				       char *path,
+				       const char *path,
 				       u16 orig_sclass,
 				       u32 *sid)
 {
@@ -2928,7 +2928,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
  */
 int security_genfs_sid(struct selinux_state *state,
 		       const char *fstype,
-		       char *path,
+		       const char *path,
 		       u16 orig_sclass,
 		       u32 *sid)
 {
@@ -2952,7 +2952,7 @@ int security_genfs_sid(struct selinux_state *state,
 
 int selinux_policy_genfs_sid(struct selinux_policy *policy,
 			const char *fstype,
-			char *path,
+			const char *path,
 			u16 orig_sclass,
 			u32 *sid)
 {
-- 
2.34.1

