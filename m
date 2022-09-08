Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF445B1DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiIHMyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiIHMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:54:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531013DC1;
        Thu,  8 Sep 2022 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662641673; x=1694177673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4z8nV3faxJ7DE6XzcpT01ziGzPcP3sN5QVEmlDYT5uc=;
  b=KDGWUSjk/lQR1vJUsC0YqQyinobPWkyjcQ6/KAYcDMzSHXf6zRPGyVfA
   vqVKito/zl2HHe8Hg+rBa8Qj0tFsOa9AnHfDZVT7ko6oxxdI8j7gKnxrO
   SaVpoA5PwiDLE8D17fz20AefA93PYbjd6KPFQlkejJKoMjf5Bn7UZN+pM
   wQKcnsZsi5P6Q9S7sp5b4MI2DNgqbYlXYjvdlVGlzPQis/Asb270INLAK
   04EZlHIXXdbigQaMJ5zHoMjtUf1DH/iMqHYhK7LNBORSww+BikLJFrT+J
   cxcvVvrsnMYaSLL0BWDYtBTnmD8pvySVtig13FZt0OIjRcZWlrwCpYQ6+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294740338"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="294740338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 05:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740659831"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 05:54:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 41A98235; Thu,  8 Sep 2022 15:54:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Group cs_change and cs_off flags together in struct spi_transfer
Date:   Thu,  8 Sep 2022 15:54:44 +0300
Message-Id: <20220908125444.30727-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

The commit 5e0531f6b90a ("spi: Add capability to perform some transfer
with chipselect off") added a new flag but squezed it into a wrong
group of struct spi_transfer members (note that SPI_NBITS_* are macros
for easier interpretation of the tx_nbits and rx_nbits bitfields.

Group cs_change and cs_off flags together.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e111cf5e77de..bffcad4e7d6e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
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

