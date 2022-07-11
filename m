Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AE5708CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiGKRXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGKRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:23:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88815A467;
        Mon, 11 Jul 2022 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657560185; x=1689096185;
  h=from:to:cc:subject:date:message-id;
  bh=MBfyWaApA3oEnyU9PXhbhtT3dHmqFz/Pcy3bSsty3TY=;
  b=mKJ1gEsjLCQmBONOq82imcvic/sKx+VxVrgAgr+jCQN8s0AYdCzOp6Ia
   TZwPs14Bq8vpJvK6Tq50yI1QUrUms4J8S1OQFc7oOSW5oSdMItW3qxlXi
   cs+ZRt6Fqa/PSG6yVjDsp8NWg/a+s1f61sPeGusImUr7rZAI1REFYB6n8
   3Ti6F5lxfKxHJWPZtYpH0/WDAn/lEf9+jwvaC2EPb01VcttjmxH+JXA03
   tCZb+IbHzZChRf1q5ptRFquJOjiym5GcH3w+M/QFG60eMnbtzIEbaNOM6
   kbcxn9ckBh6IvcPH9LgSr76zo6s9e4HpbAzwN54wbE7RfrpmKJdTu/5hM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267760976"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="267760976"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921869730"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 10:23:05 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com
Cc:     bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 0/2] x86: AMX enabling example with new constants
Date:   Mon, 11 Jul 2022 10:13:45 -0700
Message-Id: <20220711171347.27309-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are the changes from the last version [1]:
* Add AMX feature numbers as ABI constants (Tony Luck).
* Revise sentences in the documentation (Bagas Sanjaya).
* Adjust the code example.

Thank you Tony and Bagas for the feedback.

=== Cover Letter ===

With the AMX support in the mainline, recently I heard some folks had a
hard time understanding the AMX enabling process. A code example is
expected to clarify the steps. Along with that, add a couple of ABI
constants useful for the feature enabling.

The arch_prctl(2) manual page [2] is missing these new options. Perhaps,
the man-page update follows up along with this.

These changes can be found in the repo:
  git://github.com/intel/amx-linux.git doc

And the compiled preview is available here:
  https://htmlpreview.github.io/?https://github.com/intel/amx-linux/doc-web/x86/xstate.html

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20220629224235.20589-1-chang.seok.bae@intel.com/
[2] arch_prctl(2): https://man7.org/linux/man-pages/man2/arch_prctl.2.html

Chang S. Bae (2):
  x86/arch_prctl: Add AMX feature numbers as ABI constants
  Documentation/x86: Add the AMX enabling example

 Documentation/x86/xstate.rst      | 55 +++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |  3 ++
 2 files changed, 58 insertions(+)


base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.17.1

