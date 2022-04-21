Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364750A598
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiDUQ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390684AbiDUQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:22:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4D63AE;
        Thu, 21 Apr 2022 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650558001; x=1682094001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3A6zp59+CXbCtLUTRaBcmCTCcB/VbVNvDqbxb0ss9Wc=;
  b=EXBZbzjA8WH51v04aZqdN5UKuxK4m6PYPdE/m8yHJW7GWvbnEH6ZRFkU
   hZlPoEfcy17KlEndu/BcvP/WbZnePNXk3W6OoPhu/w3JkCm0cBJ/yCe1z
   svLevC5OoKVT8gFSKa8xhBdWUpb+2zt1wXh2up365rxasgTGCqTXVCHj2
   zO3bwZ0R2MzSD+vH4MdBaHd61rBPX7DIG6m0+ZA4Nch0y/7Y6kgpwEFK4
   u4ycv0EO8qfJxNmOVj8pz+F1+GS2IrB+N+AuUCQ883HKL4af2A/9MDvvE
   jcgdDjvkVwP91fDqaBltrhks9zUqyY1suGWOUMCgNpKpmRsmiWiMTDCSk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263872592"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="263872592"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 09:20:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="648200010"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 09:20:00 -0700
Date:   Thu, 21 Apr 2022 09:19:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
References: <20220421152645.3a849198@canb.auug.org.au>
 <YmD+geU9CmjoVnN9@kroah.com>
 <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
 <YmF+FTxgu2U4/oPA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmF+FTxgu2U4/oPA@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/topology.c: In function 'topology_is_visible':
drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-variable]
  158 |         struct device *dev = kobj_to_dev(kobj);

This is because the topology_ppin(dev->id) macro expands to:

	(cpu_data(dev->id).ppin)

and with CONFIG_SMP=n the cpu_data() macro expands to boot_cpu_data
(ignoring its argument) with the end result:

	boot_cpu_data.ppin

Fix by just checking whether the boot_cpu has a PPIN instead of whether
this specific CPU has one.

Fixes: c3702a746ff5 ("topology/sysfs: Hide PPIN on systems that do not support it.")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
I don't believe it will ever be possible to have no PPIN on the boot CPU,
but somehow have PPINs on other CPUs (or vice versa)

 drivers/base/topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 706dbf8bf249..11a56a10188d 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -155,9 +155,7 @@ static struct attribute *default_attrs[] = {
 static umode_t topology_is_visible(struct kobject *kobj,
 				   struct attribute *attr, int unused)
 {
-	struct device *dev = kobj_to_dev(kobj);
-
-	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
+	if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
 		return 0;
 
 	return attr->mode;
-- 
2.35.1

