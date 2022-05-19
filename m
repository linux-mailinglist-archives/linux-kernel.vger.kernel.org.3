Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F160E52CE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiESITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiESITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:19:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A569CE0;
        Thu, 19 May 2022 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948330; x=1684484330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B/wsivre0Bc6qlbjo3she/qQCDt/pTlKU20VjyLCa68=;
  b=IzgaNaIex54Q90yacvNSDb3CFgSLh+BPJVA3vDsK/h4/YX6HW0MvqCoU
   Ygx9/RoVxT4PtYUag+wG0LNLQ96WA1i+7uO5tknxcatwm+XcT4EkFeY+D
   vu1wK5AbkVv1Jh6IeL5kicYvPnnn4nPAyuiYBUUIlP+iFGxfFmBj1MKUj
   lcFgWeBuIEuW3ckp039H5JQdQMMkC+g/Z5rs+brTvfksBhdOdGcaBqwnS
   mmJf6Q7hL+xQK1JkIusQKS6haWiS4Kdybn0wn17N6CK56Yo/ihwQygU49
   wcNunEYTyTCs7IoZyBIM6v2jsSh/k7rgwuvhfCE5d4XWSis7ImYnbhoBo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272219094"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272219094"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431518"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 8/9] serial: stm32-usart: Correct CSIZE, bits, and parity
Date:   Thu, 19 May 2022 11:18:07 +0300
Message-Id: <20220519081808.3776-9-ilpo.jarvinen@linux.intel.com>
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

Add CSIZE sanitization for unsupported CSIZE configurations. In
addition, if parity is asked for but CSx was unsupported, the sensible
result is CS8+parity which requires setting USART_CR1_M0 like with 9
bits.

Incorrect CSIZE results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Cc: Erwan Le Ray <erwan.leray@st.com>
Fixes: c8a9d043947b (serial: stm32: fix word length configuration)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/stm32-usart.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 87b5cd4c9743..3c551fd4f3ff 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1037,13 +1037,22 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	 * CS8 or (CS7 + parity), 8 bits word aka [M1:M0] = 0b00
 	 * M0 and M1 already cleared by cr1 initialization.
 	 */
-	if (bits == 9)
+	if (bits == 9) {
 		cr1 |= USART_CR1_M0;
-	else if ((bits == 7) && cfg->has_7bits_data)
+	} else if ((bits == 7) && cfg->has_7bits_data) {
 		cr1 |= USART_CR1_M1;
-	else if (bits != 8)
+	} else if (bits != 8) {
 		dev_dbg(port->dev, "Unsupported data bits config: %u bits\n"
 			, bits);
+		cflag &= ~CSIZE;
+		cflag |= CS8;
+		termios->c_cflag = cflag;
+		bits = 8;
+		if (cflag & PARENB) {
+			bits++;
+			cr1 |= USART_CR1_M0;
+		}
+	}
 
 	if (ofs->rtor != UNDEF_REG && (stm32_port->rx_ch ||
 				       (stm32_port->fifoen &&
-- 
2.30.2

