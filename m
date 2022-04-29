Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAF514364
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355235AbiD2HrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351092AbiD2Hq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:46:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DFA66DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:43:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 041A821872;
        Fri, 29 Apr 2022 07:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651218220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cE02aE0M+NaUBzKQB+RLthaTB5Wl8xw0uBDzpADoSXw=;
        b=WJLmdyGX/0LbsFaPU6E6QtMrie4b9uRTjXaKGXITC20t16kfiMw0BEc6D39O3tqSjR87E+
        EMUqYeJiWQUmex28m4pVz/M0gSFbyGfxamwqgAZSQumZiNmtvnXWXnmoMpFM+yOJmoTgrq
        i4RI7qAc/ndrWnbCyIgT79H6rKDIM2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651218220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cE02aE0M+NaUBzKQB+RLthaTB5Wl8xw0uBDzpADoSXw=;
        b=CGQ7iQP4IJuGCrpaa/70FlQOSKWld0v5Dca+FO+1EOoG+lhS+bn4hWpqB1j7mBm3yrvZcG
        fYMz9CY4VUACvMDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 973E32C142;
        Fri, 29 Apr 2022 07:43:39 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     nvdimm@lists.linux.dev
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] testing: nvdimm: asm/mce.h is not needed in nfit.c
Date:   Fri, 29 Apr 2022 09:43:34 +0200
Message-Id: <20220429074334.21771-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/mce.h is not available on arm, and it is not needed to build nfit.c.
Remove the include.

It was likely needed for COPY_MC_TEST

Fixes: 3adb776384f2 ("x86, libnvdimm/test: Remove COPY_MC_TEST")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/testing/nvdimm/test/nfit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 0bc91ffee257..b4743ba65b96 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -23,8 +23,6 @@
 #include "nfit_test.h"
 #include "../watermark.h"
 
-#include <asm/mce.h>
-
 /*
  * Generate an NFIT table to describe the following topology:
  *
-- 
2.34.1

