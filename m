Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C616542CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiFHKKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiFHKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D41D519E;
        Wed,  8 Jun 2022 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654682097; x=1686218097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LO3RqP/ROL+iyBp2o8gTR6hTCZwGDg/Upf3192vzPR0=;
  b=UEJwAB20WHaEe7/iRxcmy7CERzkviulUfO6ZcFiv44qWKICfzYfjA6n8
   BN7VeA0sJ8IM42r+iTHxo4mJQNyV8BKz+99y182GhZKtCNttik3OYooFs
   ysjcOhMoQ8Tv7koDTdzTM8cig+CsCQuccgrB/4nOkdx/M0IUObmQWgRIk
   eGPsauHppB9wDV+Df1XGnm5kq2fc0i5koXUBDgiEg6ec0Ig6bYqXBKRQY
   DIN8nmN7jF6tcvpxpXxqsePdLyIKo81E3nemjTBtVKIu2GUzRKiQUELZ2
   KdKx10XqE6jFhEzySIbf+sFes9DOqY5+y58zC1eRHXa5mVLTVmI5CGfaC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="278019519"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278019519"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="584783433"
Received: from bmichals-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.131])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/6] serial: 8250: Store to lsr_save_flags after lsr read
Date:   Wed,  8 Jun 2022 12:54:26 +0300
Message-Id: <20220608095431.18376-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com>
References: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com>
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

Not all LSR register flags are preserved across reads. Therefore, LSR
readers must store the non-preserved bits into lsr_save_flags.

This fix was initially mixed into feature commit f6f586102add ("serial:
8250: Handle UART without interrupt on TEMT using em485"). However,
that feature change had a flaw and it was reverted to make room for
simpler approach providing the same feature. The embedded fix got
reverted with the feature change.

Re-add the lsr_save_flags fix and properly mark it's a fix.

Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
Co-developed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4998799abae2..c5e0f925f4b6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1511,6 +1511,8 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		unsigned char lsr = serial_in(p, UART_LSR);
 		u64 stop_delay = 0;
 
+		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
 		if (!(lsr & UART_LSR_THRE))
 			return;
 		/*
-- 
2.30.2

