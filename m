Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475DB4A7689
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbiBBRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:10:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:35115 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346148AbiBBRK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643821829; x=1675357829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=49QmYpkXxYwC/wM0Undhl+3Xb+Ekaei4zYA6CCNkne4=;
  b=HChCN+KBu1waT41Uq3jwEvRGmmUogfqHa0qVsxBvwT3pjviLp8GeLepK
   pU4pOSgUry3KCwxz7GOQkicrFM37moj32MtJKXDSK23yM7eVkU8ALdVNW
   XWh8rJAUBmRnTDToxxXmoCjX6hMSBAXX5ycaccjwiG+Hkrrq9jkotFSpE
   NXKgWV/yMTgbQvDOGZ71A6QwOObhtOPLtIs3g/fNtgEhpNY4gZXIfpa4l
   4kxS5P/LjS+WvSPoG1K7dny45ZdaYm/p/MTqYKEX2rjQIpx7bpUP7gLxK
   MbWYiqwKjQvXNFE/zk/nKG6PMy5DaTtJCEIyOhA0KNjoX3LWcemzv3xOv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308700810"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308700810"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="769339037"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2022 08:56:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F109F3B7; Wed,  2 Feb 2022 18:56:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] amiserial: Drop duplicate NULL check in shutdown()
Date:   Wed,  2 Feb 2022 18:56:55 +0200
Message-Id: <20220202165655.5647-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_page(addr), which becomes free_pages(addr, 0) checks addr
against 0. No need to repeat this check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/amiserial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 1e60dbef676c..533d02b38e02 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -538,10 +538,8 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 	 */
 	free_irq(IRQ_AMIGA_VERTB, info);
 
-	if (info->xmit.buf) {
-		free_page((unsigned long) info->xmit.buf);
-		info->xmit.buf = NULL;
-	}
+	free_page((unsigned long)info->xmit.buf);
+	info->xmit.buf = NULL;
 
 	info->IER = 0;
 	amiga_custom.intena = IF_RBF | IF_TBE;
-- 
2.34.1

