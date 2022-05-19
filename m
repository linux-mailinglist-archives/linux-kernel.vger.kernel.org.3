Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F352CE27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiESITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiESISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:18:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B965D3E;
        Thu, 19 May 2022 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948310; x=1684484310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3rLSxMemifcCya5x4k0dLXnkqmQGBK5a9aBX6E+21uY=;
  b=Bxi7XDUrYz4dyDCu7pAwbCdMtmAoZeeuX1qmT4+YhJnBbNuDufWJ0B7Y
   jL2gB84T6vwGQMxShF0vULZkmuleFfrGVnpWBXojWPtFgqKz0kGCDGAMV
   uRP1t+IsV1j9LYXry7ovMldJaF/MDAJrTDVzPcyWInHayjvL2DhXbt9Vk
   0rDErPh14iFToVPAJ1B5da5obPLSxcPdrcdk1F7yEwkKFGBK7cP1acrzK
   POg3jx/M1qsalYYiQ2qqnpt3wLduU50Efw0yW64YpMWjA7NUjJXLW5Cey
   gWHPJf2FJ9m0Q5Sl2BXER7N68ZTKtTmxd8o11BQV0S6bZADVeaBIgPObi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272218917"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272218917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431246"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/9] serial: rda-uart: Don't allow CS5-6
Date:   Thu, 19 May 2022 11:18:02 +0300
Message-Id: <20220519081808.3776-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
References: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only CS7 and CS8 are supported but CSIZE is not sanitized after
fallthrough from CS5 or CS6 to CS7.

Set CSIZE correctly so that userspace knows the effective value.
Incorrect CSIZE also results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Cc: Manivannan Sadhasivam <mani@kernel.org>
Fixes: c10b13325ced (tty: serial: Add RDA8810PL UART driver)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/rda-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index e5f1fded423a..f556b4955f59 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -262,6 +262,8 @@ static void rda_uart_set_termios(struct uart_port *port,
 		fallthrough;
 	case CS7:
 		ctrl &= ~RDA_UART_DBITS_8;
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS7;
 		break;
 	default:
 		ctrl |= RDA_UART_DBITS_8;
-- 
2.30.2

