Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB1495A24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378788AbiAUGxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:53:51 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:45462 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378777AbiAUGxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:53:50 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAB3fZ1hWOphqQW0Bg--.17811S2;
        Fri, 21 Jan 2022 14:53:21 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jcmvbkbc@gmail.com, dsterba@suse.com, johan@kernel.org,
        dankamongmen@gmail.com, penguin-kernel@I-love.SAKURA.ne.jp,
        igormtorrente@gmail.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] tty: vt: Check for NULL pointer after calling kzalloc
Date:   Fri, 21 Jan 2022 14:53:20 +0800
Message-Id: <20220121065320.2283544-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3fZ1hWOphqQW0Bg--.17811S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18Ary8ZrWDWry5Gr4fGrg_yoW8CF47pF
        ZxGry5Ars5J3Z3Xwnxta4DWF15G3W8G3W0kry3u3yUZr1Y9rW0kF9Iya4F9r9rArs7A3WY
        qw4rta4YkF1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
        VjvjDU0xZFpf9x0JU-J5rUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the allocation, the kzalloc() will return
NULL pointer.
Therefore, it should be better to check it in order to avoid the
dereference of the NULL pointer.
When it fails, we should free all the allocated memory and return error
number.
To make the code more clear, I use the 'err_free', like how
vc_allocate() deals with the allocation failure.

Fixes: a5f4f52e8211 ("vt: use kzalloc() instead of the bootmem allocator")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/tty/vt/vt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..343fa6fffc18 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3519,11 +3519,17 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (!vc)
+			goto err_free;
+
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (!vc->vc_screenbuf)
+			goto err_free_vc;
+
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
@@ -3545,6 +3551,19 @@ static int __init con_init(void)
 	register_console(&vt_console_driver);
 #endif
 	return 0;
+err_free_vc:
+	visual_deinit(vc);
+	kfree(vc);
+	vc_cons[currcons].d = NULL;
+err_free:
+	for (i = 0; i < currcons; i++) {
+		kfree(vc_cons[currcons].d->vc_screenbuf);
+		visual_deinit(vc_cons[currcons].d);
+		kfree(vc_cons[currcons].d);
+		vc_cons[currcons].d = NULL;
+	}
+	console_unlock();
+	return -ENOMEM;
 }
 console_initcall(con_init);
 
-- 
2.25.1

