Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB54C63AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiB1HMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiB1HMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:12:14 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDBB673F4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:11:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id l19so10294437pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6H6PLOlODlELuUrXrCLYoGeXhxxcGUB9kEy/fShHjn4=;
        b=yuJj80QeewJ2+adT1VdgjIVhQ6FRG5fnHsSu0frIUV2+jgz5s32ulViVic7VWe/w8B
         JbHJ3/v5Ykyq1Zju+8bFuuNvbWHQM2PGRjEmGZMFPBzzBpLDX1lsmlk223md9Xzl9mFd
         zV68wuqOqLAtIXKFGOZD4dFP2SM1fxjX/6Y8HiVq+IhJwRGVCcTJfP8QHOX7m076OAQE
         JA6/AgeQ0Pea2J3StVRYnW6zkowHDcMIi2W0ApNiSCZXyTKBh82GLmYttvWAioktT0g7
         eRKw3nD0jNANDcoAi5rFrYM2UYMMRZ/0wnXqLXjUDLqn+PEZ1fplx7I9eFCxIDFv4EOW
         89eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6H6PLOlODlELuUrXrCLYoGeXhxxcGUB9kEy/fShHjn4=;
        b=xqQ35iWTrd7Z3qgrDjAe8yMvrM6R8XBc+jE530Dgk7pBnyLBa0HEAkamHi4CTMcwfK
         O6qfsLOW8eL/OeGPw7x5nIRHURQDtRV+zpUF3sdM4DyD2aGmi8UBaJrX+pXUT+uE5/Hq
         2f20WRfjE//z0xs4amkvWgF4vBZZOgxMT0W3v5cvicFiPKqGLU+AOXG5g8QpvdQeZH7M
         GUfKRbHT058tOhJKhtPr1XusK2Ewwxk6zF34ofO5jrM0eBR/oOUVApL+eQK/EEBfBxAw
         Y3RZtZno2AarcIduKv8gmwjufDyvlFyWLvD6GBnwMfFBLbIj1FfTRJPp2+mlWvHr2pzK
         n2fw==
X-Gm-Message-State: AOAM531H8iqU8sR9wLtfHehCifFdsFdttiH4YHhpZzSlwqrIXYNY0XnU
        r/BfEI3QwiFWmma1XqYw5OYzxA==
X-Google-Smtp-Source: ABdhPJwvXcp5CL86BH67oNCcmHurbmKiXoJXFoBN4tPzC2nolXf9EU8whvLTaQsnxZ9c3gxr0Ef0LQ==
X-Received: by 2002:a63:2204:0:b0:378:9f08:206d with SMTP id i4-20020a632204000000b003789f08206dmr3409181pgi.3.1646032295754;
        Sun, 27 Feb 2022 23:11:35 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm16240390pjs.7.2022.02.27.23.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:11:35 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/3] sysctl: allow to set extra1 to SYSCTL_ONE
Date:   Mon, 28 Feb 2022 15:10:21 +0800
Message-Id: <20220228071022.26143-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228071022.26143-1-songmuchun@bytedance.com>
References: <20220228071022.26143-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sysctls only allow to be enabled and cannot be set back to be
disabled. But proc_do_static_key() does not consider this situation,
which set ->extra1 to SYSCTL_ZERO unconditionally. This patch add
the ability to set ->extra1 to SYSCTL_ONE, which will be used in
the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 64065abf361e..ab3e9c937268 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1631,7 +1631,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
+		.extra1 = table->extra1 == SYSCTL_ONE ? SYSCTL_ONE : SYSCTL_ZERO,
 		.extra2 = SYSCTL_ONE,
 	};
 
-- 
2.11.0

