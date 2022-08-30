Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42495A670F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiH3PNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiH3PNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13281286E3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45625615C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E1C433D6;
        Tue, 30 Aug 2022 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661872389;
        bh=Pgu0YF4oBMGHXYWgr2TFEwahMVgu94xHlgw22WwIyBU=;
        h=From:To:Cc:Subject:Date:From;
        b=fK9cBnGKjoVCbzqeVmKWBzw9/2/Tladl+REU5tEVU0MW5DMA2JK+EICuWAEaD3Ekg
         jOLXpOo3PRDVzImqYVz0IC6i5iGXps49kYZ+sSoTo9lzF0ySMEw6Ort7P4x+fk2TeP
         EXDJF1zCuBd6ZdEogQGN/ld1wXA34gYZTaaqC7H/klPGdivESDnFv6zcd8R8cRFCSG
         Jqe4FYD/xS3/r9s+1jM+ayvQVEj+jJH5Rx0PAqF/d/wVls4vorBfXzepWbs0s52tAP
         n4Xk+N96K8Ob/VnVgGAlbRG3ttWXFEdAUzD+8JV81vx2d92wBxemEnhckcFN3v4HBv
         3mFu13UZGu/PA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] powerpc/papr_scm: Ensure rc is always initialized in papr_scm_pmu_register()
Date:   Tue, 30 Aug 2022 08:12:56 -0700
Message-Id: <20220830151256.1473169-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  arch/powerpc/platforms/pseries/papr_scm.c:492:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
          if (!p->stat_buffer_len)
              ^~~~~~~~~~~~~~~~~~~
  arch/powerpc/platforms/pseries/papr_scm.c:523:64: note: uninitialized use occurs here
          dev_info(&p->pdev->dev, "nvdimm pmu didn't register rc=%d\n", rc);
                                                                        ^~
  include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
          dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
  include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                  _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                      ^~~~~~~~~~~
  arch/powerpc/platforms/pseries/papr_scm.c:492:2: note: remove the 'if' if its condition is always false
          if (!p->stat_buffer_len)
          ^~~~~~~~~~~~~~~~~~~~~~~~
  arch/powerpc/platforms/pseries/papr_scm.c:484:8: note: initialize the variable 'rc' to silence this warning
          int rc, nodeid;
                ^
                = 0
  1 warning generated.

The call to papr_scm_pmu_check_events() was eliminated but a return code
was not added to the if statement. Add the same return code from
papr_scm_pmu_check_events() for this condition so there is no more
warning.

Fixes: 9b1ac04698a4 ("powerpc/papr_scm: Fix nvdimm event mappings")
Link: https://github.com/ClangBuiltLinux/linux/issues/1701
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 54740af21557..2f8385523a13 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -489,8 +489,10 @@ static void papr_scm_pmu_register(struct papr_scm_priv *p)
 		goto pmu_err_print;
 	}
 
-	if (!p->stat_buffer_len)
+	if (!p->stat_buffer_len) {
+		rc = -ENOENT;
 		goto pmu_check_events_err;
+	}
 
 	nd_pmu->pmu.task_ctx_nr = perf_invalid_context;
 	nd_pmu->pmu.name = nvdimm_name(p->nvdimm);

base-commit: 91926d8b7e71aaf5f84f0cf208fc5a8b7a761050
-- 
2.37.2

