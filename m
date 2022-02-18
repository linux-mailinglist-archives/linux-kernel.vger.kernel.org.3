Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F04BBD33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiBRQP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiBRQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:15:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6722B2E3C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:15:31 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B2B53F203
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645200929;
        bh=Fdez1AmqlsBKbf0sdm0whcYqGiEOg3dPughdxsguAXI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=NXI4erxcLg4wnIgsuHh0kFmU5I2lWf8FCMhIVgrGw8TBrb6T5DFUUGDfwyW5M5+oz
         ULtAfAVKWlILygLKj5zQ4L+10h8RgQHxNRWrNgWmKo3ov1kfoJV6hLULvMk6ZEWP9v
         ttra0hLl1n/I+E/GUF/TEDoheWpD7u1PluBhd08q9wh34/o5fLQaw64QKKXWuAzx9i
         0GmIkW56z8e1ADl40PeWqlO+XfNqCLNIWW8PP9bdjeA9yvA5rPXHQ6aJ47+Bxh2d/Y
         iq5PFOXIDK480EasAOcBLII3u12EhylNxRid+p8YC5fTIv7I6ejS9Uzq6PoGiSOBMh
         A+TOvXSYo/awA==
Received: by mail-ej1-f72.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso3269211ejc.18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fdez1AmqlsBKbf0sdm0whcYqGiEOg3dPughdxsguAXI=;
        b=fhw7VVLWR1ATRBs24hEi8KI5FPI8KmpdoRlLqVYBY2BRIoxJz++0yqwHvTGHz2VwAS
         L7U+Jp1v4nku2++cj9Sxk8PVONNiR649PtY9K4+mFrpztOvpCR4eewjqN/EX0qUpA6Lo
         a3ewPNpXm61TGY4nHIgSHtGf5poks8mzYKkYfjf9YnHt+4VZ5R82I5/VMWEl3s936Z46
         5nG0Iik0u9CdcIee2b9gI7BL5hQVcEKpZ7WRwjxf78U6B9OQBVhvZu5Qo0OJpryvnwAz
         n6xG1c+EDHEyZ43+DO7wIJ9OBvc3f0fS93RgUTCdigXAXTh28tuxIX5MMGqDgoipN8xp
         lkmQ==
X-Gm-Message-State: AOAM5308TIA665P8Eg856jk4CjaAhg4FMmMm1O2c52o9+WadqECG+oa8
        jFbdkAMUCPq7dYcT52pfoSiUvFRg/XGHH5+pwDOnm77SiVWYgmU5rST1biXFNvx9hpbn27jv8Oi
        rOKsfCegUA0plzeD06sb2/IaWRUeuDFaXymAnjbqwnQ==
X-Received: by 2002:a17:907:7053:b0:6a6:b835:dbd3 with SMTP id ws19-20020a170907705300b006a6b835dbd3mr6755939ejb.190.1645200928919;
        Fri, 18 Feb 2022 08:15:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxif3aG4j6jnGHwS6RzVrgD+2IJjpK+S4H+3CmJ2oLVH02iXXbrxboKEJzUTsWoN3HnciK9Tg==
X-Received: by 2002:a17:907:7053:b0:6a6:b835:dbd3 with SMTP id ws19-20020a170907705300b006a6b835dbd3mr6755917ejb.190.1645200928644;
        Fri, 18 Feb 2022 08:15:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id y21sm2325572ejq.185.2022.02.18.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:15:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: usb: dwc2: add disable-over-current
Date:   Fri, 18 Feb 2022 17:15:21 +0100
Message-Id: <20220218161522.52044-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
References: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver parses disable-over-current protection and some
implementations use it (e.g. Altera Stratix10), so document it in the
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 1ba96706bbcb..1addab83f4fd 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -68,6 +68,10 @@ properties:
     items:
       - const: otg
 
+  disable-over-current:
+    type: boolean
+    description: whether to disable detection of over-current condition.
+
   iommus:
     maxItems: 1
 
-- 
2.32.0

