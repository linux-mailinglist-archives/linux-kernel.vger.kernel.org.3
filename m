Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326694D0B61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbiCGWst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbiCGWsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:48:45 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1476B42;
        Mon,  7 Mar 2022 14:47:49 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id c4so14684591qtx.1;
        Mon, 07 Mar 2022 14:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfbQY75DtTiNHuh2TC9ZTQRFpySh806yNkufz0AzBpc=;
        b=qwAUh7Tnoqvy/GbxN06Af8grgz9eM4fA/3Bw9e1uPj860Nn6HvrK/qHukcXM9w6lje
         9xR5GwGLs0ux4Iwz0mLJprhhvZ9zvxnXUff2Kzv39EPkratB3ZPfmSAQQ+RQuViyV7db
         iMwg+CmGBa6Ds/dIjWCMRzGiYxI0AGHO5Jwz3fQPkiYnf4dErnV1g7l3HGRx64s4jRw3
         kzPU6IUSkKE9IV7dbRhdJq8WSWWXjV/tmu5PAvYyismDmwb2kDlBXSJVHYg8HWsnHeGX
         RsYLagf/umNs9fa3Xvl48F6YGs3r6klekP9jJwXCjL49xGWGw2Etl3eAz2fctxtOnrxR
         S5VQ==
X-Gm-Message-State: AOAM5337NatpM1VLzXIem9ag3EiRA8cl7im5POZqSuCbzAHUWgI7+w3h
        yHhfJG9ge5grpezAsgY5HaK6xVhU919SDg==
X-Google-Smtp-Source: ABdhPJyvcyuunqOvxVrb88NYzJWYo076q0Sj59lD1DGToF3YHTtSsSdSTa2mnUlnRs4g2Rr8j+V/0w==
X-Received: by 2002:ac8:5cc9:0:b0:2de:8838:5888 with SMTP id s9-20020ac85cc9000000b002de88385888mr11463294qta.370.1646693268876;
        Mon, 07 Mar 2022 14:47:48 -0800 (PST)
Received: from localhost (fwdproxy-ash-007.fbsv.net. [2a03:2880:20ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a014500b0060dd4af0cefsm6707602qkn.68.2022.03.07.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:47:48 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        rostedt@goodmis.org, kernel-team@fb.com
Subject: [PATCH 2/2] rcutorture: Add missing return and use __func__ in warning
Date:   Mon,  7 Mar 2022 14:46:57 -0800
Message-Id: <20220307224655.2626262-2-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220307224655.2626262-1-void@manifault.com>
References: <20220307224655.2626262-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcutorture module has an rcu_torture_writer task that repeatedly
performs writes, synchronizations, and deletes. There is a corner-case
check in rcu_torture_writer() wherein if nsynctypes is 0, a warning is
issued and the task waits to be stopped via a call to
torture_kthread_stopping() rather than performing any work.

There should be a return statement following this call to
torture_kthread_stopping(), as the intention with issuing the call to
torture_kthread_stopping() in the first place is to avoid the
rcu_torture_writer task from performing any work. Some of the work may even
be dangerous to perform, such as potentially causing a #DE due to
nsynctypes being used in a modulo operator when querying for sync updates
to issue.

This patch adds the missing return call.  As a bonus, it also fixes a
checkpatch warning that was emitted due to the WARN_ONCE() call using the
name of the function rather than __func__.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7fdff1bfed79..7d9489cdd7f2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1210,7 +1210,7 @@ rcu_torture_writer(void *arg)
 			 " GP expediting controlled from boot/sysfs for %s.\n",
 			 torture_type, cur_ops->name);
 	if (WARN_ONCE(nsynctypes == 0,
-		      "rcu_torture_writer: No update-side primitives.\n")) {
+		      "%s: No update-side primitives.\n", __func__)) {
 		/*
 		 * No updates primitives, so don't try updating.
 		 * The resulting test won't be testing much, hence the
@@ -1218,6 +1218,7 @@ rcu_torture_writer(void *arg)
 		 */
 		rcu_torture_writer_state = RTWS_STOPPING;
 		torture_kthread_stopping("rcu_torture_writer");
+		return 0;
 	}
 
 	do {
-- 
2.30.2

