Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A95354F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbiEZUqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349056AbiEZUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B1A473
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so3179885edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnybARV3PwUYIGMqQC+Cnp8reh2zKysuGjn0nOXwzUs=;
        b=LihLiejBgtb1JWrkSoCEc7iO3MJvpnBkTVV4nodP5KXPCg3pChJQvYNBPvc7Zfdnkm
         5kMTPWtUsCDj6IVl3U0gws1lE0+lb+/Apc3ac6Rg8tciBGgMw/SJWQY9WK5XmoPjtOIC
         WKvC8XMPKlRJRz7omcLDaiX46xme99b17SQW58lrsZC7eUWctqT6NuWadl7BbPnbzGzB
         Hw1U9Dxdqcs/YkrMU8sbqf5W9ta5hF7u5FkxU+fj/+t6RQ5YZTel8kRpGSd00Y6eQuzV
         7DAk7sS9eCLb2BjOMJhOf94mnqQCv9qFabFmxvYP6SA+QFavLJqGVROURE1iI/7W0Q/Z
         TvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnybARV3PwUYIGMqQC+Cnp8reh2zKysuGjn0nOXwzUs=;
        b=25oP89iRKjYijHFOK7gPOIyydpatR7LlbuZQN7y10q3WrNS7RUVw6h146ad3GZrGiD
         orBjUaaMLUjWgsBMcTtMV/3TvV4mw5JHKliOjgb3xsf0JUDqMJ+kGiIQ4hkuvr2sJPrF
         auzEosnP6XL/cn1kRsqxyxvdrMxpBEzUYx8bnwqGFQpNnmjmK9cgz2MOnJY6onUjRcDn
         nhzusuxBzR8ImpiZJVBFRg/yoVfdJdBR6zRbU3C24yAjZJ37Bjb8L05O4P67tRFy3lpB
         nCGMGu9K3LFiABviKxu7gMt8j8chwK2uyx3Uo7OF3RMRZhlYH0c+Uzv/JnrsBEie2dmx
         fEVw==
X-Gm-Message-State: AOAM530u7zzgmvxW9kMHgb4VYWDsV30uCiU2ItHZeqJWK94xFZLFOH4h
        5Tg69b28CtFJcWEzEw+pJepz7A==
X-Google-Smtp-Source: ABdhPJxhrSUNdF75HeB2S4wTXDWWHMko2Vvbdd8PFPVfzHBp9hwcw7GOu6CQNFmU1ukyWR8Rvsn6EQ==
X-Received: by 2002:a05:6402:524e:b0:42b:5902:1f26 with SMTP id t14-20020a056402524e00b0042b59021f26mr26047973edd.153.1653597972244;
        Thu, 26 May 2022 13:46:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gc21-20020a1709072b1500b006ff16f48e2asm813254ejc.76.2022.05.26.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:46:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] arm64: dts: amd: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:46:03 +0200
Message-Id: <20220526204606.833054-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts | 4 ++--
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
index c290d1ce2b03..02bff65e5fd6 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -20,8 +20,8 @@ chosen {
 	};
 
 	psci {
-		compatible   = "arm,psci-0.2";
-		method       = "smc";
+		compatible = "arm,psci-0.2";
+		method = "smc";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
index e0926f6bb7c3..07dab1f1e3c8 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
@@ -20,8 +20,8 @@ chosen {
 	};
 
 	psci {
-		compatible   = "arm,psci-0.2";
-		method       = "smc";
+		compatible = "arm,psci-0.2";
+		method = "smc";
 	};
 };
 
-- 
2.34.1

