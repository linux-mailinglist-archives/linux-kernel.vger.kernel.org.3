Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16B52CE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiESITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiESISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:18:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A216473D;
        Thu, 19 May 2022 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948314; x=1684484314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZuMzyzE454rqEUy+oyhf8WPcSuEBUbU+ss/N1d+u/w=;
  b=HNGQ6GiM2HElwHFky9WWMJTxABrlEfbc2zRu/ZHDmbgGm2bgjIlAkhEz
   OHO6rB7RTDo4/ZiXso5bHBHmGYCI//dCPZmw91Odah+5uPh4SZkQxE1IJ
   lpNsCh2hF+E5CsvLf1DY8Xc2lYfhugxGsOL5DCMuoTM/qP6Loxujkd9YG
   Os2eX8tpTHyZVRcOf1lpoDCirRZts8sQqP1K1EBTsEPZK3gkBhHaoOCg5
   QReFfckI6egpKmoF3bMoLj2xqO5XxK3SSMSFVa7pXF03zqlNhz6J0Nrp2
   g48eXd3TmVxeSrGxbX0DqkcXVPe36NWJQEallJ7GWMS4UnAFKbbMUvf/l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272218970"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272218970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431315"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/9] serial: txx9: Don't allow CS5-6
Date:   Thu, 19 May 2022 11:18:03 +0300
Message-Id: <20220519081808.3776-5-ilpo.jarvinen@linux.intel.com>
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

Only CS7 and CS8 are supported but CSIZE is not sanitized with
CS5 or CS6 to CS8.

Set CSIZE correctly so that userspace knows the effective value.
Incorrect CSIZE also results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_txx9.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 2213e6b841d3..228e380db080 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -618,6 +618,8 @@ serial_txx9_set_termios(struct uart_port *up, struct ktermios *termios,
 	case CS6:	/* not supported */
 	case CS8:
 		cval |= TXX9_SILCR_UMODE_8BIT;
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
 		break;
 	}
 
-- 
2.30.2

