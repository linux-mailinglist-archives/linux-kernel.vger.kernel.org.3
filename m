Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B734DCEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiCQTRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiCQTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:17:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EBA20A947;
        Thu, 17 Mar 2022 12:15:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e3so5685053pjm.5;
        Thu, 17 Mar 2022 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxUfj/YGzIP4VTpLRMmUOnHGv8lAvk7GNTWCZHRo5RE=;
        b=PJsC+y+slanqZ0fOZg4N+wc/QWIg6XEQSNFZqZ6BkiWuDce1Bjy8CZLhS+HeDK6SJ4
         EEsBW+0ZX3BYDaK6J581vGWoi0JNqwg06NwsX2mT5hVXzym4Kotn1yFnqPFCidZIUsJy
         A3KncimIfXIp+mYsZN266q65sAxhspuyJ79NnbN/JU4Yt1MHEGaxkYnWD+BYSyI3C3YZ
         0bwCA/18JkKxiZczyxwRFOLgsGgYcXOnA4GK9PNTlbPbbG68gp0FBQVFQVDCF/KXUTlE
         vGcrczWSHCZEu6eOJqOVMLUCsH7vE3zaQsSKiWkhnQu+Q/VUViVK3yolXLxYetQCgKv4
         AG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxUfj/YGzIP4VTpLRMmUOnHGv8lAvk7GNTWCZHRo5RE=;
        b=VjlVUfRvq1A2sSWftMCjIr/PSUCgNBIpmqHqga2oYj9qXhke52Y3ji4B9DguXxxRW7
         u5r5xIHrKeXOOjUE76Dkuli5JPmXL/JHTOG9PMoa9G9i0ZOGgx7/h5Ei/Twp/VHYyg6M
         1yMdNnqqtKIEeUu002pBuccIwvF6uaAakCwBTJpG811fmO5+nfGp0D78kY+ac6ROJPl3
         /RQPApdlP1TaYssslwaNQ5PZWXRh1jGfRkwAf+Uns4u+25h+eRiSfI/QptL2oNA++idO
         75S3aKCNK+xD4PpsxcFU1H7Csx9NGoPmb/5traMeZDV+F0Uzs/pYJ2w7qqyWuQy9RheE
         Dy2w==
X-Gm-Message-State: AOAM532cMzjKeuDPqlL60lywZumbOZjOG0a5hDQDClJMnX+6Rvt/AuN9
        FG927yvXohAXMkOTIsnRNaE=
X-Google-Smtp-Source: ABdhPJwSsEbretjSA4xyDoEuOQfplI3CVYkHgA/VI9oeYSltQUClIE2eF1ywJVySSohih5OMimDIWw==
X-Received: by 2002:a17:90b:1e06:b0:1bf:5a9b:5766 with SMTP id pg6-20020a17090b1e0600b001bf5a9b5766mr7213164pjb.159.1647544548267;
        Thu, 17 Mar 2022 12:15:48 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b004e1b76b09c0sm7623076pfu.74.2022.03.17.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:15:48 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: timer: Document arm,cortex-a7-timer in arch timer
Date:   Fri, 18 Mar 2022 00:45:25 +0530
Message-Id: <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
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

Document this compatible to address it. The motivation to add this
change is taken from an already existing entry "arm,cortex-a15-timer".
Please note, this will not hurt any arch timer users.

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

