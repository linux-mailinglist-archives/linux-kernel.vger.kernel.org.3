Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33C34A6F76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiBBLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiBBLDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:53 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4AC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n8so39818076lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ni5LWXsIdvXQT5/BHLGBj8Xv8S8a5SpvUuYuO5CqlTQ=;
        b=kQMSrAAjI+pGgQ8SlI7flQGHgATskFtcVSsGFmCJJ8bWB9j7HLn6o0tz+dKR5V1Iu3
         pJeqP0UT6KkL+4dg/IMM3Qqk65FntjaeicFvJREmCu/3N1TTAOze+61vomGoOc+t8f9t
         V8wr8QPrYHlC8XnROE/k9ytRBlWoffBmqwdzqk5bCkHOkhKotCEd+PU23JoY4raGiZwG
         CzejVTCz/QF2GCp7jK/dw2Yt1HIrb96C86GFdiP992FPpy49oZa3DD18vdmsPG+Kzwpj
         7tsQlyacjvDGLS9Xvw7NJ4SuZjzLII3fAqx4hnAENjia3ekGa3tguU2YIf9mQodprjVx
         RCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ni5LWXsIdvXQT5/BHLGBj8Xv8S8a5SpvUuYuO5CqlTQ=;
        b=dz9dtUuGResBk44mvpK50FSE1UuQ6pxG3Er+ICXuaaSMVbOPfTDmuM/5xRY5+Q25OS
         yEF9oiyWS1Lg1tkbbsK4bMmyxraGFRYaJ+Hn85IRUtfI2+FRp8csulXAknWraZ5tV9mL
         DT8GoAwYAXokS0zt7M3l2/baPgXZ8yvgMiV9etZu+JgiTRcvpSUXRMeFqY4w6jqYhGhz
         +ABV84pSZMoiNNfLs6SM8pKbrX1g0nLANLbIPqQc0R3nKkY8Y62dQGochPxqDIs05E99
         o9EPYkvooZORIGCX4+9Hl8CM0+m9nvqEn7I2QkGEvnHTf756WWb8TFk4RDE/IHZ1Cho0
         gzZw==
X-Gm-Message-State: AOAM532nLCSc7YUH+E6t87Q+Qm66e+RnYi5f8aTLem/RlHraccQZcLVS
        VyFq/XV3ckysIJqwga3vThAjxxctBh0=
X-Google-Smtp-Source: ABdhPJwX9zIpPiaQznX4WrTegPGXBWM9JZIncOyVQRXmZKFqn0uyB8WvaDPXETkhWrVksn2itSiWjA==
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr22025537lfo.99.1643799831178;
        Wed, 02 Feb 2022 03:03:51 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:50 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 04/16] tools/include: Update atomic definitions
Date:   Wed,  2 Feb 2022 12:03:03 +0100
Message-Id: <082fde69debc36bfc56cdb413d847dcd6b1e36dd.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_long_set function to atomic.h and atomic_long_t type to
types.h so they can be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/atomic.h | 2 ++
 tools/include/linux/types.h  | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 00a6c4ca562b..01907b33537e 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -4,6 +4,8 @@
 
 #include <asm/atomic.h>
 
+void atomic_long_set(atomic_long_t *v, long i);
+
 /* atomic_cmpxchg_relaxed */
 #ifndef atomic_cmpxchg_relaxed
 #define  atomic_cmpxchg_relaxed		atomic_cmpxchg
diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 35cedaf191e8..5908e58c3598 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -74,6 +74,10 @@ typedef struct {
 	int counter;
 } atomic_t;
 
+typedef struct {
+	long counter;
+} atomic_long_t;
+
 #ifndef __aligned_u64
 # define __aligned_u64 __u64 __attribute__((aligned(8)))
 #endif
-- 
2.30.2

