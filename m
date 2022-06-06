Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9953EA9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiFFKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiFFKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFC3139C8A;
        Mon,  6 Jun 2022 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509968; x=1686045968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=geGI3l4XWU1FlWu8pGiJvI1eL9aFCA+g7U3rNUsB2m0=;
  b=GOzShFeEAkEXygPApyTG3Yzr2buvwh6HsyVDwFalOcYb/ZJY82G8eAQg
   ue1XpHFEFyfP4jQfCHl3TurdK8rMNvXHWBXLKd2ZF5+nTyTIhH2avg+c4
   bfJS+awo40LMRJawjK6IdG20BDBXct6GPYPTzi81FBvIIPCZRYkRLfA+H
   EQNaKYSj/b6SIQE8dACa0ith24dNxXMyKEjwjbyw7RB2IEvJljWp399Cs
   pDTYiIqZs/OOGo3gSx5yMZnYrbtkFW+6908YvJNDqRAH/+iqe7Uf/gcI6
   RLMlrZ+4k8cU7R9512vbdNizJSke6wrDCh/LtdQtEJu3u2Xc9afzzH5UU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987081"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523839"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:06 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 26/36] serial: 8250_fintek: Remove serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:04:23 +0300
Message-Id: <20220606100433.13793-27-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 sanitization and copying rs485 struct.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 6e98c376e082..1fb86c73786c 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -206,19 +206,7 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 		if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
 		    !(rs485->flags & SER_RS485_RTS_AFTER_SEND))
 			return -EINVAL;
-		memset(rs485->padding, 0, sizeof(rs485->padding));
 		config |= RS485_URA;
-	} else {
-		memset(rs485, 0, sizeof(*rs485));
-	}
-
-	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
-			SER_RS485_RTS_AFTER_SEND;
-
-	/* Only the first port supports delays */
-	if (pdata->index) {
-		rs485->delay_rts_before_send = 0;
-		rs485->delay_rts_after_send = 0;
 	}
 
 	if (rs485->delay_rts_before_send) {
@@ -241,8 +229,6 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	sio_write_reg(pdata, RS485, config);
 	fintek_8250_exit_key(pdata->base_port);
 
-	port->rs485 = *rs485;
-
 	return 0;
 }
 
-- 
2.30.2

