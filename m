Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A14C4D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiBYR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiBYR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:59:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C621BBF59
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i20so2102315wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PhrHGYYFJ/UoeUEyqMP9QMPkUrRP2Euua3cF1w3ntw=;
        b=BDUQ8FIxHFgti+MjvYVkimqQFihWbMv8hkX5vShAr3ByrKFCPsispbHu56Km7TC7zg
         lqToITqG53PSSV9hqTlMEECIUN9IvlrX5CffWUbJZGNJOQhluKyN8TZ0hen40eMSwTrg
         nuJv3Owpa1PqP5NiDNlqyeKV+MsoLDj6z5K9NBOYiCXMxOEsnUH5/OiaJXLzOVy4XdaO
         M0ZioN8pSieFxDcKzay71rgyFLIWpkwR7Vzjdeqy0NfVUj+HEwa2KNCbz4uLg9w3XXFJ
         Sgckx8/Z+RjY122yJAHlNSNTQZpmEMQw/BnC59ilWKJj+fTPzS8+Rk/EDB7QJZWRccB9
         POWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PhrHGYYFJ/UoeUEyqMP9QMPkUrRP2Euua3cF1w3ntw=;
        b=hu5bhCk2jnbFESagPcAk74Rz46UcwJTSPRHuJQHNyHWp5TMT2qaGD+k5dwRMfZ28N/
         Go7nptiqBE3/i+yj+9WI7yz0Nw/K/1ThK2ODn93/uGlRkD+i8d9p94FuPLKAY1tQr3Iy
         7mh5X+S4gE6gmPzM7ovAvdrvQe1ZMMTGAcnUfLM+kLN6JTJgDm4ZhJhcRtpG6DclwRPG
         DeaP9E/krPk4Sor+Ha5lVOiVfnQydlJvB4YPw1zV/q9y8Xm3KzllrBd0KsldnOrHGgSa
         Iwyl5y/GGocEK11XUv1nzKy7Q2PDCFVodGQToHYJhhTKqhgYk5tfgIZjXV6FIDGn94DZ
         CYfA==
X-Gm-Message-State: AOAM531ajboe8COtWI0UbQXYv8KoXptq8iyBGT0ucS33ry796TX6OEJ2
        KOLxCjam/LglLBirbkvWA7eYkg==
X-Google-Smtp-Source: ABdhPJz91dir81i2Q6xpDKe7kVh3AkArh/GAdjPZQaOye4o0PqbuI71IPDfVpIODqAxzRxKmp0N3Jw==
X-Received: by 2002:a05:600c:2c46:b0:37b:c653:37a3 with SMTP id r6-20020a05600c2c4600b0037bc65337a3mr3738608wmg.65.1645811925881;
        Fri, 25 Feb 2022 09:58:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c2f8800b00381428ad88dsm74172wmn.15.2022.02.25.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:58:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] dt-bindings: nvmem: make "reg" property optional
Date:   Fri, 25 Feb 2022 17:58:21 +0000
Message-Id: <20220225175822.8293-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
References: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Most NVMEM providers have cells at hardcoded addresses however there are
some exceptions. Some devices store cells layout in internal structs
using custom formats.

It's important to allow NVMEM consumers to still reference such NVMEM
cells. Making "reg" optional allows defining NVMEM cells by their names
only and using them with phandles.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 43ed7e32e5ac..3bb349c634cb 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -60,9 +60,6 @@ patternProperties:
             description:
               Size in bit within the address range specified by reg.
 
-    required:
-      - reg
-
 additionalProperties: true
 
 examples:
-- 
2.21.0

