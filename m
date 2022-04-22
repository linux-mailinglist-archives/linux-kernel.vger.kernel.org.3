Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6650B499
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446388AbiDVKEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446372AbiDVKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDB53B4E;
        Fri, 22 Apr 2022 03:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E83F61E24;
        Fri, 22 Apr 2022 10:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7658AC385AB;
        Fri, 22 Apr 2022 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650621700;
        bh=cMsSW5/kTvhMw/MKLChTukDgmLgNss7KgrlFXjRpWug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jT+sLeV7aPn2i/iEb23mZ5FK122o8oWRYzwyyyAKYYM9tIVytcwEvCfs9w78woKys
         rNdXZ4whj9wUl50bcD6xWDTAKe6jU9otuM3ulTl/e/EYsvDJ92sD4AJvAoJHk/RkYZ
         ZCz3G/hTvDo+VKNNDD5714LMaF/Rpoq7KEHkf1SCj6bn1F/cIhPpIIeyS2gVF6/S5X
         4GJtGvaVUG1/4QmKUiGNVk4urfRqibhooH/9ZzTf2Yw2mKhaEgMoj7PmDFlMNO7p3y
         HfCdkWg6YnPIGYglfnrbpyWTFFKEzdY6X8V8XGvaAQeEaHaLxQkUNDU5twrWxRmHeR
         5fHGZtnuLWZIg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/2] rtla: Fix __set_sched_attr error message
Date:   Fri, 22 Apr 2022 12:01:32 +0200
Message-Id: <eeded730413e7feaa13f946924bcf2cbf7dd9561.1650617571.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <52161d343abeda6d039d2f0734904a1383a4c62e.1650617571.git.bristot@kernel.org>
References: <52161d343abeda6d039d2f0734904a1383a4c62e.1650617571.git.bristot@kernel.org>
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

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index baf9003d5d41..60dd48315315 100644
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
2.35.1

