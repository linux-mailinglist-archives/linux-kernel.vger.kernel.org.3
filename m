Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C914FBA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiDKLGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345864AbiDKLGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:06:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FE44A27
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:03:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so30050065ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imus7EzT9HGnez1gAdtPtsmomcq86LoFHSJJI+tG7Mk=;
        b=QaCJS/Z+EMVo1NmDsVDWdCM9aawilr7BqjiFFApSOdjMKEfAbII2GdTMLz6rKfJjmH
         n6DwYwftr6FkV6fTBpHohU0DODVKMyGhJe5xnXP+BKX8CaXQb9055+VmldOhGrP5gzQU
         Q7FJucFp4LJTHWVVa4dXJgPy5Dst66sKH6sWSKJHJZk8au2spXOo30Fcet49KpL8pLeY
         yqqHroPRNIELYJcxBul6KVFRvKOeTkkesY5QixKRrNqdninh6DfJzmPOF6V/4LyCaVr6
         U1rfMIm8Eq4SzpIveAjMLYxfVCyh/WzG56e1FBxNecrkOrrasbBTDaibKWwK7vTaBgrn
         T2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imus7EzT9HGnez1gAdtPtsmomcq86LoFHSJJI+tG7Mk=;
        b=icr6GslG5rfDZYg4DQzoron49LtD1dR2782ysyntIU4Z1dbagivWT+MCr6YfdDDSBn
         M+iv/GMO4bY5yV2Ga/1lKl6w+Z3pYH8p1QiMn7wP+tDMxdXYh6WoicOKpnVaFh24Qpqd
         bQD0048bMn7bp4tPyi+zUfbjHNHvt+bJ0d9w/94MtdskCHSV5qBdVSE+J4/56uuspdiD
         hSR+9wZzwEQycu1pVmO0wccne4ZLa3ykeIgYE7LkVe0+Yi9g0kJdz49VozeJhEA8jqlw
         hOmdN9kdeaFKj8giACv6y5ywJnj8VpKcEt/wzMnPxkoXHtmh7XY8aJfEbSuNwEbHGALO
         IA6A==
X-Gm-Message-State: AOAM53143Do/iLYb1N84S+pCk7tuBUGRtKdf0phibyy6gHpLwDjuyUqL
        URgXpsT3h/SgMtpRxVGp4xcPqSi2D9ZZDvNP
X-Google-Smtp-Source: ABdhPJyg1vExJqwz1s5jjjQQ4vRNJlEuplRSomxUrnaA33LcKhQ5AwbmBjRVRX8DW6+wQVxR1BbsbQ==
X-Received: by 2002:a17:907:1b1f:b0:6e4:b202:db68 with SMTP id mp31-20020a1709071b1f00b006e4b202db68mr30196747ejc.294.1649675031268;
        Mon, 11 Apr 2022 04:03:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm11074074edl.28.2022.04.11.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:03:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH 0/2] regulator: dt-bindings: qcom,rpmh: minor cleanups and extend supplies
Date:   Mon, 11 Apr 2022 13:03:42 +0200
Message-Id: <20220411110344.231903-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Extend the RPMH regulator bindings with minor fixes and adding narrow supply
matching.

The latter actually does not work yet, because dtschema does not like it.  I
need some advise with that.  This is the reason why it's an RFC.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: dt-bindings: qcom,rpmh: document supplies per variant
  regulator: dt-bindings: qcom,rpmh: document vdd-l7-bob-supply on
    PMR735A

 .../qcom,rpmh-regulator-supplies.yaml         | 262 ++++++++++++++++++
 .../regulator/qcom,rpmh-regulator.yaml        |  19 +-
 2 files changed, 267 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml

-- 
2.32.0

