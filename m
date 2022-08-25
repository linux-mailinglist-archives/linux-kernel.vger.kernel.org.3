Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB895A0C05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiHYI62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHYI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:58:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B158A833C;
        Thu, 25 Aug 2022 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661417904; x=1692953904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GgNmDvPIIB3AnOaSd3/KVITSifmE3bgS+QSDcY0LkNQ=;
  b=Unk11ogobGZB856pL3UjrXN6erJzye4ZQr35p5scD2pPgfLqfuM0QaKX
   MeFzC0dowLqpXKjqsnyeDC89Kp/ty4kitAbCbf7otUg3VjOg+Kf0V/Rhg
   z5vT/jI+Ao7hIwRvGziHQ9K7wcVUbHSpt6T3R/PB66inBdhBoOQ0znLmj
   eEL0D/+07rEeYYZv3WqsY4jUsviU4SXALANWWOIJ7xlKR0joP0l5C2Zp7
   z3QiTUGg1BXwXQSHWOwrrCi8/97TRwpvP/tOi4EXVzpN2zHPRve+Izzrl
   U5DGx3b/9NfXo1sgDYpEc+Foa1o3Fq4lXx8snsXehxO2GuXpg8go7VCi4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273941373"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273941373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670893897"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/5] serial: Remove custom frame size calculation
Date:   Thu, 25 Aug 2022 11:58:05 +0300
Message-Id: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few drivers still calculate number of frame bits on their own. As core
can do that for them these days, take advantage of core's capabilities.

Ilpo Järvinen (5):
  serial: ucc_uart: Remove custom frame size calculation
  serial: cpm_uart: Remove custom frame size calculation
  serial: fsl_lpuart: Remove custom frame size calculation
  serial: sunsab: Remove frame size calculation dead-code
  serial: tegra: Remove custom frame size calculation

 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 28 ++++++---------------
 drivers/tty/serial/fsl_lpuart.c             | 10 +++-----
 drivers/tty/serial/serial-tegra.c           | 12 +++------
 drivers/tty/serial/sunsab.c                 | 20 ++++++---------
 drivers/tty/serial/ucc_uart.c               | 15 +----------
 5 files changed, 22 insertions(+), 63 deletions(-)

-- 
2.30.2

