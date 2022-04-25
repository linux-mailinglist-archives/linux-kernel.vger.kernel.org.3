Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BB50DA06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiDYH2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiDYH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:28:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B946598
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:25:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so27833397ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ziux6H1iLdKChog2LcoH/mwRGV3UHnm4TrKgNzHGB+Y=;
        b=vaz1pXFPkazi/kenwkoRvbIftDZ05/krCbT3mRB+odfhQLBN5qoxfDpGnOXfNlGrij
         0wyGUAt73u78jM4jlOh4XjS7U1UD/O3WJIKJk5y8xxyX+GCUdhUNtSw0yx00HKeX+STd
         FpxRlfjH2KNsca63xAJrp36KG5VrNXjAamLO/HBKNqA3MKxpLkNX9FS/jE2GTs0acY67
         0aEuI3eoLErEs52TZH86Wk2I5i+UCLnTbB9DzAFmtgYo8znw7iV/auBrNRzYF2sORtSP
         z48KaobadC3mxsSjcFuH6dfNeXDfd+SxxGdu6CraFM40fB9ciq9CY/mf41lN9EXRZg+p
         KBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ziux6H1iLdKChog2LcoH/mwRGV3UHnm4TrKgNzHGB+Y=;
        b=rMHV78SiblV5+R/zje9z2/hCkfOBveBQo9xEbsUrIgASn64kdHpj0SNhXl3vOFL6OJ
         eURIxn58nRb6X1F94ZyR6JkXFK4WfGX7glGjGb4w6T9NGMJG+UOJSPA4af0p4dS+cjTn
         n0d0Lb6kXyFINLcgyxzpMnujOiHJRVhqOR66YZ/E7oLa4jF21a0zIIjXckiUHx/lNNw4
         50OFbdR920RveXV+SvOcNu//cR1FiI5HRYxS0plKY583hw1/BAErUONflhprLhv2wDzv
         HhTYyWCg0YJZVWE4gWcoNZCiwPypSi8VVUc1wun5PuED7sLaoR6SpWuJu+UIQ1QZuspa
         iIrA==
X-Gm-Message-State: AOAM530kKSlxRv7kQu3AUfJHDG8IkkTquWlIDCjZxDlKuGLik0PFPteM
        1pJW3kvRN9+QhJGvvZXJtHCABA==
X-Google-Smtp-Source: ABdhPJzujY14uToMLyUEAG86n0bBqui6bGO2OL8eT/pm1rS8QShVq7yUKJnKWXsajeDT7fQJaEQmww==
X-Received: by 2002:a17:907:86ab:b0:6e8:d60e:d6c3 with SMTP id qa43-20020a17090786ab00b006e8d60ed6c3mr14968501ejc.346.1650871501416;
        Mon, 25 Apr 2022 00:25:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ew15-20020a170907950f00b006f3a3d60b9csm44328ejc.63.2022.04.25.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:25:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/2] regulator: richtek,rt4801: parse GPIOs per regulator
Date:   Mon, 25 Apr 2022 09:24:53 +0200
Message-Id: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not tested.

Follow up of discussion:
https://lore.kernel.org/all/2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org/#t

Changes since v2
================
Patch 2: Do not use core's ena_gpiod feature because of lost voltage issue
         (ChiYuan Huang).

Changes since v1
================
Patch 1: add review tag.
Patch 2: Check for ena_gpio_state before accessing I2C (issue pointed out by
         ChiYuan Huang).

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
  regulator: richtek,rt4801: parse GPIOs per regulator

 .../regulator/richtek,rt4801-regulator.yaml   | 14 +++++-
 drivers/regulator/rt4801-regulator.c          | 49 ++++++++++++++-----
 2 files changed, 51 insertions(+), 12 deletions(-)

-- 
2.32.0

