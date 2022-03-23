Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176E14E4DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiCWICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCWICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:02:16 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDE5A0B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648022439;
        bh=lwMLg/Yews7tW/5fe8TNLpkLv34pD5PLMY7UOC6qBW4=;
        h=From:To:Cc:Subject:Date;
        b=hgPSnT28ZTMyW/opEe+m9kYni+IAeGT26zBrlssNukx7Bz9XPndfN8lImo8eaUXs/
         S3AI+NSRn18/Jw71p5NSASF/mVOl8HyKhgRWQAy3GqPxV0nlIrnW4H5tWrS78j6tSW
         xApC5HgF7wpDgVrj/hZEbh0gUOCBGRDYf4Gsp3vA=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 23A188F; Wed, 23 Mar 2022 16:00:35 +0800
X-QQ-mid: xmsmtpt1648022435tca9ugqwi
Message-ID: <tencent_61C566F88A52C1BF198826737AAE0E471806@qq.com>
X-QQ-XMAILINFO: ONLymQk6scaO9GJ/nMNoeUSLwUq3BvP5iTFihRf6aDI5gVJH5Jgd/kyaCnjkgy
         tpXZu0pMbNV1taHd1Tfho/FwM5qpNI/vmvr1LWWc3v3VBIg0h0RHPdSzXJkPInToClh9HMG6Cj42
         SL/1v02nd0d16vEDVqz5/9GSxfaZzMllyR9lDESE6Fp5AW0sisjCiY4WmhAeNHeJ/czFd0hxPXpq
         ryC9PQREFqOkeex+qh7xBQkU9nX/1+tq+vSzEhS6Ic2qlv7gmBnRi7SRiVkhTZYfmrVldjs7JgcS
         8XBksnSB62XLpzpGsUeKijSHpJyHUvJbb4D4YEwVC+YwNWSlWd/MWuaB/QieXqGXqin+xXxWDYM1
         NNq5itTOBQLyiDj/RmfPKIB/AiJZT+aSdAvOpdQKbTLEXTbFyA0kujcanBOjj7h/ai3+6GEN6AYL
         44j/HNa6Gh9aNCnp622fjvDlApSyg/NS9u2cIecHPAVhvZtn1Wg3vkclAOUxKSJoOOuuLU1vmVaA
         HEDzkbubQgM9f8ksUpF/tP9fzV+RRUgvlh25gS73pP6N4xwQAGZoNpXTQxWOSxrVOlIiLipTbBMN
         FCMiiIzQ+kWYR6eKrjlrfq9xhBaD63vj+CT5ckwQrn41hStdx+LFh6Z6tVhmaFzZFLutzTt1vZGL
         HC4LwInyRycVR9JWsj4HlProl7bsUX3YLNBfmgEFhIHqmbrP4tIZ6p+taTdPkJHm5UdBi/u+wm8c
         HpgPyGw+zz4SG8SWN7uj4CmA7Q+TD092d7KsM7kNctV8EeVol6GmR9Wkrhb5yvZv0LNZ0uaVsDr1
         SzqvIysmbm6fTRusEmXTpwe9KKlBK5LvNKCf28UhdElSfALo3w3mPok7qGsxYZkv3bn3CFFfoMD+
         byxIdVhOAswoFH6cojh0M2bvQ6Qc1C2zqLSXOft6n8pjAcjkw6fPhZ7A5MEL+Ynz/iGsG3WseYpK
         f7fV6OHUs=
From:   xkernel.wang@foxmail.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] NFS: check the return value of mempool_alloc()
Date:   Wed, 23 Mar 2022 16:00:03 +0800
X-OQ-MSGID: <20220323080003.2151-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

The check was first removed in 518662e ("NFS: fix usage of mempools.")
as the passed GFP flags is `GFP_NOIO`.
While now the flag is changed to `GFP_KERNEL` by 2b17d72 ("NFS: Clean
up writeback code"), so it is better to check it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 fs/nfs/write.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index eae9bf1..831fad9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -106,8 +106,10 @@ static struct nfs_pgio_header *nfs_writehdr_alloc(void)
 {
 	struct nfs_pgio_header *p = mempool_alloc(nfs_wdata_mempool, GFP_KERNEL);
 
-	memset(p, 0, sizeof(*p));
-	p->rw_mode = FMODE_WRITE;
+	if (p) {
+		memset(p, 0, sizeof(*p));
+		p->rw_mode = FMODE_WRITE;
+	}
 	return p;
 }
 
-- 
