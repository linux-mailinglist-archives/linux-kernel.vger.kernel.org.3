Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE953EBE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiFFKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiFFKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50B135682;
        Mon,  6 Jun 2022 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509994; x=1686045994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jC/dgPE6/D0IhQzMV7QXUvA9O0C+12y7m0vQyoLFb4E=;
  b=VcnxHfKPvMzBlK80t1xl34mZARS403wS3CEqoizibCL3bNH/hpl8xkBq
   Nf6Y6gBv0+fHwfb3N+RPOXGWkcBju93ddOCDXT2XopE5rGo9BBTRUrnam
   AaaNAftiTL/+zk491jhhFz8BN+Z9KdYmO8IS/+ibMziAlUCIN55gMkFXe
   pM/t71IGmYfMvLq1q1RYuZYDoD9mTjHHgxlaSNpGZkFKMSlHKhvjk+fSj
   7JMVKkyYkvTMZ/OtrMI58BBSGrTLt4X/4QI+5QsYTdqI76N7Zdoi9lQKC
   ofgL3GGzm8sj0wF+UueI56u3znFXOiJqCbocgXxYz3FCnBGcDbd4I8REI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987098"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987098"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523922"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 35/36] serial: sc16is7xx: Remove serial_rs485 assignment
Date:   Mon,  6 Jun 2022 13:04:32 +0300
Message-Id: <20220606100433.13793-36-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 assignment. It is safe to remove this
assignment because sc16is7xx_reg_proc() takes port.lock at start (and
sc16is7xx_reconf_rs485() would too).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b3162dfe97b1..2ceecaa4a478 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1143,7 +1143,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
 			return -EINVAL;
 	}
 
-	port->rs485 = *rs485;
 	one->config.flags |= SC16IS7XX_RECONF_RS485;
 	kthread_queue_work(&s->kworker, &one->reg_work);
 
-- 
2.30.2

