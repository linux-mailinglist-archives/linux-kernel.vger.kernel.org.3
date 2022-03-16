Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA24DADEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355068AbiCPJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355064AbiCPJ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:56:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E793A1B3;
        Wed, 16 Mar 2022 02:54:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g19so3314332pfc.9;
        Wed, 16 Mar 2022 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpseHuuurVsvCF6c7YR9tNxdFsI8d0m+UJUC4TThNds=;
        b=gBjMX6e3E97ZuABfMI3RgeWXsztOd8Cm4w8dq+bJEjYSxA9dfOQv++x9bSStIO/gVF
         EhZyQ8AjZ/jccTBF9OD3+LWlwKTtWNp6WpMQKm78yJQTbAwJiolrPYU4E5WLjpXQ9U07
         ZWqsN0sykDJGbkvsVJreOKFLIM/U325rQEXJYdNupzAtU4jzCbZNnDpSAyXiSjxrX5U7
         EJwNcNdL20x6rziEIbn6cxEPTmgsLS2KTAIqLSoEfzXV5qcAWowVcujul/nyPkThMOfJ
         HB/f62dWx8p19fozRB3W3OS439DOYnVwndeqg5MahbJ+Sl2QmyWRLPrz3burUs5+8x+Z
         mOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpseHuuurVsvCF6c7YR9tNxdFsI8d0m+UJUC4TThNds=;
        b=fc0oGAKDjKa7i33xgq8uTNsga99TKQUE9NShVq5sXAl5VuN+OeZ26F6u9ZlxbBccpI
         Fa3qa1M4tyY4TSP9bgrjA5mTIgpI9+Qe2uCfWH2wfc2hHkRHBGiMkpJQwW8zSMX6CB3w
         jX6D+ZGVrj/sMfz4vcvpWON1XsGDQYLTCJRCdtlTm5kpfQdRjup6Im27DpOdOLltLZnc
         k2iZJUdytVQSvQtRo5LEpVafau7Uphuo7Oq6jO6m7bxR9d/mYuOtqsC3Y/bHDZQkkQej
         RlpQnJItfXhAfWAl8ztpD1JMQnahDQ5Zs1sVN90d+0xsQxZzFkbIULx5vx38vg1PVebn
         iQ+g==
X-Gm-Message-State: AOAM532eYGUQWu7vvmCbVTujn7BIWwxSZEdc4tuPVN7DsyRVP4ayhNWC
        l/OoHOGeuHzwJFqtOw+cn2g=
X-Google-Smtp-Source: ABdhPJzMZYfh+hrcbENonQvLkV0/+OhtCeCnB6JIYjtPgWQItmr7QuLJhiZEzMKcqRtQWBUnanNvXA==
X-Received: by 2002:a63:cf0c:0:b0:380:fb66:fa2a with SMTP id j12-20020a63cf0c000000b00380fb66fa2amr24400099pgg.273.1647424493165;
        Wed, 16 Mar 2022 02:54:53 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f7b8b3a44csm2567070pfv.29.2022.03.16.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 02:54:52 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: timer: Document arm,cortex-a7-timer for arch timer
Date:   Wed, 16 Mar 2022 15:24:31 +0530
Message-Id: <20220316095433.20225-3-singh.kuldeep87k@gmail.com>
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

Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
conjugation with "arm,armv7-timer". Since, initial entry is not
documented, it start raising dtbs_check warnings.

['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']

In general, removing an existing entry is mostly devastating considering
backward compatibility. Therefore, document it.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index ba2910f0a7b2..ea390e5df71d 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -26,6 +26,7 @@ properties:
           - arm,armv8-timer
       - items:
           - enum:
+              - arm,cortex-a7-timer
               - arm,cortex-a15-timer
           - const: arm,armv7-timer
 
-- 
2.25.1

