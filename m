Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78053E7A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiFFKJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiFFKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625FE144786;
        Mon,  6 Jun 2022 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509989; x=1686045989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkqgtQAboZnM/AAFg9v2/5Z9Uxqx4JM1lubOKwYAy7M=;
  b=i80R34XwgvxyfzxgBQTku+Ba0lnu1S+6XBt8i08ZEyucHIKBN8+AY3z2
   MhzKmzfKbvCGlxhjE4YyyBEukbJ17r2qnTfn7UGMq9n7M1RHZ3VnAlkZM
   AFPX4CHvps6a11RbsWs8T7i73A44KjxDbiy/Ahr7pgUi7F0VSv8STYdzT
   DiuAkgp/+MjwryMZm+hkYOQACBXri5ZCESYOH+lzLgG6HjMygoWqZe9wN
   euDF6X7OqUTMYV7X9LsHa25dM7xc7qJjv/SJLfKHw9ySitlfzGLruruKr
   KucFwOJ8QoNk9WOu4IErfYZrBDvMh2TqdOEFRVW1q0G37VvXEs2PS8nBa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987093"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987093"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523908"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:27 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 33/36] serial: 8250_exar: Remove serial_rs485 assignment
Date:   Mon,  6 Jun 2022 13:04:30 +0300
Message-Id: <20220606100433.13793-34-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 assignment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 11916f603a3d..528779b40049 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -427,8 +427,6 @@ static int generic_rs485_config(struct uart_port *port,
 	if (is_rs485)
 		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
 
-	port->rs485 = *rs485;
-
 	return 0;
 }
 
-- 
2.30.2

