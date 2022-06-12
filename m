Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83EF547975
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiFLJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiFLJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:00:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106AA51E4E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso1602097wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bh+5cvdXh3nnzozHNpzUlua2s6tISLW0nqJPvBVheEw=;
        b=RDUvhVt18U9J3OuMRKOCldFZ/tV2MGuKPzdMcLjIrxSpqqnq3EPnIHWGXU+6Oj4Mb3
         6bTxjUXe+5kYOwV/kL6w/Uz7Hj9SlihPEFvEIEHwyoV9mrw3YjFF2T8E6f8J4Y3U3y99
         S+cOMnUr2QKpBEtWXolUFuV7ZwjBp4xwLsiPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bh+5cvdXh3nnzozHNpzUlua2s6tISLW0nqJPvBVheEw=;
        b=s4oNlmYmi3fCSxLCFlwtUp0Wpw83sLb4ZdYXgoOmzG4lSqOnKcc5TUn1WjFO+Fj1ie
         mmVFZXriXCruK1vy0zvFz6L9knVZ29pGGI8WMOixyxTVUTW/ptJEOcRTe+EO5Nul65Le
         kC4bjmqRUzUzWk4+YUvhN2JLhuCyd7N0jWkh4Wd7F/YU6116SlVyYPadvxV0MTSXhBBD
         fNkJfholmirkhmCDfmiprlUgvNEZnaQqNCtOUu7jsJ9g8AN4WRqwkpuIHyXjy0riVo60
         ZQaiuQLurPMkBTPB2m4mIndBVWl4DvErUMmKP2IHHQ+mptvvk8kcmdY2HJ2n0vixWqyH
         mEKw==
X-Gm-Message-State: AOAM533zoKMLhzgIHYxxd+W1ki/YY9KTt+mN9UunwErYRBGLi+BqtXPa
        yv9C3FIk6NMtb21cMiAskKi6/h8ztHkiSukDjwR939rFGIuXhkUbLrM3KOZ7O7S5VLaHaWksoNB
        lI8xyJWp2gwfGGQDS1T3+wKs+4xjs1kfOlfb4WghsezwMrJ5/3gL5pS1GIl6zaythH65AhibTb/
        BA
X-Google-Smtp-Source: ABdhPJzHwiWJn0Q5mqMHXp5JXd4bsJvT8DXD1tByMG5tzxXc8u3ebIVE9ktGcRLM0xx+cGfJp2Oycw==
X-Received: by 2002:a05:600c:58a:b0:39c:80ed:68be with SMTP id o10-20020a05600c058a00b0039c80ed68bemr8304657wmd.150.1655024442341;
        Sun, 12 Jun 2022 02:00:42 -0700 (PDT)
Received: from localhost.localdomain ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm4798603wmp.48.2022.06.12.02.00.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 02:00:41 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,net-next v2 4/8] net: Add MSG_NTCOPY sendmsg flag
Date:   Sun, 12 Jun 2022 01:57:53 -0700
Message-Id: <1655024280-23827-5-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSG_NTCOPY so that user applications can ask the kernel for a
non-temporal copy when copying data into the kernel for TX.

A simple helper is provided to set the iovec iterator copy type if
MSG_NTCOPY is set.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/socket.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 17311ad..98cb735 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -318,6 +318,7 @@ struct ucred {
 					  * plain text and require encryption
 					  */
 
+#define MSG_NTCOPY	0x2000000	/* Use a non-temporal copy */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
@@ -378,6 +379,14 @@ struct ucred {
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
+static inline void msg_set_iter_copy_type(struct msghdr *msg)
+{
+	if (msg->msg_flags & MSG_NTCOPY)
+		msg->msg_iter.iter_copy_type = ITER_NOCACHE_COPY;
+	else
+		msg->msg_iter.iter_copy_type = ITER_COPY;
+}
+
 struct timespec64;
 struct __kernel_timespec;
 struct old_timespec32;
-- 
2.7.4

