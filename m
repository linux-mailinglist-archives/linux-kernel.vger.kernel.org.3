Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9744E6B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356834AbiCYAJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348213AbiCYAJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:09:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E14EA8EC8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:07:57 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EEA742C0185;
        Fri, 25 Mar 2022 00:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648166874;
        bh=+SFIg7fa1NM+TS4dHaC6vNTZ/+6jBhDgLI6tjzA8d38=;
        h=From:To:Cc:Subject:Date:From;
        b=ts/jmE7Rbz810AoCpY10+PncVMhVT0f9cKSm0zyN4lgXR/a/IECAbpHt1pz9CtXQ1
         7BKfbnalfXM8c9j1maBWzDvApzSxzMFw3ei9tKmj3/6pUil/ZcsO2Fy35H/tPZmr5A
         15sXb2sPegqzvnS6pOOb5UkTA7aiIBRIoZBjICwgpEqi9yWVD0GTX3Dib/DYZWNRc1
         +W+1v+o8lq1Py7M8R5JGC62ySbm1x+1SiVSWfRFePp61oWwZTTaxi2XS1UTuqGDyVX
         MY4E2QjsmGRiZwxOvx/To1jZPlHsxrY8nUNXkQRIoM5I4/ShYNU2ySM63ZFo33Xwzp
         GZk/eWFKMuvsw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B623d07d90000>; Fri, 25 Mar 2022 13:07:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 98E9213EDD7;
        Fri, 25 Mar 2022 13:07:53 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8DAF62A2679; Fri, 25 Mar 2022 13:07:49 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, huziji@marvell.com,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/3] mmc: xenon: Convert to JSON schema
Date:   Fri, 25 Mar 2022 13:07:42 +1300
Message-Id: <20220325000745.1708610-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=gY6W4IOjc_lc-HF-ILsA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the xenon-sdhci-binding to JSON schema. There are so=
me
schema violations with the clock nodes for the existing dts. It's unclear
whether the ap806/ap807 actually need the 2nd clock but the change that
introduced the requirement to the old binding was fairly explicit about t=
his
being required for cp110 and ap806.

Chris Packham (3):
  arm64: dts: marvell: Update sdhci node names to match schema
  dt-bindings: mmc: xenon: Convert to JSON schema
  dt-bindings: mmc: xenon: add marvell,sdhci-xenon compatible

 .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
 .../bindings/mmc/marvell,xenon-sdhci.yaml     | 276 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   4 +-
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   2 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 6 files changed, 281 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.yaml

--=20
2.35.1

