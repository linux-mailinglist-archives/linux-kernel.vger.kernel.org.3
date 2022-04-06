Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82164F6DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiDFWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiDFWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:03:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96431BE0C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649282515; x=1680818515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJo9I0DB9H/abgW4dRNH0eSjf9gNlwzigGOQG/tFcEw=;
  b=M72yoEj2ssvPecqu4uyRDPCcEotOVmAvQHPOWIOxeY7XEsFAz3N8RTNU
   h3BKXhVG1sbuHaiJQuiVc18KuWPcktWM9LiWFzD2wxgJHUfQaIUICmkYN
   bjXJRsJpszp8FogkAQMhPxs/zB24PWfRmeg1/zslRx7Vp6sDT55dHyYvD
   1c2dmYDzHh2zQqasGGw/qpEVc73zKOWljF+EJmdCnYREgZceO4byq03H6
   oGIiwU+DrQhz0PPhX6qcJf8oPU9cpddadVayvRCBhJ/egLV7MJI1da+6E
   38epf2pAx5Bgf0eeFQgYygCvcG2aPUJ0Dew37ykjMg9f9eLmRoaxUOT/H
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="243299504"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="243299504"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:01:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="722689824"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:01:54 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] topology/sysfs: Hide PPIN on systems that do not support it.
Date:   Wed,  6 Apr 2022 15:01:50 -0700
Message-Id: <20220406220150.63855-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yfhbj7Q99dqRIYaL@zn.tnic>
References: <Yfhbj7Q99dqRIYaL@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems that do not support a Protected Processor Identification Number
currently report:

	# cat /sys/devices/system/cpu/cpu0/topology/ppin
	0x0

which is confusing/wrong.

Add a ".is_visible" function to suppress inclusion of the ppin file.

Fixes: ab28e944197f ("topology/sysfs: Add PPIN in sysfs under cpu topology")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/base/topology.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index e9d1efcda89b..706dbf8bf249 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -152,9 +152,21 @@ static struct attribute *default_attrs[] = {
 	NULL
 };
 
+static umode_t topology_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group topology_attr_group = {
 	.attrs = default_attrs,
 	.bin_attrs = bin_attrs,
+	.is_visible = topology_is_visible,
 	.name = "topology"
 };
 
-- 
2.35.1

