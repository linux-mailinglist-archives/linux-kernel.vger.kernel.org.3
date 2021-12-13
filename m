Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121FA471F96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhLMDbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:31:43 -0500
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252]:52629 "EHLO
        out162-62-57-252.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhLMDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:31:42 -0500
X-Greylist: delayed 56315 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 22:31:41 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639366299;
        bh=JRDtp9lI1b1ILfAffBPfZBg/lls6yyX8ptRRHfpz2oQ=;
        h=From:To:Cc:Subject:Date;
        b=FPifr6Ec9J+6SrXboWqby+5L0siqXqWfckxm7ccpH6wvHiCVtX23Fh2wreDvieBQp
         fh/wlRxpo5H9AjDlGw/S7qz8RJO97e8mT7pWV2e/BjQNbzgb2UmMbYJcKLGJXbY9/t
         R18rdqgoiT2nL/hsU3gSEsrhDt0N89A+F5JnbDLk=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 7E304829; Mon, 13 Dec 2021 11:31:35 +0800
X-QQ-mid: xmsmtpt1639366295topbwn701
Message-ID: <tencent_6410A5887F4B906866965C000E7A8AA3F007@qq.com>
X-QQ-XMAILINFO: OEaI/iTChbugEN0Qc7yHGYRl/L9+60Zdrp7JoQkxMmTPZKMkCjyLKegb9weFxM
         ex1SQgApNmBjK+O+c/lrO6dcXVZVjcdefkd/5+pJ/ea7nohEDbqAiMbjtemdYJBMWI1dYDAdb8u+
         1DWhb0cjJs23vO3HYo43o2BOTotoMpCVEsXHdwRl/qRvwSziSU5ZdDvCGGD52j0Aivpyk55K1pqm
         E9mKB5b9RjINSJnJEeduVtMofuiH496cz1qV0uIoOurd69hO4UhOCtaK6bbf36BfspNQXwrbgkJ3
         L1uQ3JQKUBdLoE3CVAhl0wTGSUaKSOloMj2mJMuSlxKvVhy3Y404RLXv//ZhjtHCM38lifm9wgGN
         3lvU20ezCCYkiE/MJlfMfF7AJwazhE9SQzSYxWZLo2uh2Qm5Xn0iru/2blm0QWdDNIlRJOg/Z8/i
         YwvYg9+Sk+ViU/IYIjQ8wtBFkNnq3F+D6ANkpfkKkYKKYVgaRJC1rX23olovT/ab5VzLjdCw9Uu0
         QKN6eodtDLgngdqawIX6QF6iw2Mg9kv2xYF0ijwi1h/nEV1ve4KZx7t9+jlmrJt+CtWy6RLcMzRp
         a0VCOS8aw9TF0+avjXw+EIz728FDRjPgfksiXf1TWUfod1jZ9VvTbxI2U08geTymsmhnBmPLM5ck
         V49dFL8ueAuYwNnrezC2TG6gQbq4BS81z2Qy1F2EX3MShyx1tFSP7An5R3Dg/EvbCfqLCykauoTX
         AotSiRAnuyJ3IQJNRncD3Bfsl7KZtmrFGdKGrulwF/0xqTJmQf/nKlTclweQkoCYp7mupYHGPEoL
         HGFQMqnVEOK0/v3+gIs0J+qCDxsVoXJfXNDclgwGrnyiEvcXtg43ehc3NrNq2ufyKnKjCiUXG/7O
         M26B/Ve7/LZFtwgmrcyaa7+dD7HZDADLu7iyCqDrz1IDL6vLXnpWQhlcOAImwLVA==
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] cgroup: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 11:30:42 +0800
X-OQ-MSGID: <20211213033042.3813-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it so to catch the memory error in
time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ea08f01..47c7d58 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2228,6 +2228,9 @@ static int cpuset_init_fs_context(struct fs_context *fc)
 	struct cgroup_fs_context *ctx;
 	int err;
 
+	if (!agent)
+		return -ENOMEM;
+
 	err = cgroup_init_fs_context(fc);
 	if (err) {
 		kfree(agent);
-- 
