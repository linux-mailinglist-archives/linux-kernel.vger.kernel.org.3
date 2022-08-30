Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396D05A6471
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiH3NNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiH3NNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:13:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED08B6550;
        Tue, 30 Aug 2022 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661865232; x=1693401232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=61spzp3ubPSpqJ8pNumN5b5O60baoH8RlOzHceWW06M=;
  b=W7aPlCT7Ra5RBny8co4Z9UBlI7Q0ESyh2Gqf642suORAck+Zb2Bh+x4W
   uJRRvkcGlSJbFSIY5bAmCROiyZvjH04NUhlVgCvx3oO+h7/Ak2IZyCXVt
   qMDD3DE0+XFn/OAEVQIIPtD2B5Df9KxoL00+hP3N8P+na13R1QqKbVBRz
   cN7iCaS0po5aW1HPz0KYsD3XbOPyAA7fQ/lzHXdqrHsZ4gGVgcT6YiR2C
   Ru9LgmGOhfo6JVGJX9uDi4SVnzXezMBj5Tm6mvRpE2Wc0B6F1xdaAqXsK
   UR5JrslnmJ2jJkilxm1WaUOx7TsJtQmZ3BALgpW9OkWXPkxhGLONyn+fe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295171507"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="295171507"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:13:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="672860898"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:13:50 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/3] serial: Add uart_xmit_advance() + fixes part (of a larger patch series)
Date:   Tue, 30 Aug 2022 16:13:40 +0300
Message-Id: <20220830131343.25968-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uart_xmit_advance() helper to handle circular xmit buffer
advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
that previously lacked to accounting for DMA Tx.

Greg,
I've a another series on top this which is tty-next material making the
rest of the drivers to use uart_xmit_advance(). That series obviously
depends on the patch 1/3 of this series so if you end up putting these
3 patches into tty-linus, I'll need it to be merged into tty-next at
some point (I'm not in a big hurry with this so if you choose to delay
the merge, it's not a big deal).

v2:
- Correct tags

Ilpo Järvinen (3):
  serial: Create uart_xmit_advance()
  serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
  serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting

 drivers/tty/serial/serial-tegra.c |  5 ++---
 drivers/tty/serial/tegra-tcu.c    |  2 +-
 include/linux/serial_core.h       | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.30.2

