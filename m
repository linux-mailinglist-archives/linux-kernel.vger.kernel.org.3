Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7656CB86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiGIVQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGIVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96012193FA;
        Sat,  9 Jul 2022 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657401409; x=1688937409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/0lEMWIV0iL01NyKqCruERgYiLsTG+vyknWoi7Sfd4=;
  b=QAdZycM+c6GkAiCHSWo2oqTkUvqar0WG9snOb8SLcRYy1ViwGwAbRJ56
   AyJgAkzPRbXxG3A3e7Q6LBR7iBEd3ahTGMEjn896kmhyncAAcI/xhkFoW
   vrPikEZ6EWCvVWD8OBDDe+01SJZB40vm4u4+Su+muMqe4A75+cm91Dht4
   Ko9W0kJbPrXeqWKk4vwk8bpKQLevPve6XCZqs4mMEVs7+eMAvs2yhYMvc
   hpa6di8ccn7pXXQ/elA065CitpGit6jcOZjfZ7Ogs6neTIfsE+/ATWnp0
   rzqlHEzKf2Fe7S3F56mSjw26cpun27f8xc2rGJBrtQyMiUEJdXDkFWr6K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264872817"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="264872817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="594463351"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2022 14:16:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D04E95AD; Sun, 10 Jul 2022 00:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/6] platform/x86: serial-multi-instantiate: Use while (i--) pattern to clean up
Date:   Sun, 10 Jul 2022 00:16:51 +0300
Message-Id: <20220709211653.18938-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
References: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more natural while (i--) patter to clean up allocated resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2: added tag (Hans)
 drivers/platform/x86/serial-multi-instantiate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 970ede0ff002..0a2335693f4f 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -70,11 +70,11 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
 
 static void smi_devs_unregister(struct smi *smi)
 {
-	while (smi->i2c_num > 0)
-		i2c_unregister_device(smi->i2c_devs[--smi->i2c_num]);
+	while (smi->i2c_num--)
+		i2c_unregister_device(smi->i2c_devs[smi->i2c_num]);
 
-	while (smi->spi_num > 0)
-		spi_unregister_device(smi->spi_devs[--smi->spi_num]);
+	while (smi->spi_num--)
+		spi_unregister_device(smi->spi_devs[smi->spi_num]);
 }
 
 /**
-- 
2.35.1

