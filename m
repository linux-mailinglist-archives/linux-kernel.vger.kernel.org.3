Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68913542CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiFHKKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiFHKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233521D64D4;
        Wed,  8 Jun 2022 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654682099; x=1686218099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XjZxocqKI/F6BP18bnSiMtmDN1Frg8bfTKfJL0h0oc=;
  b=FLfhYLM6MncyOKMHaqI31k6erjb1mm/T1vD1VxPIrphSRAoaxspOoS9c
   mkzAU52t+IBy/xQ6xMK6H3yiQOog+w+yE23SSPFVrt0aUcMGoTuw8AElB
   hHl+LQRQyTDp8AykWzt7uBcpnzCLMBo8l2IoAGCiJ/de1oPL/3oQGwT6k
   S3XywPN9VzQn2IRVvFwNiNXdBOax4kh+cq7TVGlST43MkvOwOdScJneTX
   EWk26hqa4ef9jCE5eilq6d/b6r7D7T7VnW1uiAC8a6OxuDqo5s1OeVWOw
   PveshcMWv04reJq+9hllYk8+a9wGgG5ykARjljfGYehI36UDGeB9FdJgY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="278019560"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278019560"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="584783515"
Received: from bmichals-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.131])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 4/6] serial: 8250: Adjust misleading LSR related comment
Date:   Wed,  8 Jun 2022 12:54:29 +0300
Message-Id: <20220608095431.18376-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com>
References: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serial8250_rx_chars() has max_count based character limit. If it
triggers, the function returns the old LSR value (and it has never
returned only flags which were not handled). Adjust the comment to
match behavior and warn about which flags can be depended on.

I'd have moved LSR read before LSR read and used serial_lsr_in() also
here but I came across an old discussion about the topic. That
discussion generated commit d22f8f10683c ("serial: 8250: Fix lost rx
state") so I left the code as it is (it works as long as the callers
only use a subset of the LSR flags which holds true today) and changed
the comment instead.

Link: https://www.spinics.net/lists/linux-serial/msg16220.html
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a0ea048eb2ad..c860f5964138 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1782,9 +1782,11 @@ void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 EXPORT_SYMBOL_GPL(serial8250_read_char);
 
 /*
- * serial8250_rx_chars: processes according to the passed in LSR
- * value, and returns the remaining LSR bits not handled
- * by this Rx routine.
+ * serial8250_rx_chars - Read characters. The first LSR value must be passed in.
+ *
+ * Returns LSR bits. The caller should rely only on non-Rx related LSR bits
+ * (such as THRE) because the LSR value might come from an already consumed
+ * character.
  */
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 {
-- 
2.30.2

