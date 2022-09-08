Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99115B1E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiIHNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiIHNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E39D41BC;
        Thu,  8 Sep 2022 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662642542; x=1694178542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3EY9SgS3SUG4WY37IeZwy97NQANvho/Y6Owh/3ya5QU=;
  b=deAVT31NOWQGdArTBKikxfEWoMtQbP53b4mJrRkHxfoUxuLv4IMHyPA0
   PpoYd21S39FoKv/C2mJmI7lkemNv/uv4pN32RD7dxmgSK4J1TXfhWJbI9
   /13IMeHIa+/DieriiQ20T97teCrfNRkaRYrjyErN+Gar3oowdK2YpCLHd
   pD8hMvbVE1a0gWY26xk72n5aPnCksEb2hilKUKZn7fyw1IQe7YAgYQDJb
   wAcnqBXfFHcvlhANUVc2TJ6+/brebszbHkLtrT26psjTph/GG1WBUr5At
   wihErgSTQgIiSrEm1Co/Uyp2wmui3Fb1vbh3SPyel2wWgzEjFaEAMbEz1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358891613"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="358891613"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="790427318"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Sep 2022 06:05:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63BC0235; Thu,  8 Sep 2022 16:05:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] spi: Group cs_change and cs_off flags together in struct spi_transfer
Date:   Thu,  8 Sep 2022 16:05:18 +0300
Message-Id: <20220908130518.32186-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

The commit 5e0531f6b90a ("spi: Add capability to perform some transfer
with chipselect off") added a new flag but squeezed it into a wrong
group of struct spi_transfer members (note that SPI_NBITS_* are macros
for easier interpretation of the tx_nbits and rx_nbits bitfields).

Group cs_change and cs_off flags together and their doc strings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed some grammar issues, grouped doc strings as well
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e111cf5e77de..6ea889df0813 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -848,8 +848,8 @@ struct spi_res {
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @dummy_data: indicates transfer is dummy bytes transfer.
- * @cs_change: affects chipselect after this transfer completes
  * @cs_off: performs the transfer with chipselect off.
+ * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
  * @delay: delay to be introduced after this transfer before
@@ -959,10 +959,10 @@ struct spi_transfer {
 	struct sg_table rx_sg;
 
 	unsigned	dummy_data:1;
+	unsigned	cs_off:1;
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
-	unsigned	cs_off:1;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
-- 
2.35.1

