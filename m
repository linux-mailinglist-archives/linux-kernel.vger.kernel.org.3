Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214DF4D1B60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiCHPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347624AbiCHPME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:12:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98E2A719
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646752265; x=1678288265;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5veMXvNyvnB9w0pGCmjunIY5mIxO0/L9cjr+s0Tn+KU=;
  b=GFHt5lhOywrkRL01TzYpU8nFNuoHD7GkGOC6BFlVcjcAH/9ms32y6LSe
   mfOdsBxT6owN8UDq/PSkS4xAuhjZ7ugbodit43XKZAvnaSyOLiAHjBrC7
   P05xDWWP9z5fh5dE3QARuQIq6JcUw/a6nrZDNHfpaciw+EEbwzuFRq6Oh
   CzWHGcNdwOORu+keRMZTict64v3FQdqAYCgccx+1mDl3RHSPAK9ALqVbi
   HElCnssQ5+MH5aZDV8ChAy47b5qLGZZ8ZE5f3uq9ex+Z6ReOMVQbVEGdh
   FtCXDSnzJmvR0pEWWonF01igCtsTiADeff+vto85asM+LTBwtPxoTLQai
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341135448"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="341135448"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="595908117"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2022 07:11:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93A163DE; Tue,  8 Mar 2022 17:11:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] auxdisplay: lcd2s: Switch to i2c ->probe_new()
Date:   Tue,  8 Mar 2022 17:11:18 +0200
Message-Id: <20220308151119.48412-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deprecated i2c ->probe() functionality doesn't work with
OF compatible strings, as it only checks for the i2c device id.
While it's not a problem right now, it would still bring a
better code. Switch to the new way of probing.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 5201a621de45..a4503765a95d 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -288,8 +288,7 @@ static const struct charlcd_ops lcd2s_ops = {
 	.redefine_char	= lcd2s_redefine_char,
 };
 
-static int lcd2s_i2c_probe(struct i2c_client *i2c,
-				const struct i2c_device_id *id)
+static int lcd2s_i2c_probe(struct i2c_client *i2c)
 {
 	struct charlcd *lcd;
 	struct lcd2s_data *lcd2s;
@@ -368,7 +367,7 @@ static struct i2c_driver lcd2s_i2c_driver = {
 		.name = "lcd2s",
 		.of_match_table = lcd2s_of_table,
 	},
-	.probe = lcd2s_i2c_probe,
+	.probe_new = lcd2s_i2c_probe,
 	.remove = lcd2s_i2c_remove,
 	.id_table = lcd2s_i2c_id,
 };
-- 
2.34.1

