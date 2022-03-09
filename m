Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8724D31BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiCIP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiCIP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:28:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C386556;
        Wed,  9 Mar 2022 07:27:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89855B81FE7;
        Wed,  9 Mar 2022 15:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44264C340F5;
        Wed,  9 Mar 2022 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646839673;
        bh=4LvHReCCc6esFGe4Kza+mSF7SzFddRcJJjyCrXFtHJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=epSwLNLwtyJjLol22SkzlR943GKnHKRR6V3Em2kvJv3nFt8mimUPtlTBb7cUYxGAK
         kJsK6m4L3+LLV2eW7ZO5k0UrM1tW5cOaRl6auQ05Pjw9IZCYasW3ToR56zm6LS02xU
         zfOe6ewYF1TvnZwYthj15ZEVVoher1BxmGwNQQq43s0PT7Ph0HOocuLDl79PjhM8j6
         Z2Ry/yG8ExXuB0DzmE4BeBCay0HzQuEltsmdZ63AujlGGXUQ8fQD04a7iislsJ745+
         rMHinIJKL93J8YGWnLPqQTgPtqpjzucpI9Gf/0BiO0XA/A3E0TQQ61wUDVSXbsStbx
         vpNfymm4VCzjw==
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
Cc:     Xie Yongji <xieyongji@bytedance.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH RT 2/3] aio: Fix incorrect usage of eventfd_signal_allowed()
Date:   Wed,  9 Mar 2022 09:27:47 -0600
Message-Id: <5372f24b2001f02ce836cf7a1ec34e2990abc99f.1646839649.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1646839649.git.zanussi@kernel.org>
References: <cover.1646839649.git.zanussi@kernel.org>
In-Reply-To: <cover.1646839649.git.zanussi@kernel.org>
References: <cover.1646839649.git.zanussi@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Yongji <xieyongji@bytedance.com>

v5.4.182-rt71-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commmit 4b3749865374899e115aa8c48681709b086fe6d3 ]

We should defer eventfd_signal() to the workqueue when
eventfd_signal_allowed() return false rather than return
true.

Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Link: https://lore.kernel.org/r/20210913111928.98-1-xieyongji@bytedance.com
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index db21ca695781..0bb9abf39065 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1767,7 +1767,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
+		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
-- 
2.17.1

