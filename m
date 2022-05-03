Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F93518FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbiECVVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiECVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:21:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A50F40918
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:17:41 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-d39f741ba0so18450643fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q3pgt9cmaFJwCOzqFkw/yJ3I2pr8XT7y2l81WiGQbVo=;
        b=BPnq8tFJhhx5gM69LeYM5FiQ5Kuj7OWMKuGSUFPLWm4GXYdtiPfrky/YfMQivy+FtR
         Ic8ktnQeRIIXvw73Qm9/6VereVp/QTV+q1F9QijFsC40qMT0OP4x2AWFxyKbojyu1lNI
         mPxXMTCzZbjgUi9jbqsCmyrXiVahELJ6/UYWKezxXpqkCKPZwErA8NIedLl4mUt7dLys
         wUVgybqUfyIYvvPdZ3qBlsID5S/yWHd7Ue/bl1O5QkKfz1fzWcNl3DncMTFff/HEnZUo
         K1WNJQAikFGjVQare6A4izLeSv+jzpQBORreUzOLnWDs7bW2UsMqP5j4B30P2yrFWov+
         kaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q3pgt9cmaFJwCOzqFkw/yJ3I2pr8XT7y2l81WiGQbVo=;
        b=ubGs/JZXFv/9AHuaGfCDVe36uf2ewcPBx3nvFsryhkDjwxlEs0cSpgJiDEqUXueQJW
         vqh+1GJ+JkoRH3+XGuZ7ka4yfj/xiU24FT1VO6JK4mD0LiQcdoSa/nhRaSeNqAXxHwvQ
         UdOKzW8KRXP24gVJBsZ9Oy4I0kMEqTsuFCv0lUUQbxJVBQ+lCTR7L4sg3Z/bs7hRlWWx
         En66HhaBE8BLCK7B+gLagO6xqFAi/NLv7SGL53KldVytn6zEInOBB2icNbkdeYX/wxw6
         6MdD4aTXhohQ+lVSWe6ZqJumCYg2fnz1R64ej4CT1/JmRoOkahK1nZulFoyWPa72dQ8B
         BWOw==
X-Gm-Message-State: AOAM530UZ88nJB1+6g+l+/u14+lRAVwyTxhGcVOfODiM2agbEU8ZOZ0D
        PyEk3is+3ulfxn6fXTVfLj7uKg==
X-Google-Smtp-Source: ABdhPJz3OFX7D35HbbGETgFkObGRd9Zgwy8xomhAvxAMoEli8r69eer8ytSgC8BemD4JuGxHhsgViA==
X-Received: by 2002:a05:6870:32cb:b0:e5:a428:97ab with SMTP id r11-20020a05687032cb00b000e5a42897abmr2702036oac.128.1651612660908;
        Tue, 03 May 2022 14:17:40 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830104300b0060603221263sm4305906otp.51.2022.05.03.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:17:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] interconnect: qcom: sc8180x: Some fixes
Date:   Tue,  3 May 2022 14:19:21 -0700
Message-Id: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This contains a few fixes for the sc8180x interconnect provider driver to make
it functional.

Bjorn Andersson (4):
  dt-bindings: interconnect: Add SC8180X QUP0 virt provider
  interconnect: qcom: sc8180x: Modernize sc8180x probe
  interconnect: qcom: sc8180x: Fix QUP0 nodes
  interconnect: qcom: sc8180x: Mark some BCMs keepalive

 .../bindings/interconnect/qcom,rpmh.yaml      |   1 +
 drivers/interconnect/qcom/sc8180x.c           | 139 +++++-------------
 drivers/interconnect/qcom/sc8180x.h           |   7 +
 .../dt-bindings/interconnect/qcom,sc8180x.h   |   7 +
 4 files changed, 51 insertions(+), 103 deletions(-)

-- 
2.35.1

