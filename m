Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB150A495
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390274AbiDUPs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390262AbiDUPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:48:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F92BE3D;
        Thu, 21 Apr 2022 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555936; x=1682091936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FzYWfiReT6mX/53xH+cwrZM/uep1Ta2xXeOKpV1XB4M=;
  b=gqjW6V2h2P2GO3HLHeYLH5gTbx78w7M98EhYwFr8vIswH1mbckwnlS2x
   YHkQarBlj1GG0LQ0f8AKu5eX57dPVptboTdO7hDqw5uOyR1Z4TdDn1+rX
   mm9upHIukrwBHKaHpfvG19BSsa7g5jHSwb53V+EBCKmm9e25siYyzGgB9
   7+KqgO4v8y7ISm8s1b082z7VELTXMOnKBU4ai/gnK8pK8kOiUY8Z6JLHn
   sGjZg4KuGQ6SXa0v3GhF1jmRu3LR4dQW2U+FfkkTWWBJbccWfyE83p49Z
   vwg6KB3/xqFAaQzNiJuPOxEzgZxGn4RXQEWYUDiAjUsHhmTEPsnsjCcDo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327300594"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="327300594"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:45:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="626569670"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:45:35 -0700
Date:   Thu, 21 Apr 2022 08:45:34 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
References: <20220421152645.3a849198@canb.auug.org.au>
 <YmD+geU9CmjoVnN9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmD+geU9CmjoVnN9@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

My CPP-fu wasn't up to a modification to topology_ppin(), so I added a
(probably redundant) check for "dev" being a NULL pointer.

Fixes: c3702a746ff5 ("topology/sysfs: Hide PPIN on systems that do not support it.")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Better fixes with clever CPP macro tricks gratefully welcomed
---
 drivers/base/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 706dbf8bf249..31fae51fd340 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -157,7 +157,7 @@ static umode_t topology_is_visible(struct kobject *kobj,
 {
 	struct device *dev = kobj_to_dev(kobj);
 
-	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
+	if (!dev || (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id)))
 		return 0;
 
 	return attr->mode;
-- 
2.35.1

