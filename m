Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8A52A011
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345258AbiEQLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbiEQLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:08:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D62DABA;
        Tue, 17 May 2022 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652785711; x=1684321711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQ+lnY6dYx8GIiIqMS+NqyRc9HSpuylhm5ub7+G+Sro=;
  b=CxWEBRFnwuGMk//GWb0esBq7Gonnjr/PxnOHH4jgL/UiIp4j4MzYtary
   H0Kmf6zL94RFjpTkHE0eZCzt2RdZPY5K6pTtfwIpocXedbpKTrzoHfOuJ
   n8xbua6TAmVgsqQZ76K8TZdxHO3hLJdfsOnBTQoWv6YlZPgNW0Tk3XVDZ
   7QBnZzx5xzkvRBQyi83tXVbNoNbuL5Uk0UDhylAN4MuNXu5kZxu7idmWC
   YNF0UihJf1HSXHnVN2GqV9c/xoaQcifWCw4mmi34srIh36h/fpxDwx5WR
   WeoyB4HmkDzOMN8AckHkgL67VvbVJVoxKECUV0uh1yLOBBrZF93V8bu6O
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271268802"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271268802"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568831154"
Received: from mtarral-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.52.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 9/9] pcmcia: synclink_cs: Don't allow CS5-6
Date:   Tue, 17 May 2022 14:07:37 +0300
Message-Id: <20220517110737.37148-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only CS7 and CS8 seem supported but CSIZE was not sanitized in termios
c_cflag. The driver sets 7 bits whenever data_bits is not 8 so default
to CS7 when CSIZE is not CS8.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/char/pcmcia/synclink_cs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba55a8b5..d0572bbe8832 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1418,7 +1418,11 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 
 	/* byte size and parity */
-
+	if ((cflag & CSIZE) != CS8) {
+		cflag &= ~CSIZE;
+		cflag |= CS7;
+		tty->termios.c_cflag = cflag;
+	}
 	info->params.data_bits = tty_get_char_size(cflag);
 
 	if (cflag & CSTOPB)
-- 
2.30.2

