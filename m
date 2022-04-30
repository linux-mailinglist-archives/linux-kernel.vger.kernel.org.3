Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C232515D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382691AbiD3NQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiD3NQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421477DE1A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:12:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e2so14045018wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVWCR05ZRCnz9WBLjzE6WX4F3rgPdcPSc5sIdW/BRc8=;
        b=Fuq8dDB473Duj1wOyKi9RIB5oacDfg2lZPXFYJBTmv3oql34YpY1yy/TR1JDQVyHbz
         AGXoa+ixLrNEqDiLuTwDWDV+HedCDxWVkJ9MqI+9F5p3goGeGicJJGujfDPkBtO/X8d5
         iKCaVZF9KVSlcC8N9+h3fgQcKo7Lvtt2dqRwp9NvZf3gCfAEjvd8E4BS3CORXaGdzzZi
         HHbcMIMixGJ667kl25mSQjC+S6AdjkUkG1zmAfIa+NUkSc5Kc2E8+NQLRTFItAbX3ho+
         3FO9qm+MbWmM/712rCErZ6OKNkA7v2/XxaYS9JJIsn6szqeKoz8VeDD5yYFuyRzzJuJL
         hnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVWCR05ZRCnz9WBLjzE6WX4F3rgPdcPSc5sIdW/BRc8=;
        b=xHYOXUo4mJHNacLn0eibo9NHjN8m0PefysNHpkkCNdNC2ZH2TR30WkhShxNcF/n6Ow
         nOlXUgCnOVJn+9PoqzLKQN7ffKkgWwo3lhpYxt0M2F+DvRrbbMcr8tGUOoQ9aRRHGxfh
         j1o1CeRUnDlPPA62idF7+P6jcQW3aOeOYlWKCsGfGjpGJRQkhTEO8kggFQnEsw3ry4r6
         Mpytpmc9IwZnEAwMt48xM+rFhS1oPxwb4o64bZfilF95ygr6olNdW3unKgI1C0KNljiO
         q4MRW00+5jMP39a4Uz3n2/Nb/bd/9c0ERbGTQZu7dVwT+d56jHP0bmn9UapdJUdGGW+9
         AlLw==
X-Gm-Message-State: AOAM530XPRs6WSzH73CyDdFSuujXTdyk98wxEtORWr/2mHVz1pdaNN2T
        KYsDlGOmtZT6wbC8vTXEEZU9WQ==
X-Google-Smtp-Source: ABdhPJyl2s3fwLi7RIfq04FmLzyI9JYAxA0nKnSPYZExKssylLd4kz/NODo167kGwIs2TOt+YwwEOQ==
X-Received: by 2002:a5d:4e92:0:b0:20a:cafc:ebf1 with SMTP id e18-20020a5d4e92000000b0020acafcebf1mr2938721wru.17.1651324372658;
        Sat, 30 Apr 2022 06:12:52 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:12:52 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 0/8] PolarFire SoC dt for 5.19
Date:   Sat, 30 Apr 2022 14:09:15 +0100
Message-Id: <20220430130922.3504268-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

 .../devicetree/bindings/riscv/microchip.yaml  | 12 ++-
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/riscv/boot/dts/microchip/Makefile        |  3 +-
 ...abric.dtsi => mpfs-icicle-kit-fabric.dtsi} |  2 +
 ...pfs-icicle-kit.dts => mpfs-icicle-kit.dts} |  5 +-
 .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 ++++
 .../boot/dts/microchip/mpfs-polarberry.dts    | 95 +++++++++++++++++++
 .../{microchip-mpfs.dtsi => mpfs.dtsi}        | 11 +--
 8 files changed, 132 insertions(+), 14 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (93%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (95%)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (98%)


base-commit: a91b05f6b928e8fab750fc953d7df0aa6dc43547
-- 
2.36.0

