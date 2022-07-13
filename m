Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AA573387
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiGMJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiGMJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:53:18 -0400
X-Greylist: delayed 1190 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 02:53:15 PDT
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F5F9937;
        Wed, 13 Jul 2022 02:53:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LjXTN0K6Nz6PCRS;
        Wed, 13 Jul 2022 17:32:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mlhkc5iALXVAg--.35543S4;
        Wed, 13 Jul 2022 17:33:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, zhangwensheng5@huawei.com, yi.zhang@huawei.com
Subject: [PATCH -next] [RFC] scsi: ses: fix slab-out-of-bounds in ses_enclosure_data_process
Date:   Wed, 13 Jul 2022 17:45:48 +0800
Message-Id: <20220713094548.3958915-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mlhkc5iALXVAg--.35543S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1UAFykGr15Kw1UZFW7CFg_yoWxGFy3pF
        sxGayxGr48J34UJF47Cr1kXF97ZF4DAa1UJryfWr15Z3W8Gw1xtryDJrWUGr17Krn5A3W7
        JwnrZ340qw18J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6r
        W3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Wensheng <zhangwensheng5@huawei.com>

Kasan report a bug like below:
[  494.865170] ==================================================================
[  494.901335] BUG: KASAN: slab-out-of-bounds in ses_enclosure_data_process+0x234/0x6f0 [ses]
[  494.901347] Write of size 1 at addr ffff8882f3181a70 by task systemd-udevd/1704
[  494.931929] i801_smbus 0000:00:1f.4: SPD Write Disable is set

[  494.944092] CPU: 12 PID: 1704 Comm: systemd-udevd Tainted: G
[  494.944101] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 7.01 11/13/2019
[  494.964003] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[  494.978532] Call Trace:
[  494.978544]  dump_stack+0xbe/0xf9
[  494.978558]  print_address_description.constprop.0+0x19/0x130
[  495.092838]  ? ses_enclosure_data_process+0x234/0x6f0 [ses]
[  495.092846]  __kasan_report.cold+0x68/0x80
[  495.092855]  ? __kasan_kmalloc.constprop.0+0x71/0xd0
[  495.092862]  ? ses_enclosure_data_process+0x234/0x6f0 [ses]
[  495.092868]  kasan_report+0x3a/0x50
[  495.092875]  ses_enclosure_data_process+0x234/0x6f0 [ses]
[  495.092882]  ? mutex_unlock+0x1d/0x40
[  495.092889]  ses_intf_add+0x57f/0x910 [ses]
[  495.092900]  class_interface_register+0x26d/0x290
[  495.092906]  ? class_destroy+0xd0/0xd0
[  495.092912]  ? 0xffffffffc0bf8000
[  495.092919]  ses_init+0x18/0x1000 [ses]
[  495.092927]  do_one_initcall+0xcb/0x370
[  495.092934]  ? initcall_blacklisted+0x1b0/0x1b0
[  495.092942]  ? create_object.isra.0+0x330/0x3a0
[  495.092950]  ? kasan_unpoison_shadow+0x33/0x40
[  495.092957]  ? kasan_unpoison_shadow+0x33/0x40
[  495.092966]  do_init_module+0xe4/0x3a0
[  495.092972]  load_module+0xd0a/0xdd0
[  495.092980]  ? layout_and_allocate+0x300/0x300
[  495.092989]  ? seccomp_run_filters+0x1d6/0x2c0
[  495.092999]  ? kernel_read_file_from_fd+0xb3/0xe0
[  495.093006]  __se_sys_finit_module+0x11b/0x1b0
[  495.093012]  ? __ia32_sys_init_module+0x40/0x40
[  495.093023]  ? __audit_syscall_entry+0x226/0x290
[  495.093032]  do_syscall_64+0x33/0x40
[  495.093041]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  495.093046] RIP: 0033:0x7f39c3376089
[  495.093054] Code: 00 48 81 c4 80 00 00 00 89 f0 c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 dd 0b 00 f7 d8 64 89 01 48
[  495.093058] RSP: 002b:00007ffdc6009e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  495.093068] RAX: ffffffffffffffda RBX: 000055d4192801c0 RCX: 00007f39c3376089
[  495.093072] RDX: 0000000000000000 RSI: 00007f39c2fae99d RDI: 000000000000000f
[  495.093076] RBP: 00007f39c2fae99d R08: 0000000000000000 R09: 0000000000000001
[  495.093080] R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000000
[  495.093084] R13: 000055d419282e00 R14: 0000000000020000 R15: 000055d41927f1f0

