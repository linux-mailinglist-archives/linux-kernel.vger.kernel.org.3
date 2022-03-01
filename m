Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78CB4C821C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiCAETQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiCAETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:19:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6AACEB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wvaf2rS4XOIPWWBrYZGKk5K6I6KgN+6dn1ljHlk2zPs=; b=SVQP0McGFuu5OufwsHA4flHsxD
        0kXXn8LxZXj2d23U0sUGGTCIw+hfPbFi69d56eYCqYWXYSfBWrvimU/Y4TpsU8p6KF6YNYFS2bDLS
        M8kdZBlZ0dLmUFi2U0pglwn3tx7klxSygvVfb1hKQSHXzx33n4PIrDgtDHe82jM9+TrXM3BthJgMe
        HXS4YR4ztraAKWoGeXhX2RwKWqVjqgMb9H7gWacp5G5B7XdkCvFiN5APnvnz6CS7rLkGQ7FBso73U
        kXvnIJ13uCimrYomvS5GdzD3kmQ9jKmefT5tgjhLDaOf3AmwY2XXCP+ItVAkIxg1ktCen3BydUwRw
        +FhknsDA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOty2-00Eqwn-5p; Tue, 01 Mar 2022 04:18:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: dd: fix return value of __setup handler
Date:   Mon, 28 Feb 2022 20:18:29 -0800
Message-Id: <20220301041829.15137-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "driver_async_probe=nulltty" is used on the kernel boot command line,
it causes an Unknown parameter message and the string is added to init's
environment strings, polluting them.

  Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc6
  driver_async_probe=nulltty", will be passed to user space.

 Run /sbin/init as init process
   with arguments:
     /sbin/init
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc6
     driver_async_probe=nulltty

Change the return value of the __setup function to 1 to indicate
that the __setup option has been handled.

Fixes: 1ea61b68d0f8 ("async: Add cmdline option to specify drivers to be async probed")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Feng Tang <feng.tang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/dd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220228.orig/drivers/base/dd.c
+++ linux-next-20220228/drivers/base/dd.c
@@ -810,7 +810,7 @@ static int __init save_async_options(cha
 		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");
 
 	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
-	return 0;
+	return 1;
 }
 __setup("driver_async_probe=", save_async_options);
 
