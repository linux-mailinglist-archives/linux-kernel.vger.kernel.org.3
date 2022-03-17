Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5654DD0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiCQWce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiCQWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:32:20 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B99180051
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:31:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DD8DC2C019A;
        Thu, 17 Mar 2022 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647556259;
        bh=NMNU+JaGrJuLzBwcvUQaxQwPRkaGc/SGJXnhar40Wpw=;
        h=From:To:Cc:Subject:Date:From;
        b=uY8FMS0IF1vZCO9Sz78w1oJDPdlG4BLwIGHPsAb3TN+xzD/RJ42xX0IY6oWfpYxbq
         Y65M4mwFNq5bZl4ApXXd4H9iSHOHFk5YwhO4LKkEEcDyRP2/0M/S3gSB8XNa/UU3cR
         7c5hSe9Xt13Y4M1FGMow+Vbls3jOJ3CqQSk4St+PgGL6SCzAWU1nb09DdIhTaP6f6S
         U4yFj/hRf1Dcka/jTVhop+chyn1dQtQeBPWK1XLlRKJQDFpdXu3ux4UHOZbwrR+uIL
         vl0fCywZ0yGXu1zuxGlhnc/ohZsMAZpf7ktvRuPWlG5jVbo0FPH/nnQdkFSZtpcbiT
         KLVzP3f21WTzg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6233b6a30000>; Fri, 18 Mar 2022 11:30:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A10A513EE2B;
        Fri, 18 Mar 2022 11:30:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A02152A2679; Fri, 18 Mar 2022 11:30:56 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/3] hwmon: (adt7475) pin configuration
Date:   Fri, 18 Mar 2022 11:30:47 +1300
Message-Id: <20220317223051.1227110-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=_3ioNcgKDktiekeMNxwA:9
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

This series adds support for configuring the ADT7475 based on the
hardware description provided. The ADT7475 driver has always supported
detecting the configuration. This adds support for configuring the chip
based on the hardware design.

Chris Packham (3):
  dt-bindings: hwmon: Document adt7475 pin-function properties
  hwmon: (adt7475) Add support for pin configuration
  hwmon: (adt7475) Use enum chips when loading attenuator settings

 .../devicetree/bindings/hwmon/adt7475.yaml    |  22 ++++
 drivers/hwmon/adt7475.c                       | 100 +++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

--=20
2.35.1

