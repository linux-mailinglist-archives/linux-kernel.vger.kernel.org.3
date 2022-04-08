Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7B4F9297
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiDHKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDHKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:12:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC8B58E6D;
        Fri,  8 Apr 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649412599; x=1680948599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PRW1z5BDKUyVp87gb5BA0bIYa/nZ8N7XjvhnUwpnBG8=;
  b=HnOM63grL35nN5rXKNAZs0ATZoPm0DdcdILckJ2J5HKi28HQpdFb/3xO
   +YrF7qJFfn0WsYhslTGUdxz8LgTx6sXnh3ubpbdqq4vcVWDKAhq/fHTvV
   VEyVcPAskcfOtGhwE30y6UZNTTr39blTGCm5FUxBQdVAkTCXcbhNmkbZv
   Mu12++WAXPXKmJKiNqkokPMpJgVUZWqmAth8gbuvyIKydGQh0UKEPbjhL
   6PaIiXhZRsG6RI4xUS0+m9Sh9VH31wL9a7rqnrfvLVOKY5csJEkTdGbs6
   sQm3668t3Vk1ynJG/rJwdqoATWKWeBm8yzTCfOzml/ZY4HzBnmenKa2HI
   w==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643698800"; 
   d="scan'208";a="91749499"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2022 03:09:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Apr 2022 03:09:57 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Apr 2022 03:09:56 -0700
From:   <conor.dooley@microchip.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [v2] Add support for hwrng on PolarFire SoC
Date:   Fri, 8 Apr 2022 10:09:11 +0000
Message-ID: <20220408100911.1638478-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As it says on the tin, add support for the hardware rng on PolarFire
SoC, which is accessed via the system controller.
I dropped the maintainers entry change that v1 had, I will send a
single update via RISCV to avoid any conflicts.

On v1 I replied saying there was a refcount issue, but that's not
actually the case, so no changes required there.

Thanks,
Conor

Changes since v1:
- Rebased on v5.18-rc1
- Dropped the MAINTAINERS change
- Added quality estimation

Conor Dooley (1):
  hwrng: mpfs - add polarfire soc hwrng support

 drivers/char/hw_random/Kconfig    |  13 ++++
 drivers/char/hw_random/Makefile   |   1 +
 drivers/char/hw_random/mpfs-rng.c | 104 ++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/char/hw_random/mpfs-rng.c

-- 
2.35.1

