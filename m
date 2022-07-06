Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE6567D52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiGFE02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGFE0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:26:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C011B7BF;
        Tue,  5 Jul 2022 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657081582; x=1688617582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lU8TYXAHLldW1ztoF7cJu4ArDgCj/irihWhQS5ZPdQ4=;
  b=QZJ3HwsXXqLy0cy2J7UHFOhmlCWDgo0nXlfVhdUb5hg0a349LKQMAAfd
   5NzJhy+nV9vNT3uJ3diZKKIwQSa4Gn7ettog6+ezrYkD2MgM08+Lq3mm8
   Xhfxg4wZZAz3qyxgeixbpuxUnNoHfD9R4FNRnJOV7HKEPsK3wdUl98qUd
   T0ApYDlfPRyE+pAdvzJQ3fnEL3nzb1tbWybp3PJeV6jok9KqWD8kwA21p
   3RXsUG7XwOV7zfWGT0WEqHu5ifulz+PWH075js/TxM8Kugaq826IbzxGj
   rtiDzpHqnhU+IhnMYM1au1vGVzaW1RxVQg+bhRYcn0PyRF4OltdivUruN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283663243"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="283663243"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="769895423"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2022 21:26:18 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
Date:   Wed,  6 Jul 2022 12:20:36 +0800
Message-Id: <20220706042039.5763-2-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220706042039.5763-1-nandhini.srikandan@intel.com>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interface")
Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index d5ee5130601e..79d853f6d192 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -23,7 +23,7 @@
 	((_dws)->ip == DW_ ## _ip ## _ID)
 
 #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
-	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
+	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ## _ver)
 
 #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
 
-- 
2.17.1

