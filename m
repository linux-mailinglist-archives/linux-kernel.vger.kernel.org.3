Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044A523FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiEKVsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348348AbiEKVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:48:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68793377DC;
        Wed, 11 May 2022 14:47:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w19so5791899lfu.11;
        Wed, 11 May 2022 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ot1LRa7lM+k3YsGeal4v34AufyNdy0MxZF/OmP8vaTY=;
        b=AXb14pPDMmOnkzOW5Lh2mzzjaK3MQWIL1k2wk9OIijlmqSbif8CGPVbuHO3N2gETCX
         7wIDFgrSlLykhOrVG44eZ7CsNDS4H4NI5xFMCReT1EpftaiJUFdYySx/ouXKBLiXTkAx
         Gj7uViLfmAzrs98knICHzwPD27pUoxjVzm3UxddGr/rdd9dfvFFqbRU0J8smGlWETWzQ
         f5F7v12nmYcaeBEhLkQWP3dv8RAhViLZFt8/0J7tLJlCWEPmFx+gYTOYlwwUaTrzh0NR
         1BFL5JuPVWfWHefVmoxpJmAvePkGP5oiCISvHMxqcq5Y4eelOqO73CT2fyQicKgh55fg
         6kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ot1LRa7lM+k3YsGeal4v34AufyNdy0MxZF/OmP8vaTY=;
        b=IPcwNeNUnB3md6zKHViL5Tlzb4IP5GrRefVwmZNH7neP3n1HSn/IBFW8xIwz5Sb2uA
         m6QGbAuD5fDK1WAIYhgGpq26alR86vbGE3b/ELJJdATcT+yiWCBgZXHiNKvPtlXqXRHO
         1JVnAIBK4QDU1XjU5I0TqJhKWMN9SWofwHz0ziS1tJEA4YtWij/6AW85NafxxW/tjVvq
         gsjHMKbpwJby7H1w+uns3ckqfzkGKi24WmRNOaONlwGJQ/8clwlOepMcSJ1oEWyQOdci
         d9M4PW6+Nro2TKeaL3bhEn0tw14X3O6r5axC5U6ujkkoSlujrEpyB0Dok+w3/QKjpcbD
         TLpg==
X-Gm-Message-State: AOAM533Ng+ZrlFFjqH3SbI9rjakXrJ78V1wjJXoBgjzOZXc14Ccx1iHW
        rXfmHhGR/6lT0LgbM1JEzL4zzbnvfn74mw==
X-Google-Smtp-Source: ABdhPJznrkNMCxkMVOHw42H3DIgPFE5g6Y+i/C5ffxDgMZRnF5Av2ptrqegNJ8hHfvkCPPJ71IhRjQ==
X-Received: by 2002:a05:6512:3e0c:b0:473:a933:da27 with SMTP id i12-20020a0565123e0c00b00473a933da27mr20191310lfv.574.1652305677582;
        Wed, 11 May 2022 14:47:57 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b0047255d211afsm458891lfr.222.2022.05.11.14.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:47:56 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: proximity: vl53l0x: Document optional supply and GPIO properties
Date:   Thu, 12 May 2022 00:47:13 +0300
Message-Id: <20220511214718.50879-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511214718.50879-1-markuss.broks@gmail.com>
References: <20220511214718.50879-1-markuss.broks@gmail.com>
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

This patch adds the optional properties for the VL53L0X ToF sensor to the
device-tree binding.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 656460d9d8c8..322befc41de6 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -19,6 +19,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply: true
+
 required:
   - compatible
   - reg
-- 
2.36.1

