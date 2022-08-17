Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF045977AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiHQUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiHQUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD2A6C2C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so17437539wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zUVvLx/M0Ey4WkDNtfvPvUnW+BTA2iCGD2yUtKPlYzA=;
        b=On9ZheEPu5VzxXFRpX263CeSR2D+YOMy3syGCHBmeZktowjXbOdt8R6QvuqBRNbxxL
         qLHMIg1qz/XHfN3OpX+NEB03NUXcg+Ero1BOratzhXGvHps6cujRHFo4dSWkRHji0Qjm
         PNh/tK6+Ae4VS3S86KhYPZ4RcbIFHRkV01d3pe7x+ZlgaXC16k7acLouGUzhxAQptQ0s
         7IzOX+lywCmzL2K9URRyOwPLDlQy1hM8IiNFUo1fUEAyytr1t9x6EEKsUa5svCNLwU+K
         ga6RbTHSe7j/Qku/Nul7iwXXJqbnJ4ayRauV0sy+z2nuVrmXjUDZ9Fe/erADuYqmrsZt
         /JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zUVvLx/M0Ey4WkDNtfvPvUnW+BTA2iCGD2yUtKPlYzA=;
        b=YY8WfsgKJ5IK0VAKU3jyajx1Zpqo/U+tA9vlvWbvcIrEOoE0Ip7wxMsOfiakj5r3wF
         RhT2mv0RcJXxk1w6DGv55YV4wn2cIxfzap5ZJHME8x3sJgS2U/efWZqbVvb0Q5eqlP0p
         qzj46LXoOC4ZPBKFiRFaSLwuQnBYrzNLABPB+ycjBC2oZF6HpNDUbMqlk2BmGZh31NrO
         L0hEAmRoz3AbWQmf2uwlRjFP9Dk/sCa86yl/LQU0ssdc6aZuYaNXfwHc6f0LyEl3Jjeh
         BhDFLV67v0JA7BdDJXesPZSdUGSIWPT2gt3/9SKbfYO3aLAs9vQ4Uoz0A51X98URRo2W
         qOtQ==
X-Gm-Message-State: ACgBeo2bG/Zn0IR4QZHIfpyunpKO8wd/27CTzHcU6B8koR0kkMi7GXZ5
        K4y/j2yj3UO4WTlnVK5TvAHoRA==
X-Google-Smtp-Source: AA6agR45iTa9lfJ1iLIAYbdFjA17ICwWZtxzP6nWcl2YIhaueG/H0B6ZIQjOkPlREEmFy2FxfmH48Q==
X-Received: by 2002:a5d:59aa:0:b0:21f:57a:77cc with SMTP id p10-20020a5d59aa000000b0021f057a77ccmr14862481wrr.384.1660767154413;
        Wed, 17 Aug 2022 13:12:34 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003a5dfd7e9eesm3029371wmq.44.2022.08.17.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:12:33 -0700 (PDT)
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
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: [PATCH v3 0/4] Fix dt-validate issues on qemu dtbdumps due to dt-bindings
Date:   Wed, 17 Aug 2022 21:12:09 +0100
Message-Id: <20220817201212.990712-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

(correctly sent this time, without duplicate patches)

The device trees produced automatically for the virt and spike machines
fail dt-validate on several grounds. Some of these need to be fixed in
the linux kernel's dt-bindings, but others are caused by bugs in QEMU.

Patches been sent that fix the QEMU issues [0], but a couple of them
need to be fixed in the kernel's dt-bindings. The first patches add
compatibles for "riscv,{clint,plic}0" which are present in drivers and
the auto generated QEMU dtbs. The final patch should be ignored for all
serious purposes unless you want to wash your eyes out afterwards, but
JIC the versioned extensions ever come up, it's there.

Thanks to Rob Herring for reporting these issues [1],
Conor.

To reproduce the errors:
./build/qemu-system-riscv64 -nographic -machine virt,dumpdtb=qemu.dtb
dt-validate -p /path/to/linux/kernel/Documentation/devicetree/bindings/processed-schema.json qemu.dtb
(The processed schema needs to be generated first)

0 - https://lore.kernel.org/linux-riscv/20220810184612.157317-1-mail@conchuod.ie/
1 - https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/

Changes since v2:
- removed the extra patches from the directory

Changes since v1:
- drop the "legacy systems" bit from the binding descriptions
- convert to a regex for the isa string

Conor Dooley (4):
  dt-bindings: timer: sifive,clint: add legacy riscv compatible
  dt-bindings: interrupt-controller: sifive,plic: add legacy riscv
    compatible
  dt-bindings: riscv: add new riscv,isa strings for emulators
  dt-bindings: riscv: isa string bonus content

 .../sifive,plic-1.0.0.yaml                     |  5 +++++
 .../devicetree/bindings/riscv/cpus.yaml        |  9 ++++++---
 .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
 3 files changed, 23 insertions(+), 9 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1

