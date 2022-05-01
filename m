Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410C516769
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352887AbiEAT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiEAT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:29:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654042C669
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:26:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id az27-20020a05600c601b00b0039431ba4905so860771wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPg7Nhc9JbcxQ3e3ol1zL+P+PBZLZ37XfWJrz9DbVuY=;
        b=iX4vf2GeDh+FHZ/JCXBo3HZCta75jFWL58dt0DFfZn1TEBGSEgRbYE0x1Gs1TS7jWV
         UVrT4qHSregQNGY4sU0awJvOoT6vSB7pD6YK1v7dpo0g6laihkGjOPs6YTHuCCdAoCSe
         PiT4QjV5msq+HG8BgOIL5F8IiHwk1tT9QvL+DW2rjtKaNhUUcKbQqPho9V8oGETJwXPT
         iP1sdOnYYfpLzYkV3KWjjV2VbmozXQMFNGr9cDeW1VTvvKKeRZ+PyhFSZ6aXSsEoQPUb
         14yVVjad6uJHYWYQGwEK+0bIRzGYb+Nsf2gJSZiJQ9UWap6swF+hRXisYkjjSkZkt4xk
         FFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPg7Nhc9JbcxQ3e3ol1zL+P+PBZLZ37XfWJrz9DbVuY=;
        b=lRE19jjoVZrIhCcqVbDXwc3W0GcTlK4MlPwTGIhLliys5F7vFTclJs+RWWEDoQLlIz
         OfK8tD6WXwa95bvbbhSArY4tLeuyQ3Qjd2Vx7EOWrSoMIDcg0/+iexP1hMRY8Hl+Qovs
         MNfDou9fnqQ3yRvWI46V2YFd1BHBjrxfF/BLBt/FT2e9WEQtALO+wCDJWZYHJrCMGKep
         /wK/v/4luQ94h9zfjns5Aben6r3Km3XvUdVs+DNFlb9T6Y++pladnSadB/OkC+gQc5lZ
         bJrpkTe1IjHIZz4zCM4uYWFVwxUtFQxqCp9886V1W9SxJfD99LsNMtywDQ6ixPIW2dcQ
         VlIg==
X-Gm-Message-State: AOAM532jEC73ajFKctVMHl8o6UFJIHZlEJ5OsWR2hvpJEoi3f7BG3wBW
        gB2uECo6HEAqwZBNNb8ADO8QLw==
X-Google-Smtp-Source: ABdhPJx+fSgeTpjGHTMYJfT1Aidt+7Y6vzsq69M3lRo7qufT3LsQ/FxIeuBZdP/nB/3nVuJoh7w+EA==
X-Received: by 2002:a05:600c:29c4:b0:393:fdfa:9baf with SMTP id s4-20020a05600c29c400b00393fdfa9bafmr12194441wmd.26.1651433180866;
        Sun, 01 May 2022 12:26:20 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm6448105wrb.18.2022.05.01.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:26:20 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v3 0/8] PolarFire SoC dt for 5.19
Date:   Sun,  1 May 2022 20:25:50 +0100
Message-Id: <20220501192557.2631936-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
Got a few PolarFire SoC device tree related changes here for 5.19.

Firstly, patches 1 & 2 of this series supersede [0] & are unchanged
compared to that submission, figured it would just be easier to keep
all the changes in one series.

As discussed on irc, patch 3 removes the duplicated "microchip" from
the device tree files so that they follow a soc-board.dts & a
soc{,-fabric}.dtsi format.

Patch 5 makes the fabric dtsi board specific by renaming the file to
mpfs-icicle-kit-fabric.dtsi & including it in the dts rather than
mpfs.dtsi. Additionally this will allow other boards to define their
own reference fabric design. A revision specific compatible, added in
patch 4, is added to the dt also.

The remainder of the series adds a bare minimum devicetree for the
Sundance Polarberry.

Thanks,
Conor.

Changes since v2:
- make ,icicle-reference compatible with ,mpfs & put it inside the enum

Changes since v1:
- fixed whitespace problems in the polarberry dts
- disabled mac0 for the polarberry as its port is on the optional
  carrier board

[0] - https://lore.kernel.org/linux-riscv/20220425104521.132538-1-conor.dooley@microchip.com/


Conor Dooley (8):
  riscv: dts: microchip: remove icicle memory clocks
  riscv: dts: microchip: move sysctrlr out of soc bus
  riscv: dts: microchip: remove soc vendor from filenames
  dt-bindings: riscv: microchip: document icicle reference design
  riscv: dts: microchip: make the fabric dtsi board specific
  dt-bindings: vendor-prefixes: add Sundance DSP
  dt-bindings: riscv: microchip: add polarberry compatible string
  riscv: dts: microchip: add the sundance polarberry

 .../devicetree/bindings/riscv/microchip.yaml  |  3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/riscv/boot/dts/microchip/Makefile        |  3 +-
 ...abric.dtsi => mpfs-icicle-kit-fabric.dtsi} |  2 +
 ...pfs-icicle-kit.dts => mpfs-icicle-kit.dts} |  5 +-
 .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 ++++
 .../boot/dts/microchip/mpfs-polarberry.dts    | 95 +++++++++++++++++++
 .../{microchip-mpfs.dtsi => mpfs.dtsi}        | 11 +--
 8 files changed, 127 insertions(+), 10 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (95%)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (98%)


base-commit: a91b05f6b928e8fab750fc953d7df0aa6dc43547
-- 
2.36.0

