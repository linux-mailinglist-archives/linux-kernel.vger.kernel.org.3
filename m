Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022EB4ABE54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391628AbiBGMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381291AbiBGLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:39:59 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7658C03C191
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644233923; x=1675769923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RYlSCwq69RZXQwKdVlT1T4csr1Jgf18eqzB9RNwrG80=;
  b=F59QWWr75/lIH6EMr0wMRkqcfMfX3L0+DjzjBhObcS6NXERMFaxvihlr
   NFsI8LFjvIKeKHqogdAf4cyMc3sT0YDwvNfoKrY1W3uN7J5eqidrCiMQB
   mrkpKk+UzNn8Tkuvq6m2/dZKawgKJ+TCcPFTgZFfVGA2Cd+QJRna2doU2
   61xFb+8I/2SKuM5CP4zfDOMLI/Y+Jo/ZW9/Nw5VgtqiA0eSWkWw3r0Vva
   c8vnLSEU73rLr0v014tbFij+BoFFZW7xcgYCjhSwUu27FWleGNcAv3Hjp
   rhIUXoOTjj7fZ8odTBdWoRvOZofJ82UiSqOT4f6Knoy2QXUuf42XeAzAg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="309441146"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="309441146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="677731904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 03:38:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5636E3ED; Mon,  7 Feb 2022 13:38:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>
Subject: [PATCH v1 1/1] bitfield: Add explicit inclusions to the example
Date:   Mon,  7 Feb 2022 13:38:51 +0200
Message-Id: <20220207113851.88149-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/bitfield.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 6093fa6db260..ee433c60ee1b 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -19,6 +19,9 @@
  *
  * Example:
  *
+ *  #include <bitfield.h>
+ *  #include <bits.h>
+ *
  *  #define REG_FIELD_A  GENMASK(6, 0)
  *  #define REG_FIELD_B  BIT(7)
  *  #define REG_FIELD_C  GENMASK(15, 8)
-- 
2.34.1

