Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C053EB3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiFFNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiFFNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:15:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80936E1D;
        Mon,  6 Jun 2022 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654521318; x=1686057318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIAV23HzVSDkcA0rDQGW2QNr+iOt4Krdyz+ksgaxkWA=;
  b=m2brcijwzES69C44PH6RSHbyVBgOurNIvgfngIfrUGqxyjCjvbJs2Js8
   amxiPwJTKoi5EXcSdZLhmOPpbrHrAljeQerDFI2QjZtQcDvS2YufREVca
   5+0zcM52vndJXZ8kDu1rghFLwBK+4vr+YRE1WEAaOOCQl8GhsajfJJs/g
   TtLxpnDdx3Oh46g1WyJ6G6vQOCbQH2asV6oLKKk9JyYiDakQKQMnyG5Uc
   oPlZyNKK4xuQaOkdWYfdfS0IXSQyVWAcSEEkojzxj7BSgmsCd12+UaDfI
   XR/45txKmgMpe6HY/EF8iOELSw754hakTBJLBXDoyerMTfk5tN0Ac+pNM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="339948464"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="339948464"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583630963"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@penugtronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/6] serial: 8250: Adjust misleading LSR related comment
Date:   Mon,  6 Jun 2022 16:11:22 +0300
Message-Id: <20220606131124.53394-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
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
triggers, the function returns old LSR value (and it has never returned
only flags which were not handled). Adjust the comment to match
behavior and warn about which flags can be depended on.

While I'd have moved LSR read before LSR read and used serial_lsr_in()
also here but I came across this old discussion about the topic:
  https://www.spinics.net/lists/linux-serial/msg20555.html
...so I left it as it is (it works as long as the callers only use
a subset of the LSR flags which holds true today).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a0ea048eb2ad..686891f1b2ca 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1782,9 +1782,12 @@ void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 EXPORT_SYMBOL_GPL(serial8250_read_char);
 
 /*
- * serial8250_rx_chars: processes according to the passed in LSR
- * value, and returns the remaining LSR bits not handled
- * by this Rx routine.
+ * serial8250_rx_chars: Read characters. The first LSR value must be passed
+ * in.
+ *
+ * Returns LSR bits. The caller should rely only non-rx related LSR bits
+ * (such as THRE) because the LSR value might come from an already consumed
+ * character.
  */
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 {
-- 
2.30.2

