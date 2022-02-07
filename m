Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE24ABEF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbiBGNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445378AbiBGMmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:42:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40597E0321DD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644237211; x=1675773211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x6kFVrzT05XFotdvtiT0qifyAXqqSEHdTPezDSU7rR8=;
  b=IA3ugXAmGTNY+s33704DvbybAOE4u7SFDXBSSy6J4RbFtRdGukYN5Zhi
   dc5JVkLKVPw+qblq6ac8h4qkBe/m7sooZFPKvSgRLJFZVDKJ09DE2kY/c
   ht5P5HAhs5lWeA7JYT/VmxXbqgXfopqary0wkevQiNcbXWL0mG20pddl4
   lAhxeQIs6BMeD64skdRuEEF/Rj97JROIVZ3DBhyXZCJHIVyQCmjaoNwXA
   RIr8vR3Q9ShumJ9khH0+ZJB/wBA2Y8FtgInZvi6iUsYlDslBpRUA461Ti
   rFLcmwJhZHkLnjhItMH+FowAOvj90T6WCzcTe2cMBcLZFDjRJfX+t6Fe6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="247538984"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="247538984"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="484406335"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2022 04:33:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 57F393ED; Mon,  7 Feb 2022 14:33:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>
Subject: [PATCH v2 1/1] bitfield: Add explicit inclusions to the example
Date:   Mon,  7 Feb 2022 14:33:41 +0200
Message-Id: <20220207123341.47533-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not obvious that bitfield.h doesn't guarantee the bits.h
inclusion and the example in the former is confusing. Some
developers think that it's okay to just include bitfield.h to
get it working. Change example to explicitly include necessary
headers in order to avoid confusion.

Fixes: 3e9b3112ec74 ("add basic register-field manipulation macros")
Depends-on: 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
Reported-by: Jan Dąbroś <jsd@semihalf.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used full paths
 include/linux/bitfield.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 6093fa6db260..c9be1657f03d 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -19,6 +19,9 @@
  *
  * Example:
  *
+ *  #include <linux/bitfield.h>
+ *  #include <linux/bits.h>
+ *
  *  #define REG_FIELD_A  GENMASK(6, 0)
  *  #define REG_FIELD_B  BIT(7)
  *  #define REG_FIELD_C  GENMASK(15, 8)
-- 
2.34.1

