Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592834FC141
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbiDKPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348169AbiDKPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:46:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33900272D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so6797701ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/VH4iXX/HSvKxY6FnWRf9tFEMBnPZdBMAJ6em5xnqg=;
        b=UGGTSUjSAL9NJgQLtybygrDJb4vXO3cNduQvPayzRK+bZW0CJAg/czgJYYpwUkCkz/
         g2sVarYA4gjU4dM3pX/7gZQJJV0Rf3mP673DCCsOSXT2a5wv0OR+lDBY9UIbgVk5fPEj
         Hmj11yCdw1n7nlh2Iptx3Bjw3oUf27qh5v2nVFKVdT/bcBzwz9jxxJMW1goeUwzgyVa6
         y8+HnYKi19tDgn18Vk6ieukuQVPeLbijXrNeTGVZNoCKcKPqFQbTUD3bGT/6AxqcrEyj
         n/nv/lqpTOcTxkcfHs6oaiA3R65VSov7sb/iBdypQzoO4eb+tGYdvmQt4gF5v0KXsvjD
         Grbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/VH4iXX/HSvKxY6FnWRf9tFEMBnPZdBMAJ6em5xnqg=;
        b=Dwh92ZcZ5CTglfwl2aR/KywE8r82LNumwSjzlSZtWRzASUv0kjEtw6A2wcNTjiXDnE
         ksQvkKC9gfZ5hM2QLWiBQhjDtFRG8Z0u/0wgJ/eiMvzDykvPBVqxSvgwmzkHoYZMXoD+
         1hInN9JoUf+Gx7v1Dhi+plnNnkGNdzgk3SXoRTMNE58jJDvXdgNfv7i5REMhRUcj+ncQ
         6xIsQWdDd7klhplqMpHl4hT6QSyh9Nn9+OrJxvuCma32zLcMtOghgsNxTpaTskKWxm3C
         URfx489ijcKQ03T10T2OuOdvB1M821Yb+a8WRqJhcVkhpc821Cn7XbeUAqmFEFz06psN
         5e1w==
X-Gm-Message-State: AOAM532C7Rx6fGV/p6u3bGbMIvtBsKZ7tEH5bRzEhnkvF5weLnpw0k5u
        B1m/twksZT1j0/hiy6xEns0INA==
X-Google-Smtp-Source: ABdhPJyyTzBko5kSxEeXxWHuBtOf1c1YnoIFTwVmCQmEzWG+0S2JVR3bspyNTYSGSf/bPjPbl7Ff2Q==
X-Received: by 2002:a17:907:7ea3:b0:6e8:92eb:3dcc with SMTP id qb35-20020a1709077ea300b006e892eb3dccmr5019092ejc.75.1649691846674;
        Mon, 11 Apr 2022 08:44:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm12173177ejj.74.2022.04.11.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:44:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v2 2/6] dt-bindings: opp: accept array of frequencies
Date:   Mon, 11 Apr 2022 17:43:43 +0200
Message-Id: <20220411154347.491396-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
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

Devices might need to control several clocks when scaling the frequency
and voltage.  Allow passing array of clock frequencies, similarly to the
voltages.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 76c8acd981b3..1d7216008f95 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -50,6 +50,14 @@ patternProperties:
           property to uniquely identify the OPP nodes exists. Devices like power
           domains must have another (implementation dependent) property.
 
+          This can be also an array of frequencies for each clock provided to the
+          device.  In such case value of 0 means the clock frequency should not
+          be configured for given clock.
+        minItems: 1
+        maxItems: 16
+        items:
+          maxItems: 1
+
       opp-microvolt:
         description: |
           Voltage for the OPP
-- 
2.32.0

