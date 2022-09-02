Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFB5AB895
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIBSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiIBSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D03DD75A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662144769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWCWlSmZFYEaKyKiurVFOsZ2PihsSoTnqTvGm6hbF8A=;
        b=W1JqL72ExMrz/Q86CWcpzTrSb4CsCZ31pqVZoEAHbdhhSp+8b5yiBAGW5wW9XalH7dnJCJ
        UuPTlkbqbq3y7ZZKxnLGbyxAadVA95qTnbyvYpRk2IpTgviW65h1wdKwF7zkx2zoy1r7hR
        uw65nJvC5i3tmq7u78dYWTiKtfh399w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-tKlGMwyvPmiKmHpr7R9YiQ-1; Fri, 02 Sep 2022 14:52:40 -0400
X-MC-Unique: tKlGMwyvPmiKmHpr7R9YiQ-1
Received: by mail-qv1-f69.google.com with SMTP id cz3-20020a056214088300b00498f11a6d8aso1815083qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uWCWlSmZFYEaKyKiurVFOsZ2PihsSoTnqTvGm6hbF8A=;
        b=a3tmW5XjJW8STeP5ginhDY3CPlTgbTKtHApx+TLdLpmkiyOdM6U7mcrthF6xSixAIl
         HcGi6CPjkqmxHLd+wGdr7V3syFVyXmJm8RVFS90Yh4KHBNhvyKju5v3Kr9ZZPCIyExuI
         R1+VVNJvL6eQu2hynLGd/ufkygJ1nC8G0gEhV0BRWkJkhqB+FQyMuEqcUIFw4n8ueZts
         dkmIdBii1kSiAMjSy+rpeuygB56HoGgFGIITX6mUDxwS5jY57jDV3M6e5WxbAoLQfUV5
         cb80NwKWW5JO1cetYG9g3fmjItRAEXjDKyFnIhxlj4JKp/hm0QZ7sEx139J+8HjLa34K
         W8FA==
X-Gm-Message-State: ACgBeo2qPX/nmktyooejiTTAjPFAEvYZOSLC5Cu5AWS0lnuK0zAv8Vlt
        qDx39YYq7llhK2QbIG4x1N4OgnL7LEAuqGJN9sthk37Os38GuIqNrmRnWeCZFd7mUrT+VCukoCu
        HfW9+wIldYGHpdSaHXYKto9ep
X-Received: by 2002:a05:6214:5299:b0:47e:89e9:e27b with SMTP id kj25-20020a056214529900b0047e89e9e27bmr30305779qvb.52.1662144756904;
        Fri, 02 Sep 2022 11:52:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6sQ1Y+//dmjxKBj3ZEaXYuHYln+NL61ZdmgRorPSxsIvkkcjpHQ8qd63mv5wb+6ajlx/wzPA==
X-Received: by 2002:a05:6214:5299:b0:47e:89e9:e27b with SMTP id kj25-20020a056214529900b0047e89e9e27bmr30305759qvb.52.1662144756618;
        Fri, 02 Sep 2022 11:52:36 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id j4-20020ac874c4000000b0031ef0081d77sm1403168qtr.79.2022.09.02.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:52:36 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 3/3] regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies
Date:   Fri,  2 Sep 2022 13:51:48 -0500
Message-Id: <20220902185148.635292-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902185148.635292-1-ahalaney@redhat.com>
References: <20220902185148.635292-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RPMH regulators it doesn't make sense to indicate
regulator-allow-set-load without saying what modes you can switch to,
so be sure to indicate a dependency on regulator-allowed-modes.

With this in place devicetree validation can catch issues like this:

    /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
            From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml

Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 86265b513de3..1cfd9cfd9ba6 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -99,12 +99,16 @@ properties:
     type: object
     $ref: "regulator.yaml#"
     description: BOB regulator node.
+    dependencies:
+      regulator-allow-set-load: ["regulator-allowed-modes"]
 
 patternProperties:
   "^(smps|ldo|lvs)[0-9]+$":
     type: object
     $ref: "regulator.yaml#"
     description: smps/ldo regulator nodes(s).
+    dependencies:
+      regulator-allow-set-load: ["regulator-allowed-modes"]
 
   ".*-supply$":
     description: Input supply phandle(s) for this node
-- 
2.37.2

