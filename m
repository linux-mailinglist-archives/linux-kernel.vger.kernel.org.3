Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789BD5A9AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiIAOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiIAOjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:39:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8411B50;
        Thu,  1 Sep 2022 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662043184; x=1693579184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=neOt7Y5kaJ06TGwl5lHvIazrPvdcugvQz5cQxNTdQG4=;
  b=ccGlxTo2SmjdG+ZNZkMPz+68s5Nm4DIJO+Piwke0/SH3GpeIzBFHVzA4
   a1arsXXNxPtsIFcbOHF8p7XRX5AcXToXUpZrRiLVw5aCh2rsvyI4T4UJM
   rbEkmd/bz+yK9bZYqMazHz39EIejKuqIDjhbz1kNptGm4Zqu9fDxSyVCN
   76FOc9iomQlvWmjdBtsZJn/rIt43a3K0biPBxT7PZDYOGlyjH0tOCq5wd
   521zofBtY0XavsWbrIJCqDxZOWfkX6Tz8a97DVPxIZnf7Be3r6JNlVPYS
   SkCQ9fpl2KbiU8Uc56Nzq4uDmp5Rt1IeGoX34CY5MdaK5ukooDHmsKpVT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321880086"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="321880086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:39:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="642356626"
Received: from rmalliu-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:39:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 RESEND 0/3] serial: Add uart_xmit_advance() + fixes part (of a larger patch series)
Date:   Thu,  1 Sep 2022 17:39:31 +0300
Message-Id: <20220901143934.8850-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uart_xmit_advance() helper to handle circular xmit buffer
advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
that previously lacked to accounting for DMA Tx.

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

