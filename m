Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF558CF36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiHHUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiHHUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:33:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5D1ADA9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659990837; x=1691526837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xlZNRDzOg05HlsEGD1/D8QH0uUFUnQyLW1EOluncF6A=;
  b=enWEAMbkIwLK9gMl9acrmdexiZQ4YNmhpw5XEs+frswz5H0XLNR+fXZs
   imU8ww6OsELZB77X9dRZTPQI2ymVKe3Is3t2jTW+EjYoSyRIcNlL2slQV
   9JsJeGqmhKXYFuq1mrsz0aoZj02ziBlcHZF6CwL15b2Cz3NM/K2JexyB8
   EeFQ2UwvVRAR7F1SuXkjMdQZ2LqrNXPDfXVwE73dtMmUHkjYpaIrchlWb
   dEsHd86OmI+cjIfNZTONvohKMCbEkFBFUxG/ulbVAPTGYs6UA+FaZxK1W
   e/PfSRqw24fPkicISvYfYBc9VsOrGkJGmgao6aGzFDG7hORs+sTp/UWVE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288250820"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="288250820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="637451644"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2022 13:33:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E5C4F7; Mon,  8 Aug 2022 23:34:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 0/4] regmap: mmio: Extending to support IO ports
Date:   Mon,  8 Aug 2022 23:33:56 +0300
Message-Id: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently regmap MMIO doesn't support IO ports, while being inconsistent
in used IO accessors. Fix the latter and extend framework with the
former.

Changelog v2:
- dropped the first two patches (Mark)
- split the last patch to two (Mark)

Andy Shevchenko (4):
  regmap: mmio: Remove mmio_relaxed member from context
  regmap: mmio: Get rid of broken 64-bit IO
  regmap: mmio: Introduce IO accessors that can talk to IO port
  regmap: mmio: Fix MMIO accessors to avoid talking to IO port

 drivers/base/regmap/regmap-mmio.c | 140 +++++++++++++++++++-----------
 include/linux/regmap.h            |   3 +
 2 files changed, 91 insertions(+), 52 deletions(-)

-- 
2.35.1

