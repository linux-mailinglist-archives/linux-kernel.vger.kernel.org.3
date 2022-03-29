Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A94EB595
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiC2WIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiC2WH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:07:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9EFE3389
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:06:11 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D7B6F2C00C5;
        Tue, 29 Mar 2022 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648591567;
        bh=2yoNCniX/MtoTMpkQdC4Gm/7f/mkXZvG4wvzBibLAz8=;
        h=From:To:Cc:Subject:Date:From;
        b=VgrLl9jsVCHJ4R9YGog5J7FY6OPvgdjXSMUxlPTBp9G9LghVH08KtQlIoEDdkT6Bg
         KlugvIHp5t0B6wFp0uO4FCl9J/TsMgw5yFlGon4P5oOoORlBTNQdflG//m+PJ8Eq51
         v8OPoqMlgMTwd1eQHV7wa+VrET3YwOT95tTstU2NDeWconz/7k1YlNrJk044zQv2Qw
         376BQpPb30JNPJNsTsl/NLbsv4FL7BWtHPyz3NnUmpb4Gr4s/rRvpQ9B9N8t/tZEML
         8B+f5i4HdlVtFrHv3fYBUtV0P0tkZXZ4wgE7/MTDGdSHxeXV7v1Cg2MZKzxwsh6l15
         dWfEELk2FATiQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624382cf0000>; Wed, 30 Mar 2022 11:06:07 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 8148413EE11;
        Wed, 30 Mar 2022 11:06:07 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 84F7C2A2679; Wed, 30 Mar 2022 11:06:03 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/2] mmc: xenon: Convert to JSON schema
Date:   Wed, 30 Mar 2022 11:05:42 +1300
Message-Id: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=RB5vAHK8orW3AuQTtkgA:9
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

Chris Packham (2):
  arm64: dts: marvell: Update sdhci node names to match schema
  dt-bindings: mmc: xenon: Convert to JSON schema

 .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
 .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   4 +-
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   2 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 6 files changed, 280 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.yaml

--=20
2.35.1

