Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0585150D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379232AbiD2QcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbiD2Qb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042ED95F5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so11478949wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqYXAEE5hciWC62isgzvygxsJPM9qOYnGSv8u0xpx1w=;
        b=Y6cwe+piOZJTEGcF9JxJ/32QGYiHzEmVm/tYUrHsHFt9YD2RCzXemvwgHhz7LRZ72A
         8geGPzzh5wA/PkPSSoGGGYEkZTa5O2QOTAvLtY7BmTngxKuLa/zgYNqic+nBJgfB3wcY
         EvsBM3M/oUAG6KVKqueiVP43NsFOnlG1CR+LDgvczoknEkYNDJB5MxOEtlFAcGiJT3/9
         75ct5scBdKp8ho22dsq3OT3BvJ9E12C7q9Vh4K5Mat3dP1InYZjch9x6djtHEE9Ry24L
         Ww/m8fpl0PdzaSSA7267H1RMqfMUpwwJNtKDUyLetb/ITmE/czILUnz+V8Ht8sFcWIWl
         TX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqYXAEE5hciWC62isgzvygxsJPM9qOYnGSv8u0xpx1w=;
        b=JTXZmUCdDj9GoxilOPJw8gUheEX27Dc8aJIqBQwYrY+dyKTVvmw5gZL+3+P8ietJTM
         oPtnQknxXBwfnKJaTeo8PHFtvRNBpgfVJ3ZhXZfPTLF4+BHeJ8EUJlnNVBbeh7mtuyGx
         CuzzKC03lhOxCSGQHzO2U+3BHABeb1atR6LYeh0nkEgiIaEh+L/ejGiUiTcoYaVgncVD
         K0glcCjNVF98AV+vhic+rQsYH9y1M01Tp/hqIgw7OdVm0jjKsrulksBh/q+1qQTtX8os
         +SMJiJ64AYOxu6HT5V2jJZs/EXwljgORpqYtIYPhdc8eUp23mHD4fGfZoxhCPRMzrdka
         M8ZA==
X-Gm-Message-State: AOAM532AaQrJwcy2f5gmp9aivqXKir7feJ6QU2dBNjO8zxbSY2twK9fi
        0qqS2HJ7MJs7SkFv3aVRlgWy1A==
X-Google-Smtp-Source: ABdhPJx/FdjPsAC9fThal/9IUXJnCdi3dQmA7tuwKC7Ie5x894ukc46mDl7j/heKfjAafdYI/pyh0Q==
X-Received: by 2002:adf:c805:0:b0:209:e1aa:87a5 with SMTP id d5-20020adfc805000000b00209e1aa87a5mr30853195wrh.701.1651249688729;
        Fri, 29 Apr 2022 09:28:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/16] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
Date:   Fri, 29 Apr 2022 17:26:58 +0100
Message-Id: <20220429162701.2222-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

The TA_PROG_SFP supply must be enabled to program the fuses, and
disabled to read the fuses (such as at power-on-reset). On many boards,
this supply is controlled by a jumper. The user must manually insert or
remove it at the appropriate time in the programming process. However,
on other boards this supply is controlled by an FPGA or a GPIO. In
these cases, the driver can automatically enable and disable it as
necessary.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 54086f50157d..c5d7375b840a 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -32,6 +32,11 @@ properties:
   clock-names:
     const: sfp
 
+  ta-prog-sfp-supply:
+    description:
+      The regulator for the TA_PROG_SFP pin. It will be enabled for programming
+      and disabled for reading.
+
 required:
   - compatible
   - reg
-- 
2.21.0

