Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A45546D79
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350524AbiFJTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiFJTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:44:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5B3DA42
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:44:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 78-20020a630051000000b003fe25580679so30899pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oRH9s66i/tSGRatQjV8lrlYVzRqMhVkli+0iViEEm3E=;
        b=EWvIhNpLP4xn7/AaqRD2ry5tJ0od8mdvtIo1l8Mu+AVSg+pAqesAczV/0Lr9wi2kiz
         Fy1MQLHaGvnHVaKfEvTTAGxuQ35arwQTMzrK2HRvce7BKsnt7sTyah4aPc8tPwHAGwCP
         alnn29BH+uZT8ISPg2q0Aplzk57S3UfzlWezvPJ4bm6+UjnhYvJElPhjilELUc3eMS3i
         biAZPX2dSat+7EcVOoZvb8GhkN6J+dYfXoCwKW+EU9nHCjcLl83cMunu9bKv9Kdj8e3T
         TmfhQM5pKilrhRQQjzkRZ7h9oFsr0mAh0K0WVdTgcxvqo9ykb8W3YB6HehNxkS1wukLn
         Pf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oRH9s66i/tSGRatQjV8lrlYVzRqMhVkli+0iViEEm3E=;
        b=zQPyJ/0BmsTXDWW2v9w5M3k79jTgQda3od643wEke08tWi1nxcu4pc11nSmbPLfpB/
         2ffsTeft9F+7+EPuhmO2fcIuXT6v25H4NqlXJQMJKK+u5r6lLoywGHpuPbqaFE6XvAIO
         6FVS0BYj1ES3DX4Opci7e6ICLV1z8Y8iM3KTZeVVlPe8P2yZXJ9QbCrX99dgjlyh6RUF
         xqaa721WVoFy+MkxFZTgQQbQ4rcFK/t2fp3boArCnJ0SpHPoaLyM6ols770aHfb0Vofo
         j3qxEESZ6h6WsNJb5AC5jxxZc8/r/nxHBV8Z9yUpfD2vQD01K6BdLnDgG4/mqZPMWJdF
         yN/A==
X-Gm-Message-State: AOAM532V0FDYLzjn39/ZInUenUuwf+e+GCZwA1XXB24lS9Jm4WFCep4X
        PeY2RzGTkrKGT9NfwoBgMtnrQmfo/LIRkugj
X-Google-Smtp-Source: ABdhPJxLzCg7BT12DYURFJcz5iuhljjyz60dSOKo1LAt2zz0VKFLfw3YaQHFlASgYFV2U5cX9TzLETp7QJyh9R1w
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP
 id t9-20020a17090a024900b001e0a8a33c6cmr2523pje.0.1654890286518; Fri, 10 Jun
 2022 12:44:46 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:44:30 +0000
In-Reply-To: <20220610194435.2268290-1-yosryahmed@google.com>
Message-Id: <20220610194435.2268290-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v2 3/8] bpf, iter: Fix the condition on p when
 calling stop.
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index d5d96ceca1058..1585caf7c7200 100644
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
2.36.1.476.g0c4daa206d-goog

