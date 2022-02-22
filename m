Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27B84C0581
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiBVXqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiBVXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:46:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02142DEA0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:46:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m22so1152514pja.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYOsgWaa8gKED9EtUz2whYFugaP5OcwrhL4viLYk8A0=;
        b=UoTkLPWwVmHpZgpeT6DePwMy0hKShZxWsh44jv0WsFBSmnLqnnVXWprtJcO6mRA3lA
         T56O+usOJP+iOJYPvsMMAY3TZlsESyPcWo1hYrMJu6CyrKfZvyURDLKL2aqlcBPpbZ3O
         N2w8v3SorWbuZe9T/11/rTcCTbH2vsuszPpNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYOsgWaa8gKED9EtUz2whYFugaP5OcwrhL4viLYk8A0=;
        b=rc5TxV74Ck+NFBheiMUn5mlpqh35LQEyxuW8Yt3U2arqcdAcOdFKKWTXSYd1PVrU69
         NUQ/+Vdj5AA5iuIKBFEhoTV5EO5XjYTki1raoK5WELM5ckRjPU5/FCbIpj8FhFdgOMY4
         UiFPTXnfRle1t91lwuUvOl8dL1R+lZQhgBDntvruFg1F2uvC26x4dvid/vQutDu4JvDl
         MExYExpf9/eSnxw/HJWTwSHUTgYVed/jtYxuE7Kk9sWkq0RChDBYkk8WbiuEL5bdnoSZ
         ffgqrqgFZbIDhxMAq89uqFDGqPkxb9kaezuiao/WXeAOI+nYbzgNjFvR8W1221eC9k+h
         MleQ==
X-Gm-Message-State: AOAM533fylNmEtmOA/1RoTtHtcEu89I7LihV6to08C+ARlaK3Rc1Phxh
        GKD42LntwRGg3z4zvVxWuNEwxg==
X-Google-Smtp-Source: ABdhPJy93mnePXIGnWAfwfPfOYlt/LdKxgP86OPz/6CgqYvr4k7MJZs3U79csd1r5gg/GRX1jF4TQw==
X-Received: by 2002:a17:903:2352:b0:14c:ba3c:2eae with SMTP id c18-20020a170903235200b0014cba3c2eaemr24701886plh.80.1645573583536;
        Tue, 22 Feb 2022 15:46:23 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fbbe:971a:f60f:11e1])
        by smtp.gmail.com with ESMTPSA id h5sm17516574pfc.118.2022.02.22.15.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:46:23 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: Document that debugfs_create functions need not be error checked
Date:   Tue, 22 Feb 2022 15:46:00 -0800
Message-Id: <20220222154555.1.I26d364db7a007f8995e8f0dac978673bc8e9f5e2@changeid>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in commit b792e64021ec ("drm: no need to check return
value of debugfs_create functions"), in many cases we can get away
with totally skipping checking the errors of debugfs functions. Let's
document that so people don't add new code that needlessly checks
these errors.

Probably this note could be added to a boatload of functions, but
that's a lot of duplication.  Let's just add it to the two most
frequent ones and hope people will get the idea.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 fs/debugfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2f117c57160d..3dcf0b8b4e93 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -450,6 +450,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
+ *
+ * NOTE: it's expected that most callers should _ignore_ the errors returned
+ * by this function. Other debugfs functions handle the fact that the "dentry"
+ * passed to them could be an error and they don't crash in that case.
+ * Drivers should generally work fine even if debugfs fails to init anyway.
  */
 struct dentry *debugfs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
@@ -551,6 +556,11 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
+ *
+ * NOTE: it's expected that most callers should _ignore_ the errors returned
+ * by this function. Other debugfs functions handle the fact that the "dentry"
+ * passed to them could be an error and they don't crash in that case.
+ * Drivers should generally work fine even if debugfs fails to init anyway.
  */
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 {
-- 
2.35.1.473.g83b2b277ed-goog

