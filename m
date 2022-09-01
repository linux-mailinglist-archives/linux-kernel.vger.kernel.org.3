Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37F25A903F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiIAH1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiIAH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:26:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216824973;
        Thu,  1 Sep 2022 00:24:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b5so21091300wrr.5;
        Thu, 01 Sep 2022 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w5hQ9lsg4aStVnWEe58NuxmSMBp6bNEY3Ax3y4vZW/0=;
        b=RFeGeqi16qSzVROI6DPTpkL3kAVLZ/kqbl1ZL/bTRjLlLtPTpjjUYRvZGjKqimHKlp
         QSVuNafhJ3QIWOGwM5BV7zS03nOJGIqyRdpAH6m/xYPbFtX097/WrFEPmNB6HC5iwT70
         6lbrShSyKlKQhpquG/CUyUyunwEBNka4Xu8tA9fKGpWOZmUmGkckLdeTr62R/oap8DFu
         yDw3fTpOGC6kr6q1jPDsitXrygQXY4MNaGUUBXG2SFDO3Ck9qpUyQjF53z5/YtPcX8/E
         QEaOH596WRWEEYgFVmcXtY6JzmK2FpHny9BMwPCCJkQeO+qRGz6LRjKTizN+NkptE8Ws
         J0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w5hQ9lsg4aStVnWEe58NuxmSMBp6bNEY3Ax3y4vZW/0=;
        b=4ovrVrJNehNyJZqQYONID16AHzWNKpNqXr+DJC67SfVLZ+qjWgoCM25CEJr0I2R8q2
         NEAoj8vVjU7s3DhTfvHXOe25MqrTS709rYSmvMvYaYzQ0yYupEIeL5Pj85Twwj+K1Tpy
         cAoYas//w+Q7hciEakvD0VZZLUgs0wK3ABFdpQMlEq3E+KO0Kc7QffTIZjU91Rnk7k5v
         IizUu0ovJijhtbl8xNHzYGi3MCCqShRLo4G5jp437+IFLJ/Zpv52wuOSLakJ7pSboRXA
         buAPVApnk/14KYlMRVPDtFCyE0a/9xUrN5LAgNkUTKgGdNHep3gEkLNxupnQpG1WCWLA
         bOYQ==
X-Gm-Message-State: ACgBeo3QPDcWhmVWWDwyic5xxd9Lcaxwk5NVrqGtOJvHTYjCC7JpjXtI
        p8WSOrAm/FJzPAttDQD8y7s=
X-Google-Smtp-Source: AA6agR5odP5Ugn3TkDqE478NxD4yIrxOlCn+qhJwW8/lHqdPEH1iwqertOhGy2R+w1bnYn4DIoIc8g==
X-Received: by 2002:a5d:6d50:0:b0:225:89b2:a03a with SMTP id k16-20020a5d6d50000000b0022589b2a03amr14509418wri.51.1662017096204;
        Thu, 01 Sep 2022 00:24:56 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003a2e92edeccsm4602717wmq.46.2022.09.01.00.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:55 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] dt-bindings: arm: cpus: Add kryo240 compatible
Date:   Thu,  1 Sep 2022 10:24:10 +0300
Message-Id: <20220901072414.1923075-12-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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

Kryo240 is found in SM4250, the slower sibling of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index a07c5bac7c46..5c13b73e4d57 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -174,6 +174,7 @@ properties:
       - nvidia,tegra194-carmel
       - qcom,krait
       - qcom,kryo
+      - qcom,kryo240
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
-- 
2.37.2

