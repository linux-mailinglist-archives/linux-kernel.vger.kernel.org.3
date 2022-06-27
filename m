Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF855D5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiF0PIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiF0PIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:08:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970A127;
        Mon, 27 Jun 2022 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656342484; x=1687878484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OkWPsn2b02Q9Pv+/0ZVMO3zsX02+G170/f67CGxFMUY=;
  b=ke863qino8lJ+g61VLKsnq1yZC3OY/fiHDR79/b5LF+ThQX8RUkDKVfF
   O88X2iv4FHNIZNL9A0Lno0gZMqdfs8V/ki8o4KNRF3hD2/RZn7zXoJ6k1
   BN70XUr4Cg2acsGq7doLuFylcNcTvNTSczXNRxlDCYjhsmn/f4l3qewRz
   F6PkrCkW8eOCBw5XuFiNzHO3cNNYbNLB0Qj3Oh8uOGmspMWSS68F5pVRQ
   Rq8J99ZaC2WkWkSIXZ2sEQQFDFYfGJiVY+8Yh6tMgLixW734SfobI7Klx
   nkfeUTDGEF01F+thh0wHftzjgrXIhox0DiaOFOyf7cu/anHcL1sSF/uSj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261881848"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="261881848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 08:08:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="646461411"
Received: from gretavix-mobl3.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.43.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 08:08:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yves Coppeaux <yves.coppeaux@st.com>,
        Bich HEMON <bich.hemon@st.com>, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] serial: stm32: Clear prev values before setting RTS delays
Date:   Mon, 27 Jun 2022 18:07:52 +0300
Message-Id: <20220627150753.34510-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code lacks clearing of previous DEAT/DEDT values. Thus, changing
values on the fly results in garbage delays tending towards the maximum
value as more and more bits are ORed together. (Leaving RS485 mode
would have cleared the old values though).

Fixes: 1bcda09d2910 ("serial: stm32: add support for RS485 hardware control mode")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/stm32-usart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index db3dd9731ee1..0cfe183f4076 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -72,6 +72,8 @@ static void stm32_usart_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
 	*cr3 |= USART_CR3_DEM;
 	over8 = *cr1 & USART_CR1_OVER8;
 
+	*cr1 &= ~(USART_CR1_DEDT_MASK | USART_CR1_DEAT_MASK);
+
 	if (over8)
 		rs485_deat_dedt = delay_ADE * baud * 8;
 	else

-- 
tg: (65534736d9a5..) fix/stm32-delay-rts-clearing (depends on: tty-next)
