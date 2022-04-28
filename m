Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E17512A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiD1Dow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiD1Dot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:44:49 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1CE9483B1B;
        Wed, 27 Apr 2022 20:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=TkdTGRGgDnMX8EaddtL3uKayHDJt8/TLy89laRtXYrQ=; b=Bs50JvXElikc8
        7LmlIXOE0aU/NqN9yLGnQ7AyQbt+K2NN295V1n12wk+whZrxyTZmGCSyvpYbUA+J
        EpGVSO8EL2gioZXhd9aIUOmNF5RKblRXuWkia1AUjYm4UO6JgDTvUbfLFVax2jyd
        DgaIxXcp0eeL49A+etI6rCR8xIgzs0=
Received: from localhost.localdomain (unknown [10.102.183.96])
        by app1 (Coremail) with SMTP id XAUFCgAHsrnPDGpi9qRkEQ--.26115S4;
        Thu, 28 Apr 2022 11:41:08 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] apparmor: fix reference count leak in aa_pivotroot()
Date:   Thu, 28 Apr 2022 11:39:08 +0800
Message-Id: <20220428033907.1658-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XAUFCgAHsrnPDGpi9qRkEQ--.26115S4
X-Coremail-Antispam: 1UD129KBjvdXoWruryruFW5tr4kCFWfGry3Arb_yoWkurc_GF
        1kZwn5urWUZF1qqF4qkay0gF92934kJr4qga4FkrsrG34Y9a1ayrZxJw1fZry2qw47JF15
        AFZ3Cr9Iy34xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbT8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUo-BMDUUUU
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAQ0KEFKp4-Oj6wAAs1
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aa_pivotroot() function has a reference counting bug in a specific
path. When aa_replace_current_label() returns on success, the function
forgets to decrement the reference count of “target”, which is
increased earlier by build_pivotroot(), causing a reference leak.

Fix it by decreasing the refcount of “target” in that path.

Fixes: 2ea3ffb7782a ("apparmor: add mount mediation")
Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
---
 security/apparmor/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index aa6fcfde3051..d0b19ab9137d 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -718,6 +718,7 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 			aa_put_label(target);
 			goto out;
 		}
+		aa_put_label(target);
 	} else
 		/* already audited error */
 		error = PTR_ERR(target);
-- 
2.25.1

