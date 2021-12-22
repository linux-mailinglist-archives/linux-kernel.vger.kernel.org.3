Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD347D8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhLVVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhLVVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:30:42 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13211C061574;
        Wed, 22 Dec 2021 13:30:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id bm14so13617324edb.5;
        Wed, 22 Dec 2021 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQXUaN0G/M7AuMBSJmA3Q8Ph5u2SiY7RJ4xRri99ZLE=;
        b=AumMTRNWoZx/L5fXOyl3GJKgA4sfsO4D5ZIKm+9We5Y/AvzVLyE2MwEvvYCChW3CIb
         8eHNz3bxYNg52d2Wy2uFHkY0Pr1HbLd5y6c2ir8Hqyx09+z+ns1nHf+MF6MXS9JMjBjY
         Y7dKi1+vEZCDDfmcb6z2wIADqnY6UtiYCB69ca8xWN/WLwpzUj1dcRepWBS/tXPqmg9I
         XsSHNYUTy0Wn0HbRaqOq6fjVwc9mzAjH+oGFR+QW5tmMjswoSkC64Pe5nATUs94H8z0j
         iVL6HIOTOFW4VboFn7aPXJB0dcgWYRODeS0Gt/U45dzgLCplRT1ApdwPXyZDZiTBxeGv
         nuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQXUaN0G/M7AuMBSJmA3Q8Ph5u2SiY7RJ4xRri99ZLE=;
        b=MLPj4PgMMwsv6mlp1+OlFmJdkApa486j9LCHCk2H9/7DJ+qDW+ER4PRZTxVWI+8gE0
         oJsYdn1IoGUzKHiTWN51E3elVprJrpDX/dARmSpyqM5v0SUI2rXbZwP8L/yGWmtAdVbq
         //Y4Tj49S7dmzuG9Tal128sjX+cIpQPwHMQsa4ey8YPYpWMGDDIjVp6+t56aEW3EVMKK
         qHRb6Y0+nFehcuRMZhqoMPjnpjTIOWBQtIXXCEfYTHiIWDFoD6SMtXCYXnfCSw7gRgaY
         PJwAzS8+uJOkfj4vrmCgyfKZI6c8iCIZeZmx1+z1GfOlSST5w/HaXQcR+1X9cWZJOfua
         E+zA==
X-Gm-Message-State: AOAM533p4TfUowltJWbkjs4JduAnbNDrJNQjGSR/uOJ4U3qK0m5b+D+0
        hRvck5dh1f7feDnMnIB+BtY=
X-Google-Smtp-Source: ABdhPJz6Fpffv+KYXV7xi5AzTzY21/iPgukLA+zAUVKyJuepnnsc0k2qSeJgVh35yHAEQAghE25M/A==
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr4053483ejc.452.1640208640675;
        Wed, 22 Dec 2021 13:30:40 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ne2sm1087776ejc.108.2021.12.22.13.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 13:30:40 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, lee.jones@linaro.org,
        yifeng.zhao@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 1/4] dt-bindings: mfd: syscon: add naneng multi phy register compatible
Date:   Wed, 22 Dec 2021 22:30:29 +0100
Message-Id: <20211222213032.7678-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211222213032.7678-1-jbx6244@gmail.com>
References: <20211222213032.7678-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Naneng multi phy register compatible.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 5de16388a..9f0c8aa81 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -52,6 +52,8 @@ properties:
               - rockchip,rk3288-qos
               - rockchip,rk3368-qos
               - rockchip,rk3399-qos
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-qos
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
-- 
2.20.1

