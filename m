Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50B506C08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbiDSMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbiDSMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:13:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03329A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:08:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 21so21020024edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJBICKQLh4SmRmRXg7WcqpSsoivPECC+yHqWJcRnyBw=;
        b=Sn37T4kc1gy6ZYukal91cqyroyiiW0YOKutyzzxL28XA021ppNbIRoT1O3N+vhXW3N
         +RyZY0Hy6LmczFbwuQG8t6BhAgN472/45bvNHNpmrlRfJY32fI7Or2xZy+Fhpmq3PgcD
         q5e8W4q44jtq1Q3ZvOd/MnlnC8Zi4KmpTtep9lJBACmNVsSazRv+QjwGwozjxlVq1nzg
         EUizVvuL/kBaF9D+ynoknZyRiZreXODj1OvFLz+Qk5jZ556+k35E1pjtj7X7xVgJnlBv
         BTyjfM9+ClMhojyOf1tfD6VAub9L3iLUEDfu5d7Mrq/Cfeecla3rYxMFRXU5Oed9Dplf
         NLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJBICKQLh4SmRmRXg7WcqpSsoivPECC+yHqWJcRnyBw=;
        b=BZHqKxjoiERzp4gf7LWE84FLZG175obf4oRFs9Q5YAkN8ib8pOEUwyPIWn7UaH+LXK
         cBOsTB3jFyuEH2N26KWIuJf7K4MDvxYfERavDsZ7jc/NwS3dULwXtyK2O1MZWLHV3hvh
         EGW9qo30YI0eRWuF1Y5iaFZ7pZvBS61lm5/J3dxiTqULTNQ7VOdAl4d4BgDYoake+6FB
         Q77D9BkRE3u06tpPQdiEmObRJiyUWH++sapDJNPI0yPyIJhVx0SBDqPjiPNrE26XLt+q
         4VSjBKrzYUSRv65wqIcqoQhiFjNUe9qa4FEDyv+ay0Fh6FM+UkyrJ/zx5RbIxpq76udJ
         2Pug==
X-Gm-Message-State: AOAM531u693UbT4ARdlwHmbH5ZpNxucL+ta2GpSg4VsOKHRmFt87d2Jt
        dXAgjYRUUfFRPV0k4RlosHojIA==
X-Google-Smtp-Source: ABdhPJwfSsZ+0H3n/XuujAWcXTuBSL/NU/on/b6lZHEaFDgqno2IZJZAD1kRcItiaW2nIfGLCX/8ug==
X-Received: by 2002:a05:6402:50cb:b0:423:d7a8:719e with SMTP id h11-20020a05640250cb00b00423d7a8719emr14101396edb.37.1650370112033;
        Tue, 19 Apr 2022 05:08:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b006e87e5f9c4asm5677200ejb.140.2022.04.19.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:08:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND usb] dt-bindings: usb: samsung,exynos-usb2: add missing required reg
Date:   Tue, 19 Apr 2022 14:08:27 +0200
Message-Id: <20220419120827.249627-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

"reg" property is required on Samsung S5PV210/Exynos EHCI/OHCI
controllers.

Fixes: 4bf2283cb208 ("dt-bindings: usb: samsung,exynos-usb2: convert to dtschema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Fix for commit in v5.18-rc1.

Hi Greg, could you pick it up for fixes via USB?

---
 Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
index 340dff8d19c3..9c92defbba01 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
@@ -62,6 +62,7 @@ required:
   - interrupts
   - phys
   - phy-names
+  - reg
 
 allOf:
   - if:
-- 
2.32.0

