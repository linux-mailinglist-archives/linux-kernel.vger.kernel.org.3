Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532C649E350
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiA0NWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiA0NWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5326C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id n8so5320732lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPBQi8ycxhPpw53EXEIDBSTw4oWSjfC+savcVruO6uA=;
        b=Tpaq7+XtiHccGdmKT2dHoLOUmnzNF+jfgtEk86QJIzlWNOHSysoJYKZ7Dqbi/kaJAO
         WkU0TxVs/FwZTd84TaKffKnwoEufv6KXABBbCUNEyhdHIyXHVUk9I3VYaBTc25ZHt60c
         pZM/wASw8EWb7NpExZuMVLf3zpNnGWNi1MeQM5Tj5lEGHUm8B+olnXufkAy0vH+hv5U7
         fsA3H1GRaM6SH8ZkPrEiN0Jt+vgQNXVBMMAEcBr800FFQDTTvZtK6GHpYjOI6jn03xPi
         CfreNskhgv2nhcPmFFLQztCnB7SZOXPG4AfJ4SDky6ZE4DsN3vuR8F4jYUpevN2CHOPV
         Zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPBQi8ycxhPpw53EXEIDBSTw4oWSjfC+savcVruO6uA=;
        b=VwAlFel3rgkUn6qyL04VjXvrusREcNuoT5g+U+NhPZ4J5lAsFmOBkgCfBnMOmc1jee
         tcCKi5UceHFAHntMMWr8vEw+U6mNGi0PTmciMwq3MQjCLr8AWFk+Dtx/FHZx7X/MsWcO
         wpLc1FLPdeacC1BnM9CKXLRSnB2+JWGKlbFKkKnuj9cT6+bgBT6yg6y8wl14IGjci9Yv
         ICN1X58ugis4X/DE/bc7h+CfjM8cUyyj65UD+1LaV19gDYC4lhF6UBL75V1lMrBQVymP
         b343HA3uAYsVS7MoZ+cU42CfUz7Tz2Ij4Rx5MLp7JHwGv7S6pHFKFQXT3qvo9K0UgBAM
         V5ug==
X-Gm-Message-State: AOAM5338V2dB6qmqDbwurXfMO2msJ2ZjN5d6PjYCxAMD/kBLugI+M/k1
        PIK/npZzrmjPQZkjbuAIhrs=
X-Google-Smtp-Source: ABdhPJwSkig+CIrvQ7RJLWbX3c1g4+OgDnSWHAkTP04VyFSrh+c+5R/3TRnzbH8VSa30R2THSSL5ng==
X-Received: by 2002:ac2:4e08:: with SMTP id e8mr2910679lfr.266.1643289756126;
        Thu, 27 Jan 2022 05:22:36 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:35 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 02/16] tools/include: Add phys_addr_t to types.h
Date:   Thu, 27 Jan 2022 14:21:20 +0100
Message-Id: <0baedc091016e35d738a9439d9475371d00f8206.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update types.h file to include phys_addr_t typedef so it can
be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 6e14a533ab4e..35cedaf191e8 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -64,6 +64,12 @@ typedef __u64 __bitwise __be64;
 typedef __u16 __bitwise __sum16;
 typedef __u32 __bitwise __wsum;
 
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+typedef u64 phys_addr_t;
+#else
+typedef u32 phys_addr_t;
+#endif
+
 typedef struct {
 	int counter;
 } atomic_t;
-- 
2.30.2

