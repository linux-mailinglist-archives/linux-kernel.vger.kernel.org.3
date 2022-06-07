Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB85402FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbiFGPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344383AbiFGPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200D50E36;
        Tue,  7 Jun 2022 08:52:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so23556647edm.13;
        Tue, 07 Jun 2022 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzgvlhk4U9BqT2nWRr42a6fdV0TBkWb1ZUnx7kKgOIY=;
        b=Xmm7QtA8LbazZwVsbDJKmkMqqfl8hvAjz3sTxpmRSyIX1eqSbQ+0rR65151FbQsCzk
         ZR7xCfWdH47FgNqRf8ONJ4JYs2oRt/ivVnmXKrfnGqM4KLZvrTywnDIflEb1A3ozAAVr
         ftIRQg7RcQ+3kHtLq9L8lyfL4zHQfWRe95PpUQkqiAOVCX+yvEsq+zqOG7ta9kezRY7+
         zUEDWHp/rMUOXhutie3B3JRnq6gLRf16a2Kj9mx2CLa62hFZgujl9nVSnZzMsUwc73LT
         U8QsP9RAw/o2zXzravbj9piqFCu4raGX15y58qJ2aJ+mo1UXTP5QF3PhMB79I8+LBkum
         /sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzgvlhk4U9BqT2nWRr42a6fdV0TBkWb1ZUnx7kKgOIY=;
        b=rqYcnDRV4LrNZFtdFozdllbPAmQqUPIsMmHgyY7IKQYhGy5dMtdoHOFvhZGrYhtmqe
         hygO8rrjJgJon68NfLfD8lmnT+jIWWFI6vT6MhWbHMe53CW/3d83hMtF13iDlo4uwpoC
         2gczWJpPzepPVOv3kZZ780qTbcAHytimCHGglIWYmtL83LvbJ4h6YuqELg+ubT+arA6K
         8mv4uCS5uQCgFJeqRcepE7zo6Qrd2xHUNu/qRyYS7pc5fAD2oseeaUo9g67TKBDziwxH
         9Mkc+D4J35x0OOIInCWSQVE5I0AbmYjtfl4WT9dlBeV2/Wa+HRx3hyWBsaexJW6ctp0R
         Knvg==
X-Gm-Message-State: AOAM531o81S1Ojkixsk8nJSpMKFjrqzagw5/gIOzVby4MxI3NpmNJUdJ
        W9ud1EMwuxI2zJ6owTmITtI=
X-Google-Smtp-Source: ABdhPJynq+Ula7nMmH3Td62B1hhclVnEFnjv0vbmbLjhal26Xzv6HSiwSvMVZYMDlleqbPSTJkxWNg==
X-Received: by 2002:a05:6402:50ce:b0:42e:2208:bd8c with SMTP id h14-20020a05640250ce00b0042e2208bd8cmr29456702edb.216.1654617153500;
        Tue, 07 Jun 2022 08:52:33 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id r7-20020a056402018700b0042dc9aafbfbsm10538576edv.39.2022.06.07.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:33 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 05/17] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Tue,  7 Jun 2022 16:53:12 +0100
Message-Id: <20220607155324.118102-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192's USB power supply is similar to the AXP202 but it has
different USB current limits.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 0c371b55c9e1..e800b3b97f0d 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - x-powers,axp192-usb-power-supply
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
-- 
2.35.1

