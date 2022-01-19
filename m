Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D7493A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354423AbiASMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:21:19 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:43214 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354343AbiASMVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:21:17 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADHpxQoAuhhdXyFBg--.58592S2;
        Wed, 19 Jan 2022 20:20:56 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     dan.carpenter@oracle.com, keescook@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] lkdtm/bugs: Check for the NULL pointer after calling kmalloc
Date:   Wed, 19 Jan 2022 20:20:55 +0800
Message-Id: <20220119122055.1826561-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHpxQoAuhhdXyFBg--.58592S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4UGw4UJFyxAr4xKF43Awb_yoW8Jr47pr
        s2gr1YqFn8Wan7CF4qkw13KFZ5Gan7tFWxW342v3s5ZFn5CryUAa45t3yj9r1kZrZ3J34I
        vF4rtF93Ga4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0CJPDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the kmalloc(), the not_checked and checked
could be NULL pointer.
Therefore, it should be better to check it in order to avoid the
dereference of the NULL pointer.
Also, we need to kfree the 'not_checked' and 'checked' to avoid
the memory leak if fails.
And since it is just a test, it may directly return without error
number.

Fixes: ae2e1aad3e48 ("drivers/misc/lkdtm/bugs.c: add arithmetic overflow and array bounds checks")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Add the kfree if fails.
---
 drivers/misc/lkdtm/bugs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index f4cb94a9aa9c..c35ea54824ac 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -325,6 +325,11 @@ void lkdtm_ARRAY_BOUNDS(void)
 
 	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
 	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
+	if (!not_checked || !checked) {
+		kfree(not_checked);
+		kfree(checked);
+		return;
+	}
 
 	pr_info("Array access within bounds ...\n");
 	/* For both, touch all bytes in the actual member size. */
-- 
2.25.1

