Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2B51B62E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiEEC45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiEEC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:56:53 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE34DF41
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:53:15 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l203so3135003oif.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JtMcRY+9JipAU8C1bkMSmvF0PCdAKtGbjYynT12iIQ=;
        b=s/7YYm+ykBqWwHsrdfzUnctOAAIiD3SMSXkA5/lNxfZqFYKJnzyeuwCq4vXUdN1MA1
         hScfyde5HQZDEe9qcmDEyqMr+l0PTrsXmTnzahIoQzDcN+uXZleuWB+C+KRc4sBHtkjZ
         D63o+e94E4iV/kRbgx/Y6n3mCBqBXwAPbkKcs9fbq+VPacbTageksLm54LucC+k7egry
         eq10zmOlBy/XDA3wk9K+1mPx3CM1tDOGee5ZfipVtj5MlQPXzqc0+Oc2lGOgMXoOqdHj
         7lmD/TKbcoYxcGMGuIQIiQ3j4JFDJKF+S65M385CpZKMi255Wi+xJ68jN1MHYDvv1KHT
         B0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JtMcRY+9JipAU8C1bkMSmvF0PCdAKtGbjYynT12iIQ=;
        b=jsrHqD2NbkAqGmI/PthqaWqt++qBjbMkqb8UlF+I8zTKFOB7U92ekqwREdxzJ9DL5G
         M182ufFPZfH6m2Ox3hX+bZ+e8APogwfyLCD1GfkgnQV2PpwnYlurNPCDbfp2nU2nnIuy
         Tx4CCLRF4y982f0a+4N8r/5spNB4S229ftjcxirFOgtmveRcQWbqDtYyHV8ele/G4mHo
         /nvWe4WjYRi60UqR0P3JfX0vv/MkMl8RYU0/nGNeWx6u/1ULxoL7DxHit17IMwc5TW++
         y2YrOi0ExWqiNlKXKl2shknUfFNE3YbKiRlLbfpDXGV90m9UGuQxWHDKPSkRt3LdQyDx
         hdpQ==
X-Gm-Message-State: AOAM530FRC322bVqXd5ThleKrC6wKyprCuGCi3izSojCfb4JoJ+uGcXb
        5S2GcX9llUmPnyL81f0fwkkk4A==
X-Google-Smtp-Source: ABdhPJxdPv1yS48+PtUC0XC2ujBEDklgGUJAlp2EVPL/sKrWpGR5jQTUNF2lsFYfn4x5wW42fwqKvA==
X-Received: by 2002:a05:6808:20a0:b0:326:5283:7614 with SMTP id s32-20020a05680820a000b0032652837614mr1344376oiw.55.1651719194711;
        Wed, 04 May 2022 19:53:14 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2801000000b00325cda1ff95sm242572oix.20.2022.05.04.19.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:53:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] clk: qcom: SC8280XP GCC
Date:   Wed,  4 May 2022 19:54:55 -0700
Message-Id: <20220505025457.1693716-1-bjorn.andersson@linaro.org>
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

This adds binding and driver for the Global Clock Controller (GCC) found in the
Qualcomm SC8280XP platform.

Bjorn Andersson (2):
  dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
  clk: qcom: add sc8280xp GCC driver

 .../bindings/clock/qcom,gcc-sc8280xp.yaml     |  128 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sc8280xp.c               | 7488 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h |  496 ++
 5 files changed, 8122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc8280xp.h

-- 
2.35.1

