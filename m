Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767415A11BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiHYNSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbiHYNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:18:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C9A9255;
        Thu, 25 Aug 2022 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661433479; x=1692969479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Xldrfug7F3ZOc/ocWfpppxI2d2k/b5ME9FwiEpzFJw=;
  b=aZECd8zZRTCO79N9nJ7RYDBmRfZ0mjfaHqy7LcWoh8sm4jA3niEh1Agv
   peTKpr7zwI1jT5V/CWjL1MzOYkBFfH9JNiMgKdy97lnO1ELNSAoOQ8xFK
   1qoueoy7ZCsfz7W7bG1RBUM0Ck0U53BDLK/mkFT3iQWCOyp57A9Qs6sMf
   yvfqEW4Ls17p1sVilVpvMpA+BY7LmrJbQZH0ffp2NLmV5PUkMY6Q6PGY/
   nPKfuIbN3JxALQY7AzOilLqlOXYSdc3MiQwoiwq+r8tlj30CHqewV1Sjv
   E9090eowZINiL17lb6I7fvXAfIjUVLkNiyntrpW2R+VYLhvd1j1IDLXEr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="294234923"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="294234923"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:17:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="670974568"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:17:57 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/2] serial: dz: xmit buffer is UART_XMIT_SIZE'd
Date:   Thu, 25 Aug 2022 16:17:45 +0300
Message-Id: <20220825131746.21257-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com>
References: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of DZ_XMIT_SIZE, use the normal UART_XMIT_SIZE directly as it's
the correct size of the xmit circular buffer.

In theory, the Tx code would be buggy if UART_XMIT_SIZE differs from
4096 (occurs when PAGE_SIZE > 4k), however, given the lack of issue
reports such configuration likely doesn't occur with any real platform
with dz HW. The inconsisted sizes would cause missing characters and
never-ending bogus Tx when ->head reaches the region above 4k. The
issue, if it would be real, would predate git days.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/dz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 2e21acf39720..5d2588f3e6a9 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -279,7 +279,7 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 	 * so we go one char at a time) :-<
 	 */
 	tmp = xmit->buf[xmit->tail];
-	xmit->tail = (xmit->tail + 1) & (DZ_XMIT_SIZE - 1);
+	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 	dz_out(dport, DZ_TDR, tmp);
 	dport->port.icount.tx++;
 
-- 
2.30.2

