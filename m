Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3364F522E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849466AbiDFCiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443250AbiDEWUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:20:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE69D0CF;
        Tue,  5 Apr 2022 14:08:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m16so219376plx.3;
        Tue, 05 Apr 2022 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtngP8d0g0fi2Zi2weqgSY60agKP0OsKMyjizujaa74=;
        b=LfOLR30Fdj30wr86t2iIVLaxJGwMJ0KBcQXZVtJQZJIuAQ8Dh19WNThfA4VM3e8Ytn
         HHI932K10nMfwMEC5pKGCcpXIbQhoUUAeZ7kM/ocyYGDjfbhlE2kxs05NXewD7bjvSsR
         D9hynn+MGRET238VbNLuq5BVeHdbUYOLyGte5DmT7aV8U+9np6LwuSt1YIFplqtQIDNX
         i15w/TKzB5a5wKj1Di5WJubjB+JtFjMJhMhOOwEu+WTcWongNq1z3vcf0po9kZgSsfMB
         PbABfib6Q9EU0H6CBfKw8JXF7f4veBaMVUKg5ETkjyUsmsFXWYeuNPYdBjjYco5gVtXr
         jc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtngP8d0g0fi2Zi2weqgSY60agKP0OsKMyjizujaa74=;
        b=sUnoq488stvnst/Exqho95ARNyfY9OsotaCO/44ivdLuC26cW+x9D4xYm1ySM/xBWc
         C5fIOY5e4N1+3uJ/ztJ6NNhcs4MZGazk2bkHcI/ukK69PSIfoPxAUjzNjZY7zLwH4/Cp
         tnYHtFc2BkBsdszHMlz9twZDNNHmeBtSfdDVJ8nZ1aKlJrcuOZOUPaeIovPjXzw5JwiN
         IO22PzYwKulFG29my3jxqhO/zOQyT3gOvLjp7IAGF79tEZuQNkNbplqoHh79LzxoAuR+
         g7bb+D4DoSGwa0v0NiaXzGzLliwXfltmJz7ysuUBQACJsTdNVXSd1xwzZnyYU2j6SdhT
         bpMA==
X-Gm-Message-State: AOAM531B8QY/HvXECu87ZVDJIyo/qJyPUgJu0xNhHGVvCBRi+n+29Gmw
        PMJ9v9+iX29RZSG8iKYjkN8=
X-Google-Smtp-Source: ABdhPJyxCwrKvkUu9M6Duz48XTcvyzgBHvz1hsRU6NdhZWIFqFIcpUkk9QddmT8Sm1NZVtSH0iPIyw==
X-Received: by 2002:a17:90b:1bc6:b0:1c7:f32:3aa0 with SMTP id oa6-20020a17090b1bc600b001c70f323aa0mr6336718pjb.168.1649192889310;
        Tue, 05 Apr 2022 14:08:09 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:3:511c:41a7:57f7:f826])
        by smtp.gmail.com with ESMTPSA id k22-20020aa788d6000000b004faaf897064sm16240010pff.106.2022.04.05.14.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:08:08 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: surface-duo: Add surface xbl
Date:   Tue,  5 Apr 2022 14:07:50 -0700
Message-Id: <20220405210750.619511-5-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405210750.619511-1-jaschultzMS@gmail.com>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
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

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce device tree source for the surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v4:
 - N/A

---

Changes in v3:
 - N/A

---

Changes in v2:
 - Updated to reference an offset inside of imem
---
 .../boot/dts/qcom/sm8150-microsoft-surface-duo.dts     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 5901c28e6696..abb7964daac4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -430,6 +430,16 @@ &i2c19 {
 	/* MAX34417 @ 0x1e */
 };
 
+&imem {
+	status = "okay";
+
+	xbl@a94 {
+		compatible = "microsoft,sm8150-surface-duo-xbl";
+		reg = <0xa94 0x100>;
+		status = "okay";
+	};
+};
+
 &pon {
 	pwrkey {
 		status = "okay";
-- 
2.25.1

