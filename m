Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3458AE26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiHEQ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiHEQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:29:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE78D100
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:29:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z16so3761922wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=er0g7uHt/REArzX+ze5K8GPRuPY+Jxgp51y8SELP3FM=;
        b=EbOTl21mdJTL1GSzLoH5mndTGZ7rvd3Xg13P4ZKyz1HCSdoZ+u7F/xmaKdmhUrrJYR
         ArAdrwc4a1//4AnluZSlFDO6+T3WonDWZ7YJAoV50fmI/J5ExQUtkLJKbPjLjsScuXwe
         WN1Qs3sMEseZZVv/O9h179kGKXIXUaZ7acdsR24+fFhX69GI2nTzP/kZtlcjr7KN9DOZ
         vFaNNYQYq6E/a41Mn8Y+odfAkjrhdjCAvuuGk00A/HgX+GlhAhe93bBVZfYbqTMm1ZFx
         Vpkg4f2wo26DXiVBb+vHMqHogYZl59hldL5jGPOYrirc97C0RUGdzYLF2J//OSiPFvsa
         0YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=er0g7uHt/REArzX+ze5K8GPRuPY+Jxgp51y8SELP3FM=;
        b=qD3AkVfikHsQk0FX6VYvVApIUdrGjscrZ1w6w8+bSbGzqs5tKD1xoqCOmF8zN0T9Km
         fa1zBLHZZNx7h/yftyIpVYT9J59hqTtN0Kf0kUVafjO4YKZfDhJCZ3O9pKtQ8osa5Ml+
         oLRpIQjzfnQ5YzWzCkYsqc1oU9URKISsVYLo99mmpyp+Ey4+E5ICjvm8t+eQURMIWxOp
         P+WUzMixrEEu2n8gQ0ab5eu1NIiaAL8thn3N84dcfbNIiFezUEfCQusaH8GGMii0tZH0
         vDlKx2JEdmE+LWzkDDIifxMUUQs5tBkykT0y7mrPoVoz9Vso/17T2e01ee+y22M0VIss
         ps6g==
X-Gm-Message-State: ACgBeo2SegnCHQvxruWEwEiG0KDYTo0Km8i/FnCWLuEEKahxKWg2J3JY
        rrh7aZUs6kXePjjmES59mwpHNw==
X-Google-Smtp-Source: AA6agR5PYR+Wl+0VOlguEQQuXuRRJGr8efSXklKvUOQvZ7GXAI/mg5rEbgBwI6yH/e0BdmhHI1txbw==
X-Received: by 2002:a05:6000:1542:b0:220:603d:ec93 with SMTP id 2-20020a056000154200b00220603dec93mr5044554wry.73.1659716943539;
        Fri, 05 Aug 2022 09:29:03 -0700 (PDT)
Received: from henark71.. ([93.107.66.220])
        by smtp.gmail.com with ESMTPSA id b10-20020a056000054a00b00220633d96f2sm5210086wrf.72.2022.08.05.09.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:29:03 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to dt-bindings
Date:   Fri,  5 Aug 2022 17:28:42 +0100
Message-Id: <20220805162844.1554247-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
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

From: Conor Dooley <conor.dooley@microchip.com>

The device trees produced automatically for the virt and spike machines
fail dt-validate on several grounds. Some of these need to be fixed in
the linux kernel's dt-bindings, but others are caused by bugs in QEMU.

Patches been sent that fix the QEMU issues [0], but a couple of them
need to be fixed in the kernel's dt-bindings. The first patches add
compatibles for "riscv,{clint,plic}0" which are present in drivers and
the auto generated QEMU dtbs. The final patch adds some new ISA strings
which needs scruitiny from someone with more knowledge about what ISA
extension strings should be reported in a dt than I have.

Thanks to Rob Herring for reporting these issues [1],
Conor.

To reproduce the errors:
./build/qemu-system-riscv64 -nographic -machine virt,dumpdtb=qemu.dtb
dt-validate -p /path/to/linux/kernel/Documentation/devicetree/bindings/processed-schema.json qemu.dtb
(The processed schema needs to be generated first)

0 - https://lore.kernel.org/linux-riscv/20220805155405.1504081-1-mail@conchuod.ie
1 - https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/

Conor Dooley (3):
  dt-bindings: timer: sifive,clint: add legacy riscv compatible
  dt-bindings: interrupt-controller: sifive,plic: add legacy riscv
    compatible
  dt-bindings: riscv: add new riscv,isa strings for emulators

 .../sifive,plic-1.0.0.yaml                     |  5 +++++
 .../devicetree/bindings/riscv/cpus.yaml        |  2 ++
 .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)


base-commit: 42d670bda02fdba0f3944c92f545984501e5788d
-- 
2.37.1

