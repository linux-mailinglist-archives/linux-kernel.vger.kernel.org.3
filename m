Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33DD595B50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiHPMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiHPMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68EE01E;
        Tue, 16 Aug 2022 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651088; x=1692187088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/F4tMrll8nHV2susd2hq+bFV1Y77UKistuJ9wgFtd4=;
  b=GK8EXZH2jQhbzwp/siVI8lsinxg2K9olh8EVDwDbh+vpN6aUMPZcPw8g
   5gz2v18kIa7DK53UcxbSYynVq+YkrPk/zIQ1v+Lo7kc1MIAp+IM+TtPYQ
   Z3Tq+ijsI9/nKk3tz0LxYEnhqKOn/edM23nXHT78yLo0TJr5IB4PDry7z
   pZWj8HIhqMllUCfU0LJncjACxXITEVSsjIfbXA0zIjM/MpJXcJsbc65RF
   zeWENIwwLijZ1ld9vtWoeqlJk/6EQCxd55H+fO3EBO47URXV2VmyU84BJ
   rrD8KV2aHpOf44Xg7+BlTEPdpO9UF9z4AkD/xTO6/8L/o8PTKx8T++Xdt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356199340"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356199340"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080814"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/8] tty: Make tty_termios_copy_hw() old ktermios const
Date:   Tue, 16 Aug 2022 14:57:35 +0300
Message-Id: <20220816115739.10928-5-ilpo.jarvinen@linux.intel.com>
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

There should be no reason to adjust old ktermios which is going to get
discarded anyway.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_ioctl.c | 2 +-
 include/linux/tty.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 2a76b330e108..fc94988f0283 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -249,7 +249,7 @@ static void unset_locked_termios(struct tty_struct *tty, struct ktermios *old)
  *	in some cases where only minimal reconfiguration is supported
  */
 
-void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old)
+void tty_termios_copy_hw(struct ktermios *new, const struct ktermios *old)
 {
 	/* The bits a dumb device handles in software. Smart devices need
 	   to always provide a set_termios method */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cf5ab26de73d..ae41893f8653 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -458,7 +458,7 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 unsigned char tty_get_char_size(unsigned int cflag);
 unsigned char tty_get_frame_size(unsigned int cflag);
 
-void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
+void tty_termios_copy_hw(struct ktermios *new, const struct ktermios *old);
 int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
 int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
-- 
2.30.2

