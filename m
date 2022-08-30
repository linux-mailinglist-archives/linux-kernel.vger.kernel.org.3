Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1D5A5E89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiH3Itn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiH3Itf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:49:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D30C3F73;
        Tue, 30 Aug 2022 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661849374; x=1693385374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cQZr5SwMlT5ni0FtBYvJfC7PVmKcmVjiiGes1MYFgSQ=;
  b=nrVDWsm8PVC+uTiabuwEsa8J6CagmASPlbRXFMilLDKAMtzKnxc4EfN6
   rYJrlDFdOnKA6BVc7YyCxuamXOnk7sYar/Wn4Zld5xlT0Y46quDqXdZSb
   EiFwgxFf/7W9iwj9R70NOyzhS9ZchdVh43Zp26CIWk17RGOVYDNkEaP03
   fjZxooLMPP0MTTtz+4wU43g6spvn7/I33Y/Q5dJqnaDTD7Z4AR8RLxxYP
   78VGQ/KPqZK1vsxhlvQeLyg+j7CY8flMelbTq4vXoFefXM1sj8IQ9B3gw
   vCH9vm5O7VlmDOE975f+cwooMyuJchihRps8Jbzy9IKiz7Qa1LyStQ/Wg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275522882"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="275522882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672761793"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/5] serial: Remove custom frame size calculation
Date:   Tue, 30 Aug 2022 11:49:20 +0300
Message-Id: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
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

A few drivers still calculate number of frame bits on their own. As core
can do that for them these days, take advantage of core's capabilities.

v2:
- Address coding style comments (from Andy)

Ilpo Järvinen (5):
  serial: ucc_uart: Remove custom frame size calculation
  serial: cpm_uart: Remove custom frame size calculation
  serial: fsl_lpuart: Remove custom frame size calculation
  serial: sunsab: Remove frame size calculation dead-code
  serial: tegra: Remove custom frame size calculation

 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 31 +++++++--------------
 drivers/tty/serial/fsl_lpuart.c             |  9 ++----
 drivers/tty/serial/serial-tegra.c           | 12 ++------
 drivers/tty/serial/sunsab.c                 | 20 ++++++-------
 drivers/tty/serial/ucc_uart.c               | 15 +---------
 5 files changed, 24 insertions(+), 63 deletions(-)

-- 
2.30.2

