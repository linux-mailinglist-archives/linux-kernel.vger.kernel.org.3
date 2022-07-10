Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B456D0BC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiGJSZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGJSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:25:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5E13D23;
        Sun, 10 Jul 2022 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657477527; x=1689013527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5y4vwrb2+7xCrIUmxJiHnlCdSDFJBBSO+45IgJpkgxw=;
  b=SnCcaYNosi8C9jmW+x3AgC6Z7bkeBtHscb504TDuBN518qPkDTMgq3MT
   UIM6p6wdeihWc/3JNllZJRE2RiIteKsHe1NEa3QmiI/vbt1hUqRlhG6a8
   Dt5DY/KCNaj5tTT55w3xyW0a2iKUnUEFV428TsbFe/cQMOwd41HOF+Ebh
   d8R8af7QbxVJ5K01NDG/54+0yvJyFukhce8NZkjm0kg/ju+N4GclYQX49
   roNL3sKSMgzMscp/TtWAiKmK0BBifeGVIKhVApAXVDMMBQ/vP82NCXFQU
   G6e4wNV2wMROPTGHiWEF+6dzxR3lglx0l/GqWDsCRzkEHappv5/eUNSQv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282081438"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="282081438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:25:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="736864833"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:25:26 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/2] platform/x86/intel/ifs: return error on load failure
Date:   Sun, 10 Jul 2022 11:25:21 -0700
Message-Id: <20220710182521.60642-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220710182521.60642-1-tony.luck@intel.com>
References: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
 <20220710182521.60642-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

A bug in ifs_load_firmware() error path will make it return
SUCCESS in the event of failure.

If ifs_image_sanity_check() fails, then "ret" is still zero (from
the earlier successful call to request_firmware_direct().

Reinitialize the return variable with appropriate error code.

Fixes: 684ec215706d4 ("platform/x86/intel/ifs: Authenticate and copy to secured memory")
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d056617ddc85..3edcc570f1fe 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -252,6 +252,7 @@ void ifs_load_firmware(struct device *dev)
 
 	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
 		dev_err(dev, "ifs header sanity check failed\n");
+		ret = -EINVAL;
 		goto release;
 	}
 
-- 
2.35.3

