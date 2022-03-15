Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDB4DA505
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352131AbiCOWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352113AbiCOWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:07:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808AB5C363
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:05:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9C6642C066E;
        Tue, 15 Mar 2022 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647381952;
        bh=6qW0bIvSocuUGPAKqMqS/TneO9lAt3g2leeaoQdWrxE=;
        h=From:To:Cc:Subject:Date:From;
        b=WK12/Uushi22+XWuZlXZH+dgMjzpo8ym5bC+34Le7apERadkSrybyWZLUeooNpRKW
         C9mTDvAHJ8+89Ulvx7f5AlCSHku4KJipPz0gM2Y97yWfq1AsboM540SV2T/Po8jC7n
         Smp/ruiDgk2KhSGtHuzAKq0mXIGAhAWWShWslQVVR26vXTnQ+WOs0yLflxsbk9OYsl
         FEsCcS/ZdbL/sbr7gBoAY50fX/pL2EN4LsftHmA38Y2se+8N2nZKkG4r63M4kiTf2c
         NGTrtHyiOiWeB9qwrwmJiag3DRztmDpWPsO+drP2vSKtIomAP+RYnfPlSo88Oi/1Lr
         lE+P15P3EuUAg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62310dc00000>; Wed, 16 Mar 2022 11:05:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 5870F13EDD7;
        Wed, 16 Mar 2022 11:05:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3F9DE2A2678; Wed, 16 Mar 2022 11:05:51 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     huziji@marvell.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/2] mmc: xenon: Armada 98DX2530 SoC
Date:   Wed, 16 Mar 2022 11:05:47 +1300
Message-Id: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=e-_wUu_MSEDw5Nq8D2YA:9 a=AjGcO6oz07-iQ99wixmX:22
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

This is split off from [1] to let it go in independently rather than wait=
ing
for the rest of the series to land.

[1] - https://lore.kernel.org/lkml/20220314213143.2404162-1-chris.packham=
@alliedtelesis.co.nz/\n

Chris Packham (2):
  dt-bindings: mmc: xenon: add AC5 compatible string
  mmc: xenon: add AC5 compatible string

 .../bindings/mmc/marvell,xenon-sdhci.txt      | 52 +++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.c                |  1 +
 drivers/mmc/host/sdhci-xenon.h                |  3 +-
 3 files changed, 55 insertions(+), 1 deletion(-)

--=20
2.35.1

