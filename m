Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD31595B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiHPMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiHPMHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1C4D62;
        Tue, 16 Aug 2022 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651092; x=1692187092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jViNROObNO3h6Uyd+viPlFHM6zP9PKpgfEeghIlk4cw=;
  b=F/B58Oud4Dt7w9NvXdipCymfhxan2EoWMKT34l041LL1XZWLWVNVo+Ut
   ZMSlTCEXC9xYrWkBgNFNucRshMQGYNgbKFZdb7dkw4QGqTBlgQgTyGUqG
   Y/3h4JAQLig1uVQXad6IkKNGf7o2iHXnFLXwAt9Lb48UOGyS1LxSk6BkE
   41/3iHdPt5SXeEoP7fpVp5cFsGXnXwlSLWYGtZozQQrLzeiOav0rh52rM
   e4gbFk8DrGSSgaZMnCWS5FwefchtgFhmcY28VKcxzG79aE9J7h3k/npw8
   CAOpDSi58206mkLOPzOmGXxmUWMyM8IWtVUGVji9ZwmWoWXL/Vth0HYu1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356199344"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356199344"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080819"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/8] tty: Make ldisc ->set_termios() old ktermios const
Date:   Tue, 16 Aug 2022 14:57:36 +0300
Message-Id: <20220816115739.10928-6-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/n_tty.c       | 2 +-
 include/linux/tty_ldisc.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3afdd9033a9c..597019690ae6 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1758,7 +1758,7 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
  *
  * Locking: Caller holds @tty->termios_rwsem
  */
-static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
+static void n_tty_set_termios(struct tty_struct *tty, const struct ktermios *old)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index ede6f2157f32..dcb61ec11424 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -130,7 +130,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	a pointer to wordsize-sensitive structure belongs here, but most of
  *	ldiscs will happily leave it %NULL.
  *
- * @set_termios: [TTY] ``void ()(struct tty_struct *tty, struct ktermios *old)``
+ * @set_termios: [TTY] ``void ()(struct tty_struct *tty, const struct ktermios *old)``
  *
  *	This function notifies the line discpline that a change has been made
  *	to the termios structure.
@@ -227,7 +227,7 @@ struct tty_ldisc_ops {
 			unsigned long arg);
 	int	(*compat_ioctl)(struct tty_struct *tty, unsigned int cmd,
 			unsigned long arg);
-	void	(*set_termios)(struct tty_struct *tty, struct ktermios *old);
+	void	(*set_termios)(struct tty_struct *tty, const struct ktermios *old);
 	__poll_t (*poll)(struct tty_struct *tty, struct file *file,
 			     struct poll_table_struct *wait);
 	void	(*hangup)(struct tty_struct *tty);
-- 
2.30.2

