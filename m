Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C825A29E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbiHZOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343829AbiHZOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:46:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B11D86F7;
        Fri, 26 Aug 2022 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661525204; x=1693061204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ua1eMzWICE18zPpgUg/mQvWp3yPZXQYmF3anVr6ntg=;
  b=WHfieG4cHidpIVFW9KGOpbTN3TPPtfQ54avY98gqXh9YBzPQI/USNDve
   DmgSe7AW1l9T0b2cgMLVtZQ40VpD6NZOc2zfvg4Ue1FT2Z7TK0vKy03vh
   eXXGhkSapMfc5IEat1sXbf6HEHZdWVVaWk5PBt2NgGsF+Hh6cAHRWnWFB
   JytyvOC5zAD7RVnyd/Zekju76JV9qPoVJ32E+5bQBC/JzOTKasirTnUak
   KtwHWZnXP5XKKcRuZfjfXkSco1dsRChNenG94Q+8E+AJHzpsh682A1H/6
   AQbi74C9MDf6spMiZY/kvquKow8yUolnOdL5dQkYBiQuQwWJDgZbzJ1XM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295792964"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295792964"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:46:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671488308"
Received: from syeghiay-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.41.100])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:46:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] serial: Rename vars in uart_get_rs485_config()
Date:   Fri, 26 Aug 2022 17:46:27 +0300
Message-Id: <20220826144629.11507-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com>
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make variable names to match uart_set_rs485_config() ones:
	- rs485 -> rs485_user
	- aux -> rs485

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 12c87cd201a7..9c1bf36b7a93 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1408,16 +1408,16 @@ int uart_rs485_config(struct uart_port *port)
 EXPORT_SYMBOL_GPL(uart_rs485_config);
 
 static int uart_get_rs485_config(struct uart_port *port,
-			 struct serial_rs485 __user *rs485)
+			 struct serial_rs485 __user *rs485_user)
 {
 	unsigned long flags;
-	struct serial_rs485 aux;
+	struct serial_rs485 rs485;
 
 	spin_lock_irqsave(&port->lock, flags);
-	aux = port->rs485;
+	rs485 = port->rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (copy_to_user(rs485, &aux, sizeof(aux)))
+	if (copy_to_user(rs485_user, &rs485, sizeof(rs485)))
 		return -EFAULT;
 
 	return 0;
-- 
2.30.2

