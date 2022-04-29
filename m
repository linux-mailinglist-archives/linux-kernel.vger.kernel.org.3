Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A751590A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbiD2Xe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381852AbiD2Xew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:34:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE0B0A40
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:31:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so2254128plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YgscAPmkdXZdvGItBkARoN39El7k5vd+0X9bZIsm5A=;
        b=KmAugV8D8y1df2eVDeWevN4/iD84DGOM8cNKf2bLCx5dR+9pytBdoDJY8NaKCN/bpm
         4YWdnvT77Gjnx+W7GzD5V38U1PiwXjZMClOjfR+QN6nFNmmw0nN1h5qC9iPb6pfgNdDK
         faZR9HqrO1iNLv7lbv7EuNZ8eFUp6DgrLLgzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YgscAPmkdXZdvGItBkARoN39El7k5vd+0X9bZIsm5A=;
        b=aLpKa4Gv+R5CZMbqC924unwfM68i7OwBmIhaOlNToAbMOhFCxlHV3Iwm3LsV041daT
         Ah19719sKACGjXsf1bs2RP39d/9v2T9z7rB6moAoh3yVpqQA85tTvCkcX/j6pc7k4J8A
         CDuYe7Q19UU+H9VOPuCssOa0MWXykBHEqhvbmTrgsIAQb3Tg/W9aolBxXXVkGkb3SSPk
         uUtFqI8XsnKMQ1AFK28PeNKl8U4egWKg3yiq4hlrBsgtNRVcK9oMPyO9GldJijCJWCvh
         sNaOJfAjr0K/U1VQIC4qLsMt1uiVtQQqdm3ZoqJLveqsAuT2gvF+vtKTsE4yWBYgWRtL
         Rt0A==
X-Gm-Message-State: AOAM532Z5/FCO54hi0tXfNG1HytjVGVDBix1ZMEM4PT2wYoKx+z8sgO4
        A3pH2NT5j4gmmxbg1ucVOdTXkawhRbGwqA==
X-Google-Smtp-Source: ABdhPJxY44iFfukhQ8UWK7Y9QYQdpA1U3pRUTpzNyjs/fGYqLlp0a0KtfPcanGdAuptsnq82S1XbrQ==
X-Received: by 2002:a17:90a:c302:b0:1bd:14ff:15 with SMTP id g2-20020a17090ac30200b001bd14ff0015mr6436842pjt.19.1651275074332;
        Fri, 29 Apr 2022 16:31:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5172:14b3:3687:1fb0])
        by smtp.gmail.com with ESMTPSA id i24-20020aa78b58000000b0050dc762818esm223037pfd.104.2022.04.29.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 16:31:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH v2 0/2] Input: cros-ec-keyb: Better matrixless support
Date:   Fri, 29 Apr 2022 16:31:10 -0700
Message-Id: <20220429233112.2851665-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to my previous patch[1] that skips keyboard registration
when the matrix properties aren't present. This adds a compatible string
for this scenario so we can ease existing DTBs over to the new design.

Changes from v1 (https://lore.kernel.org/r/20220427203026.828183-1-swboyd@chromium.org):
 * Better enforcement of properties in DT binding
 * Skip registration by means of adding compatible to device id list

Stephen Boyd (2):
  dt-bindings: google,cros-ec-keyb: Introduce switches only compatible
  Input: cros-ec-keyb - skip keyboard registration for switches
    compatible

 .../bindings/input/google,cros-ec-keyb.yaml   | 95 +++++++++++++++++--
 drivers/input/keyboard/cros_ec_keyb.c         | 15 ++-
 2 files changed, 102 insertions(+), 8 deletions(-)

Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

