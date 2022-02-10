Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090B14B12DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbiBJQgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:36:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiBJQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:36:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB71137;
        Thu, 10 Feb 2022 08:36:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k1so10578702wrd.8;
        Thu, 10 Feb 2022 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bsK/ywYRhNd6B9acdjFBjLw6uCbq8GkPqEAUDJ0Iq0=;
        b=nd/5t16q2dZeSUXeLARHqs1r2kr182kK742RAKdzthI6qpbsztn0Jl15mbQ4Khd7uU
         IZl1CVv03mdQzSrtA22Rs+EUVMfzQv/TXgFjmEUz7rJ9NSnNFg7hb+/YMHtKAsaYbI7K
         QwEkvtkdBiIsp/Hop8+q+savBqyxD1bUlsPBg6HK5hSH1GmB2UuVf/WxEFWJd2f/kRYY
         fCTAs6XR5DJKslcZH7x6Jd150NCyVElAp59wyt9X1jk5tzgI25mh/xn2GAumUy6z6B4K
         C/DMNmM6OHGaX9clEk1ntOqRpO8uauDjtlCbjdVE3I2Y1yzzZnnIXXv0gkmJLX7flc5c
         0wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bsK/ywYRhNd6B9acdjFBjLw6uCbq8GkPqEAUDJ0Iq0=;
        b=jLbQTQFLpLWNaigM5VoPHZrLRLscs9YlVhq06Qmf5+fszcKzXiKTgCFqzLW2BMdPA/
         NwenMFWhUYAUqGPgSsca9obN9uN25Us5gbXy885gEIOde1BIvFLz3meSzlEec0VVd3Ul
         PznxDdwoa0xwpSGm8TjXOnJUAzSBo6qs2wYXw01+QBItoL/L7zuSGWarqi+p7bU/Bw+5
         EOIxqqhA2Yr2ZNzWdi4sEUsbZwvLaWKczIxW6/xZeXveK/j7vSrU0WY2xArK/dv96FxK
         1BGcXGHGW1m1rcEyRS9b7ARE4lKrV2ZVCbVbZHkKtuGbkBJM+HXzye1hmvTxEmLP2XHk
         rmHw==
X-Gm-Message-State: AOAM530gdjHqgbWWWt6ME1dgG1HQR8bHyMtbvG08fMyN8VK/2h84g2kl
        LRUiN39lmJSQNisrzX7/f9JIel4/uZD4UA==
X-Google-Smtp-Source: ABdhPJw3E1DbJcu/NQe2RVRdi2hEvEpWrfv2F9Vzy6kkcP9oZkdso+/gVayKkwaIiZJxNkDECxCTUw==
X-Received: by 2002:adf:f592:: with SMTP id f18mr7196852wro.179.1644510965064;
        Thu, 10 Feb 2022 08:36:05 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id i2sm2354057wmq.45.2022.02.10.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:36:04 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add support for Imagis touchscreens
Date:   Thu, 10 Feb 2022 18:35:37 +0200
Message-Id: <20220210163540.162727-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Imagis touchscreens, used on various mobile
devices such as Samsung Galaxy J5 (2015), J3 (2015), J5 (2016).

v2: rebase on top of the correct tree

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 329 ++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.35.0

