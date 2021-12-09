Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9846F629
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhLIVvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhLIVuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:50:55 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B35CC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:47:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 137so6300381pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7I3/ylyyWl5IlmqGZ0OG/LXzIE6BgtyXBZbZqV7mIfI=;
        b=FetAVBNY84eVNVfQNHhWrVinFl9VLlrF4UC0lLXkeynZe5F3ycaF/E39joD/8C3oGE
         z+DIeDOUggxuqMadfjKTpQincGtIoxO6DuHZ0bVCBS7DnAClL0u6633WXMnveB6iUmdY
         1muobthf85GKwawVAdqbxXFCnVVuDJLYQTUJ0Ghac9y64pDRGgDLXByLKA0C6Ghogo2c
         Ajs1wAFoH7rCsjt0ruD0kw7Unlo+WFXfzl+bMpLjpl99y8GqhtBjlCuQ7YtqkA9J9Wr3
         m2V/0xj4C7ES7oWfH0bcjRUzOlczloj9Rl7efQZSyBuqp5dQIn1USHS8wbsAXHLlEbn7
         S78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7I3/ylyyWl5IlmqGZ0OG/LXzIE6BgtyXBZbZqV7mIfI=;
        b=ega8+zICwEkGAcE6Hi2QHt6mVNomwSpN6VHMG2mnZ4DIiaJicWEBXnHmXRtSfZ1FUb
         NniAp7RLOBQzHlvfbapf00a5qFhIaw6xsOj71PrMrorZAwKyA2zbRLRzca1upzM2C4so
         U2kZV9LSFyE7ducssyfjcGQ26LHEaGUl6KIAqEOXwcefvUoKm3FJ9LBal6yt7+NnaDfx
         hPDkrp6u/Eg0FX0Z2QzThdmQ72zbiI3w/Mh5HqnhOUq3m5Ar/DLymaVDNrWaln0e7qDt
         Rg2T66TcBKHVbP5b6aYSXYYyXjAfKZ6q0tJfUtdcn5fWxyzyyrDXphUPgnH1GsvLmjnQ
         h+uw==
X-Gm-Message-State: AOAM530NFoGroxzjCIIzAtVd/nW66SfHv/8Dd+eZOBlwVPtU8yShWI4Z
        rGdzFJqMuqgtvO9s4XsO790=
X-Google-Smtp-Source: ABdhPJzMQke4Z05bn3+ZUMeWgkd6+HB4yV6eBztd6WCsaSvqwaxAsOoEUX5ZFLUl7zC1kv0egftFmw==
X-Received: by 2002:a63:886:: with SMTP id 128mr30926561pgi.232.1639086440798;
        Thu, 09 Dec 2021 13:47:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z2sm645735pfh.188.2021.12.09.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:47:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] selftests: cgroup: Make cg_create() use 0755 for permission instead of 0644
Date:   Thu,  9 Dec 2021 11:47:05 -1000
Message-Id: <20211209214707.805617-5-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209214707.805617-1-tj@kernel.org>
References: <20211209214707.805617-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0644 is an odd perm to create a cgroup which is a directory. Use the regular
0755 instead. This is necessary for euid switching test case.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 623cec04ad42..0cf7e90c0052 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -221,7 +221,7 @@ int cg_find_unified_root(char *root, size_t len)
 
 int cg_create(const char *cgroup)
 {
-	return mkdir(cgroup, 0644);
+	return mkdir(cgroup, 0755);
 }
 
 int cg_wait_for_proc_count(const char *cgroup, int count)
-- 
2.34.1

