Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6D4B2748
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350611AbiBKNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:35:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350596AbiBKNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:35:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD91E3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644586532; x=1676122532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dcNmaTIDG4XHn1AdLz19Xxg5AO1roEqTMpTVP6Z9qNQ=;
  b=sN+AOyJXZ4ZrOS9IEoiIOwrhLfXmiJ9o5HU3wPPw6HcYgYsih4bJwEaN
   5KDYLJ8SbhA0LhkW8fxbGcBEG7N5wCEUqXFj6mVCj/X5jd8QS8hRzP8gy
   4NVhiBqutuKllNFeKOhxMGLcvbgUU/PsnUl4goHOikcCgzQmmGEqS68ij
   m9Fglv85K2PnCiydO+SDMICazBpGXlinmGmzMmFlSBeCnopMYecqmKXqp
   anwhv6R03iDf4gQMALPhjnicdATdcBZeCIyPkgBQrwUi3LGgorcZnBso1
   h3JIZXPVfV+eX38ikZL1O+rhcltsYEvN7eXqoT6g5WuVNXUbE4rmm3WAW
   A==;
IronPort-SDR: uDw/z51m8ayvTGJca7U1d2SJnITPbBLWauSWy1vFwzlG8mCBOEPhkkZAoRU+HcdjzXz8u8ZKC7
 R65h8v/jgiq0F6xEbpZ3DGlaq0RzdMjQNcZ9mK/NSfIocLNT9pwh4qSSD0poC91h13WL2aDhHH
 VcfbjN71b2ZNWtoj0MWrIULNpoyEswvnBQrkKmYYlrNDxzlBf4FPVbltDtibCcmh4i6gBYI7aM
 nKJbdYirDkoXilyyOJE44F0Fkr9mKiQyKgh3H3qNAU4PGqkff3ePafMX+t2GS6U8E6VjSp5KtM
 zWmMwA5c9L4IpCp/O3tGenkq
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="153283188"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 06:35:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 06:35:31 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 11 Feb 2022 06:35:29 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: fixes for 5.17
Date:   Fri, 11 Feb 2022 14:35:15 +0100
Message-ID: <20220211133515.15314-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are 2 patches that just change the MAINTAIERS entry for at91. I think it's
better to have it sooner than later so this is why I add it to a "fixes" RP.

Thanks, best regards,
  Nicolas

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-5.17

for you to fetch changes up to 26077968f8389a68fdb38af3f2c2289ddc95e8ca:

  dt-bindings: ARM: at91: update maintainers entry (2022-02-09 11:30:01 +0100)

----------------------------------------------------------------
AT91 fixes #1 for 5.17:

- MAINTAINERS file update.

----------------------------------------------------------------
Nicolas Ferre (2):
      MAINTAINERS: replace a Microchip AT91 maintainer
      dt-bindings: ARM: at91: update maintainers entry

 CREDITS                                               | 6 ++++++
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 3 ++-
 MAINTAINERS                                           | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre
