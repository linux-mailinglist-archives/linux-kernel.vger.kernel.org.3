Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C994F5A0C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiHYJRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiHYJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:17:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E061A0325;
        Thu, 25 Aug 2022 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661419049; x=1692955049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FtTKxcZto/nxmnPdOKNSdnDg1ZwycQlYMeAUGBpCi0=;
  b=E5Zb6o9IoicptZNrABA6TxLk1a11fv/UozDG74jHhgY1KN4JXsIBTy0u
   Gb5gc7VbY4Ux7izcOvae0jdrXNep0JZS/JuZuOfRn1QvZDHHYpaDEQw6E
   Edo3AVD03hRiDz2a5AMbUlAAF1+ZP73hux8TKJY9ynvoZjKGFx/bCOLyf
   MVyBiNzdoPpaFtwkZiW5SzBH1c2AqVQT40c438f7HZHAf9Gu4buC1Z/ue
   gyL7rtLZ0/ATOFgLacbWm38ySJqyUl753b/GJJItob1mCK6huf21N7VVT
   ta90HIcmXBoZ+bteZN6HyxDRhYeMrJ6LJgyB1fO8j4SkwEkUQ1/LkNKWl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355917191"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="355917191"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="938254148"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting
Date:   Thu, 25 Aug 2022 12:17:07 +0300
Message-Id: <20220825091707.8112-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tx'ing does not correctly account Tx'ed characters into icount.tx.
Using uart_xmit_advance() fixes the problem.

Fixes: 2d908b38d409 ("serial: Add Tegra Combined UART driver")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/tegra-tcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 4877c54c613d..889b701ba7c6 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -101,7 +101,7 @@ static void tegra_tcu_uart_start_tx(struct uart_port *port)
 			break;
 
 		tegra_tcu_write(tcu, &xmit->buf[xmit->tail], count);
-		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+		uart_xmit_advance(port, count);
 	}
 
 	uart_write_wakeup(port);
-- 
2.30.2

