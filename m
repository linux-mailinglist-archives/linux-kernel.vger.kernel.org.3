Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6252CE20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiESITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiESISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:18:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D53565D3B;
        Thu, 19 May 2022 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948319; x=1684484319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3zjirNqG/3LyQnmY81zuizX47Uw5UxNaZ0Aqf8btHo=;
  b=cALzHj99uiJza9mO4AF+gf5Z5S/azT/ZMKGD9whJAxOKgZUlr7rL8ESH
   47Ka8c+mnxyQLyQ/NaeJbamfYy1oryOny/Zt/tzRH6DfbruwgmakeovYF
   CK91yidQnIh0dcnXCinp2aan2xNUIsMT8VbQJ7cLIcma2emnVxndqGaGd
   jDffy8G0D1eLKfyVKmcQe2vrBlszPhD8Dn8QXhbs+XmNGDVhK0E6MwD7h
   T3ZkQjL509r8M5ATbbhsetXwt9Qyf7/P6AzeGcH6TC2u5c9D8ZFGUAZqs
   0EbBCSC9GRXZivn1d2vGy5oS/D4oLR+6Q+Bqg/yvDIFiqQ1fN9mH+AnF/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272218996"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272218996"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431415"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/9] serial: sh-sci: Don't allow CS5-6
Date:   Thu, 19 May 2022 11:18:04 +0300
Message-Id: <20220519081808.3776-6-ilpo.jarvinen@linux.intel.com>
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

Only CS7 and CS8 seem supported but CSIZE is not sanitized from
CS5 or CS6 to CS8.

Set CSIZE correctly so that userspace knows the effective value.
Incorrect CSIZE also results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0f9b8bd23500..0075a1420005 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2379,8 +2379,12 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	int best_clk = -1;
 	unsigned long flags;
 
-	if ((termios->c_cflag & CSIZE) == CS7)
+	if ((termios->c_cflag & CSIZE) == CS7) {
 		smr_val |= SCSMR_CHR;
+	} else {
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
+	}
 	if (termios->c_cflag & PARENB)
 		smr_val |= SCSMR_PE;
 	if (termios->c_cflag & PARODD)
-- 
2.30.2

