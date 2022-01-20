Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7990849458B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358094AbiATB0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:26:18 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:55102 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358092AbiATB0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:26:15 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAB3fS0iuuhhb47FBQ--.44891S2;
        Thu, 20 Jan 2022 09:25:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     keescook@chromium.org
Cc:     dan.carpenter@oracle.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] lkdtm/bugs: Check for the NULL pointer after calling kmalloc
Date:   Thu, 20 Jan 2022 09:25:51 +0800
Message-Id: <20220120012552.1851621-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3fS0iuuhhb47FBQ--.44891S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3Wr1DAFyfJw1rtrW7twb_yoW8GF1Upw
        s2gr15XFn8Wan7CF4qkw13KFyrCan7tFWfW3ySvwn5ZFn8CryUAa45t3yj9r1kurZ3Jw4I
        vF4rtFn3Ga4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6w4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbYFAPUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the kmalloc(), the not_checked and checked
could be NULL pointer.
Therefore, it should be better to check it in order to avoid the
dereference of the NULL pointer.
Also, we need to explicitly yell about the memory failure and then
kfree the 'not_checked' and 'checked' to avoid the memory leak if fails.
And since it is just a test, it may directly return without error
number.

Fixes: ae2e1aad3e48 ("drivers/misc/lkdtm/bugs.c: add arithmetic overflow and array bounds checks")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Add the kfree if fails.

v2 -> v3

* Change 1. Add pr_err if fails.
---
 drivers/misc/lkdtm/bugs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index f4cb94a9aa9c..c64ab6f387eb 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -325,6 +325,12 @@ void lkdtm_ARRAY_BOUNDS(void)
 
 	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
 	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
+	if (!not_checked || !checked) {
+		pr_err("FAIL: could not allocate required buffers!\n");
+		kfree(not_checked);
+		kfree(checked);
+		return;
+	}
 
 	pr_info("Array access within bounds ...\n");
 	/* For both, touch all bytes in the actual member size. */
-- 
2.25.1

