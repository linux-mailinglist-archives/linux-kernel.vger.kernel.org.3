Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8752CE29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiESITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiESITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:19:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9D663C5;
        Thu, 19 May 2022 01:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948334; x=1684484334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQ+lnY6dYx8GIiIqMS+NqyRc9HSpuylhm5ub7+G+Sro=;
  b=PtPNFJPRPKsDlIJarL9/zz0hzzgkiVpchWvFuzjrEr6GmChx/jfxjIiJ
   v/F3U+nsNwf/htYSe6x0wp82rhPVF81mtjw1QB2nEI2vNAgGs34VffSqz
   G/nmWrZ6VkEBe8MYHGOpQ1SJtukKzsDo7tmBovBEaO+RoxMc0q7iYe9X2
   CgSGy56lEFEimnEZkl7ACCkLTftiQVa+tO3nVhvTyFk3ryllKzIehfseA
   zrxXNU9t7gwo/4idbqq9HWzcs02/CUCyCD48wrcyQsts3dlCT21oqrCZq
   KXlSiDlLHF5CkNH+fB9yAsq5hwfNs82RK89TSwDVuoZh2N+mq8nXJrRSC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272219112"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272219112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431547"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 9/9] pcmcia: synclink_cs: Don't allow CS5-6
Date:   Thu, 19 May 2022 11:18:08 +0300
Message-Id: <20220519081808.3776-10-ilpo.jarvinen@linux.intel.com>
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

