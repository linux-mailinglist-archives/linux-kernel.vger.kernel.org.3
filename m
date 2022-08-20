Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB859A923
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiHSXOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHSXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:14:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6102D5DDE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq11so133849wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SaeFaIV5wV1MKMr29Q6wupMh56tK3GFJ3AGQW75BYAE=;
        b=CGs3P+Cp1wV98Tih58wKHgLyWCKINJrfx6yL72mF1A8UF9jmiJMChfyPINgIVOByhr
         BTraVSVz4osV3Wr3JoOqCa/t6H410iUM9T6oU4m2J/9fYv6+SurQjrupYfo5M91mndyr
         ahmj7QeGxOVY00UfKAw/9xc/w65Ijrfdyl0ejMXa8/rnMnuUaSNR01kpejLmHmISVhnF
         +6WEjyzVLsTZMLuB1/6gOl8DmPR5wCbL5dremvHWhDt1rbRaunnmAaOJh+qvhZAEluR3
         CLjygIoBx/umhsPSf74QopQS6EDYGRsPFk3XnabCP6abxdxF6zPGvyNBABIT4voyhiJ2
         OFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SaeFaIV5wV1MKMr29Q6wupMh56tK3GFJ3AGQW75BYAE=;
        b=vdtx4Hwq96tDTFYFjjiXeyyXSVlK4HAomDt3S+r/h/SaDx91suWgWzr4DUVLZdvohJ
         Y5EhwA4+SXPKR4srPBhj7eITKhk1172B515QeDO2kXPiGZuqm6RzJAFw5GxUtLMGU1hF
         huRCdueKaq6d5X7G2Iwgy/b9BMFQdNswBsv9eBjghbhk03PXFsWrlF9qBLwyUm+W1LvH
         kKLjHwWqw1XwpRiTSCjJoT+Hw26PVHCbPzbca4JcWO9aEH3IyC0BV7Bh6XhyUWKFbczb
         dcpGf+Zzm/Ju8qen9SrTwS0yS/sKYnhJxlXWs/r98ZjsVOboEi5supOcWmAvTkeFXtJN
         ro0A==
X-Gm-Message-State: ACgBeo28cDYSYJwk29JzBynTSsusZm5RGCuPrrPO+TAYQJIVaIAgOWvi
        91+f9wxkCqM5vSZ6A2NTuEExeg==
X-Google-Smtp-Source: AA6agR45rexqagWDTaf4OrZKNQUASwm12brUKvs56alSg1WmnroFZwWLaQyc1Nq9TLv496a/xaoE2A==
X-Received: by 2002:a5d:4642:0:b0:225:33bf:39f4 with SMTP id j2-20020a5d4642000000b0022533bf39f4mr4002097wrs.77.1660950864300;
        Fri, 19 Aug 2022 16:14:24 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:23 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/7] Fix RISC-V/PCI dt-schema issues with dt-schema v2022.08
Date:   Sat, 20 Aug 2022 00:14:09 +0100
Message-Id: <20220819231415.3860210-1-mail@conchuod.ie>
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

Hey all,

Got a few fixes for PCI dt-bindings that I noticed after upgrading my
dt-schema to v2022.08.

Since all the dts patches are for "my" boards, I'll take them once the
bindings are approved. I added a pair of other dts changes to the series,
mostly for my own benefit in tracking what I need to apply that were
previously at [0] & [1].

Thanks,
Conor.

0 - https://lore.kernel.org/all/20220811203207.179470-1-mail@conchuod.ie/
1 - https://lore.kernel.org/all/20220811204024.182453-1-mail@conchuod.ie/

Changes since v2:
- fu740: make clock-names required
- mchp: add regex to clock names
- mchp: add a new patch adding dma-ranges as optional

Changes since v1:
- fu740: rewrite commit message
- mchp: rework clock-names as per rob's suggestion on IRC
- mchp: drop the "legacy" from the node name
- mchp: renemove the address translation property
- mchp: change the child node name in the dts rather than the binding

Conor Dooley (7):
  dt-bindings: PCI: fu740-pci: fix missing clock-names
  dt-bindings: PCI: microchip,pcie-host: fix missing clocks properties
  dt-bindings: PCI: microchip,pcie-host: fix missing dma-ranges
  riscv: dts: microchip: mpfs: fix incorrect pcie child node name
  riscv: dts: microchip: mpfs: remove ti,fifo-depth property
  riscv: dts: microchip: mpfs: remove bogus card-detect-delay
  riscv: dts: microchip: mpfs: remove pci axi address translation
    property

 .../bindings/pci/microchip,pcie-host.yaml     | 31 +++++++++++++++++++
 .../bindings/pci/sifive,fu740-pcie.yaml       |  8 +++++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |  3 --
 .../boot/dts/microchip/mpfs-polarberry.dts    |  3 --
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  3 +-
 5 files changed, 40 insertions(+), 8 deletions(-)


base-commit: 69dac8e431af26173ca0a1ebc87054e01c585bcc
-- 
2.37.1

