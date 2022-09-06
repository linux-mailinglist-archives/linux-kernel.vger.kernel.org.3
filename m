Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0413D5AF5C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiIFUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiIFUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7339C22A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662495630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vINMxXDx/GP00laEzueh2Ucc5/ncSXAIQhbYOwhIwO0=;
        b=KHjj9DNOCNrOCJ9TnXFZn2+umxsHHO4HA9zYW+2ZgtuPoMOIg7U6MyyudoOXNyZ0ABb5wU
        x+JSnqO/RxYkENdrs+NE/eNtFb4EyBdwwkSDoF8GMEGA1YV6HN7YSQ4vYR3+NTpCK1Yzt7
        U/t95leG8N5QXOaYRz4Za75+FBjZpnk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-GvxdnE_XPryLuiSjWiftfQ-1; Tue, 06 Sep 2022 16:20:28 -0400
X-MC-Unique: GvxdnE_XPryLuiSjWiftfQ-1
Received: by mail-qk1-f200.google.com with SMTP id bs43-20020a05620a472b00b006bb56276c94so10252296qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vINMxXDx/GP00laEzueh2Ucc5/ncSXAIQhbYOwhIwO0=;
        b=l6G0RuJwtoWhK3cbOjV0PA0AOd1q/Fy1ZWEz2Hbfjb4gTT/+iDaZ5umkhq7ltatR7a
         NyKk5ACxrAAD/3W+xl8N8KuSf8y8tHApiVtxGkX8LZSMYu0tLtFF2VsHehYyXLlmOrHv
         nG5d/LIgzrOw2YnsbxOZkLo2qd3w1PMYQHiVHiZ/Bcb0Z+Nwj+67o57IRBClvFl6OpFl
         Qm1sJ0MByuepjsLYpEhnWpkdrYm/V0ail4jlp/DdLQTyYOclB2JfSyHybVRptDpPTUBx
         HpMJlbviob6ljf+2nEkdUYNoJXnhZqUe9GZMsuV2QOkyrdN+5aHlK+jRjgJTpYdnazLj
         b2Dw==
X-Gm-Message-State: ACgBeo3C6A8Ke0mCYxw57NPG7ggEPIfwvtvh/3b4fhudt3pui7LMFgLE
        8s5ATSvY7EipprjX6yNkX1jwbis61bZmH48C1+VE9XLIP8UBQ9ztL+msYRsrmLjc2ZzJbAsp4G+
        4BsAQmpgJ9w/SOXuh7HCrPKLd
X-Received: by 2002:a05:6214:1cc8:b0:46e:1920:70f8 with SMTP id g8-20020a0562141cc800b0046e192070f8mr313883qvd.6.1662495627966;
        Tue, 06 Sep 2022 13:20:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7FvlA5FhvR3KvnIshbIQJl0zQIP1ibxwJlVoyeLJTiDcXTn96w5r5a1ESbR3w6uJUzZcMwNQ==
X-Received: by 2002:a05:6214:1cc8:b0:46e:1920:70f8 with SMTP id g8-20020a0562141cc800b0046e192070f8mr313868qvd.6.1662495627698;
        Tue, 06 Sep 2022 13:20:27 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([2600:1700:1ff0:d0e0::a])
        by smtp.gmail.com with ESMTPSA id o13-20020a05620a2a0d00b006b5df4d2c81sm13049873qkp.94.2022.09.06.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:20:27 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2] regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies
Date:   Tue,  6 Sep 2022 15:19:59 -0500
Message-Id: <20220906201959.69920-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

v1: https://lore.kernel.org/linux-arm-msm/20220902185148.635292-1-ahalaney@redhat.com/
Changes since v1:
  - Dropped first two patches in the series as they were user error
    (thanks Krzysztof for highlighting this!)
  - No change in the remaining patch

Krzysztof also asked if this patch in particular should apply to other
regulators, which I think it should for those regulator's who implement
set_mode(). Unfortunately I don't know of a good way to get that
information in order to apply it at a broader scope for devicetree
regulator validation. At least with this in place RPMH users can get
better coverage... if someone has suggestions for how to broaden the
scope I'm all ears!

Thanks,
Andrew

 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 9a36bee750af..92ff4d59ba20 100644
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
 
 required:
   - compatible
-- 
2.37.2

