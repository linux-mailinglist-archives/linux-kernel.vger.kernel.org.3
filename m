Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309085825CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiG0Ln4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiG0Lny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:43:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355649B72
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:43:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g10-20020a17090a290a00b001f313618470so384972pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7ePXmHdwHU2OjPT92pojdb5hOsn4+tmUhcWnC3P2SY=;
        b=n2kvokZ6QBtDMNxlIgXlVTyF5/T+r6EWQgPYeiNlJ8uGN3wV/9vjxdgCodlT71/VeL
         l6POfqmKabMw/olF/IR6gLEvM+DmiYD0qsmibuQHhpHtdCUubckTsia0fe/x1IiSxHzf
         ume/BNNmQUR/tb/+Qjs0xN99ZfgrrieC/+VnSxzNnUZE26igUchsDhgo4iO8R+P9WO56
         g0L09xdD4xwXgG7A1T7NvUx+2wixN1jCYsfJt3jANC9xrL1MAvmsBmBhpWwcMowhtDS4
         WrD/UxtAprONWcCv3JynhtjD/0mtODz0w1IoVcvyqVW7tKrnWg6V6YJWBDRZJ3n/fIGU
         ogQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7ePXmHdwHU2OjPT92pojdb5hOsn4+tmUhcWnC3P2SY=;
        b=e9mcI4C/Ga+18/tkNUh+2K+D7ZGPzXVMdfPQiSSfQ0ITDOcrE27M9JfQAv9ue1iOzq
         2RTXJoSXUs7WLwnM4RgYIhOIilMfav3JjopMKWg2KKelFCU3nVHwgbWHoTjxUb6XJuzM
         7ckWxZ5p6TUkNn9imL5D9GACs3AAfC6+XGj+zAV4UL+oUjSHzXtQpJwZvFgycGg4T33H
         7eUfGqIb02WToxSb75xZJgXYCobFpNy/b+U6WHu84WhFyNcXScRY0XOqLpJ8yq+DsTGK
         Fq7/M5qrTHTVRCQX+nCvSTWlEQ+gQQHS0VrLR7PJT598M29FMnNXiNEW9Kzw0yDfUqXw
         m1AA==
X-Gm-Message-State: AJIora8HwWc3ai7/2LbXe9ZOez0na5h4vrNuWPQC0B4evAhTluMWHBws
        E4lKNFj2ejp742SE9mbKK0rEge4sy+VYaA==
X-Google-Smtp-Source: AGRyM1u9ZDX6Uohi7hKG0s8RCc6AOjPOCEKAJndtw4mRC02EhgIbii2uHsFndUckh6by9gEB56ZcBQ==
X-Received: by 2002:a17:902:e945:b0:16a:1c41:f66 with SMTP id b5-20020a170902e94500b0016a1c410f66mr20580720pll.129.1658922232923;
        Wed, 27 Jul 2022 04:43:52 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.87.63])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b0016be9fa6807sm13486685plg.284.2022.07.27.04.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:43:52 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/2] Improve CLOCK_EVT_FEAT_C3STOP feature setting
Date:   Wed, 27 Jul 2022 17:13:00 +0530
Message-Id: <20220727114302.302201-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the RISC-V timer driver to set CLOCK_EVT_FEAT_C3STOP
feature based on RISC-V platform capabilities.

These patches can also be found in riscv_timer_dt_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Rebased on Linux-5.19-rc8
 - Renamed "riscv,always-on" DT property to "riscv,timer-can-wake-cpu"

Anup Patel (2):
  dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
  clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
    property

 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 drivers/clocksource/timer-riscv.c                 | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.34.1

