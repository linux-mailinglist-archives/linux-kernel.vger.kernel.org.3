Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AF94A794E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbiBBURm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiBBURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:17:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:17:41 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v74so285465pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0QIAImud6iPXLrn9HIO0GQ1enH9FI5z6TDtrOkZu5Y=;
        b=PJzu9atye0Tb9JiMwedtVeny9KQFt/+qrpM+05tPLw3cTSNCGiKY1atVYYm4G6+gPQ
         /JLJslq4bguS6L0xzyBitiNa09KTJS9CEwoQNUwMRRJ4pPVj/AmcpiAcWMI1K3BSQRD/
         ktBoAohwo8aop0UZ9UgaIvPHjNxNQJ+HAX8RUgGfP2SeyhYbrABFnzdjaTy148cmTlzd
         HFHW/1QShZid+0zjeh/KWZrzLoBEr8Z3jM3oE30JMn4sZGai5R0TJMFTOsfZQCpJJZBE
         b+7BAiXC849fWZ7J07Gcrrofttr9IM0eP6y2S3VEeJaiyreoLAccjr+dDyJ8z9+mFl6g
         Ev7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0QIAImud6iPXLrn9HIO0GQ1enH9FI5z6TDtrOkZu5Y=;
        b=GtwZ3a9K2Fwdgrlh/k9WCJOZ9lj+77oW1+U70GnmQUe5sBQN1QkODG7QIgtIDJh62F
         hbmugTDsUOxdZki/mP7OoeQo6JPcrNatyWaZ98izpJT+sNN4bGIrTf6TkZEtJvtdu5Eq
         5cx/eG5XlLIpnJKDvREnAZLUufdWUq+So8ikQu/mySKfBkk2Kbfy+w3XTAzc3F3c8nNk
         W9Si20ddFKc/Rn11boIvNuKOs5NgI+ixZyvlB/OrFRc0r8wPx4/M7u1LhUKTS/fJWKA3
         vAnB8h5nZ1OhfJ373eqt3t9VmXntu51nqAdXzNhTNle5aYU5eBfkb14pF45aT+VK+lRX
         hPzg==
X-Gm-Message-State: AOAM5304xW+GFC4kch4EtuR+80AYiIRS6YIXIvfeCPqGWKjRWgZGNVYd
        5AwMdHjlLIUS9FaJDVN8U1fhYqShzm4=
X-Google-Smtp-Source: ABdhPJxy5CQSAJViSX2Y5oFfiLj2LWqDG+d/HseasiKr0R+wRhkp1GzgB8U0lFTlBSNlgMmbdJ1i6A==
X-Received: by 2002:a63:c007:: with SMTP id h7mr26442067pgg.422.1643833060816;
        Wed, 02 Feb 2022 12:17:40 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:346a:7cb2:d6df:c585])
        by smtp.gmail.com with ESMTPSA id f3sm27240729pfe.67.2022.02.02.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:17:40 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: add atomic write related options to f2fs_io write command
Date:   Wed,  2 Feb 2022 12:17:27 -0800
Message-Id: <20220202201727.3410310-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added two option to f2fs_io "write" command.
 - atomic_commit : atomic write & commit
 - atomic_abort  : atomic write & abort
Also, added an optional option {delay}, which is in ms unit and optional
only for atomic_commit and atomic_abort.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index c6847c8..af4a34b 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -496,16 +496,19 @@ static void do_erase(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define write_desc "write data into file"
 #define write_help					\
-"f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path]\n\n"	\
+"f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path] {delay}\n\n"	\
 "Write given patten data in file_path\n"		\
 "pattern can be\n"					\
-"  zero     : zeros\n"					\
-"  inc_num  : incrementing numbers\n"			\
-"  rand     : random numbers\n"				\
+"  zero          : zeros\n"				\
+"  inc_num       : incrementing numbers\n"		\
+"  rand          : random numbers\n"			\
 "IO can be\n"						\
-"  buffered : buffered IO\n"				\
-"  dio      : direct IO\n"				\
-"  osync    : O_SYNC\n"					\
+"  buffered      : buffered IO\n"			\
+"  dio           : direct IO\n"				\
+"  osync         : O_SYNC\n"				\
+"  atomic_commit : atomic write & commit\n"		\
+"  atomic_abort  : atomic write & abort\n"		\
+"{delay} is in ms unit and optional only for atomic_commit and atomic_abort\n"
 
 static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -516,10 +519,12 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 	int flags = 0;
 	int fd;
 	u64 total_time = 0, max_time = 0, max_time_t = 0;
+	bool atomic_commit = false, atomic_abort = false;
+	int useconds = 0;
 
 	srand(time(0));
 
-	if (argc != 7) {
+	if (argc < 7 || argc > 8) {
 		fputs("Excess arguments\n\n", stderr);
 		fputs(cmd->cmd_help, stderr);
 		exit(1);
@@ -545,11 +550,26 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 		flags |= O_DIRECT;
 	else if (!strcmp(argv[5], "osync"))
 		flags |= O_SYNC;
+	else if (!strcmp(argv[5], "atomic_commit"))
+		atomic_commit = true;
+	else if (!strcmp(argv[5], "atomic_abort"))
+		atomic_abort = true;
 	else if (strcmp(argv[5], "buffered"))
 		die("Wrong IO type");
 
 	fd = xopen(argv[6], O_CREAT | O_WRONLY | flags, 0755);
 
+	if (atomic_commit || atomic_abort) {
+		if (argc == 8)
+			useconds = atoi(argv[7]) * 1000;
+
+		ret = ioctl(fd, F2FS_IOC_START_ATOMIC_WRITE);
+		if (ret < 0) {
+			fputs("setting atomic file mode failed\n", stderr);
+			exit(1);
+		}
+	}
+
 	total_time = get_current_us();
 	for (i = 0; i < count; i++) {
 		if (!strcmp(argv[4], "inc_num"))
@@ -568,6 +588,23 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 		written += ret;
 	}
 
+	if (useconds)
+		usleep(useconds);
+
+	if (atomic_commit) {
+		ret = ioctl(fd, F2FS_IOC_COMMIT_ATOMIC_WRITE);
+		if (ret < 0) {
+			fputs("committing atomic write failed\n", stderr);
+			exit(1);
+		}
+	} else if (atomic_abort) {
+		ret = ioctl(fd, F2FS_IOC_ABORT_VOLATILE_WRITE);
+		if (ret < 0) {
+			fputs("aborting atomic write failed\n", stderr);
+			exit(1);
+		}
+	}
+
 	printf("Written %"PRIu64" bytes with pattern=%s, total_time=%"PRIu64" us, max_latency=%"PRIu64" us\n",
 				written, argv[4],
 				get_current_us() - total_time,
-- 
2.35.0.rc2.247.g8bbb082509-goog

