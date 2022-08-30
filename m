Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1B5A673B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiH3PXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiH3PXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:23:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E218B6D7D;
        Tue, 30 Aug 2022 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661872985; x=1693408985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=djTr8S5hFVJQCZAcmEv77RdKFem4vVtFK/sUITgcoUI=;
  b=QjlUyt9lhkD27EQUkj8+F7gqWwcoGwJx/VYcq0c0FAgyEsBZivxROACj
   QdvrNVK++88R3/q3xVfRnsrbMi9Dgo53Scp17EcVAJyfWwIvVuZIsc5KT
   a9jPDrmoLiAV/l9miD1b4G65tYlSFPO4WZxw+TB+JRPMA2hcx13tEtcPz
   XCNsrsx+2olpz/mJPWutHKoCNmF9FN8h8Xjeqf3iOLJAKXSnlYh9emkO+
   gKHJtv0N4KF8KW9xty8bKO2L61F8EyE5dlrt3GIAqxZPs/o6jJ41kwP2v
   An4tidmS/3H3ykjj5PQr51NU2iGni3XAJO264yp4i0sJiiXIUA6F7876z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="293947323"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="293947323"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 08:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="588645647"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 08:23:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B544AD; Tue, 30 Aug 2022 18:23:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_men_mcb: Remove duplicate UAPI:serial_core inclusion
Date:   Tue, 30 Aug 2022 18:23:13 +0300
Message-Id: <20220830152313.14650-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

The UAPI serial_core.h is guaranteed to be included by in-kernel
one (with the same name). Individual drivers do not need to include
it explicitly. Remove it from the driver.

Note, it's a single driver in the entire kernel that does this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 737c4c31e8a0..f46ca13ff4aa 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -7,7 +7,6 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
-#include <uapi/linux/serial_core.h>
 
 #define MEN_UART_ID_Z025 0x19
 #define MEN_UART_ID_Z057 0x39
-- 
2.35.1

