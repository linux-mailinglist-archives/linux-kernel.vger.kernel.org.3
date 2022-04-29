Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD9C5143B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355444AbiD2IRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355432AbiD2IRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:17:23 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 58A0EC12D5;
        Fri, 29 Apr 2022 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=vji+Pu3Etg
        splcw6DXX8MliDmzUMLPecRIBpkLQydNs=; b=G+89dIPb4OwgGg87ArWir/r6Gj
        5+6XSueQAVD80bXh6iEsk5p3E7k8yPGCGcuPTbpZUfom1c2qqWsSG5pjdC53cFJ0
        Ai5HYfaB6ws3Jj2Tne006pEwB4+BuUk5ZDAFBRCf072rgLuMEWKL1RT1Y4Weo0Qz
        sgjNTiN/wd//aoQm4=
Received: from localhost.localdomain (unknown [10.102.183.96])
        by app1 (Coremail) with SMTP id XAUFCgBnb8Mrnmti7ZN2EQ--.47586S4;
        Fri, 29 Apr 2022 16:13:37 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] ksmbd: fix reference count leak in smb_check_perm_dacl()
Date:   Fri, 29 Apr 2022 16:11:22 +0800
Message-Id: <20220429081121.1640-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XAUFCgBnb8Mrnmti7ZN2EQ--.47586S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF45JFW8Gw4fKFyUGw45Jrb_yoWDAFc_Gr
        WrJF4Ivr15JF1qvw1qv348Aa17uws8JF48K39rtF1aqayUKF9xXrykXw1avr1Uu3y3ZFs5
        u3yrtF1xZrs2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjfUFYFADUUUU
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAQ4LEFKp4-TN3QAAso
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue happens in a specific path in smb_check_perm_dacl(). When
"id" and "uid" have the same value, the function simply jumps out of
the loop without decrementing the reference count of the object
"posix_acls", which is increased by get_acl() earlier. This may
result in memory leaks.

Fix it by decreasing the reference count of "posix_acls" before
jumping to label "check_access_bits".

Fixes: 777cad1604d6 ("ksmbd: remove select FS_POSIX_ACL in Kconfig")
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ksmbd/smbacl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 6ecf55ea1fed..38f23bf981ac 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1261,6 +1261,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 					if (!access_bits)
 						access_bits =
 							SET_MINIMUM_RIGHTS;
+					posix_acl_release(posix_acls);
 					goto check_access_bits;
 				}
 			}
-- 
2.25.1

