Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3185150E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379218AbiD2Qci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379216AbiD2Qb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9776BDAA3E;
        Fri, 29 Apr 2022 09:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ED3DB836A1;
        Fri, 29 Apr 2022 16:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15EDC385A4;
        Fri, 29 Apr 2022 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651249706;
        bh=lAIRKSuq0bM0AuqbQaLq94Uoac+j3FgUzcXpkiyoZBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4FxWR5MINP4k3ApgAv3PidBTU7pja68e4htNByhDpZ+MJnS+FeHDTcodm+zx+4Tc
         DDbU/NXQcXBeN8L38hMqvM4Dtux92N07RHDB98dxnPyGD3TZkppijHxWe+5Fp0Z6sn
         s5bWi0bSmZDB7CNxRcTNNANLqFBZt2xT9FYGIsLKx2zDCNAG4ev/4go25DckUtN2MP
         PZ/upfQedj9cCZp1BFJ2JYEkE7zZ2XM0P551aoCtbWJIt+OC+8Z5HbisultW8+Yo0X
         cO6LLYFThj4iZrk2hQoNzw9Jh7+27R2HHIMk3M3HCcDX/fnfvqvnQaou8M52c4ibS2
         QhncBRklI7aZQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH 4/4] rtla: Fix __set_sched_attr error message
Date:   Fri, 29 Apr 2022 18:28:13 +0200
Message-Id: <a2d19b2c53f6512aefd1ee7f8c1bd19d4fc8b99d.1651247710.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651247710.git.bristot@kernel.org>
References: <cover.1651247710.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtla's function __set_sched_attr() was borrowed from stalld, but I
forgot to update the error message to something meaningful for rtla.

 Update the error message from:
        boost_with_deadline failed to boost pid PID: STRERROR
 to a proper one:
        Failed to set sched attributes to the pid PID: STRERROR

Link: https://lore.kernel.org/r/eeded730413e7feaa13f946924bcf2cbf7dd9561.1650617571.git.bristot@kernel.org/

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index da2b590edaed..3bd6f64780cf 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -255,7 +255,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
 
 	retval = sched_setattr(pid, attr, flags);
 	if (retval < 0) {
-		err_msg("boost_with_deadline failed to boost pid %d: %s\n",
+		err_msg("Failed to set sched attributes to the pid %d: %s\n",
 			pid, strerror(errno));
 		return 1;
 	}
-- 
2.32.0

