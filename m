Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79825A5E47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiH3IhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiH3IhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:37:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273865E338
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:37:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c2so10432801plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=awkJXmGGU5TdN13Umx2r2zUdBoTqXjBxvaSpBFaOz1Q=;
        b=MNWzEtz28t7wCdJEdyw7V+7sGRZ34xjJdwPaK0ybD4hNvH1HmV5JH6TAKu3ZgABS7p
         xjTVWEtne8Nr9qvDIN3a1sNLxbSmjCT/eEq2PULqQR7Pd5CEGwhdVhisDKmLZhw3F3oF
         fO9AhnfetyNHigK9pNeynOLb3nlLgqEynzAwQF6Q+Vb933bikOKHsj+nveJJFnVFX9Mv
         KBaMNZLZfwzBfXwCW79YQiB6D1As0skH7rPpmpJnUIBVPXIbsqFBXiUPvAJUpOWgML8v
         3SI8L357Uk82mx2mt6VlqE1w3hJQv0xHgygxuNjaYN5J3J4hvv+eLw1C6Yay3PKeyXs7
         WOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=awkJXmGGU5TdN13Umx2r2zUdBoTqXjBxvaSpBFaOz1Q=;
        b=epWleSPkX9ZDISvtT/PcPUU2tqVtaQMrnVOSfSXveNeUEubfU+GWE0oXzsG54Gei06
         PzhPTlnQms51YHdgQtO9aL+YshmlBosZc115cMFctQVQjKXIhTycL6f51vw8NDuVfdlc
         ZL7SM1UFx2v/EUGlR+/lJgchgh7wyxfCVCnsIUwQa4F9DLXTBF2J+u5b8jpgs+sRZIby
         5iKsFu84xnd/8raxA/ap/Mhice5vq3MahzUn9bL6UKNLbyDQDL0rpn+B8du3BVCxCkEc
         WT7TbSjbZjvSOAJBUqtm7wxyCttwg0kI1CpxQaonOJ+WpoHN2yadAjGH+trQEYok4GVE
         VYWw==
X-Gm-Message-State: ACgBeo2T14QNxS7cte/mdj0hJ7/EpWzJLFS6WpdmnIrAYW17vzDgNGoc
        rSsSY/oJfmXgnzp2t05k2mpqeQ==
X-Google-Smtp-Source: AA6agR6IBJ7j8lf/g2whEj9kbYF1PlZ8hZ2VY3gIgpfm0wLlV9RB/zMnIhwcOuvhwsg7S+AmnEDR3A==
X-Received: by 2002:a17:90a:fae:b0:1fd:a1bc:ff65 with SMTP id 43-20020a17090a0fae00b001fda1bcff65mr13694791pjz.73.1661848619625;
        Tue, 30 Aug 2022 01:36:59 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id h123-20020a625381000000b005360da6b26bsm8676636pfb.159.2022.08.30.01.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:36:59 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] nvmet-tcp: Fix NULL pointer dereference during release
Date:   Tue, 30 Aug 2022 16:36:28 +0800
Message-Id: <20220830083628.499028-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
and waits the inflight IO requests in nvmet_sq_destroy(). During wait
the inflight IO requests, the callback nvmet_tcp_queue_response()
is called from backend after IO complete, this leads a typical
Use-After-Free issue like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:shash_ahash_digest+0x2b/0x110
 Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
 RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
 RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
 RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
 R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
 R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
 FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
  ? __switch_to+0x106/0x420
  process_one_work+0x1ae/0x380
  ? process_one_work+0x380/0x380
  worker_thread+0x30/0x360
  ? process_one_work+0x380/0x380
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30

To fix this issue, free CMD buffers until all the inflight IO
complete.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..2325246e3b4d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1449,8 +1449,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
-	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_tcp_uninit_data_in_cmds(queue);
 	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
-- 
2.20.1

