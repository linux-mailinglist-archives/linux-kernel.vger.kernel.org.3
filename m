Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79A492502
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiARLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:35:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38314 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234332AbiARLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642505735; x=1674041735;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Xpnk/KGmrv0cCAMDVblqIQzdev4jRFWvT9glia5SNwY=;
  b=MwAG7vjLIQi7yX6G2yf6esXSE4/sfFCShJn55fjGgBctEkXITseOYSXL
   uTec1nlaQVlDJ6VwyUziqq11Cwvn9ucF/4n5f+DSmJHq4K5RF31hzOxGD
   IwBMQIQxEUgtUvmYLceI6IKe0DgU5PwoRIQncjVFOP5lWMS9CnjfZ9trL
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Jan 2022 03:35:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:35:34 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 03:35:31 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <john.ogness@linutronix.de>, <rostedt@goodmis.org>,
        <senozhatsky@chromium.org>, <pmladek@suse.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] printk: Fix seq check inside devkmsg_read()
Date:   Tue, 18 Jan 2022 17:04:48 +0530
Message-ID: <1642505688-1194-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prb_read_valid() could return a record whose seq number can be
newer than the requested one. In that case, we allow the reading
of the data instead of erroring out.

This commit fixes this by correcting the check.

Fixes: ce6de43a547b6e01a3 ("printk: avoid prb_first_valid_seq() where possible")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 155229f..53b09b98 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -738,7 +738,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			goto out;
 	}
 
-	if (r->info->seq != atomic64_read(&user->seq)) {
+	if (r->info->seq < atomic64_read(&user->seq)) {
 		/* our last seen message is gone, return error and reset */
 		atomic64_set(&user->seq, r->info->seq);
 		ret = -EPIPE;
-- 
2.7.4

