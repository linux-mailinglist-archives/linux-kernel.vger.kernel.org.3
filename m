Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9DF47AA07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhLTNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhLTNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:00:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736BC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 05:00:18 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id a23so9336871pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHGl+thi566lLkqEM3W8OiPpX0IeNMe3UigGXwhsDUI=;
        b=GUwf2ohT/FJTOyL0GJdzYcpNELzU7T3WNz/BQi252+uWkgEy95lI6whwIsSAk5yvcZ
         MzNyb9VPwz9o5N3+bJeo6K0HJFaqlMoe+CG4RV+B8I6tGC2H7jgolIABUD8TUlFc1ZEr
         ci3p2cmN6tJY3jrfxfP3qJn5YdsMw0RL3i8l/PDBSWJNTEuG2HxfAaCfu0BJvOD6B03W
         3NXw1XRZnCQVK7E5ddTnaiyQZfBRvoNoYnLcqNXAF5HYjg/bdQMqGr/K0rXM/MtB4VTn
         YpUPxqb9ETTCnyBxahNKCQ6/YSnbxnrsmtL+wNyuycFFUlaecbAA0bvGfIavO0MczGBe
         e/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHGl+thi566lLkqEM3W8OiPpX0IeNMe3UigGXwhsDUI=;
        b=HaGPoeIVbxJfmJ8rpEJz5AUgqD9JnNad1E+pKDb7ABS8/ELb1wvESlP+FSsasA3Dip
         hvi8da671+vA3N0OZpig+FZpwob7NUugfB8BNnBmrvc60WryfNgl0uPlfIdGP9KVGM2a
         vC9B1J5+6y0Lemq5WqYQbZvolhSpdIfceBHq/ZqGTZqZniPArsysu+INFLbnLz/XHzJf
         DAEiObvCoGfRFdRRh50GqzxVwLE6I1VqPY4rdjSiQsZAKQnO9Wk2ylpKUucvXPWTDpP4
         zAFgLTDpk4kqrwTYiSPXO/X7soM6yZc6tihFEzJzuSYpyF/F/Fg9d8uboXMdSNqJdlfv
         IF1Q==
X-Gm-Message-State: AOAM530uckQwvxeQCT+EyyAXPVy1DT0AhWNaCFnfEJqlDb3qe1UUdaeo
        M76KWNKi1kinqtfA9++qSDc=
X-Google-Smtp-Source: ABdhPJxU5Yo1ezBNCUdtyyl59Q55E+qvwSkLKO5A8RfULH7f4kQ2GMYzUz/orAvdm9G6SPBfdgg3dg==
X-Received: by 2002:a05:6a00:22d2:b0:4bb:721:7337 with SMTP id f18-20020a056a0022d200b004bb07217337mr116186pfj.76.1640005217976;
        Mon, 20 Dec 2021 05:00:17 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.115])
        by smtp.gmail.com with ESMTPSA id k141sm2937168pfd.144.2021.12.20.05.00.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:00:17 -0800 (PST)
From:   Eric Ren <renzhengeek@gmail.com>
To:     david@redhat.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, ziy@nvidia.com,
        renzhengeek@gmail.com
Subject: [PATCH] virtio_mem: fix panic on mb_states indexing overflow
Date:   Mon, 20 Dec 2021 21:00:00 +0800
Message-Id: <9a2f66123f74e8c452b0fa61cb5da6e0c2804070.1640004743.git.renzhen.rz@alibaba-inc.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`mb_id` is unsigned integer, which is used to index
`mb_states` array in reverse order. `mb_id` can decrease
to `0UL - 1` that is a very large number, causing invalid
address access.

The calltrace is like below:
```
[  286.344977] BUG: unable to handle page fault for address: ffffa95180cf8fff
[  286.345800] #PF: supervisor read access in kernel mode
[  286.346738] #PF: error_code(0x0000) - not-present page
[  286.347440] PGD 1000067 P4D 1000067 PUD 138c067 PMD 1840435067 PTE 0
[  286.348156] Oops: 0000 [#1] SMP PTI                                                        [  286.348556] CPU: 1 PID: 122 Comm: kworker/1:2 Tainted: G           OE
...
[  286.350740] Workqueue: events_freezable virtio_mem_run_wq [virtio_mem]
[  286.351605] RIP: 0010:virtio_mem_unplug_request+0x418/0x890 [virtio_mem]
[  286.352519] Code: 0f 87 fc 00 00 00 4a 63 54 ac 30 48 83 bc d5 f8 00 00 00 00 48 89 d0 0f 8
4 e5 00 00 00 48 8b b5 38 01 00 00 4c 89 e2 48 29 ca <0f> b6 34 16 39 c6 75 c7 40 80 fe 02 0f
82 a4 01 00 00 40 80 fe 03
[  286.355030] RSP: 0018:ffffa95181c4bd50 EFLAGS: 00010286
[  286.355737] RAX: 0000000000000005 RBX: 0000000000006100 RCX: 0000000000000000
[  286.356752] RDX: ffffffffffffffff RSI: ffffa95180cf9000 RDI: ffff8e5dc393b348
[  286.357649] RBP: ffff8e5dc393b200 R08: ffff8e463cd2b610 R09: 0000000000000021
[  286.358627] R10: ffffa95181c4bcd0 R11: ffffa95181c4baa0 R12: ffffffffffffffff
[  286.359617] R13: 0000000000000003 R14: ffff8e5dc393b348 R15: 00000000fffffff0
[  286.360503] FS:  0000000000000000(0000) GS:ffff8e463cd00000(0000) knlGS:0000000000000000
[  286.361532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.362229] CR2: ffffa95180cf8fff CR3: 0000001846234000 CR4: 00000000000006e0
[  286.363168] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  286.364162] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  286.365054] Call Trace:
[  286.365431]  ? virtio_mem_run_wq+0x5a4/0x870 [virtio_mem]
[  286.366132]  ? __schedule+0x4b3/0x800
[  286.366547]  ? process_one_work+0x18b/0x350
[  286.367041]  ? worker_thread+0x4f/0x3a0
[  286.367675]  ? rescuer_thread+0x350/0x350
[  286.368234]  ? kthread+0xfa/0x130
[  286.368605]  ? kthread_create_worker_on_cpu+0x70/0x70
[  286.369155]  ? ret_from_fork+0x1f/0x30
```

Fixes by also checking its up boundary.

Signed-off-by: Eric Ren <renzhengeek@gmail.com>
Signed-off-by: Eric Ren <renzhen.rz@alibaba-inc.com>
---
 drivers/virtio/virtio_mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 96e5a8782769..e403e6d95c0b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -486,7 +486,9 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 
 #define virtio_mem_sbm_for_each_mb_rev(_vm, _mb_id, _state) \
 	for (_mb_id = _vm->sbm.next_mb_id - 1; \
-	     _mb_id >= _vm->sbm.first_mb_id && _vm->sbm.mb_count[_state]; \
+	     _mb_id >= _vm->sbm.first_mb_id && \
+	     _mb_id < vm->sbm.next_mb_id &&		\
+	     _vm->sbm.mb_count[_state]; \
 	     _mb_id--) \
 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
 
-- 
2.30.1 (Apple Git-130)

