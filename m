Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F853EA28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiFFKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiFFKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5AE144FC7;
        Mon,  6 Jun 2022 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509992; x=1686045992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oll5KaEkDpEpL5et566YY0PuRsrie8otuYYJ8R196ro=;
  b=QGIhEVFgkBXsxjRSBVk4PB1KuCJn6rrEfXH3rDAUde8dCZ7niZzZQIO5
   if5nPpvC9DHlNp6ShudiXunKabH2z69vDUiykp8Il7qlSrle/e1ru4YqO
   qOJkbQl0stO7mNaEsQmRtzstq7mPaU0j48/ecNeRCiH6HCumbRVx04JL8
   EK999bmNLwP1xejBMiQhrJmoAXeXw5bvK95bY+/N5t7EJSKi3anRG4oSf
   G/W8hDS+v6AbM5vZ2DhMivfzuLHA1h9qhYcaLwQJEAGBonRIVc44yDg3h
   9qemJimvSJ+Oa4UfvbC2Eo9Tg5I9Nqgw8svgguGw1w//ACWx+K32PlYy2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987095"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523918"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 34/36] serial: mcf: Remove serial_rs485 assignment
Date:   Mon,  6 Jun 2022 13:04:31 +0300
Message-Id: <20220606100433.13793-35-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/mcf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 655255e0c76a..036f178e3d66 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -448,7 +448,6 @@ static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	}
 	writeb(mr1, port->membase + MCFUART_UMR);
 	writeb(mr2, port->membase + MCFUART_UMR);
-	port->rs485 = *rs485;
 
 	return 0;
 }
-- 
2.30.2

