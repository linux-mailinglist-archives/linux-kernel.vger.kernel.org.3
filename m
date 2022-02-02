Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA74A6F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiBBLD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbiBBLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4679EC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:51 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x23so39972179lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AfNznDv6b7CrorpQrureC1eis+2zp1+WJpTDBcjrg8=;
        b=n6IPg815Ohs/oagqZPKlGwYugQoYojfBPew2vXyYz3U2qVCOUccVMjAuEN34twcOAf
         c8IAEIB9HIsjqneB8W0yCxJvZxOu4oSzhU26KbN7Cj1EeK1NC51eiILXU5TD86qTJKd9
         b2whegXWE40h+D2VYkPoqm6Yis33QfpE1rUS1iCG0HswN36cnNrgMt3Di/A92lzxTfbm
         k9nBszBFqXsohIvSL/RdZwp8f/va+MmiDGQQCakigIHpFSI5P/WOT+zcPVEaTbZ3WACU
         juRQExn9wef2NHpUetNwLi2o04c+AGL0xKq0mHJPgwS/HuK7Wb/hpIRbmbr9N30V6Qvf
         iyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AfNznDv6b7CrorpQrureC1eis+2zp1+WJpTDBcjrg8=;
        b=VJsPWlfIxlzBZkMTrMoQ9GXrGr0efCYOXuqxku4YRtA5VHkqYN/BKzCg0/r5vdQlY4
         1QFbMbMMWLg4z5o7OV7PvvsY57IOypQVcOOFJYUTce5q/VlP3j17Mg4LggOPvSjCyXGA
         rS3ylX0uFiEuVh2L97sv+M7rHvcA9Z5DaGUg1m52L6ESV+wAawVnTJgPKPkdpi6HQePy
         GHaFMcbkjSn+RbPNkG8Vm12dJvbcAll+vNumoxKRrhqq0kYOcYsuZtQc9aftSVZEJPlb
         ou/R+broUZtj0Q58aTeN1HYPONi0RIV0T0zPHRGAXE3+tMNBYEaZ6W1KtEZbrN6bLTpc
         g3jQ==
X-Gm-Message-State: AOAM532Q7HQfC2gkol+R3YZGUPqj6TVl7xGkJNjNUEbbMxdpZMMGQvYR
        5X0bXBTMQ98iyAXhTlaHnIs=
X-Google-Smtp-Source: ABdhPJw0DqLHRPGt/CiIfQOjJeP+7WnZ5gOjm0b71s1NbD+VJ0L5hxMvtXcX0Ee3QhvzEFd3LVoGCg==
X-Received: by 2002:ac2:5f53:: with SMTP id 19mr22341777lfz.560.1643799829686;
        Wed, 02 Feb 2022 03:03:49 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:49 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 03/16] tools/include: Add _RET_IP_ and math definitions to kernel.h
Date:   Wed,  2 Feb 2022 12:03:02 +0100
Message-Id: <230fea382cb1e1659cdd52a55201854d38a0a149.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add max_t, min_t and clamp functions, together with _RET_IP_
definition, so they can be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 9701e8307db0..4b0673bf52c2 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -15,6 +15,8 @@
 #define UINT_MAX	(~0U)
 #endif
 
+#define _RET_IP_		((unsigned long)__builtin_return_address(0))
+
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
 #define __PERF_ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
 
@@ -51,6 +53,10 @@
 	_min1 < _min2 ? _min1 : _min2; })
 #endif
 
+#define max_t(type, x, y)	max((type)x, (type)y)
+#define min_t(type, x, y)	min((type)x, (type)y)
+#define clamp(val, lo, hi)	min((typeof(val))max(val, lo), hi)
+
 #ifndef BUG_ON
 #ifdef NDEBUG
 #define BUG_ON(cond) do { if (cond) {} } while (0)
-- 
2.30.2

