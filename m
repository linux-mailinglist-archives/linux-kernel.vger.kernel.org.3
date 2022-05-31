Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09917538F49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbiEaKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbiEaKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:52:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5145748897
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:51:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h19so8857379edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+aAYlhBaoqcFmdU6C9Gx84E9qMJBIbqGLgTA0/mSl4=;
        b=pwIV2cacZ4ygg//TwNYbRKiQjUBGzgJXtzcat0O1FUmk1LRXTQlUJc6YLXXq5TAeVn
         XTCERPOuIAUvyA1fsx/lioJV542cqtv6JlHCeTPnTmWtkvMqpvUNnDfn0Nn7mnVzj2kN
         2V7sQohQUnjdNW6Y0rM64nPDNwRlpqtkcahLIXo/vWcujgCoxDuG7MYyY1LbTXnUCT/g
         RwhPdpNiD3G44Ta4qb/1IKHQ5Ve1UePVPf/Fq3m871Uf1efZ3z/zrq7rBnrfJ2e3ETSO
         qfWsPGcPhc31ZKBeBSaPCp6wfmp3PQDAY3ob04CrCAty60UOsIVAlXrhkiHVyKRxzsHK
         uWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+aAYlhBaoqcFmdU6C9Gx84E9qMJBIbqGLgTA0/mSl4=;
        b=JBAkvjmMg6fK8lMAuyu2o6xZfQ5Fo2OrVOQFlPuAXnRmII1H0o2HZ1O6E5sLFPdekv
         Ti+gRrscEql4+2fdZO/HvMM/3HLwyCvldrArgXtTdm1OIWkt+M9tDBJdytoL02rYkd6i
         /wv1PCctRzMw7muwbv3udiwRiWotY1g02p2asNEUYOkSnlp/WCHBSKKTXmVfmVZ3NLQ+
         KrVLXJv4EwF8OvuZTreeL4d9UhHX/X5mgYwGyfwMNP4TsnabhRWGYTUeqBvd/rUkk/F4
         jHRElUNC9K61GEAO4j+7nFOI4JNGnOLpHUqr7/5DXPQDYoGvzsUfvqcSkayPGR2Y1l6Z
         BCFA==
X-Gm-Message-State: AOAM5330RjMWA4IPnhparS+9/x1uE07Jo4m6GgMfo7UYAj5rzpLpOgmo
        ybFeIpAZQQJdDEf/1ouM2A+0ow==
X-Google-Smtp-Source: ABdhPJw6rnERzo76jayiAAFVyPq+buvlnElOKXK3el57Jti5fQow9ZL3T4gzpxQSRGCHCDm5L/IYNg==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr63412100edd.239.1653994316871;
        Tue, 31 May 2022 03:51:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q3-20020a50aa83000000b0042dc513ced8sm5117441edc.30.2022.05.31.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:51:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Tue, 31 May 2022 12:51:33 +0200
Message-Id: <20220531105137.110050-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. Spent a lot of time on benchmarking and learning the BWMON behavior.
2. Drop PM/OPP patch - applied.
3. Patch #1: drop opp-avg-kBps.
4. Patch #2: Add several comments explaining pieces of code and BWMON, extend
   commit msg with measurements, extend help message, add new #defines to document
   some magic values, reorder bwmon clear/disable/enable operations to match
   downstream source and document this with comments, fix unit count from 1 MB
   to 65 kB.
5. Patch #4: drop opp-avg-kBps.
6. Add accumulated Rb tags.

Changes since v1
================
1. Add defconfig change.
2. Fix missing semicolon in MODULE_AUTHOR.
3. Add original downstream (msm-4.9 tree) copyrights to the driver.

Description
===========
BWMON is a data bandwidth monitor providing throughput/bandwidth over certain
interconnect links in a SoC.  It might be used to gather current bus usage and
vote for interconnect bandwidth, thus adjusting the bus speed based on actual
usage.

The work is built on top of Thara Gopinath's patches with several cleanups,
changes and simplifications.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: interconnect: qcom,sdm845-cpu-bwmon: add BWMON device
  soc: qcom: icc-bwmon: Add bandwidth monitoring driver
  arm64: defconfig: enable Qualcomm Bandwidth Monitor
  arm64: dts: qcom: sdm845: Add CPU BWMON

 .../interconnect/qcom,sdm845-cpu-bwmon.yaml   |  97 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  54 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/qcom/Kconfig                      |  15 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/icc-bwmon.c                  | 418 ++++++++++++++++++
 7 files changed, 593 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

-- 
2.34.1

