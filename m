Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE134DADEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355046AbiCPJ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355039AbiCPJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:56:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90F35276;
        Wed, 16 Mar 2022 02:54:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so4536262pjb.3;
        Wed, 16 Mar 2022 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5mNvrZN9lZkpS+QOv00K0RMgjrUj0vzj/s1xuppdno=;
        b=Xr+0fdTsz0Txo88MbxgIxbCziPWIEblzXPq+hZGB941/jv6mGciPxI7tGvF1p4Dm1V
         t5pOISmYaso3KRj378Q9aplZ1ZuJ4weDywWg0t7NlDEpwKQunOvNtAGxrF/gF+8vuw7m
         vdAXRI6tYRbQZjuhu0LNnpu3PJtiAilooUQ/R/fzJrMw0QiMPkuDfwRWgT8+37EM6HgP
         Vlpb7gFuUgv9/PcyKPMwdBOb5kuIal3VL8ifK7gpdbx2OiPDigl2/xyHFUn+QFHzZ2O9
         gtIwqdB/YrwjzKH6GZLyb0DkUA8VTPiDK4NRbC7Y4MMpraL05vTzOQYsafPe33gjrkW2
         K2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5mNvrZN9lZkpS+QOv00K0RMgjrUj0vzj/s1xuppdno=;
        b=3YcZ7Bx4WCnoDiOWfz9/yIGjuNtjDLR7MpEjM5TAQCfV/gjTbxcbclOvgYcmfbue8S
         C2BR1HYTWMFMFzfHqWz7Ei/MPV8hhoI6udCVqukeR4c5qpCukfLNbz2jWbROAXHeyeE9
         RfchbhwgJltRWqqbLr9vS+/PSgD0UxsNZT3OUnvkVluuPNOh6VpxVXZzTLxHMboAJT/s
         P13SxpcF4hI//lLGvuGAqHbhT4hniqzm1e7hZs48cuDclvHLkIyk9CK+YUgCDO5IXw3L
         MIcZYdQISOARpEBloKMRV2+4shdStUja5VBTF/NimWEZIfMqwK9MyjbCj+6j3IznikWn
         73DQ==
X-Gm-Message-State: AOAM5322gWx8GOY7G8Cu3dL0nD5hxyCn3bAgTj0d3lhcEjLC6+fo8xK1
        bZ3MeoVchrm6ld3yAa2L7mE=
X-Google-Smtp-Source: ABdhPJyIJmE052pBUPiWhEKPUBd9SEDzehcGzTSiuc3MHkMAx6skUQgvtIK8pGrRgk+i+HeeXnNJ6Q==
X-Received: by 2002:a17:902:e5ca:b0:152:54c1:f860 with SMTP id u10-20020a170902e5ca00b0015254c1f860mr32819967plf.35.1647424485335;
        Wed, 16 Mar 2022 02:54:45 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f7b8b3a44csm2567070pfv.29.2022.03.16.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 02:54:45 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: timer: Rearrange compatible entries of arch timer
Date:   Wed, 16 Mar 2022 15:24:30 +0530
Message-Id: <20220316095433.20225-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
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

Compatibles entries of arch timer includes few extra items and enum
pairs which are redundant and can be simplified in a more clear, concise
and readable way. Do it.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 .../devicetree/bindings/timer/arm,arch_timer.yaml    | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index df8ce87fd54b..ba2910f0a7b2 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -21,17 +21,13 @@ description: |+
 properties:
   compatible:
     oneOf:
+      - enum:
+          - arm,armv7-timer
+          - arm,armv8-timer
       - items:
           - enum:
               - arm,cortex-a15-timer
-          - enum:
-              - arm,armv7-timer
-      - items:
-          - enum:
-              - arm,armv7-timer
-      - items:
-          - enum:
-              - arm,armv8-timer
+          - const: arm,armv7-timer
 
   interrupts:
     minItems: 1
-- 
2.25.1

