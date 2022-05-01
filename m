Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125A1516211
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 07:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiEAFsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 01:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiEAFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 01:48:14 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2845138BF0;
        Sat, 30 Apr 2022 22:44:50 -0700 (PDT)
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651383887;
        bh=eIKWJyoaLkJuB+nzU9OpjewDEuEGEm0it8FLQCd8BaE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=cZmGGMcQLi8neWNptANOwYRSIn7ZXoRUdTezksV5TgjQC57ZizSyXisUGZdIPuFm4
         qD6vcRCDR5Qle1tgfYuCoifl9D0KFYd71uxcvc2Ozj/No/9zmU5TRIJO2fRjO96NS2
         bqD/8U5zh23kL4yaLXq+BjCYPgRgRjijCMowNgrSfH3Du+9el0FRkW3SLN2QDP70vi
         nFtIaQ3rEC9EqHyTaJAcDpkrzfvF4m0ckemUJkEmmXe1CN/zXjo1ThfX/mtxTkfrLJ
         ZQtYIHXYcsW1W2sdYBaTLs+jROMSxyzhy2HB/0f8LdZrt6M/Cz3VjhmHvpPTVrdXMX
         nHT5ZR8Y+nsJg==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gengdongjiu@huawei.com,
        rdunlap@infradead.org, hanetzer@startmail.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, cai.huoqing@linux.dev, novikov@ispras.ru,
        linux-mtd@lists.infradead.org
Subject: [PATCH 0/2] Hi3521a support.
Date:   Sun,  1 May 2022 00:44:40 -0500
Message-Id: <20220501054440.2434247-1-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks. Its been a while. Finally got back on the kernel dev train.
This *mostly* seems to work, but I've ran into an issue which may
require some upstream support.

Basic gist, I was attempting to boot a buildroot-built intramfs, was
mostly working, but it would not give me a login prompt no matter how
much I badgered it, so I decided to try a flash boot. That also failed,
and after much banging my head on the desk and annoying people on irc,
we finally came across *why* it was failing, or at least part of it.
The kernel parser could produce the mtdblockN partitions based on the
devicetree, but for whatever reason, when the hisilicon,fmc-spi-nor read
its superblock, instead of the magic 0x73717368 (sqsh), it read back 0x73717360.
At first I thought it was a mistake of mine, as we had tried modifying
the header, and 0x60 is a `, so it could be a hex editing issue, but nope.
Reading the data in u-boot (2010.06, vendor fork, would like to get mainline
running on it at some point) showed the correct magic, so its something
with the controller driver, I guess. CC'ing the people associated with
that as well, hopefully we can get to the bottom of this.

Marty E. Plummer (2):
  clk: hisilicon: add CRG driver Hi3521a SoC
  arm: hisi: enable Hi3521a soc

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/mach-hisi/Kconfig                |   9 ++
 drivers/clk/hisilicon/Kconfig             |   8 ++
 drivers/clk/hisilicon/Makefile            |   1 +
 drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++++++++++++++++
 include/dt-bindings/clock/hi3521a-clock.h |  34 ++++++
 6 files changed, 195 insertions(+)
 create mode 100644 drivers/clk/hisilicon/crg-hi3521a.c
 create mode 100644 include/dt-bindings/clock/hi3521a-clock.h

-- 
2.35.1

