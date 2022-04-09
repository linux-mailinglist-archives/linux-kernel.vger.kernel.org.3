Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8634FA20A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbiDIDmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiDIDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:41:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C18AC928;
        Fri,  8 Apr 2022 20:39:48 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3xP9_1BiOesbAA--.5440S3;
        Sat, 09 Apr 2022 11:39:44 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] init: print some info about UUID and LABEL in name_to_dev_t()
Date:   Sat,  9 Apr 2022 11:39:39 +0800
Message-Id: <1649475581-12139-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
References: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dx3xP9_1BiOesbAA--.5440S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryxGF43uFy5Aw1kZw45GFg_yoW8uw4kpw
        47K345Kr92qr4DA3WUAF1rXry5Ja1Y93WFqFWFvws7uwsIgF9rX3W0yF1jy34UJw1rA3W2
        qa15Jr93CF4YyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jw2-5UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no valid initrd, but root=UUID or root=LABEL is used
in the command line, boot hangs like this:

[    5.739815] VFS: Cannot open root device "UUID=19957230-2e15-494c-8dfa-84aab3591961" or unknown-block(0,0): error -6
[    5.750280] Please append a correct "root=" boot option; here are the available partitions:
[    5.856059] 0800       125034840 sda
[    5.856061]  driver: sd
[    5.862124]   0801          307200 sda1 d5077411-3d87-4f85-b312-8cc309ef9073
[    5.862128]
[    5.870603]   0802         1048576 sda2 aae0dd30-e5f5-44e1-994e-d47bf5ce2e52
[    5.870606]
[    5.879080]   0803        52428800 sda3 759079ee-85fa-4636-9de7-1ac0643ab87e
[    5.879083]
[    5.887558]   0804         8388608 sda4 439c4b0a-7b4f-4434-82f1-f9d380b55fb9
[    5.887560]
[    5.896035]   0805        62860288 sda5 ee52e951-1315-4fab-a3e5-45c6eeae6ce6
[    5.910575] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    5.918796] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---

The above log is very useful, but some users still need time
to analysis the cause [1, 2]. It is better to print some info
to explicitly tell the users root=UUID or root=LABEL is not
supported without initrd.

[1] https://unix.stackexchange.com/questions/93767/why-cant-i-specify-my-root-fs-with-a-uuid
[2] https://unix.stackexchange.com/questions/302795/how-to-identify-root-partition-via-uuid-without-initramfs-initrd

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 init/do_mounts.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7058e14..2c1c492 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -290,6 +290,14 @@ dev_t name_to_dev_t(const char *name)
 	if (strncmp(name, "/dev/", 5) == 0)
 		return devt_from_devname(name + 5);
 #endif
+	if (strncmp(name, "UUID=", 5) == 0) {
+		pr_info("root=UUID is not supported without initrd\n");
+		return 0;
+	}
+	if (strncmp(name, "LABEL=", 6) == 0) {
+		pr_info("root=LABEL is not supported without initrd\n");
+		return 0;
+	}
 	return devt_from_devnum(name);
 }
 EXPORT_SYMBOL_GPL(name_to_dev_t);
-- 
2.1.0

