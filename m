Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB6E5225A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiEJUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiEJUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5728C9C8;
        Tue, 10 May 2022 13:43:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d19so134585lfj.4;
        Tue, 10 May 2022 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9G++WF8LonnHZDYny2HgBv8zpOOV1ZfhnXecCxIdB/c=;
        b=oC1nDZJUIcoxmeJuf46XKLCdKsFVbv14mRDQ4TCbWRRZ/2T/blqq/pVinPV1MpNFRs
         Um1zTgcqa2xMflirwhsM0Qyk1k42MLQ6cgey3SEWNUppejuFdx5nMx2+NXuP0TlTg9dH
         qfqttfMMFg+eN/2I7aPeGYh1D+rdO2bgTt2aLhpYLLkJULM1XbGE+ilKZbnvEeMdSp8q
         9dUNZo/woa+ChY6rQXCvA5hUAnqLqHxeKFN1XQ+pdzFqPGfkOz8ofMwh9IYJBF6J8FT0
         H7n1QYqPAvtCCPVuU78xu/RQhGTacUyYqVpk/QzjS+Rb0Py6ir/RDSRYsxaa8aguH0kl
         b+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9G++WF8LonnHZDYny2HgBv8zpOOV1ZfhnXecCxIdB/c=;
        b=MspUPSbYxvzyiBKxyZDae8QtRJzjmZd7MjpAxLXu3nXqBwpH+BPekc4K1i13U7RYF+
         byAxkn2YSyRO+hQR++Hq2wiV2AkwzBN+3JY6quaTnIGXlVIPlktI4qzpSjIeA9dKs2XS
         yNbHspvNdBu2snCbNRmofF13pEunN6hHiz3DFJT8HbRua/RXbC3QLBuQt25GTF2/h74i
         DKwFMx+Z1B/kTogEjbh6izQedaSdZX17irT3/5t3AmTqtatxV75K0lYzHf08Mg1J7fWR
         43sXneFdd/qTtjS9hLwbfC1SBxF9yVIfa792byt4Z8pBm8tEtvEbnKnhoF8GpY7e9pWe
         Zq/g==
X-Gm-Message-State: AOAM5305oS/kKEIpmVMFk+O2PziBmYPOMrApsCYehhm2I8n+I7TYRagv
        WvQDJD+itCAFeZJFjmFc1hviGJ3l0g0=
X-Google-Smtp-Source: ABdhPJxKnWdhAbmEYBGFyTemRsJT1LJ2+kqjGBTzjHFMadp54oVMMqLucP1KgHZ5gnSqoem9VPazxg==
X-Received: by 2002:a05:6512:21ce:b0:473:d8ac:6c74 with SMTP id d14-20020a05651221ce00b00473d8ac6c74mr17768519lft.63.1652215407629;
        Tue, 10 May 2022 13:43:27 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b0047255d210f0sm12318lfz.31.2022.05.10.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:43:27 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
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
Subject: [PATCH 1/5] dt-bindings: proximity: vl53l0x: Document optional supply and GPIO properties
Date:   Tue, 10 May 2022 23:42:52 +0300
Message-Id: <20220510204256.8874-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510204256.8874-1-markuss.broks@gmail.com>
References: <20220510204256.8874-1-markuss.broks@gmail.com>
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
2.35.1

