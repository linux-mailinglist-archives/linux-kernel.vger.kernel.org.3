Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB650B547
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiDVKi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446721AbiDVKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1943DFFE;
        Fri, 22 Apr 2022 03:35:12 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOFSd7rbHEQFd/HFnNhB9bHsxoqiRUzgDAeYs8Oe4o4=;
        b=0RTFvP0/kvxiZFMVn2E7Uj53VePk+/OJ3mRZ/1z4S7ZDPPFxSv0HNll4/BOAus986tQVRf
        w6w2TA6m3REctsS8eHm/z68BTOkTA1mBkETJYDAOSx/20mrisD//gGbQc6XRJDvwji122s
        EownN0mUwfwqGLIfeMW03ef7/n4lq83YuiMrKCfNO/o5H98fW0/aIEhK7Ju94tH3LEnmaH
        dmF8SuIGTOAafGP8+JtSvsLQx4iQPk1i+1EXpRSD7ecVK537lHbBPQzeHtNbwpkykI9ZQi
        f8+/Dirf7bn4A19WF5VCQ/KMlYi9C6nXtPwCH0exbCmb0d5BLIIFS3SBJiPpGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOFSd7rbHEQFd/HFnNhB9bHsxoqiRUzgDAeYs8Oe4o4=;
        b=s/1GUisZBSplbmENbEGu6Fj8tBbHEObpEGdlAKB2nxVOkAbs2qWDcrQh9sX4uHK9V6lvyk
        S1g2yEpdWCPPSTBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] libsubcmd: Fix OPTION_GROUP sorting
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e167ea3a11e2a9800eb062c1fd0f13e9cd05140c.1650300597.git.jpoimboe@redhat.com>
References: <e167ea3a11e2a9800eb062c1fd0f13e9cd05140c.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370967.4207.4014236875289539210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     aa3d60e050112ef1373d7216eabe0ee966615527
Gitweb:        https://git.kernel.org/tip/aa3d60e050112ef1373d7216eabe0ee966615527
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:21 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:01 +02:00

libsubcmd: Fix OPTION_GROUP sorting

The OPTION_GROUP option type is a way of grouping certain options
together in the printed usage text.  It happens to be completely broken,
thanks to the fact that the subcmd option sorting just sorts everything,
without regard for grouping.  Luckily, nobody uses this option anyway,
though that will change shortly.

Fix it by sorting each group individually.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/e167ea3a11e2a9800eb062c1fd0f13e9cd05140c.1650300597.git.jpoimboe@redhat.com
---
 tools/lib/subcmd/parse-options.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 39ebf61..9fa7594 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -806,9 +806,9 @@ static int option__cmp(const void *va, const void *vb)
 
 static struct option *options__order(const struct option *opts)
 {
-	int nr_opts = 0, len;
+	int nr_opts = 0, nr_group = 0, len;
 	const struct option *o = opts;
-	struct option *ordered;
+	struct option *opt, *ordered, *group;
 
 	for (o = opts; o->type != OPTION_END; o++)
 		++nr_opts;
@@ -819,7 +819,18 @@ static struct option *options__order(const struct option *opts)
 		goto out;
 	memcpy(ordered, opts, len);
 
-	qsort(ordered, nr_opts, sizeof(*o), option__cmp);
+	/* sort each option group individually */
+	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
+		if (opt->type == OPTION_GROUP) {
+			qsort(group, nr_group, sizeof(*opt), option__cmp);
+			group = opt + 1;
+			nr_group = 0;
+			continue;
+		}
+		nr_group++;
+	}
+	qsort(group, nr_group, sizeof(*opt), option__cmp);
+
 out:
 	return ordered;
 }
