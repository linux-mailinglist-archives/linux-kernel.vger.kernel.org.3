Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410E517C91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiECE0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiECE0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:26:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E93D4AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:22:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so1183355pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 21:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4lUh0yMD8sZjGjtl6Yt4cfDa+0R6nAeSt8H2W7xp7w=;
        b=Py1VeLdd73EaC/N3n2EUF5DQyzaEeRU4qjm+oSAX5LrWLpK5G0FoxrUniGC3udZw+N
         fiTYOoF0VoAZ13/dtzJ5ilWNXkPgwpOUkOYf8VHFH6Aw4m7b2nSBk/c0k/HuvIr5PkuW
         0KscM5R8Eq6nmzyv37b6TOVti2VbxK3HZ4wN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4lUh0yMD8sZjGjtl6Yt4cfDa+0R6nAeSt8H2W7xp7w=;
        b=upCqROP4Lbk4q+EiZiySrjZJsObnFHLpFcDC8i1929zsY1HQTHts+d2r87BTnlnpCC
         8MHGSte7tYqGvIrC2lKEK3X2/9fPBXMpcT+O3QGkJCFHGzk6PPsxNKDoZ/ckNa083FRG
         +RiskJCV39HDNQ6Jpaeyaw97m5m/1VmBa67t6oN7UtzPjEDAsXD8D0SxfO/YHxjP/7bI
         T8S0zxCw2Cq5vqMMYvn34ae+82x48ZmP+siU3iLNBhzSc1YrvMPvJNXrtax6o6OH9Tyy
         4SxC+imNvO5jZqvlQlyyvQJ1dilEantwMQ0OX/S9Djsx/ZkG4lHhSxlsNjPgiAj2mNhn
         M33g==
X-Gm-Message-State: AOAM533Drh77JIu3gsRD4BcmcTdFvfilBb7F4JidQCJ/fiEoAWk+cfE7
        Ag1XErnbv8JGE94+/gfJxajnUg==
X-Google-Smtp-Source: ABdhPJxFcEjU1mcmL/2/u9IOmP+AtNAGjAGJjyWxSLlHdtDYjvQy/6Xq+2fsmLuTJIZ9EIwif3WXDQ==
X-Received: by 2002:a17:902:edc5:b0:158:4065:a5ce with SMTP id q5-20020a170902edc500b001584065a5cemr15343814plk.55.1651551764571;
        Mon, 02 May 2022 21:22:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15e:c760:9a04:7fbe])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902e34b00b0015e8d4eb24asm5390223plc.148.2022.05.02.21.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 21:22:43 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Input: cros-ec-keyb: Better matrixless support
Date:   Mon,  2 May 2022 21:22:39 -0700
Message-Id: <20220503042242.3597561-1-swboyd@chromium.org>
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
 drivers/input/keyboard/cros_ec_keyb.c         | 20 +++--
 2 files changed, 92 insertions(+), 15 deletions(-)

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

