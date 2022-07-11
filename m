Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE65708CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiGKRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiGKRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:23:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F3B5508E;
        Mon, 11 Jul 2022 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657560186; x=1689096186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2rufqAJIACVuFQz6JSoLzapJ7A7N9b8Dx9NSiS5xTSo=;
  b=cu7AIPf+ThNK9fzH9jVQ1CgIX36WFquSxoo0waCDNSsIGrhYlneG3DDF
   St0jEjBCco/BgXIRokgwKiXhYAH8hhzJSCYu1utVwOSCKoheZ9jfmwYR1
   ebG8FB9k4hgKzkQXfG2q1E0fYnSie8bBodEl8JMYQrrIb5TXpOuWxflIq
   mSCv+TDgNKm9pR9RTi414xhVy9JnLxWLFYlpbTzsF0A+9EkX+QiINR5U+
   GooAcbm7IGwzzC7ZNv9mLtDke5U0FSnUyUb+vZqKKxzXqtUapFjqVrdZ5
   uDMotaQ1H+8gPsxgZ6KBQCXOmVBSZ//7zU8DkFbFAXHLgsjdRPUkfki+r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267760981"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="267760981"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921869735"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 10:23:06 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com
Cc:     bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 1/2] x86/arch_prctl: Add AMX feature numbers as ABI constants
Date:   Mon, 11 Jul 2022 10:13:46 -0700
Message-Id: <20220711171347.27309-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711171347.27309-1-chang.seok.bae@intel.com>
References: <20220711171347.27309-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMX state is dynamically enabled by the architecture-specific prctl().
Expose the XSTATE numbers as ABI constants. It will help applications as no
more spec look-up is needed for these numbers.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Add as a new patch (Tony Luck).
---
 arch/x86/include/uapi/asm/prctl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..f298c778f856 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_XCOMP_TILECFG		17
+#define ARCH_XCOMP_TILEDATA		18
+
 #define ARCH_MAP_VDSO_X32		0x2001
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
-- 
2.17.1

