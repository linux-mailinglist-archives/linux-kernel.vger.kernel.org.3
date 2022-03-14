Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6394D8B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiCNSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiCNSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:19:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9D17E07
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:18:36 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01FFD40029
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647281915;
        bh=pln0ZykfdR6U20gd/nBd69M2uvOZDkJH678+bzhKZSQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CK9/4K+/heoJtJMSg6MetaMBeyf/ukw1AvLuLpEKC38Bst3ZIPBADha1Ec9pTC9al
         5rtWmYt2gd5ObwqOSbgnxg3v5Ohq4Qhdxbe2P+eA5QA4osISR+IAlBNLdxcc4w/byR
         956bnroOukfdNlGDmCdZkhfPXWK2FE578Egb5x9QsBAr1XfdnufnPO1gESNFQBIshn
         gyqRux5aNHsAXZf1T7SrGaiRuYDxxmKk23EJ/B9eE5S3zT/PXu6ufdEIrPkX3ZMQYa
         3S/FlPmW/nY9wQsj5g7B5UXWJEaaz6++T5ECOh88HnUWHVtKb7fEkgcWp+EwMxMuJG
         GWawtx+uqrXCw==
Received: by mail-ej1-f70.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso8387850ejs.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pln0ZykfdR6U20gd/nBd69M2uvOZDkJH678+bzhKZSQ=;
        b=gRzm8kMtL7vVID+Eye1E/SCbrSGx9tHebIo6uI+hamATK4KTQ4r2xHLr/hQpHpUITA
         LGY5VACV0/FERt8W71fcov+HisLGFgAod2VyiON7o/HESK5oTyuH480Revk0vpepCoYM
         1mkfyrx6+122K/edpJqEzPf5QqeUX4EIXNy5Gs0ugRnkBBu4Ct1PlPxlpwACJVRQ4tkr
         rb1wjgINQhsJ0KzPntaPfYbix6NzAwFdiuCATgF4B9sHMtiv+p1mFT2h4llxofUF2Qq2
         ucuy7QU1TNAdI4jPIBSR4zedKPHJ8/tNh/RN51szAQ6+UgWTAPBCJpLI3lMSbLrF0MTu
         oqnA==
X-Gm-Message-State: AOAM533/XAXa/izC0UfVI0tDOdxvWAhS0H85iWNbz2X9gLJTs/ucLT6v
        WjvjBay0jmYytvbFve9ck2mtBPic01mVilCQYqybjFpnTCCKFzv7eTfg2gPBUTAtUcfjoAQKcb8
        i831MMpMBfObCiMR5VXhYXwH8RSvBzwgx1sp/begi4g==
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id ew6-20020a170907950600b006dab4cd515bmr19824108ejc.602.1647281914409;
        Mon, 14 Mar 2022 11:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGvZoe/6RDLg0+bwDl2IFe7QyqDAYzB9mn431xaRY3QoSX8/h1yyzN7TmRS6lE3IF/EQzEBA==
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id ew6-20020a170907950600b006dab4cd515bmr19824090ejc.602.1647281914186;
        Mon, 14 Mar 2022 11:18:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b006cea15612cbsm7310401ejh.176.2022.03.14.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 11:18:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: hcd: correct usb-device path
Date:   Mon, 14 Mar 2022 19:18:30 +0100
Message-Id: <20220314181830.245853-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb-device.yaml reference is absolute so it should use /schemas part
in path.

Reported-by: Rob Herring <robh@kernel.org>
Fixes: 23bf6fc7046c ("dt-bindings: usb: convert usb-device.txt to YAML schema")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/usb/usb-hcd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
index 56853c17af66..1dc3d5d7b44f 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
@@ -33,7 +33,7 @@ patternProperties:
   "^.*@[0-9a-f]{1,2}$":
     description: The hard wired USB devices
     type: object
-    $ref: /usb/usb-device.yaml
+    $ref: /schemas/usb/usb-device.yaml
 
 additionalProperties: true
 
-- 
2.32.0

