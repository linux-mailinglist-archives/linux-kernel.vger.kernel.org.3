Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334F586FDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiHARy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiHARym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:54:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDDABC0F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:54:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f99336d8dso97218777b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1MQEHp+uPveOmZBO2w8/VdQxe4yWB13dK4o7EbmOrFM=;
        b=OASAc39jaSNasFVK5EN0ERbBf1LiiHWKnKgjnRjmVVzdPHUdsjvY4hF6IPlZEQmdUe
         tz+SIRqq3C7joulADC7AJO5sE8zqqlTAVdwjipZq0W0rD9iLqcq2n7QB8BkPqp7j/Pj/
         IRaUav0mIyHpo+Nv8I8Y7zy0aTpBHtWda2SEpthbHgfqsj8iISZNG0U9Eb/aPoIAJpsB
         g9ecwAKTh0zl6PMFWv+UOy2cOCXs8IBqyrFi2HNRfaQoAGIA6Qkii384wrNMJEi0Ehxa
         cHdlOYkyeVGn3UVAbCr7OjubrPTzPlT2iVsmzcBIw/8JIFdN/+9hhrTZvgX929w0qFDq
         Du9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1MQEHp+uPveOmZBO2w8/VdQxe4yWB13dK4o7EbmOrFM=;
        b=GGeTqBVVc2T84zhFD5J29ki4zxD6/FXOTASuTHluy3qd6a55m6FE3wNDmRx5n2o4vO
         xyz5z8g/4ZwNMRvxVG571RTcNGYGC5KxRxjN0ynrxUSNW87hvfRkq15PQCsTwf4SCiVf
         UXi/rdPpw0aOiDL7E34ERpT7IYWdkMNOOsJov4i3fNvhmGAr53tPfr3Uy6X4GfhuDfyS
         affNhC620L5HL3F9SZm+5NormCCIRJErz0mUV8H/haGhkFRAH0DF1FObGmxCDeIkZkNr
         hrCYa2TMktAMaBcImFLTKaqLgYcGSJtXVvRpFfd4W9QAl9qrvBLj+JT6lmpVJxy5UADn
         6yIw==
X-Gm-Message-State: ACgBeo1bMfEfmQQv3z+IOlDY1UR//6ZZ/Opsa2rwSeTuz2B+bLLLDh15
        hGmlhmzc40iVFqxY7xEZq+SXto0JVsVIRSSghhH32KrrrbUluZXDl4RNqvhZdKeGhNV6JiniuBd
        x/d/ovYRchs5b/mvRtN9RHWrUsu8IFNxmmuN3toQbFmSzabTYMYlPmbT/Ule7QPDPhaOnSA==
X-Google-Smtp-Source: AA6agR4fyH19hzDaq8AHc4igKnH+awdkL2zP+7Q+B8mbbub5P8/WRBsU6hiDMXSigkuA+sAIf3i8yhCLXzA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7c9:7b32:e73f:6716])
 (user=haoluo job=sendgmr) by 2002:a81:8351:0:b0:324:5ffb:5d1a with SMTP id
 t78-20020a818351000000b003245ffb5d1amr11742086ywf.337.1659376479536; Mon, 01
 Aug 2022 10:54:39 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:54:01 -0700
In-Reply-To: <20220801175407.2647869-1-haoluo@google.com>
Message-Id: <20220801175407.2647869-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220801175407.2647869-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v6 2/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
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

From: Yosry Ahmed <yosryahmed@google.com>

From: Yosry Ahmed <yosryahmed@google.com>

cgroup_get_from_file() currently fails with -EBADF if called on cgroup
v1. However, the current implementation works on cgroup v1 as well, so
the restriction is unnecessary.

This enabled cgroup_get_from_fd() to work on cgroup v1, which would be
the only thing stopping bpf cgroup_iter from supporting cgroup v1.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 13c8e91d7862..49803849a289 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6099,11 +6099,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 
-- 
2.37.1.455.g008518b4e5-goog

