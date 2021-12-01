Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E459465053
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbhLAOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbhLAOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:49:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A3DC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:45:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03187CE1F4D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 14:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA4CC53FCD;
        Wed,  1 Dec 2021 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638369954;
        bh=7Ho7n6rjLlleXHreFeiPC12K7HB5s3y00yAbj5K+LLA=;
        h=From:To:Cc:Subject:Date:From;
        b=dc4L8v+0e2lPEQm6mm7W/39YbQuH509szTu3Z2qX0lT/dwzp8ATbDXZXpvuaoqgsx
         U1hlJ2e9JfIO7VNXDEXzNj/wV2Jbf4rCOr3E7hGFNWFK7Vb1GMp/6fjZLFDgsYO+Ge
         5gczCOo56neSHvW/1XBSRkNsxmjcpCdkuX30eKYJ5K57VocTyuyLvLUSiv3/T853fK
         xFZc01JIrjMgeoQp1xDq2h0rQ7lxgqglvda0BYWPRAlumCUny17LJMpT03ddRWmSNy
         SKYGxCsaMtUD9Z/4xSOHt0Wj0Paako7fdw/PTlPPzOiBSHDy+gaWzOmmaAHF5Ep/mS
         z4nQksTtaD0pw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        zhangyue <zhangyue1@kylinos.cn>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Subject: [PATCH] kprobes: Limit max data_size of the kretprobe instances
Date:   Wed,  1 Dec 2021 23:45:50 +0900
Message-Id: <163836995040.432120.10322772773821182925.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kretprobe::data_size is unsigned (size_t) but it is
used as 'data_size + sizeof(struct kretprobe_instance)'.
Thus, it can be smaller than sizeof(struct kretprobe_instance)
while allocating memory for the kretprobe_instance.

To avoid this issue, introduce a max limitation of the
kretprobe::data_size. 4KB per instance should be OK.

Reported-by: zhangyue <zhangyue1@kylinos.cn>
Fixes: f47cd9b553aa ("kprobes: kretprobe user entry-handler")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    2 ++
 kernel/kprobes.c        |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e974caf39d3e..8c8f7a4d93af 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -153,6 +153,8 @@ struct kretprobe {
 	struct kretprobe_holder *rph;
 };
 
+#define KRETPROBE_MAX_DATA_SIZE	4096
+
 struct kretprobe_instance {
 	union {
 		struct freelist_node freelist;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e9db0c810554..21eccc961bba 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2086,6 +2086,9 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	if (rp->data_size > KRETPROBE_MAX_DATA_SIZE)
+		return -E2BIG;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 

