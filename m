Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26842495FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380751AbiAUNpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380734AbiAUNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642772742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=17q/M65gYgBO/SPoZzHGwbDSkKeNitT4nImp6fFN+Jg=;
        b=H3+E2DfoaxgSoqMjSeUPm6Kk/7e5+TB6RJ9XY8xm7vYddZn/Bov564E8oinRD8MGAj8N32
        bCWyYqj3bD7dizTSQcc4fxSZLadeyoisVKhzyp6N2naXmD7UBGMjuuISYk483gWSImDwsj
        SfP91A/owitvEst8lbJXKwT/5f8Q4d0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-qlsH8C5vMgOMQdqkh2YgOg-1; Fri, 21 Jan 2022 08:45:41 -0500
X-MC-Unique: qlsH8C5vMgOMQdqkh2YgOg-1
Received: by mail-oi1-f197.google.com with SMTP id j126-20020acaeb84000000b002c90b1bb864so5725391oih.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17q/M65gYgBO/SPoZzHGwbDSkKeNitT4nImp6fFN+Jg=;
        b=ecpLi8f+ZxB1nmFLd9Th8iiAf5dPRjb/Sp70OdmwLc7VdYJtEYeYwMkye3N6tbzEf3
         ABK5ZY0nDUE4+wtvR4nHQUqaMbzmN29osH5Fnp2acuFHuTqa6TeA9HmTScsHzqqKEWiz
         UrqSfLZZ8CU6rfAk/dmP5v/9LLkTVZrvrVZV9m+wH/9nuvL/9zTH7VKgpf19hZsxU1aU
         EqAO5DR5UxbTdhhHKXdhO5tYk3L+6lg8V/GvMJiAR+iJa1V1bKcgKIKmsT87k+5DHhY5
         Vvs6pakTYtRod7L/TqFClEl3Z6AGnBmAfjspaulvjkOoL0KmTwqvBKtI0EmFep06kAjS
         0MLQ==
X-Gm-Message-State: AOAM533lqpFf6/4oMgRXzoFGYrfJzAT1tIDX6Tirgp02cEaNAEVSq2ZQ
        2ZwGNxp0OggsfN7uU8jyfmwjo9AxD6UgrAnwQ3WRLyEQqvnT3/zGuEaJAL7ApcmoCIxSnfW/nlD
        Rxxv1yCemTUmy5Jzsc0x1jV+S
X-Received: by 2002:aca:741:: with SMTP id 62mr570970oih.87.1642772739431;
        Fri, 21 Jan 2022 05:45:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9SguOPBXUy11/Do9O3kCGX1ZokLcCXVsUAdxGjD9Ol9xJN2frusYOCbndlnUNmcESN2jJZw==
X-Received: by 2002:aca:741:: with SMTP id 62mr570954oih.87.1642772739225;
        Fri, 21 Jan 2022 05:45:39 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m5sm1349202oiw.30.2022.01.21.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 05:45:38 -0800 (PST)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com, anand.jain@oracle.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: initialize variable cancel
Date:   Fri, 21 Jan 2022 05:45:22 -0800
Message-Id: <20220121134522.832207-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
ioctl.c:3333:8: warning: 3rd function call argument is an
  uninitialized value
    ret = exclop_start_or_cancel_reloc(fs_info,

cancel is only set in one branch of an if-check and is
always used.  So initialize to false.

Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 190ad8af4f45a..26e82379747f8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3308,7 +3308,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct block_device *bdev = NULL;
 	fmode_t mode;
 	int ret;
-	bool cancel;
+	bool cancel = false;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-- 
2.26.3

