Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81D4B1A77
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiBKAdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:33:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346380AbiBKAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:33:08 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27E75F81
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:33:08 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 413AE2C00C4;
        Fri, 11 Feb 2022 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1644539583;
        bh=zn/yu2lMb6LsMc4qbLeNBM9b0Jo0d/eKfyNo33ad2UE=;
        h=From:To:Cc:Subject:Date:From;
        b=MWtbpllMPBy0A2tq0OKIXwSyIqKL7hgDNCQtZvnlcKJsVwHpJsclqpBVJI3N3qJ+m
         oP39nCMgI+W+yJK8fgez6N4/uI6FNdjsaPE7DlMpg8nvX+H/aOFZnAkEA+sqQHG9uJ
         kSbiwTULABoO4+2d+C1lOXQf+w/HRod10FHbx8I2q7bnzpIe1bHSGMoaUIoLRnsP/L
         pEXhkfCjmu2zV1tzq8ARszJLql131sQ5vAagBjzzCcdVUHxLEXr0cHOVDaJP9l1WjP
         nYmrBFeDcm84AWI/+93O39QiRL2/UUUIS+IvgMU9QC9l9YHdMPu4hr9WXKV7ujKDo8
         hki+92oeZx91w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6205aec00000>; Fri, 11 Feb 2022 13:33:04 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 18E3C13ECE9;
        Fri, 11 Feb 2022 13:33:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id F1C052A00D0; Fri, 11 Feb 2022 13:32:58 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com, robh+dt@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] watchdog: Pretimeout support for Armada-XP
Date:   Fri, 11 Feb 2022 13:32:55 +1300
Message-Id: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=c43Vvi1l c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oGFeUVbbRNcA:10 a=Dj44Gz3Sirx6rMiEHMMA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends and enables support for using timer1 as a pretimeout =
for
the watchdog which allows for getting some additional debug out before th=
e
watchdog triggers a system reset.

Chris Packham (2):
  ARM: dts: armada-xp: add interrupts for watchdog
  watchdog: orion_wdt: support pretimeout on Armada-XP

 arch/arm/boot/dts/armada-xp-98dx3236.dtsi |  1 +
 arch/arm/boot/dts/armada-xp.dtsi          |  1 +
 drivers/watchdog/orion_wdt.c              | 13 +++++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

--=20
2.35.1

