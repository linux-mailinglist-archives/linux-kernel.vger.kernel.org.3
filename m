Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5235AB897
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIBSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIBSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD0A105B6F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662144782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLJN7/BLiss15VoCQRispsUH3s6wfzk4G5XVQwrvZI0=;
        b=Z3aPh5M3FVS3jPgl9t5XzSw0T/n1SvfyQh6BaITZLWYnmZEA/lAMccmLVl7uMOcdrQuKrv
        Jp3AjQsU3zIpximqMiE6XlJ9APE0rgfQIK9y4JXATb6fu19a2ScrP1fAWC0AUmmwNUaio7
        sbVEVAgGsG2FRdbxW/KpBfflKiwgIWk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-c-YbB_U2Pc24vjX_KEYZdw-1; Fri, 02 Sep 2022 14:52:30 -0400
X-MC-Unique: c-YbB_U2Pc24vjX_KEYZdw-1
Received: by mail-qv1-f70.google.com with SMTP id oo7-20020a056214450700b00499144ac01dso1832306qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uLJN7/BLiss15VoCQRispsUH3s6wfzk4G5XVQwrvZI0=;
        b=BeorH4fMoMVRZeefLkhiuWaXclnfNsEtxWteuUsgX8REuE9Yvmv9iFvQrzFYwOvBGB
         KwmjrhyfrbJzHe173yjr8TfJRWtrgVsgXx2skdcVSlWkQHN903AC9JRqy2OfneC0xbJD
         B2NGg/fWF8cTfI/3Q6XBaoGDvP6oP+pUU8xx2eyqYk2vPPPvwU0f40+Edxs3wFDjhERe
         x8kjeqGsL49aWu6sulofx85ckwYEJJjnGKwY46I90IaTxFw0z3BDAzNwLjURqCCn7+p4
         jVOpLObUvUqnaKfUeCYVm0PIVhb36evHH56Ai3G9j7pfkPquSNX4duKfprUNb/tmRRpr
         HRSA==
X-Gm-Message-State: ACgBeo1SLa8coFzJ89O14D06PPMm4ZBat42qdCFDVkPV3OEVj1/wfhiU
        8gYzCX9ew1rbZBQwoP8YHhBzO6OmTTzYE2QMW8Id9wAtpHRO8xPbdbs++GkZ4kfcMjzqfsjGBun
        bgoj94o1pg4L+YQSd6gWe1tiV
X-Received: by 2002:a0c:9d46:0:b0:476:ff07:3fe7 with SMTP id n6-20020a0c9d46000000b00476ff073fe7mr30933305qvf.15.1662144750214;
        Fri, 02 Sep 2022 11:52:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7aZwLqxASsgLyT6pr2oLxtShydapkDDS6erqpAYgTyjpgPuDnQlYnCVVNVGOO0dY0TwHgdKg==
X-Received: by 2002:a0c:9d46:0:b0:476:ff07:3fe7 with SMTP id n6-20020a0c9d46000000b00476ff073fe7mr30933279qvf.15.1662144749987;
        Fri, 02 Sep 2022 11:52:29 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id j4-20020ac874c4000000b0031ef0081d77sm1403168qtr.79.2022.09.02.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:52:29 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 2/3] regulator: dt-bindings: qcom,rpmh: Specify supply property
Date:   Fri,  2 Sep 2022 13:51:47 -0500
Message-Id: <20220902185148.635292-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902185148.635292-1-ahalaney@redhat.com>
References: <20220902185148.635292-1-ahalaney@redhat.com>
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

The top level RPMh nodes have a supply property, make sure to specify it
so the patternProperties later that are keyed off of the PMIC version
are properly honored. Without this, and the dt-binding containing
additionalProperties: false, you will see the following when running
make dt_binding_check:

      DTEX    Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dts
      DTC     Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb
      CHECK   Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb
    /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb: pm8998-rpmh-regulators: 'vdd-l7-l12-l14-l15-supply' does not match any of the regexes: '^(smps|ldo|lvs)[0-9]+$', 'pinctrl-[0-9]+'
            From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml

That supply pattern is intended to be considered correct for the
qcom,pm8998-rpmh-regulators compatible, and is no longer complained
about with the supply property described.

Unfortunately this pattern is wide enough that it no longer complains
when you bork the expected supply for a compatible. I.e. for
qcom,pm8998-rpmh-regulators, if I change the example usage in the
binding to:

        vdd-l0-l12-l14-l15-supply = <&pm8998_s5>;

I get no warning, when really it should be of the pattern:

        vdd-l7-l12-l14-l15-supply = <&pm8998_s5>;

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index b3fd60b21610..86265b513de3 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -106,6 +106,9 @@ patternProperties:
     $ref: "regulator.yaml#"
     description: smps/ldo regulator nodes(s).
 
+  ".*-supply$":
+    description: Input supply phandle(s) for this node
+
 additionalProperties: false
 
 required:
-- 
2.37.2

