Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797E853CB29
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiFCN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbiFCN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:56:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01E381BB;
        Fri,  3 Jun 2022 06:56:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q7so10517515wrg.5;
        Fri, 03 Jun 2022 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzgvlhk4U9BqT2nWRr42a6fdV0TBkWb1ZUnx7kKgOIY=;
        b=pOeBBazR97DypyM6LTiK8U40Ar4dflOf6Q9S9ZXiC4YFHvmeZ3EfCTlEmFNfiTkdgM
         0ezllszEUWwdkzSnfk/+WREnKppZPMhm5y60JvruIX9q0L46SnKE16/KWjzCfoKcOnqP
         Y7kA+q9E040mvz2ScWokPTlA0Pb4C/hgm5nGOYB1tTW4IrfbDlrZthcVenITfslN4Byj
         C0SMRkdkB+zz2lXiIJLs673qcL7oTZv9FiiLlDqmwBSVTsG4/BdV81oSYiCypaU6RqUR
         cDTbdjLeShPuDm5EWdq1sxQA5XHxZF3J+tIGs9xESP0+Idp3wrFlsKo8LJLTys2n6SRU
         TavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzgvlhk4U9BqT2nWRr42a6fdV0TBkWb1ZUnx7kKgOIY=;
        b=mVPSzVJhQRhLy7aF5j725QeZAoJUEmKQAOL6zROzEFRY08lrv4Vp/lzWw2rMN+YcYb
         aWl2/IItlCfdqYl69pItgX/8aIEHtX/ZxOCS7KG2gA87RJY+QtJSRY0DS0hKyTpvf4R9
         lesiksFGzikJznwQOyMeG6I1H2QLFPkDdZWvTxB/6EkpGpadYDC38ogqYZPXtm2vXZ0R
         oHiqlX2AVxKs34VM/MzMnDJplBsoVX/Z8hcv1F/v1bXKWOLQFZvSGJplkLg6hPD3ls25
         BxRblK4E13DQ//emt+o+lydcV/9fXjzcMsKuI7gQiJRLGtiGghFrn6ntW+zCPe17ZvrV
         eFMw==
X-Gm-Message-State: AOAM530GdJDLQy/q0KDvM61HbCKn9Q8FAvyVqoj/CrYXjA6M/cAceoB3
        yEWnsiN0dghTYgTZeLKY5CM=
X-Google-Smtp-Source: ABdhPJxWk27J7hnrwlpGkUoyXJSu5Gy7XQue8d6i2hkYd4tc9wmtAPWITUWiUyH9svhg3F5vANmfKw==
X-Received: by 2002:adf:e8cd:0:b0:210:2b10:ab22 with SMTP id k13-20020adfe8cd000000b002102b10ab22mr8138830wrn.476.1654264603682;
        Fri, 03 Jun 2022 06:56:43 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id be5-20020a05600c1e8500b003942a244ee6sm9041515wmb.43.2022.06.03.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Fri,  3 Jun 2022 14:57:08 +0100
Message-Id: <20220603135714.12007-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
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

