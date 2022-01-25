Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50F49B514
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577168AbiAYN3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:29:04 -0500
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:44429
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1576700AbiAYNZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KQ8E+I5jgn
        dpekEIjuxuetI480OK8imxCoO0iKH46S4=; b=iGmegbYJKl0TTCJ9UVfVlywkjU
        y4hAUgS3gUbn9eo5PyMUqZCJAje+hMTB1fB1EsLdyse43KwUDDPJj/QP7U+Mfpeg
        1E/ECXjuN3Y8gbnzIdYk83UOxCMutLG0oBS2tQMhCgnPiFfrBPFjH1QaVR6WuWTe
        lH3gIHkHgIcP6UYtQ=
Received: from localhost.localdomain (unknown [111.192.165.103])
        by app1 (Coremail) with SMTP id XAUFCgD3_sIO9+9hW39lAA--.12450S4;
        Tue, 25 Jan 2022 21:11:48 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] NFSv4.2: fix reference count leaks in _nfs42_proc_copy_notify()
Date:   Tue, 25 Jan 2022 21:10:45 +0800
Message-Id: <20220125131045.37342-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XAUFCgD3_sIO9+9hW39lAA--.12450S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rGFW5Gr1rKr4DKFyxuFg_yoW8Aryxpa
        yrCrWUAF95KF18JFZIyayv93W3uFZ5tryUGF9293y7uF9xX3s8GF1Yyr1Y9r17JrW8X398
        XF1DKF4UZanYvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUboa0DUUUUU==
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAg0REFKp2ijNzAAAsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference counting issue happens in two error paths in the
function _nfs42_proc_copy_notify(). In both error paths, the function
simply returns the error code and forgets to balance the refcount of
object `ctx`, bumped by get_nfs_open_context() earlier, which may
cause refcount leaks.

Fix it by balancing refcount of the `ctx` object before the function
returns in both error paths.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/nfs/nfs42proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 8b21ff1be..438de4f93 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -592,8 +592,10 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 
 	ctx = get_nfs_open_context(nfs_file_open_context(src));
 	l_ctx = nfs_get_lock_context(ctx);
-	if (IS_ERR(l_ctx))
-		return PTR_ERR(l_ctx);
+	if (IS_ERR(l_ctx)) {
+		status = PTR_ERR(l_ctx);
+		goto out;
+	}
 
 	status = nfs4_set_rw_stateid(&args->cna_src_stateid, ctx, l_ctx,
 				     FMODE_READ);
@@ -601,7 +603,7 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 	if (status) {
 		if (status == -EAGAIN)
 			status = -NFS4ERR_BAD_STATEID;
-		return status;
+		goto out;
 	}
 
 	status = nfs4_call_sync(src_server->client, src_server, &msg,
@@ -610,6 +612,7 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 	if (status == -ENOTSUPP)
 		src_server->caps &= ~NFS_CAP_COPY_NOTIFY;
 
+out:
 	put_nfs_open_context(nfs_file_open_context(src));
 	return status;
 }
-- 
2.25.1

