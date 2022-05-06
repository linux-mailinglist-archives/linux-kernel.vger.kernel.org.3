Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C5C51D8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392449AbiEFN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392443AbiEFN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:27:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FB6973F;
        Fri,  6 May 2022 06:23:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so10001380wrg.12;
        Fri, 06 May 2022 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrHJifezRBbBXBz1Br8ccGMZFPK/Rrov+5oYjaCH9Gk=;
        b=L/PJa/H5NuN1TWiAxR+lSyYUntdgdxyzaUxLMhhzQU1uEZxUKGqrUAQndyv2+9tT7L
         fglq80K+GeWokMSbJsFYHozUf2PZMjiR8VoLxInGrN703h+M4NI6eTodBSyLJ0d8ITO1
         5moKaTWnFgDiSztySget/rUjUBCgUzDJLczKJhs9Jc3EmqgAVhj+zSvSC5NS551slsq8
         AYTb1x/Hr6SfWr1vDBfHTGHObcGAx5NelgESDu4wggbpFFfu2VNXrDkGMzCdJ9BYiiXN
         Scz8wPLNDlm9xi6aQByFpzrLFJB4DSyYdRRdEJetwBpzbDwxlsc08r75PAaOOc5aoLi2
         9vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrHJifezRBbBXBz1Br8ccGMZFPK/Rrov+5oYjaCH9Gk=;
        b=EmuebqjRz4QLyCKNwL4EmHY+Znii+rNrD0SFWFKdr9Kf/SBMU/IZDqpnO258+t8KBi
         DRy1pfR8pH4oN6E+DBdT97XVZe/UEK5Egn1B5exX1RE6Qol/nVY+VTGhKBGKOh/Ty9zW
         vijvU84QbKVoq6LyXnX0Bx8ZeBuP5OljcAIYIOsdrYXxELKKwDAyvrYDWZSL36/VlCXF
         BjHOi3o3zCbFRPfW8TKl4YJ8W1XB8cjb7aHjBjzBCS9+EFZ6oL9WwuaSzTQlm9D0Zi4u
         OhX/qUXXt2m0dPlwaC7MkB8/KLUGuG78hEdayQv3RHm+93bzeLhB9xMQP4vir/n1eINS
         51CQ==
X-Gm-Message-State: AOAM533TE4HH242ko/tH4at2mFKmlwN2Xan504NoL8uXqVoSQn3AsMJc
        uVO8gpCKD6zmmkFoGPdP+JY=
X-Google-Smtp-Source: ABdhPJyJxXuIKz19SlZeK1n89joxjE9EVSe0sZHYzY/a5EnolYlYwooSgT9CYN+A0Nh2O2S/EbvMYQ==
X-Received: by 2002:adf:f187:0:b0:20a:dfb0:766a with SMTP id h7-20020adff187000000b0020adfb0766amr2826121wro.517.1651843397932;
        Fri, 06 May 2022 06:23:17 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4089000000b0020c5253d8d2sm3669451wrp.30.2022.05.06.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:23:17 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/4] memory: tegra: Add APE memory clients for Tegra234
Date:   Fri,  6 May 2022 15:23:10 +0200
Message-Id: <20220506132312.3910637-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132312.3910637-1-thierry.reding@gmail.com>
References: <20220506132312.3910637-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameer Pujar <spujar@nvidia.com>

Add the memory clients on Tegra234 which are needed for APE
DMA to properly use the SMMU.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 45efc5139960..e22824a79f45 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <soc/tegra/mc.h>
@@ -70,6 +70,26 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x4b4,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APEDMAR,
+		.name = "apedmar",
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x4f8,
+				.security = 0x4fc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APEDMAW,
+		.name = "apedmaw",
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x500,
+				.security = 0x504,
+			},
+		},
 	},
 };
 
-- 
2.35.1