[  495.093091] Allocated by task 1704:
[  495.093098]  kasan_save_stack+0x1b/0x40
[  495.093105]  __kasan_kmalloc.constprop.0+0xc2/0xd0
[  495.093111]  ses_enclosure_data_process+0x65d/0x6f0 [ses]
[  495.093117]  ses_intf_add+0x57f/0x910 [ses]
[  495.093123]  class_interface_register+0x26d/0x290
[  495.093129]  ses_init+0x18/0x1000 [ses]
[  495.093134]  do_one_initcall+0xcb/0x370
[  495.093139]  do_init_module+0xe4/0x3a0
[  495.093144]  load_module+0xd0a/0xdd0
[  495.093150]  __se_sys_finit_module+0x11b/0x1b0
[  495.093155]  do_syscall_64+0x33/0x40
[  495.093162]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  495.093168] The buggy address belongs to the object at ffff8882f3181a40
                which belongs to the cache kmalloc-64 of size 64
[  495.093173] The buggy address is located 48 bytes inside of
                64-byte region [ffff8882f3181a40, ffff8882f3181a80)
[  495.093175] The buggy address belongs to the page:
[  495.093181] page:ffffea000bcc6000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f3180
[  495.093186] head:ffffea000bcc6000 order:2 compound_mapcount:0 compound_pincount:0
[  495.093194] flags: 0x17ffe0000010200(slab|head|node=0|zone=2|lastcpupid=0x3fff)
[  495.093204] raw: 017ffe0000010200 ffffea0016e5fb08 ffffea0016921508 ffff888100050e00
[  495.093211] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
[  495.093213] page dumped because: kasan: bad access detected

[  495.093216] Memory state around the buggy address:
[  495.093222]  ffff8882f3181900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  495.093227]  ffff8882f3181980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  495.093231] >ffff8882f3181a00: fc fc fc fc fc fc fc fc 00 00 00 00 01 fc fc fc
[  495.093234]                                                              ^
[  495.093239]  ffff8882f3181a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  495.093244]  ffff8882f3181b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  495.093246] ==================================================================

After analysis on vmcore, it was found that the line "desc_ptr[len] =
'\0';" has slab-out-of-bounds problem in ses_enclosure_data_process.
In ses_enclosure_data_process, "desc_ptr" point to "buf", so it have
to be limited in the memory of "buf", however. although there is
"desc_ptr >= buf + page7_len" judgment, it does not work because
"desc_ptr + 4 + len" may bigger than "buf + page7_len", which will
lead to slab-out-of-bounds problem.

Fix it by using judging desc_ptr cross the border or not after
"desc_ptr += 4".

Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 drivers/scsi/ses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0a1734f34587..981e6e950adc 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -559,11 +559,11 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 			struct enclosure_component *ecomp;
 
 			if (desc_ptr) {
+				len = (desc_ptr[2] << 8) + desc_ptr[3];
+				desc_ptr += 4;
 				if (desc_ptr >= buf + page7_len) {
 					desc_ptr = NULL;
 				} else {
-					len = (desc_ptr[2] << 8) + desc_ptr[3];
-					desc_ptr += 4;
 					/* Add trailing zero - pushes into
 					 * reserved space */
 					desc_ptr[len] = '\0';
-- 
2.31.1

