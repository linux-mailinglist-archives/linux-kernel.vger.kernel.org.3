Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237C586842
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiHALhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiHALh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:37:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FA192A1;
        Mon,  1 Aug 2022 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659353847; x=1690889847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vDhxCvHhJut5tXZH1xKoNcrFRZwt2G18ehQhWJ00bP0=;
  b=PsTC+YvmIhPT+HIu3xWx6qygQkS+JIDSVuXdKPKCC2Abq3mnCUUlmUPM
   Cx3z6MqPZMZ23MULhXk4iNYlv8MJ0PEfNsyuJp2QRJtbVotuTXjbdprEM
   2IbS2lFiOIMZzrchagtlKLYlK/0IoqzS4DO5Q6ngx1yPLratkDE6NV1vO
   7PG9vjus/ksNNiGYiktzFjWflRkUAYR1Eb7SbXVr/tvJu0zpQ2fAmciXd
   FcBQVfSWsR17SPgwv07K/h6hOBE8XjiA6L9BhVGbSKM6cUmQoYeD1duYT
   K5edIJwLe9X286gjUxQOFtjB7CgxoLeceQr38XAESBcaHJkicd/K5TK9O
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375426853"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375426853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="728412082"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2022 04:37:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE6EE86; Mon,  1 Aug 2022 14:37:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
Subject: [PATCH v2 2/4] platform/x86: pmc_atom: Improve quirk message to be less cryptic
Date:   Mon,  1 Aug 2022 14:37:32 +0300
Message-Id: <20220801113734.36131-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801113734.36131-1-andriy.shevchenko@linux.intel.com>
References: <20220801113734.36131-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not everyone can get what "critclks" means in the message, improve
it to make less cryptic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/platform/x86/pmc_atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index c220172fefbb..4c3d6b48d2f0 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -354,7 +354,7 @@ static bool pmc_clk_is_critical = true;
 
 static int dmi_callback(const struct dmi_system_id *d)
 {
-	pr_info("%s critclks quirk enabled\n", d->ident);
+	pr_info("%s: PMC critical clocks quirk enabled\n", d->ident);
 
 	return 1;
 }
-- 
2.35.1

