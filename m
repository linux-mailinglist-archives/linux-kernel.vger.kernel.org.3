Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3988E5A1B46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiHYVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiHYVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:39:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B38C2294
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:39:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-335420c7bfeso362964177b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=qyjREfjkq0hIeesiuObUgKl0CFQ9rAXNLG/+EmCCOug=;
        b=Mz+DnI4of0BYshEfym2Ka/PzJ9GfRcPKAz/WWjS7OP9u7mD+Ksba3kRYQl/jBIVHoi
         oG2D2uUnrOrUQmHeUurZkx93oBq1ceQ2hn96zUZLgxRDyhVewe6kN1esNGMVQtSQvwvd
         hOBom9axJKVPjSlESgsenu4/V0Bj1iOZPFd+8oDkkdTGkk3FpOj2eWqqu/QQag7S66ek
         o3FOsVesz8mzvF8Pw9i9l7QuT/O55FB4w7ZAMUyMkjxAQU4h3TfjC+osbssLeWqwETJ8
         ejxR3J8KwtlQMKzLeUsTFomcDKHbkEpdjZZf1kOCcf8RwoJcg52MJ9Mp6rb9LuHOfQg1
         vdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=qyjREfjkq0hIeesiuObUgKl0CFQ9rAXNLG/+EmCCOug=;
        b=MKlbqx5PGGJJuRIgAhHvwN1ADGPrdLzMtLv2skEQx4pDH4391MHMfJtCoDNPVZDbK+
         7TyU2ZAX2dDLmKEaa4qezu5R1qaIU8nLsugkyfQBY3buzlbf9EAhjPHPsRssj2nbV8Iu
         jOZGjWx3gIxh/T8q6Y0bLV4nGQNxTl08jJPhHsMzEVdfXb+cdPlB+OWPyKHJt/gVzuAN
         X2cSgSvE2nWWAmxw26ClsR1IeSjbnKXlyz0+nVxuIr8PjHeF81/lIrgZ4ReIi/973jVc
         oVXqXcBK019WTSLyw+KdXsF1++PMf+xgaV2uzWXjco0TayQUxkdBZAsP83+IHCZaMUVf
         X9DA==
X-Gm-Message-State: ACgBeo3vJNDF0dv0lvJbadB8CnanDBADjCBBSDCpNI2Lra0yVbOWbs/U
        hstNQHkWADYTaThz/7LDNUVOlP0MWDZVZiOm8ONMzlMO/nYp0Rsiv9dLMq/HiKwIwtqiWxFCbJk
        buYdIMKNg9co3bAsyVrPvgktAZue0r53RoCRx7HYjg8UQkGHa/2AXAKSQisaeLJIa3nvzmQ==
X-Google-Smtp-Source: AA6agR7J1T+1mDf/L7KJ6viBPp96hK/l2ak65iQp0rK0p+gbSsL7vdWeOOGRneu6yCsZT9QG2uZsweyN+M0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:2c4f:653f:78b3:2b5b])
 (user=haoluo job=sendgmr) by 2002:a25:198b:0:b0:690:65bb:9416 with SMTP id
 133-20020a25198b000000b0069065bb9416mr4806243ybz.142.1661463555046; Thu, 25
 Aug 2022 14:39:15 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:39:05 -0700
In-Reply-To: <20220825213905.1817722-1-haoluo@google.com>
Mime-Version: 1.0
References: <20220825213905.1817722-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825213905.1817722-3-haoluo@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Fix test that uses cgroup_iter order
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commit added a CGROUP prefix to the bpf_cgroup_iter_order.
It fixes the commit that introduced cgroup iter. This commit fixes
the selftest that uses the cgroup_iter_order. Because they fix two
different commits, so put them in separate patches.

Fixes: 88886309d2e8 ("selftests/bpf: add a selftest for cgroup hierarchical stats collection")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/cgroup_hierarchical_stats.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
index 101a6d70b863..bed1661596f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
@@ -275,7 +275,7 @@ static int setup_cgroup_iter(struct cgroup_hierarchical_stats *obj,
 	 * traverse one cgroup, so set the traversal order to "self".
 	 */
 	linfo.cgroup.cgroup_fd = cgroup_fd;
-	linfo.cgroup.order = BPF_ITER_SELF_ONLY;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 	link = bpf_program__attach_iter(obj->progs.dump_vmscan, &opts);
-- 
2.37.2.672.g94769d06f0-goog

