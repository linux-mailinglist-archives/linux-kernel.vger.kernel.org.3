Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C753CB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbiFCN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbiFCN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:56:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB2393F4;
        Fri,  3 Jun 2022 06:56:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso5080983wms.0;
        Fri, 03 Jun 2022 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JN5xhLwiBOldWzvgregOvN11Mr2QiqXZtW0+iAWNzDU=;
        b=M99BJuI3qILh6Lg0wKaIAW9efXlTmypyZJUDLQg5Vsgk4jgB2A8gOnv5vTIWeO3QtO
         G5AiCMZfQM3bJ3IOBB0JXrtDk4gcLHTrYuKedh0wOwW0HgFFyr0Fjy0djdxznKBc57/H
         wsuEktCi/Q3VWgAlx8P8oUsJicA8NNbn47nry032P1rRiyYnZWCWsTnF78wryq9Dp5WP
         kqcTIW5STPyHzK1dIPoYVD/QEhSx5Wl9UgtdS/tMghcwN8Q5pu6XInN/27uOAe9qV1ok
         t5gxqHFgWgojG/JDz5vPBiBQFmLn0kikjnbdXXr18+mzKrWfrovnGpOckTjD3rNpGNhq
         P/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JN5xhLwiBOldWzvgregOvN11Mr2QiqXZtW0+iAWNzDU=;
        b=3kYi3qVSzsRtwz+fSGbGl58HgHvDLn+fjLCK7gvhuYM7OzNfzyTOIQUcrjJXDsXOeX
         ML2yu4PJuBmHrdIKH6jKwttzJ5F9nipss3fzo++xGfMr8IJW3UyYhsDDezqhIC15i1Ik
         9/orkmzQkW6CGbcnfJ5hIzFfDbBXcKFeIxM3PZoOHs8IdDbtJyagALEOnSJIPtqWozn9
         J0rv09ssw/ySP3GPBgnA0RB8Zn2O5yyQCLROJSfsmX2uwNwFYuIDN25w9NSFGse6uBlo
         0Py3ebXD7ONJFwQEaJcynr7LYkXJ4m0Td7YR2DKlk0YnkAiAOf9gxPQZaNwFHBP24ex+
         zLJg==
X-Gm-Message-State: AOAM532fZJmZsUFoBiiTcIjObYdW8x5ITDFLaWaXRC2nBezUNOMXp1MY
        sITny91MpIDPUYenFbqMWN8=
X-Google-Smtp-Source: ABdhPJzDNTjUPY+X2P0sqlRa/bRCrUxtmWpjrfKYF0/AkrnzCNnW+A2QMZr3TrFEBmf82EseSuM1JQ==
X-Received: by 2002:a05:600c:1d2a:b0:39c:4215:7305 with SMTP id l42-20020a05600c1d2a00b0039c42157305mr1557747wms.136.1654264600536;
        Fri, 03 Jun 2022 06:56:40 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d4dcc000000b002100316b126sm7618765wru.6.2022.06.03.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:40 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Fri,  3 Jun 2022 14:57:06 +0100
Message-Id: <20220603135714.12007-3-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is another X-Powers PMIC similar to the existing ones.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 3a53bae611bc..33c9b1b3cc04 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -84,6 +84,7 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp152
+          - x-powers,axp192
           - x-powers,axp202
           - x-powers,axp209
           - x-powers,axp221
-- 
2.35.1

