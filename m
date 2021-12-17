Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8B478226
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhLQBaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhLQBaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:30:14 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:30:13 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a37so840078ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yaqftt3owVOthmZsTXu6qqocFp+xmA+2zpi/aE8bycA=;
        b=TLZOSUI03KuFnA1xZYtVGpPq9/JPzlRqU3ouxE4ZGiUNAlF1JsLqHIAscta9jcbX9y
         1d1yZBPVe9NynqBAkznN4XrKy4vP42CwDGpRKo2PAkOhMnYYc0gdd2Th6DndX3fBkpb4
         irCii+x9r3K1UjsmrIbb5k032XIOin75WEenmZyeNWnIMp05qr03wNo4K210cD6dhGia
         Atzb+gog7xtVAmliaw8t/vhkCexx2OSIGVkdKQjP3sbJiPB7S/QmEiruNn0ltOA/2cRV
         rLvakuwraY0wzyAq1Wl7YMV+FxCfCitpJdGZN29knxZYkUjtHV5gxc7GGNEXDJx2O2zE
         uMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yaqftt3owVOthmZsTXu6qqocFp+xmA+2zpi/aE8bycA=;
        b=ULWpTQ/DNCUL8ABSa7uY8QU0VPK958bh/xIGV/AIFvv2qzU7EKFrkZ00OHqpXQ8jlu
         HhZxlQTGdMi7KWP8Xvg9vGqqDXGlGmKP0F5vSeaGPdM0XTglViF13OyDF3Ufq0a7DloL
         oAnaoIPS8LxDwAZhS0TlAJvSAWppch1fnl1lBppv2KAhUwPNBgkOnC6iJPMUntaWG1oi
         PSYiw3xKkV0vxOBgMGCwwatYbl6NUf58q7NNKwKVGMULxawZYtP7YDcpyDYEqgEue5w+
         Lwtr7wdURPocNzLqQwrIjUltokFUh/8Y0yFT9DBtIL5S5No12waLbx26DC3YKHxxljDd
         Gwzg==
X-Gm-Message-State: AOAM530ODbKNwG2ptrOXz8OuFEjOnw9CtB7LvaIHcrr4zIl+YMuFvG6b
        4sBqmBNsvYwMufb8bINXkUxdnQ==
X-Google-Smtp-Source: ABdhPJwbfqITVZVw2cIK5V1Eikggxn0UrJT2uzmDNO9847zh341zXw0OoMimI2SF7q98jMIS8+7cnw==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr705346ljk.216.1639704611423;
        Thu, 16 Dec 2021 17:30:11 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z18sm414147lfd.8.2021.12.16.17.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:30:11 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 3/7] dt-bindings: Add vendor prefix for WinLink
Date:   Fri, 17 Dec 2021 03:30:01 +0200
Message-Id: <20211217013005.16646-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217013005.16646-1-semen.protsenko@linaro.org>
References: <20211217013005.16646-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WinLink Co., Ltd is a hardware design and manufacturing company based in
South Korea. Official web-site: [1].

[1] http://win-link.net/

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Added Ack tag by Rob Herring

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 4698213611db..25f94c723cbc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1328,6 +1328,8 @@ patternProperties:
     description: Wiligear, Ltd.
   "^winbond,.*":
     description: Winbond Electronics corp.
+  "^winlink,.*":
+    description: WinLink Co., Ltd
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wits,.*":
-- 
2.30.2

