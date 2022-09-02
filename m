Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F095AB898
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIBSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiIBSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA44F490F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662144812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMXlQl3McI8LljLOfD/beUo4yXAI3eoC9II432XUfis=;
        b=NFyD6lg/ndGL8MrwO2IDWFqsdhveDMi43FdRhLKUOZUZwRu4DTjY9sHXO2t2vmDk1iBvKu
        9EJIlnY4Ig/1PImPNaTkLDC7oQkYamh6B7nOljAxGl9ri9ivJe5iLXVprDdElDidhVfEdo
        VOc7WnPZr9/Qk81Fy3+OUh7dyS8muIw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-203-LDdfd4MtP9KdUBjoNwMRWA-1; Fri, 02 Sep 2022 14:52:26 -0400
X-MC-Unique: LDdfd4MtP9KdUBjoNwMRWA-1
Received: by mail-qv1-f70.google.com with SMTP id e17-20020ad44431000000b00498f6fa689eso1821865qvt.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mMXlQl3McI8LljLOfD/beUo4yXAI3eoC9II432XUfis=;
        b=cYw4FErfemvNGBtJY2NixOEfWFpIpc2DPc0uGDb1oJ78mbUF2lC/4NL0m9UNom98Ld
         TJRGm08ATDL6EyVr/5tI/YQa2Bulbl6ovl9kiSyH/SJl3QN0PcLDLP2tohMl/+fUWWqf
         MsuXsOHS3NIeQwgtQLnscK47tGIeKI5gfs9hQ7dDNXHfBdNcrlYRwyAEMuuo5sEyh0HD
         CkW+pef3WQ6331W5JF4jYVdj74zUas6nLhAw+D+p6Ex0THsfflRwf9eb+REvdXCt5biR
         KygdJF/I2PTSEVGRDJLtiFRX4HOCUmrGVco16gFXFsph2vDuthqixNJho/R+kukbF9jx
         YG2g==
X-Gm-Message-State: ACgBeo3L45Z4geh7vnbZ9kk9CCY2k7nn5+1EyQVb+LRLQYgb9HswgSaf
        O7YhW6ynCzCBubMU083oiXciT9I5h0yit2T4n3UgWZKUtEz4v4aNO4ADleYaCnO3iS1pQvYBz/A
        gjvZjmCN6kAsxjanZbkY+dGnc
X-Received: by 2002:ac8:5a4a:0:b0:344:56b3:7eac with SMTP id o10-20020ac85a4a000000b0034456b37eacmr30002977qta.656.1662144745534;
        Fri, 02 Sep 2022 11:52:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ogEKHDJ2+aO2zqFgKOn0rePP35V50OUqeadZCgV7OcOEFgnmwuKzmiq0+0YezCsI8iP5uqA==
X-Received: by 2002:ac8:5a4a:0:b0:344:56b3:7eac with SMTP id o10-20020ac85a4a000000b0034456b37eacmr30002963qta.656.1662144745324;
        Fri, 02 Sep 2022 11:52:25 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id j4-20020ac874c4000000b0031ef0081d77sm1403168qtr.79.2022.09.02.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:52:25 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 1/3] regulator: dt-bindings: qcom,rpmh: Use additionalProperties
Date:   Fri,  2 Sep 2022 13:51:46 -0500
Message-Id: <20220902185148.635292-2-ahalaney@redhat.com>
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

Right now, running make dt_binding_check results in this snippet:

    /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml: 'additionalProperties' is a required property
            hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
            from schema $id: http://devicetree.org/meta-schemas/base.yaml#
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
    <snip..>
    /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml: ignoring, error in schema:

Which results in the schema not being properly evaluated. Swap out
unevaluatedProperties which doesn't seem to be doing anything for
additionalProperties.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 9a36bee750af..b3fd60b21610 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -106,6 +106,8 @@ patternProperties:
     $ref: "regulator.yaml#"
     description: smps/ldo regulator nodes(s).
 
+additionalProperties: false
+
 required:
   - compatible
   - qcom,pmic-id
@@ -351,8 +353,6 @@ allOf:
         "^vdd-l2[01]-supply$": true
         "^vdd-s[1-8]-supply$": true
 
-unevaluatedProperties: false
-
 examples:
   - |
     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-- 
2.37.2

