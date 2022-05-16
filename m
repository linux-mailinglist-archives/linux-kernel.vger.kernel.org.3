Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE8528D28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbiEPSfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344908AbiEPSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:34:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9609366B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:34:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x23so14795990pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ND8PT1JbEK9sNH8l0vjUc9ivWP9q6grqcaLrqiHd17w=;
        b=aTih4suD01GOEGOHwQsrDkW85JkMwe1FJcwfcvDvngb4WWWw+0R+L8L5R8u2MXSqgz
         wCmXeepWtdzQyrBAzJrQx+umSW7wgVVtad9nT4mFpm+yzsT2lPkuCUEsOWIvqlGlDc/u
         +M3cYdBEygDR4d+8o1Q/08O2j986Jxmg9pgM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ND8PT1JbEK9sNH8l0vjUc9ivWP9q6grqcaLrqiHd17w=;
        b=MlKpHJ8OWvOZaLPwTPZOOK/gSeVWiQ3yGHqXlQiastzLTufvSSC3Sw2FC6n0S/LFaL
         GOhkIjSC0JpSz/XqIhimOItihBNCVcAMw1db0NVB9zKZlpPiz2Dc9bXEnR44e5czjtsM
         NVO7fccu/MWj2dfmkHNBPZJAU+C51BPie95D2LbRMhVaL+jk3spCOzh9faDUWYbfFwyI
         2Bx2UbyKQoRRfF4pzUMYbOQ38RvNL2ZB6+pk92LhWLjCkO/Gym1lLC9tKnasI97yhhnB
         9SqhRX0R+NDUN0yp3Gzu7bfpK5DnHdPoPjBFLMeDIgj+yein8vYuDeWd1HQHlssqV+V3
         /YNw==
X-Gm-Message-State: AOAM532C/ED+J30YFy8Mi33OxZ7T1PfZWKH7DNdikRNpYthKQ9VBEef/
        cSSJ2C/bh64cLQu3d+VPHstIsA==
X-Google-Smtp-Source: ABdhPJz6CmiuPrfYudzJKS4y8hS8jwFnUVEBC5Zu6nO9STUk+y6bjDsVybZ5mlT/a0AGoMiNT+8EbQ==
X-Received: by 2002:a63:2048:0:b0:3db:7de7:34b4 with SMTP id r8-20020a632048000000b003db7de734b4mr16508794pgm.105.1652726094158;
        Mon, 16 May 2022 11:34:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7d0d:b8ac:a3e3:757a])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b0015e8d4eb24fsm7331090plk.153.2022.05.16.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:34:53 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH v5 0/2] Input: cros-ec-keyb: Better matrixless support
Date:   Mon, 16 May 2022 11:34:50 -0700
Message-Id: <20220516183452.942008-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to my previous patch[1] that skips keyboard registration
when the matrix properties aren't present. This adds a compatible string
for this scenario so we can ease existing DTBs over to the new design.

Changes from v4 (https://lore.kernel.org/r/20220503204212.3907925-1-swboyd@chromium.org):
 * Make switches compatible fail probe if no switches present
 * Add description to compatible list

Changes from v3 (https://lore.kernel.org/r/20220503042242.3597561-1-swboyd@chromium.org):
 * s/register_keyboard/has_keyboard/
 * Pick up review tags
 * Indicate properties are required in example #2 in yaml file

Changes from v2 (https://lore.kernel.org/r/20220429233112.2851665-1-swboyd@chromium.org):
 * Drop rows/cols check now that compatible schema handles it
 * Make binding require rows,cols,keymap for cros-ec-keyb compatible

Changes from v1 (https://lore.kernel.org/r/20220427203026.828183-1-swboyd@chromium.org):
 * Better enforcement of properties in DT binding
 * Skip registration by means of adding compatible to device id list

Stephen Boyd (2):
  dt-bindings: google,cros-ec-keyb: Introduce switches only compatible
  Input: cros-ec-keyb - skip keyboard registration w/o cros-ec-keyb
    compatible

 .../bindings/input/google,cros-ec-keyb.yaml   | 91 +++++++++++++++++--
 drivers/input/keyboard/cros_ec_keyb.c         | 26 ++++--
 2 files changed, 101 insertions(+), 16 deletions(-)

Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>

[1] https://lore.kernel.org/all/20220425210726.3813477-1-swboyd@chromium.org/

base-commit: 4352e23a7ff2f8a4ff229dd1283ed2f2b708ec51
-- 
https://chromeos.dev

