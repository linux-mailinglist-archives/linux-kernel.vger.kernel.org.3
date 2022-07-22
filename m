Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57357E5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiGVRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiGVRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:49:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A89DEED
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:48:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p21-20020aa78615000000b00528d84505b5so2163493pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wbl69skgO/KCoHNYhblp1Sm0LyLquoPWEcXNs9wNbPo=;
        b=AmUgsvum8Imcrw7TkDzaGbus+Rb4RvrczWCp5I5by2yqHRT10dP5RNXchlZWMy0XCa
         RxBTwZWpW61iQlaiiYafIDEh6C7ufsrZYHCDvW49uYthANuemdP3MIfHhUS9X0zzXWjt
         M43GzdejCLYF5izJthcOjdmrlVixZf4xTtal42R4qcJxO3KkQmSQFP4Sdo/moRIJfpCo
         7sCj8zlKVY/yi72ECe+6WEUiF3b3phpz2DL3aAvl+IpJ1IQCSQt+iQStmFwLE5pFeTrh
         n+gwJP81y3rWRTnB1SMGupv71Ovs/WSWrxoGIg4XRTqJcG0S6WGumNLNRRNXnnvIX7hi
         qbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wbl69skgO/KCoHNYhblp1Sm0LyLquoPWEcXNs9wNbPo=;
        b=PMSIo76ae3XxHGKkH0hpAxhz/ffKyxqQRv34mojIGs8p2H5fu1RjK3YmZV223tAcxs
         asyf6yfbqnQ8OJi850Z/GcrIwEzzZrSCk0Ur9w5kvmFWRtUSwroXi2J3wNX5obhNSusL
         Cf30nD3W2rMfiwxLvlRO8tWpzLHoCP1vu5uoBwfy8RymK9hwK4flgSQSrMsi9QurLxhe
         /cX5ZLUT9LpioN7vrCApYEvMkCB3gKt8zumkIZOP0VIgzJimam0r8uCFCW6zt9WgsAJM
         7WAm3lMT/LR1V3jVtjDh1FjZbzSIjghwfIQdp9+65U/aYE3erFPi8vMboADv1WijQSRt
         dJ0A==
X-Gm-Message-State: AJIora85yjJwuviiu3ZIv1c53GeNiq1teGkkFuWk/T6nKCGWdVyvx0jw
        m+fkge+HPgRajUImMOdxpQ3x2OaUGSUkhOr5
X-Google-Smtp-Source: AGRyM1tTWZqgJstxad4aJ/olu/cwPgtph6W5MU4NplL/bFH47OLxRw7UTpWSI49Yun/ZgK449GSC0hp2qZ+8WXG5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:228d:b0:16d:4549:1078 with SMTP
 id b13-20020a170903228d00b0016d45491078mr958471plh.78.1658512132836; Fri, 22
 Jul 2022 10:48:52 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:48:24 +0000
In-Reply-To: <20220722174829.3422466-1-yosryahmed@google.com>
Message-Id: <20220722174829.3422466-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220722174829.3422466-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH bpf-next v5 3/8] bpf, iter: Fix the condition on p when
 calling stop.
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Luo <haoluo@google.com>

In bpf_seq_read, seq->op->next() could return an ERR and jump to
the label stop. However, the existing code in stop does not handle
the case when p (returned from next()) is an ERR. Adds the handling
of ERR of p by converting p into an error and jumping to done.

Because all the current implementations do not have a case that
returns ERR from next(), so this patch doesn't have behavior changes
right now.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f6..4688ba39ef25 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -198,6 +198,11 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	}
 stop:
 	offs = seq->count;
+	if (IS_ERR(p)) {
+		seq->op->stop(seq, NULL);
+		err = PTR_ERR(p);
+		goto done;
+	}
 	/* bpf program called if !p */
 	seq->op->stop(seq, p);
 	if (!p) {
-- 
2.37.1.359.gd136c6c3e2-goog

