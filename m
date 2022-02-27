Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DEF4C5C92
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiB0PbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiB0Pa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:30:59 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAB3FBC0;
        Sun, 27 Feb 2022 07:30:21 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id b23so6957342qtt.6;
        Sun, 27 Feb 2022 07:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=fX7jIl7DhRISNYbrdZ7o3NlddSPJm6wn8+Fz2legfMrw0fWC7J3Dbw7TDnR5wOJdCY
         gpAxFOW7fOZ5tpfbGQXrfwbIxARXhi3BEoV5C9q1Mvv2TV+huO9eBaVRwR/Z4JCN4pou
         o+cd7icR01yEHh3RgUzTVtwekz8ocngD+m/wPuborxjbKudpyPSG3yTEUng1HKgNl5RR
         ubdjJB/NSYy+tqlkdG9UFnHkbezAj3KhR0ghlQbU70td2rW5szs8VL6YEWXJsic1R8PK
         pbusKyUqtKRy+NJVzqvm1M7K+xUXmehhDsRtAKIqpOeuxqX9i6sUSKFgPBeG7/3zPYXW
         Jmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=UZjlBObTV7iISz+8twe9rR2MlW6tmn52RkMxLEDaQ8rgiJnHM+oWIeXW03w7OjYlM8
         PFIiB9vTV5vqe9G0hod1YE2v8pKtucwATQPm5HvXaeD8q4FRZt3+kuhC7fh9pZdWQVeK
         RCqK9Kp3ocXrh019ijrc98M5iwrDBn3B7yB9scO1vD+hK6epiXBNSPuuylirVJicomtM
         kceLIdYa5a+FefF7NgmeKZMKPh0d/9qjjhwb//gDX0TOxM+HfJ6rJwdL/516p7432OH7
         6ta3GFwcRYN+mnVPXfgysBGo8tPizEkortslIdC37SxlI6MDxWX0DG0JGpo5YmJv/CcL
         xc3Q==
X-Gm-Message-State: AOAM530RKXzCpIodna3yZQSJCEOEV1JxXiK5WoEq18NN+dplU6bfr2yj
        ppa26judjfyZL6BnLWdwLCk=
X-Google-Smtp-Source: ABdhPJxQRsI7Khsgyq5bCDJkTk1UuWXiSFiSgTumT5vnLv5/CZeunbwcFbAYiHp8junh5Dy5tZskpg==
X-Received: by 2002:ac8:5805:0:b0:2de:23d0:1c28 with SMTP id g5-20020ac85805000000b002de23d01c28mr13602302qtg.585.1645975820913;
        Sun, 27 Feb 2022 07:30:20 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:20 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] dt-bindings: soc: grf: add rk3566-pipe-grf compatible
Date:   Sun, 27 Feb 2022 10:30:11 -0500
Message-Id: <20220227153016.950473-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227153016.950473-1-pgwipeout@gmail.com>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
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

The rk3566 requires special handling for the dwc3-otg clock in order for
the port to function correctly.
Add a binding for the rk3566-pipe-grf so we can handle setup with the
grf driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 5079e9d24af6..75a2b8bb25fb 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
-- 
2.25.1

