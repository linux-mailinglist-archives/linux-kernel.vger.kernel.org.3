Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26D59777B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiHQUFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHQUFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:05:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8F5A2CA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so5671977wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=G88Wg8efx4vUqMWMZ62OXKazA2toNV7pxgmBvPS4y7g=;
        b=UjMVkMOhH0QDp6O/pCgKkjwAgoTr7VLaEZvWBQ+tjcd31e0GYx2VQdEmdGYONFZlBV
         JXSoVTKAwZz2v4YW/Uizoa99V8t3dHzfTeno0mWPMNhh4igom0Bmr6ijGRVDHpyMGd7K
         RD33fy8KrpjEF9DtfgDokOP/K0xkdEBYEZgLbmuvpjzpJ77YnXuGes8IGqUhqOEtcuTz
         1EtmXbFWHbm8sgCgqbfJwoywVRFVNGycJiPJnMqkXnaxVeGp5CUmEstg4+UHY5j1Wvvc
         OYe7bnF33uDXEY5dt1xkYnKlxySlYViNcOylr1RCwj3UfknSZbnUPfMlStx4kPmCFh6a
         AtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=G88Wg8efx4vUqMWMZ62OXKazA2toNV7pxgmBvPS4y7g=;
        b=723NwJcd0FMX7EX2BG3FJKE4SmIiU4WcL5fGjwrsVIRl661RyeUfWq6klw6OEfa60/
         TtNcdw3/UBO7/KB/Aw2d2S1VcziVyS/Hp1URnA/pgVCMiXACkc43mZ+Wvtjd5cGSDnnM
         WgNynxLfq6OzOEU9ZdwZdN+Fqruat/f/COv6qs8XRoT+EJOoM+dm0Saecuo0f4lFdXnz
         /3i4Aq47if8GU5/IUKYl2JvhCTi+W9TBVwTxUTpVCE53SAl6zWIs+nWAonhcftfy6hZW
         RXlCleV99TCdQnyq3pZYwE5Mw+lxslTOGczLvD7t3botqfTZDQHqZLSZQ/v3O+dBCTcF
         Iwxg==
X-Gm-Message-State: ACgBeo3NzEB81CGLhAxfxwUxCC7BmwuqkxTiCC3kU9aaepvPP1r5QqeI
        d1HdMjfOmcgWQCU0vnuPoProrg==
X-Google-Smtp-Source: AA6agR5IgGfJqwk47mOqzOms5cJpBLn149vtKJEQDmN0sxHazUEu1rNO09FeTJ5nbKwwA4+D0l30ow==
X-Received: by 2002:a05:6000:617:b0:225:1d23:467a with SMTP id bn23-20020a056000061700b002251d23467amr4681470wrb.692.1660766749119;
        Wed, 17 Aug 2022 13:05:49 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a531c7aa66sm3400883wma.1.2022.08.17.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:05:47 -0700 (PDT)
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
Subject: [PATCH 0/4] Fix dt-validate issues on qemu dtbdumps due to dt-bindings
Date:   Wed, 17 Aug 2022 21:05:19 +0100
Message-Id: <20220817200531.988850-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

