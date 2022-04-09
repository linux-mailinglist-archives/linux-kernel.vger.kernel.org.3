Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BD4FA20C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiDIDmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiDIDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:41:54 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A6DB396B5;
        Fri,  8 Apr 2022 20:39:47 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3xP9_1BiOesbAA--.5440S5;
        Sat, 09 Apr 2022 11:39:46 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block: print correct sectors in printk_all_partitions()
Date:   Sat,  9 Apr 2022 11:39:41 +0800
Message-Id: <1649475581-12139-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
References: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dx3xP9_1BiOesbAA--.5440S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryxGF43uFy5Aw1kZw45GFg_yoW8KrW5pr
        43KFn5GFW8Wr1DZ3WDCF1UXFWrCayrZa1rtFWI93sru3s8Wrnrta4akrWjyw12qF1fXay2
        vw48Wr9IyFn8CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsNeoUUUUU
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

In the above log, the sectors are not consistent with the output
of fdisk command, fix it.

[root@linux loongson]# fdisk -l /dev/sda

Disk /dev/sda: 119.2 GiB, 128035676160 bytes, 250069680 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 01D1BA1C-232F-45CA-AC12-0AF2A5D8CE0D

Device         Start       End   Sectors  Size Type
/dev/sda1       2048    616447    614400  300M EFI System
/dev/sda2     616448   2713599   2097152    1G Linux filesystem
/dev/sda3    2713600 107571199 104857600   50G Linux filesystem
/dev/sda4  107571200 124348415  16777216    8G Linux swap
/dev/sda5  124348416 250068991 125720576   60G Linux filesystem

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index b8b6759..453ce42 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -761,7 +761,7 @@ void __init printk_all_partitions(void)
 			printk("%s%s %10llu %pg %s",
 			       bdev_is_partition(part) ? "  " : "",
 			       bdevt_str(part->bd_dev, devt_buf),
-			       bdev_nr_sectors(part) >> 1, part,
+			       bdev_nr_sectors(part), part,
 			       part->bd_meta_info ?
 					part->bd_meta_info->uuid : "");
 			if (bdev_is_partition(part))
-- 
2.1.0

