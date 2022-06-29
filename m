Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A9560C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiF2Wvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF2Wvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:51:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FCD1C91B;
        Wed, 29 Jun 2022 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656543106; x=1688079106;
  h=from:to:cc:subject:date:message-id;
  bh=CFbJLfUlKxVvR7y4Sz/NOJSEIt8/+z+wY+N/tQFVsA0=;
  b=YMuOPyVFP3FMA42TEUqpOZD874Lg4QbXyRJBQLPR8MvjgRM79CO3Z69B
   vDHWbqyse+Bct06N7/+XhLEP5uLlYV4kvEYfyMTPm94+tSZ5nOLMeR7MF
   uVZ4yJ8ynOoeo56AVu/CXks+B1UM7Xz1yjYi5NyC7rbi0grkzYryInj7A
   FqRE8KrcmwcY4pNsbuWEllrxHGYnN0AkTiVuEA8goKitEzKyzY4NdSRVO
   uJEWZjsk9AvfYt0/mbWXPgidOV+rSO3CBa4Kr9d/R/DJDl9P/crTdnFLZ
   FKDue9aXFJWsm2COKxFKZE7nvOizRALU2jk67BNzp9hwf7IollZXPSF7s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343871870"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="343871870"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="917795898"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 15:51:45 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 0/1] Documentation/x86: Update the dynamic XSTATE doc
Date:   Wed, 29 Jun 2022 15:42:34 -0700
Message-Id: <20220629224235.20589-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A couple of changes from the last posting [1]:
* Trim the sentences in the AMX enabling example (Dave Hansen).
* Drop the description for the guest options as this change alone does not
  cover the practical (KVM) use case. Will follow up with a new series for
  this.

Sending this to the Intel reviewers again as one of their feedback was
just addressed.

=== Cover Letter ===

With the AMX support in the mainline, recently I heard some folks had a
hard time understanding the AMX enabling process. A code example is
expected to clarify the steps.

The arch_prctl(2) manual page [2] is missing these new options. Perhaps,
the man-page update follows up along with this.

These changes can be found in the repo:
  git://github.com/intel/amx-linux.git doc

And the compiled preview is available here:
  https://htmlpreview.github.io/?https://github.com/intel/amx-linux/doc-web/x86/xstate.html

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20220616212210.3182-1-chang.seok.bae@intel.com/
[2] arch_prctl(2): https://man7.org/linux/man-pages/man2/arch_prctl.2.html


Chang S. Bae (1):
  Documentation/x86: Add the AMX enabling example

 Documentation/x86/xstate.rst | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)


base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
-- 
2.17.1

