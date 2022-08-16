Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42175595B63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiHPMIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiHPMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFA302;
        Tue, 16 Aug 2022 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651084; x=1692187084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1UKIh5lVnmIBtDpa/AFX4y2MwA+uxmPJv1Yi4y10neY=;
  b=ZOqkhz0gXvSmIGe2T5t8WHxenGbTHS+sck7yvwAnS5lmECLp3WHvbEsT
   MdVveM+9veTWWu2+VNnd6qR1FrXbyAKgP5iPZR8KNSPi6ZwZdnpdphA6+
   dHSKwXhRUpKuSLWVPztHWd7sUhkHWO67JAnf8q5LrDZmp7VR1G3yg/Pr2
   ukAox3CtAy85Y0mOodWM182cL7SZIzLh4ChPxGA76gRWMhCnjdO0+kMub
   lDBScaWm04UsQijbckPBfTh6oJCX0gpWPwL+0pDgoR0r9BboLV6/Ly6T/
   bnUGAHgaKUOQX16V4UXvsfYxxNrBp5vn9TqXnlGp29I13yUOzCmF//JJl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356199331"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356199331"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080809"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/8] serial: dz: Assume previous baudrate is valid
Date:   Tue, 16 Aug 2022 14:57:34 +0300
Message-Id: <20220816115739.10928-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
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

Assume previously used termios has a valid baudrate and use
it directly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/dz.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 2e21acf39720..3eaf4e85bfdd 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -592,9 +592,12 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 
 	baud = uart_get_baud_rate(uport, termios, old_termios, 50, 9600);
 	bflag = dz_encode_baud_rate(baud);
-	if (bflag < 0)	{			/* Try to keep unchanged.  */
-		baud = uart_get_baud_rate(uport, old_termios, NULL, 50, 9600);
-		bflag = dz_encode_baud_rate(baud);
+	if (bflag < 0)	{
+		if (old_termios) {
+			/* Keep unchanged. */
+			baud = tty_termios_baud_rate(old_termios);
+			bflag = dz_encode_baud_rate(baud);
+		}
 		if (bflag < 0)	{		/* Resort to 9600.  */
 			baud = 9600;
 			bflag = DZ_B9600;
-- 
2.30.2

