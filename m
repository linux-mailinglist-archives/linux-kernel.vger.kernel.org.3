Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639644646DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbhLAFwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:52:44 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:51848 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231820AbhLAFwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:52:41 -0500
X-UUID: c41db5476a4e4701abeb0ea4a9f909e8-20211201
X-UUID: c41db5476a4e4701abeb0ea4a9f909e8-20211201
X-User: zhangyue1@kylinos.cn
Received: from localhost.localdomain [(172.17.127.2)] by nksmu.kylinos.cn
        (envelope-from <zhangyue1@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1372583411; Wed, 01 Dec 2021 13:57:31 +0800
From:   zhangyue <zhangyue1@kylinos.cn>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: fix out-of-bounds in register_kretprobe
Date:   Wed,  1 Dec 2021 13:48:55 +0800
Message-Id: <20211201054855.5449-1-zhangyue1@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the data 'rp->data_size' is negative, the code
'sizeof(struct kretprobe_instance)+rp->data_size'
is less than 'sizeof(struct kretprobe_instance)'

At this time, the pointer 'inst' may be out of
bound when it is in use.

Signed-off-by: zhangyue <zhangyue1@kylinos.cn>
---
 kernel/kprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1cf8bca1ea86..71cf6bde299f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1983,7 +1983,7 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret;
-	struct kretprobe_instance *inst;
+	struct kretprobe_instance *inst = NULL;
 	int i;
 	void *addr;
 
@@ -2024,7 +2024,8 @@ int register_kretprobe(struct kretprobe *rp)
 
 	rp->rph->rp = rp;
 	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
+		if (rp->data_size >= 0)
+			inst = kzalloc(sizeof(struct kretprobe_instance) +
 			       rp->data_size, GFP_KERNEL);
 		if (inst == NULL) {
 			refcount_set(&rp->rph->ref, i);
-- 
2.30.0

