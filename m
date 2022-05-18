Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9252B82C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiERKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiERKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:49:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6095A36
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:49:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q130so2028322ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=THEFsdSxydD0vt+onRmNubTxehHSNNOEbCpKvaGHi2w=;
        b=52dZFMDohGaff05/XhlRhzygsS0/or6wRli7ktIUzoe6PNy7W5T/FFKjLmsGxr2hqw
         xtEB2H7YeCYhUPR20L7wzpIAQ6LUtYIUS9uGz7NQMW3eapjtEl6V7NIJKfBrfwBZCdD/
         glrCu7koVJMqe96czllFD8/KaQI8QpeI5vdK4vnWX8d70Kyx0H2HrkK8vEifOXu7SgRh
         IivMpoIvGSrdhmy+wpQtYH4y2khVcI6yClZzUKGglLNYYXiM4QD08j2PDqCI3u83cjCY
         65pTFkRcD/74/NUK8ftRDrkRwnM61JObdkkPWAfHPvPk9H4RsT0fv+myc2hXatEkBvIh
         lLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=THEFsdSxydD0vt+onRmNubTxehHSNNOEbCpKvaGHi2w=;
        b=6IWjqYp4GYAu3s89K1YWogmgBMe1RToKMfYrri54jszPxeTRA7RapZU60XC62/Q6bA
         vQrR50pGnas3vtcGer93mXCQMMtE1UDDJUd+2AiTET3nUcG5ChkM6NGymh2WfNYa2fUn
         TxPOmNDEH7cFBKYaXE8NeDt9IWTmAcP8v1uViXt19oQgmXLXxOOiRvFd0pQMhwLpY86a
         9OHhGtd7bz/wLdrxv7kJdqxzWokOEZxeernDmKw+RgsvCCdeyYl2+JV614evx7HKgZa5
         X7REMTEcrni+oeYxjQNHq/A0JKk/x18N86EB69vqjwGZhVZnYwY5BRHc6fmHl2320x7s
         NvAw==
X-Gm-Message-State: AOAM530YTnuiE5+Cm2WwBpMfwsd3pPKiCq2+jI40X7M/pnIcPvkhfZ59
        gvzJ3+D7KeG7LJPuieCZnzU5Pg==
X-Google-Smtp-Source: ABdhPJxV+i/RpLYpfwa3suBX2wn1svrIhOGj77DoePZz6SYcFTUqqOZ6BNOELpNKbuelmsT8SmvZYw==
X-Received: by 2002:a2e:a23b:0:b0:24f:b6f:6fe7 with SMTP id i27-20020a2ea23b000000b0024f0b6f6fe7mr16743076ljm.67.1652870949255;
        Wed, 18 May 2022 03:49:09 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.243])
        by smtp.gmail.com with ESMTPSA id 1-20020ac25681000000b0047255d211b4sm169881lfr.227.2022.05.18.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 03:49:08 -0700 (PDT)
Message-ID: <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
Date:   Wed, 18 May 2022 13:49:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] sparse: fix incorrect fmode_t casts
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
References: <YoNDA0SOFjyoFlJS@infradead.org>
Content-Language: en-US
In-Reply-To: <YoNDA0SOFjyoFlJS@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparce warnings:
fs/notify/fanotify/fanotify_user.c:267:63: sparse:
 warning: restricted fmode_t degrades to integer
fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
 warning: restricted fmode_t degrades to integer
fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t
fs/open.c:1024:21: sparse: warning: restricted fmode_t degrades to integer

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2:
 1) use __FMODE_NONOTIFY instead of FMODE_NONOTIFY
 2) introduced fmode_instantiate_de/encode helpers
      thanks Christoph Hellwig for the hints
---
 fs/notify/fanotify/fanotify_user.c |  4 ++--
 fs/open.c                          |  2 +-
 fs/proc/base.c                     | 21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9b32b76a9c30..2bec3b612618 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
 	 * originally opened O_WRONLY.
 	 */
 	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
@@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | FMODE_NONOTIFY;
+	f_flags = O_RDWR | __FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
diff --git a/fs/open.c b/fs/open.c
index 1315253e0247..386c52e4c3b1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1021,7 +1021,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..b8ed41eb5784 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2233,11 +2233,21 @@ static const struct inode_operations proc_map_files_link_inode_operations = {
 	.setattr	= proc_setattr,
 };
 
+static fmode_t fmode_instantiate_decode(const void *ptr)
+{
+	return (__force fmode_t)(unsigned long)ptr;
+}
+
+static void *fmode_instantiate_encode(fmode_t fmode)
+{
+	return (void *)(__force unsigned long)fmode;
+}
+
 static struct dentry *
 proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
-	fmode_t mode = (fmode_t)(unsigned long)ptr;
+	fmode_t mode = fmode_instantiate_decode(ptr);
 	struct proc_inode *ei;
 	struct inode *inode;
 
@@ -2292,10 +2302,11 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	if (!vma)
 		goto out_no_vma;
 
-	if (vma->vm_file)
-		result = proc_map_files_instantiate(dentry, task,
-				(void *)(unsigned long)vma->vm_file->f_mode);
+	if (vma->vm_file) {
+		void *ptr = fmode_instantiate_encode(vma->vm_file->f_mode);
 
+		result = proc_map_files_instantiate(dentry, task, ptr);
+	}
 out_no_vma:
 	mmap_read_unlock(mm);
 out_put_mm:
@@ -2391,7 +2402,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      (void *)(__force unsigned long)p->mode))
 			break;
 		ctx->pos++;
 	}
-- 
2.31.1

