Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376B518F32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiECUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiECUps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:45:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2522C114
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:42:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a11so15683607pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sH2w/vVTdfqCz9W7ywvi2pyU3dj2/u0WQnJwqpg8dQ=;
        b=TsVPkF5lorasvG1c2y3HR37wwKZGRSaeSe8PsNwNLlK2wi5Bosh8OI+CNya7EG9Y+u
         hlQIkf+UrhTi6GFmf6u+1ZfSEvNA1YPyjKpWKXYmIfdnnXqkNqVbZQR0YW6n2Vzg4Z8e
         ktwBeYTBB86K88SKuYlb7OF+aibShxishTBzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sH2w/vVTdfqCz9W7ywvi2pyU3dj2/u0WQnJwqpg8dQ=;
        b=tQ5NPilL/OI3+tJEJ4LmgNzLuhRN8t3WVsWxEr5f3fRhPMH0Lr9YpYabiw+5kpeq8Z
         fhXZuxRvjUbmNcbwkNAuXOAXqWPTtCe2kGHF/u0K9GyqIOFB1B4n+/6vu84QLV6qcXz9
         PD+jiY6nlSs31dx4A8mizZi5CbhVzW57dgUkY2FWQJUG4/SW+E24eGIDhpBtnly0UNln
         KImr0qWAYx2xLcpOo1RG3jtmrYG97TiYVcNn2XYNzh630O0/9wm14tTaX1qESK70f/Kt
         un+dfimZjaLzzG5kJijBWOhwA0qhIttxhW/b+YpqFymynt08tmw08UEhsdK1Gw7sguMR
         SJ5g==
X-Gm-Message-State: AOAM530F8SbbAAT/BHY4iuEVHPbeYy4KL+pZAper6eQDYnFm+mUES1fQ
        Y/IgvGKrgQ3BDROsdkxoaBTpWg==
X-Google-Smtp-Source: ABdhPJyjndjP6OpzigAn1DCQYecLfzQxzacZHA2QxQ7hTlGtc3urBMYgF3okwc7M7hDK8vnnYzwa4w==
X-Received: by 2002:aa7:8258:0:b0:50d:d365:70c8 with SMTP id e24-20020aa78258000000b0050dd36570c8mr15890945pfn.50.1651610535103;
        Tue, 03 May 2022 13:42:15 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15e:c760:9a04:7fbe])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79192000000b0050dc76281e4sm6702081pfa.190.2022.05.03.13.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:42:14 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Input: cros-ec-keyb: Better matrixless support
Date:   Tue,  3 May 2022 13:42:10 -0700
Message-Id: <20220503204212.3907925-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 .../bindings/input/google,cros-ec-keyb.yaml   | 87 +++++++++++++++++--
 drivers/input/keyboard/cros_ec_keyb.c         | 19 ++--
 2 files changed, 91 insertions(+), 15 deletions(-)

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

