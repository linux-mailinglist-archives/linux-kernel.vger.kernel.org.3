Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF64734D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbhLMTSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbhLMTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:49 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y7so11925890plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7I3/ylyyWl5IlmqGZ0OG/LXzIE6BgtyXBZbZqV7mIfI=;
        b=YEt96t0I/zwnRPtcUJWtCB32yHqCK81frW17Oeg4ukU+lS+COyrZiOD4g2DILT8Psc
         WGnARMS9aMP7uG0cwMmPVhtkgiOi2mkEMokHczj2acWZc31ieT3c8ukxhhoxQUbEnhrj
         QfTAtuSVJ8YjVIBye9Pjoa/tA2KMnbeo/OOe3f3TqaENJo6jTHL2XEKOvsDiTD0LUUwV
         Bsn2p3ao7Gtvxr8QOqw/+HLwb+/kiWgyeWPOCvQSUPVpMJRygrn26nnmp4+ZLAeQkpmI
         1zU9qmI9B6GMtlLaMlnknaUO3E7x2F++Fu+9B5ubRV8jUwtnwu78uPPlLzjQI/5gxDDX
         8VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7I3/ylyyWl5IlmqGZ0OG/LXzIE6BgtyXBZbZqV7mIfI=;
        b=lg9gnHqtZ0jl5FroxO3T/I50msZGY9W5uTjU0SmbgCrDwIdt76pJqSZQFNWIyDeUZW
         wkEMmTnYFk2+b6OOK1Vj4l12jBOC1IT5fhA9glv3X+k6MiEowTMoV4nj+EZxSHP0fYCY
         GTMaPN5Bpmz3S6HkzBmbvISjY1rHQTR8BcN0eyNL/XvZOidm0kSSRFA51UKHeP/3hY/d
         81Z8eGpLeZSRzcWOrim0LqxVVsySWz1e6VZiUQ+/TpBH+v3A2YeDVGrudi3MNA7LVcVe
         hMMINFiG/ZQX2sxnp/vUxnVNk+Bs02HeGPgd9nmlnY/FsWiqIFbSWxt84w9A7OCX+U+h
         Lwdw==
X-Gm-Message-State: AOAM5321poLydEqOCbKwgyN2GoyG+EPk84yLrjqLYOTAKJXYIaQ4X/Ht
        FZTI2Vb3SCQiqPX0Xr3Dc+A=
X-Google-Smtp-Source: ABdhPJy7otCQpGJA5qLk63TIGFW0endiu3Nh348wD7QO9a8pS69ZMDMSshZCediJ5oJ+c1g/9ARXNA==
X-Received: by 2002:a17:90a:6e0c:: with SMTP id b12mr223157pjk.41.1639423127939;
        Mon, 13 Dec 2021 11:18:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b9sm14052022pfm.127.2021.12.13.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:47 -0800 (PST)
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
Date:   Mon, 13 Dec 2021 09:18:31 -1000
Message-Id: <20211213191833.916632-5-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213191833.916632-1-tj@kernel.org>
References: <20211213191833.916632-1-tj@kernel.org>
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

