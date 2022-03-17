Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26104DCA33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiCQPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiCQPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D5320C2E0;
        Thu, 17 Mar 2022 08:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18706199B;
        Thu, 17 Mar 2022 15:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B72AC340EF;
        Thu, 17 Mar 2022 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531561;
        bh=No/nArYdGiPaiSflbYi9n3JC3ItYkbFrFm5VnVe0g94=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JsELj5TFdiNOmnNPOTxgdEbPy9oaD0+AIBoev2UJsob2PK2KYI8F1WZsWUMB8di6h
         FQJPMDikz+1nERbi/4wXfwarVcVikb0IiWwvzYC98oniIJkoNTyy6lMi7JCf1/iyDh
         EbXFx7DlbwsT2/rZ8ybgFXrTGtV3PgML5cbmpifynsOhvgkuO+wnCpMwgvVQCu3lbQ
         6I0xUYIHVnZ/Vm5K0+WhThCM2O6wP9Oi2DXsO2q5w2B87yYvi+zv6TXJj1wwVjiTCa
         JzURqYctGygrSDjAj+aNy9FLEn1oWsLxR9eIDAWN9qyqF3xNHqVTNDJ8n/2GgA6msF
         GMxjEC2MEL//Q==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 1/2] eventfd: Fix stable-rt v5.4.182-rt71 conflict fixup issue
Date:   Thu, 17 Mar 2022 10:39:16 -0500
Message-Id: <7ecbf796f7026cf007e9d03d251a9f04e89cd3e9.1647531549.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1647531549.git.zanussi@kernel.org>
References: <cover.1647531549.git.zanussi@kernel.org>
In-Reply-To: <cover.1647531549.git.zanussi@kernel.org>
References: <cover.1647531549.git.zanussi@kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.182-rt72-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This fixes an issue in stable-rt release v5.4.182-rt71 where a hunk
from the context diff was inadvertently included in a conflict fixup
where it shouldn't have been.  Remove those lines that don't belong.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/sched.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e1dfb01f4623..91f1aac3c86a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -802,14 +802,6 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
-#ifdef CONFIG_PSI
-	/* Stalled due to lack of memory */
-	unsigned			in_memstall:1;
-#endif
-#ifdef CONFIG_PAGE_OWNER
-	/* Used by page_owner=on to detect recursion in page tracking. */
-	unsigned			in_page_owner:1;
-#endif
 #ifdef CONFIG_EVENTFD
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
-- 
2.17.1

