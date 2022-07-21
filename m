Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8C57D72F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGUXFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGUXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:05:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914301CB10;
        Thu, 21 Jul 2022 16:05:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p6so3554681ljc.8;
        Thu, 21 Jul 2022 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDdTh6ElQrmmm6WEeY+R44ZAqktUPGx7Q0MN7n+sSfA=;
        b=LQg+E6L0nWpDrTl2lJW5GDJqqIBaap+jyNo7gIK3SRPW6fqohN+ulcwre2/nmkDcY5
         +F5Io8dWQuyaPQlWpy3BXa9Bt9MfApvBc8eupSZCvs36wCwQdYy/wgbwCK0Xr5UeI2KV
         Vy5qMVoVqNDuHj+BQM2eAbUbhZ5nRhKSJUyQCPQU9uemhCvBJlUwooFDLga1EyNFR6OU
         +QBZUO92DViNCqb3LHO8+En6mB6wtsnmOf0z4dwXdupeZb1gwpwik7MDs3ZaGt2m6v1g
         H94YpTYOj24rCp8u/zzyty8m53qxBf/tdsPyclcJTfQbIKfqEAfUxUBcN067KNKKQdeP
         oZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDdTh6ElQrmmm6WEeY+R44ZAqktUPGx7Q0MN7n+sSfA=;
        b=m0f5gfJ/7LmPofiMCtgM9HFQgaNvCM7LlY2uWa5Th0ofoFoW1RoMytOHmy9Z82ts85
         PlpTDacN/1D1D/0mjIJXutvULWANIX3U6oE2Qa95CkTWsnYFuDZyK5b1fQByvtHYHQnr
         U3Z6Z28KXpvWBlK+43gB6rI/sHRsFN4RiLg3K4OeZwZHEmLYz4cAPaiZp4YlnbE0dfBc
         ujzbvTxpSGb/jF1n0Hz0dGhqwXff2Ut2D1ppGvmjiEcZ1YOOw/UW0C6ZoUDWsr7NwXf1
         Ooy2Pv9BFnShCElvHsm/i5HqqvJ2N39I4nzPZkAi7sLqkGVDu3teITJHfMNVRFZ8pOng
         L/jA==
X-Gm-Message-State: AJIora+mY0NXavTSp9dQuQdGi7MPUukU8nrkfNXzzaCCQ88GLoeXw5Ua
        dTV0Y87wzGPVVS8R4TPfiC/ZA3jFMi4NNNah6eA=
X-Google-Smtp-Source: AGRyM1sxWQt4Pl0jfbCRQE/UpkjCg86tPdLFtaPQ8G7bxDgO/eixpnrq0vx6gT/9//37pdvjF7WqvQ==
X-Received: by 2002:a2e:880a:0:b0:25d:73af:52b5 with SMTP id x10-20020a2e880a000000b0025d73af52b5mr217102ljh.298.1658444733877;
        Thu, 21 Jul 2022 16:05:33 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id g31-20020a0565123b9f00b0047fb0d5e049sm701360lfv.273.2022.07.21.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:05:33 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Fri, 22 Jul 2022 02:02:27 +0300
Message-Id: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
Tab 4 10.1 (SM-T530) tablet which is based on apq8026.

---
Changes in v2:
  - Change codename to matisse-wifi
  - Remove msm-id, not needed when lk2nd is used
  - Remove unused labels from reserved memory regions
  - Rename muic node
  - Rename pm8226 gpio node

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add node for the GPIOs
  dt-bindings: arm: qcom: Document samsung,matisse-wifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 469 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  10 +
 4 files changed, 481 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts

-- 
2.34.1

