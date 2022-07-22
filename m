Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955657E899
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiGVUwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:52:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77E61738;
        Fri, 22 Jul 2022 13:52:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy29so10422839ejc.12;
        Fri, 22 Jul 2022 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7kAaiP6aRNtfZL0vbTnM6otziHNfeXxPpMIn5XWR8Uo=;
        b=acCoBp2+q1v+jnRU9z5bc8+5LKEYGXY7kFBLBno6mD804rpkGcRVB0AcWVL6oOLC70
         u807TcSlkiiU/5f6i08lmBgiTi8v8rH1ua3AIlwbNdvIEdK41KYKBbheYgHJShO5SDVV
         6xID+qEdettA6izrjglo9WaG20vxhoRjXwL2+bK2HcgvfhGsbs8qzliUiyHsn9YfzjIv
         3FfxMMIlpJS23Wt11hAPI/IyI2EuXQjlDZk36xhmGNsfB6dn2GNhChBkt8DnESL09BfQ
         /XBk7Jy6lIsdKwGPhBhDa/pVvRYw1Nbj+/cGBZlSYP6JhtC3DUu3Fe5E8nLn8+juJ0+G
         I5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7kAaiP6aRNtfZL0vbTnM6otziHNfeXxPpMIn5XWR8Uo=;
        b=LEYuXhTyWp1hNbvIC914hHpRXhlPi9/RdjOdt2/Cu60kHkfYQAj6beX+EcF6HRtrXD
         2IP0OpigrlnFTqGCWPkEpZPYZgFnggR3r/3w+3iOvDAjrodGnhQT2IohZn2TQJ7hEykj
         wFWAKhrAWKCAf4ss1TZjqZTCiwdSeykwZM8lK4qjhs1//fbPnwYWTJKR7dFj5uGiipg8
         JjzpzQtkwHdFOxlgAs3SWmADmnwNqU+t8mc2k36+WlaW9Vzm14iGCXZh5OB7tiVNVqTf
         AQtnOaGUXqtNP4Ke1yRC5JHXkTiBVwBNWCbiscIdLQur3aMOy709CUO1ngLUlG//q8sO
         1Atg==
X-Gm-Message-State: AJIora9Ip0CXjvELxLTUVc9dkY5ha/rImFVAXhGE/ZDWUgvPisfK7BDO
        Bcrp5W+cI5hBRoWNEd6pPqCbIjSLt2Mf+uWCg14=
X-Google-Smtp-Source: AGRyM1uYF7VbtcyrVO5kPpcj5DSRy3z1gp18nqjR+qptfou+vAlD7+atVr//GY3Afn8loWlwDTo/6QvqmjZGF1VNTjA=
X-Received: by 2002:a17:907:a056:b0:72b:1964:fbcc with SMTP id
 gz22-20020a170907a05600b0072b1964fbccmr1279571ejc.489.1658523132610; Fri, 22
 Jul 2022 13:52:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Fri, 22 Jul 2022 13:52:01 -0700
Message-ID: <CANX2M5aYK8_7Ygyh=co+bXTc4-Yoc96O2Z6avPooAn3uYbvoLw@mail.gmail.com>
Subject: KASAN: use-after-free Read in reiserfs_fill_super
To:     Matthew Wilcox <willy@infradead.org>,
        damien.lemoal@opensource.wdc.com, jlayton@kernel.org, jack@suse.cz,
        edward.shishkin@gmail.com, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002c0ea405e46b02c0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002c0ea405e46b02c0
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: KASAN: use-after-free Read in reiserfs_fill_super
affected file: fs/reiserfs/inode.c
kernel version: 5.19-rc6
kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
git tree: upstream
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
crash reproducer: attached
======================================================
Crash log:
======================================================
UG: KASAN: use-after-free in init_inode fs/reiserfs/inode.c:1325 [inline]
BUG: KASAN: use-after-free in reiserfs_read_locked_inode+0x1f9c/0x2300
fs/reiserfs/inode.c:1574
Read of size 4 at addr ffff88819f38c000 by task syz-executor.5/13593

CPU: 0 PID: 13593 Comm: syz-executor.5 Tainted: G           OE
5.19.0-rc6-g2eae0556bb9d #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:313 [inline]
 print_report.cold+0xe5/0x659 mm/kasan/report.c:429
 kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
 init_inode fs/reiserfs/inode.c:1325 [inline]
 reiserfs_read_locked_inode+0x1f9c/0x2300 fs/reiserfs/inode.c:1574
 reiserfs_fill_super+0x126c/0x2f10 fs/reiserfs/super.c:2073
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1228/0x1cb0 fs/namespace.c:3370
 do_mount+0xf3/0x110 fs/namespace.c:3383
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f4fe2e8fe8e
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4fe148b9f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f4fe2e8fe8e
RDX: 0000000020000040 RSI: 0000000020000100 RDI: 00007f4fe148ba50
RBP: 00007f4fe148ba90 R08: 00007f4fe148ba90 R09: 0000000020000040
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000040
R13: 0000000020000100 R14: 00007f4fe148ba50 R15: 0000000020011400
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00067ce300 refcount:0 mapcount:-128
mapping:0000000000000000 index:0x1 pfn:0x19f38c
flags: 0x17ff00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 017ff00000000000 ffffea000610d9c8 ffffea0006897b08 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask
0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 2972, tgid 2972
(systemd-udevd), ts 583268397100, free_ts 649857437696
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2449 [inline]
 prep_new_page+0x297/0x330 mm/page_alloc.c:2456
 get_page_from_freelist+0x2142/0x3c80 mm/page_alloc.c:4198
 __alloc_pages+0x321/0x710 mm/page_alloc.c:5426
 __folio_alloc+0x12/0x40 mm/page_alloc.c:5457
 vma_alloc_folio+0xf9/0x6e0 mm/mempolicy.c:2233
 alloc_page_vma include/linux/gfp.h:634 [inline]
 wp_page_copy+0x1f1/0x1d00 mm/memory.c:3104
 do_wp_page+0x52c/0x1840 mm/memory.c:3471
 handle_pte_fault mm/memory.c:4921 [inline]
 __handle_mm_fault+0x2a69/0x3ee0 mm/memory.c:5042
 handle_mm_fault+0x322/0xa80 mm/memory.c:5140
 do_user_addr_fault+0x489/0x11c0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1484 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1540
 asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x51f/0xd00 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page_list+0x15a/0xe90 mm/page_alloc.c:3475
 release_pages+0x10ea/0x2590 mm/swap.c:980
 tlb_batch_pages_flush mm/mmu_gather.c:58 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu+0xef/0x690 mm/mmu_gather.c:262
 tlb_finish_mmu+0x93/0x3c0 mm/mmu_gather.c:353
 exit_mmap+0x1de/0x4b0 mm/mmap.c:3164
 __mmput kernel/fork.c:1196 [inline]
 mmput+0x16b/0x430 kernel/fork.c:1217
 exit_mm kernel/exit.c:511 [inline]
 do_exit+0xa33/0x2dd0 kernel/exit.c:784
 do_group_exit+0xd2/0x2f0 kernel/exit.c:927
 __do_sys_exit_group kernel/exit.c:938 [inline]
 __se_sys_exit_group kernel/exit.c:936 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:936
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88819f38bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88819f38bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88819f38c000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88819f38c080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88819f38c100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

-- 
Thanks and Regards,

Dipanjan

--0000000000002c0ea405e46b02c0
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wxrw1g1>
X-Attachment-Id: f_l5wxrw1g1

c3l6X21vdW50X2ltYWdlJHJlaXNlcmZzKCYoMHg3ZjAwMDAwMDAwNDApLCAmKDB4N2YwMDAwMDAw
MTAwKT0nLi9maWxlMFx4MDAnLCAweDAsIDB4MywgJigweDdmMDAwMDAwMDIwMCk9W3smKDB4N2Yw
MDAwMDEwMDAwKT0iMDA0MDAwMDA2ODAyMDAwMDk3M2QwMDAwMTIwMDAwMDAwMDAwMDAwMDg0M2Qw
MDAwMDAwMTAwMDA2MTFjYWQ0OWUxMDAwMDAwMWUwMDAwMDAwMDAwMDAwMDAwMTBlYzAzMDIwMDAx
MDA1MjY1NDk3MzQ1NzIzMzQ2NzMwMDAwMDAwMjAwMDAwMDAyIiwgMHg0NSwgMHgxMDAwMH0sIHsm
KDB4N2YwMDAwMDExMTAwKT0iODAwMDAwMDMwMDIwMDAwMDAwMDAwMDAwMTIwMDAwMDAwMDAwMDAw
MDg0M2QwMDAwMDAwMTAwMDA2MTFjYWQ0OWUxIiwgMHgyMSwgMHgzZDk2MDAwfSwgeyYoMHg3ZjAw
MDAwMDAyODApPSIwMTAwMDIwMDc1MGYwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMTAwMDAwMDAyMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAyMDAwZTAwZjEwMDAwMTAwMDAw
MDAyMDAwMDAwMDEwMDAwMDBmNDAxMDAwMDAyMDAyMzAwYmQwZmY5MGI3MTg1ZjExYWM4MDkxMDhj
Nzc4ZDUxZTNlMDQzY2I0MjIwMjM2MTc0Yzc4YzQyYjE3OTViMzczY2NmNTUzN2ZhNmM4YjRjMWJh
YmQ3ZjFjY2YzNDgwNzU1NzUxYmM1MzBjOWE3ZmI3MjQxYmQ3M2NjMDI4MmFlMzNkYzFlOGQzNWUz
YjMwZjViZmZmMzNlMGMxMGJkYzMzNDExNmZiMzE5MzYyNjZkNzQ5MzY5ZWY1ZjQ2Mjg2NjMyYWVk
ZGE4NjgyMTc5ZDRkMjkwMDAwMDAwMDA4ZGJkNDRkZGM0YTFjNzVhYjc5YjViOTRkNjVjZDE5NTg4
NTU0MGQxYzAzZDY4NDAyMzJkZGRhODNkZDY3MGI2Mzc3ODc0ZDBmMTUxYTIxYjY4Mjc3NzliZjdi
MTBmZjg2MDdhNjU4Mzc3ZDkwMDAwMGNjYmJhYTdjNWU3MWJmMjFkODllMWUyNDZlYzFjOTg5NjY3
MjYwNDBiMzFhYzdmNTRjOTdhNjcxYjUzZjk5OTBkYWMxMWYwNzliZGE0ZGI1N2M5M2ZhMTAxZDlk
NTMzMTc0MGVmOWI5ZDY5YzMyOGEwZWFkZjI5YzhjNjNkZTI0OGM3OTU5MzI4MTUwZjE3YjljZjcy
IiwgMHgxMzQsIDB4M2Q5NzAwMH1dLCAweDAsICYoMHg3ZjAwMDAwMTE0MDApKQo=
--0000000000002c0ea405e46b02c0
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wxrw150>
X-Attachment-Id: f_l5wxrw150

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgojaW5jbHVkZSA8c3RkZGVmLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlv
Lmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lz
L2lvY3RsLmg+CiNpbmNsdWRlIDxzeXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgoj
aW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxz
eXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNs
dWRlIDx1bmlzdGQuaD4KCiNpbmNsdWRlIDxsaW51eC9sb29wLmg+CgojaWZuZGVmIF9fTlJfbWVt
ZmRfY3JlYXRlCiNkZWZpbmUgX19OUl9tZW1mZF9jcmVhdGUgMzE5CiNlbmRpZgoKc3RhdGljIHVu
c2lnbmVkIGxvbmcgbG9uZyBwcm9jaWQ7CgpzdGF0aWMgdm9pZCBzbGVlcF9tcyh1aW50NjRfdCBt
cykKewoJdXNsZWVwKG1zICogMTAwMCk7Cn0KCnN0YXRpYyB1aW50NjRfdCBjdXJyZW50X3RpbWVf
bXModm9pZCkKewoJc3RydWN0IHRpbWVzcGVjIHRzOwoJaWYgKGNsb2NrX2dldHRpbWUoQ0xPQ0tf
TU9OT1RPTklDLCAmdHMpKQoJZXhpdCgxKTsKCXJldHVybiAodWludDY0X3QpdHMudHZfc2VjICog
MTAwMCArICh1aW50NjRfdCl0cy50dl9uc2VjIC8gMTAwMDAwMDsKfQoKc3RhdGljIGJvb2wgd3Jp
dGVfZmlsZShjb25zdCBjaGFyKiBmaWxlLCBjb25zdCBjaGFyKiB3aGF0LCAuLi4pCnsKCWNoYXIg
YnVmWzEwMjRdOwoJdmFfbGlzdCBhcmdzOwoJdmFfc3RhcnQoYXJncywgd2hhdCk7Cgl2c25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgd2hhdCwgYXJncyk7Cgl2YV9lbmQoYXJncyk7CglidWZbc2l6
ZW9mKGJ1ZikgLSAxXSA9IDA7CglpbnQgbGVuID0gc3RybGVuKGJ1Zik7CglpbnQgZmQgPSBvcGVu
KGZpbGUsIE9fV1JPTkxZIHwgT19DTE9FWEVDKTsKCWlmIChmZCA9PSAtMSkKCQlyZXR1cm4gZmFs
c2U7CglpZiAod3JpdGUoZmQsIGJ1ZiwgbGVuKSAhPSBsZW4pIHsKCQlpbnQgZXJyID0gZXJybm87
CgkJY2xvc2UoZmQpOwoJCWVycm5vID0gZXJyOwoJCXJldHVybiBmYWxzZTsKCX0KCWNsb3NlKGZk
KTsKCXJldHVybiB0cnVlOwp9CgpzdHJ1Y3QgZnNfaW1hZ2Vfc2VnbWVudCB7Cgl2b2lkKiBkYXRh
OwoJdWludHB0cl90IHNpemU7Cgl1aW50cHRyX3Qgb2Zmc2V0Owp9OwoKI2RlZmluZSBJTUFHRV9N
QVhfU0VHTUVOVFMgNDA5NgojZGVmaW5lIElNQUdFX01BWF9TSVpFICgxMjkgPDwgMjApCgpzdGF0
aWMgdW5zaWduZWQgbG9uZyBmc19pbWFnZV9zZWdtZW50X2NoZWNrKHVuc2lnbmVkIGxvbmcgc2l6
ZSwgdW5zaWduZWQgbG9uZyBuc2Vncywgc3RydWN0IGZzX2ltYWdlX3NlZ21lbnQqIHNlZ3MpCnsK
CWlmIChuc2VncyA+IElNQUdFX01BWF9TRUdNRU5UUykKCQluc2VncyA9IElNQUdFX01BWF9TRUdN
RU5UUzsKCWZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbnNlZ3M7IGkrKykgewoJCWlmIChzZWdzW2ld
LnNpemUgPiBJTUFHRV9NQVhfU0laRSkKCQkJc2Vnc1tpXS5zaXplID0gSU1BR0VfTUFYX1NJWkU7
CgkJc2Vnc1tpXS5vZmZzZXQgJT0gSU1BR0VfTUFYX1NJWkU7CgkJaWYgKHNlZ3NbaV0ub2Zmc2V0
ID4gSU1BR0VfTUFYX1NJWkUgLSBzZWdzW2ldLnNpemUpCgkJCXNlZ3NbaV0ub2Zmc2V0ID0gSU1B
R0VfTUFYX1NJWkUgLSBzZWdzW2ldLnNpemU7CgkJaWYgKHNpemUgPCBzZWdzW2ldLm9mZnNldCAr
IHNlZ3NbaV0ub2Zmc2V0KQoJCQlzaXplID0gc2Vnc1tpXS5vZmZzZXQgKyBzZWdzW2ldLm9mZnNl
dDsKCX0KCWlmIChzaXplID4gSU1BR0VfTUFYX1NJWkUpCgkJc2l6ZSA9IElNQUdFX01BWF9TSVpF
OwoJcmV0dXJuIHNpemU7Cn0Kc3RhdGljIGludCBzZXR1cF9sb29wX2RldmljZShsb25nIHVuc2ln
bmVkIHNpemUsIGxvbmcgdW5zaWduZWQgbnNlZ3MsIHN0cnVjdCBmc19pbWFnZV9zZWdtZW50KiBz
ZWdzLCBjb25zdCBjaGFyKiBsb29wbmFtZSwgaW50KiBtZW1mZF9wLCBpbnQqIGxvb3BmZF9wKQp7
CglpbnQgZXJyID0gMCwgbG9vcGZkID0gLTE7CglzaXplID0gZnNfaW1hZ2Vfc2VnbWVudF9jaGVj
ayhzaXplLCBuc2Vncywgc2Vncyk7CglpbnQgbWVtZmQgPSBzeXNjYWxsKF9fTlJfbWVtZmRfY3Jl
YXRlLCAic3l6a2FsbGVyIiwgMCk7CglpZiAobWVtZmQgPT0gLTEpIHsKCQllcnIgPSBlcnJubzsK
CQlnb3RvIGVycm9yOwoJfQoJaWYgKGZ0cnVuY2F0ZShtZW1mZCwgc2l6ZSkpIHsKCQllcnIgPSBl
cnJubzsKCQlnb3RvIGVycm9yX2Nsb3NlX21lbWZkOwoJfQoJZm9yIChzaXplX3QgaSA9IDA7IGkg
PCBuc2VnczsgaSsrKSB7CgkJaWYgKHB3cml0ZShtZW1mZCwgc2Vnc1tpXS5kYXRhLCBzZWdzW2ld
LnNpemUsIHNlZ3NbaV0ub2Zmc2V0KSA8IDApIHsKCQl9Cgl9Cglsb29wZmQgPSBvcGVuKGxvb3Bu
YW1lLCBPX1JEV1IpOwoJaWYgKGxvb3BmZCA9PSAtMSkgewoJCWVyciA9IGVycm5vOwoJCWdvdG8g
ZXJyb3JfY2xvc2VfbWVtZmQ7Cgl9CglpZiAoaW9jdGwobG9vcGZkLCBMT09QX1NFVF9GRCwgbWVt
ZmQpKSB7CgkJaWYgKGVycm5vICE9IEVCVVNZKSB7CgkJCWVyciA9IGVycm5vOwoJCQlnb3RvIGVy
cm9yX2Nsb3NlX2xvb3A7CgkJfQoJCWlvY3RsKGxvb3BmZCwgTE9PUF9DTFJfRkQsIDApOwoJCXVz
bGVlcCgxMDAwKTsKCQlpZiAoaW9jdGwobG9vcGZkLCBMT09QX1NFVF9GRCwgbWVtZmQpKSB7CgkJ
CWVyciA9IGVycm5vOwoJCQlnb3RvIGVycm9yX2Nsb3NlX2xvb3A7CgkJfQoJfQoJKm1lbWZkX3Ag
PSBtZW1mZDsKCSpsb29wZmRfcCA9IGxvb3BmZDsKCXJldHVybiAwOwoKZXJyb3JfY2xvc2VfbG9v
cDoKCWNsb3NlKGxvb3BmZCk7CmVycm9yX2Nsb3NlX21lbWZkOgoJY2xvc2UobWVtZmQpOwplcnJv
cjoKCWVycm5vID0gZXJyOwoJcmV0dXJuIC0xOwp9CgpzdGF0aWMgbG9uZyBzeXpfbW91bnRfaW1h
Z2Uodm9sYXRpbGUgbG9uZyBmc2FyZywgdm9sYXRpbGUgbG9uZyBkaXIsIHZvbGF0aWxlIHVuc2ln
bmVkIGxvbmcgc2l6ZSwgdm9sYXRpbGUgdW5zaWduZWQgbG9uZyBuc2Vncywgdm9sYXRpbGUgbG9u
ZyBzZWdtZW50cywgdm9sYXRpbGUgbG9uZyBmbGFncywgdm9sYXRpbGUgbG9uZyBvcHRzYXJnKQp7
CglzdHJ1Y3QgZnNfaW1hZ2Vfc2VnbWVudCogc2VncyA9IChzdHJ1Y3QgZnNfaW1hZ2Vfc2VnbWVu
dCopc2VnbWVudHM7CglpbnQgcmVzID0gLTEsIGVyciA9IDAsIGxvb3BmZCA9IC0xLCBtZW1mZCA9
IC0xLCBuZWVkX2xvb3BfZGV2aWNlID0gISFzZWdzOwoJY2hhciogbW91bnRfb3B0cyA9IChjaGFy
KilvcHRzYXJnOwoJY2hhciogdGFyZ2V0ID0gKGNoYXIqKWRpcjsKCWNoYXIqIGZzID0gKGNoYXIq
KWZzYXJnOwoJY2hhciogc291cmNlID0gTlVMTDsKCWNoYXIgbG9vcG5hbWVbNjRdOwoJaWYgKG5l
ZWRfbG9vcF9kZXZpY2UpIHsKCQltZW1zZXQobG9vcG5hbWUsIDAsIHNpemVvZihsb29wbmFtZSkp
OwoJCXNucHJpbnRmKGxvb3BuYW1lLCBzaXplb2YobG9vcG5hbWUpLCAiL2Rldi9sb29wJWxsdSIs
IHByb2NpZCk7CgkJaWYgKHNldHVwX2xvb3BfZGV2aWNlKHNpemUsIG5zZWdzLCBzZWdzLCBsb29w
bmFtZSwgJm1lbWZkLCAmbG9vcGZkKSA9PSAtMSkKCQkJcmV0dXJuIC0xOwoJCXNvdXJjZSA9IGxv
b3BuYW1lOwoJfQoJbWtkaXIodGFyZ2V0LCAwNzc3KTsKCWNoYXIgb3B0c1syNTZdOwoJbWVtc2V0
KG9wdHMsIDAsIHNpemVvZihvcHRzKSk7CglpZiAoc3RybGVuKG1vdW50X29wdHMpID4gKHNpemVv
ZihvcHRzKSAtIDMyKSkgewoJfQoJc3RybmNweShvcHRzLCBtb3VudF9vcHRzLCBzaXplb2Yob3B0
cykgLSAzMik7CglpZiAoc3RyY21wKGZzLCAiaXNvOTY2MCIpID09IDApIHsKCQlmbGFncyB8PSBN
U19SRE9OTFk7Cgl9IGVsc2UgaWYgKHN0cm5jbXAoZnMsICJleHQiLCAzKSA9PSAwKSB7CgkJaWYg
KHN0cnN0cihvcHRzLCAiZXJyb3JzPXBhbmljIikgfHwgc3Ryc3RyKG9wdHMsICJlcnJvcnM9cmVt
b3VudC1ybyIpID09IDApCgkJCXN0cmNhdChvcHRzLCAiLGVycm9ycz1jb250aW51ZSIpOwoJfSBl
bHNlIGlmIChzdHJjbXAoZnMsICJ4ZnMiKSA9PSAwKSB7CgkJc3RyY2F0KG9wdHMsICIsbm91dWlk
Iik7Cgl9CglyZXMgPSBtb3VudChzb3VyY2UsIHRhcmdldCwgZnMsIGZsYWdzLCBvcHRzKTsKCWlm
IChyZXMgPT0gLTEpIHsKCQllcnIgPSBlcnJubzsKCQlnb3RvIGVycm9yX2NsZWFyX2xvb3A7Cgl9
CglyZXMgPSBvcGVuKHRhcmdldCwgT19SRE9OTFkgfCBPX0RJUkVDVE9SWSk7CglpZiAocmVzID09
IC0xKSB7CgkJZXJyID0gZXJybm87Cgl9CgplcnJvcl9jbGVhcl9sb29wOgoJaWYgKG5lZWRfbG9v
cF9kZXZpY2UpIHsKCQlpb2N0bChsb29wZmQsIExPT1BfQ0xSX0ZELCAwKTsKCQljbG9zZShsb29w
ZmQpOwoJCWNsb3NlKG1lbWZkKTsKCX0KCWVycm5vID0gZXJyOwoJcmV0dXJuIHJlczsKfQoKc3Rh
dGljIHZvaWQga2lsbF9hbmRfd2FpdChpbnQgcGlkLCBpbnQqIHN0YXR1cykKewoJa2lsbCgtcGlk
LCBTSUdLSUxMKTsKCWtpbGwocGlkLCBTSUdLSUxMKTsKCWZvciAoaW50IGkgPSAwOyBpIDwgMTAw
OyBpKyspIHsKCQlpZiAod2FpdHBpZCgtMSwgc3RhdHVzLCBXTk9IQU5HIHwgX19XQUxMKSA9PSBw
aWQpCgkJCXJldHVybjsKCQl1c2xlZXAoMTAwMCk7Cgl9CglESVIqIGRpciA9IG9wZW5kaXIoIi9z
eXMvZnMvZnVzZS9jb25uZWN0aW9ucyIpOwoJaWYgKGRpcikgewoJCWZvciAoOzspIHsKCQkJc3Ry
dWN0IGRpcmVudCogZW50ID0gcmVhZGRpcihkaXIpOwoJCQlpZiAoIWVudCkKCQkJCWJyZWFrOwoJ
CQlpZiAoc3RyY21wKGVudC0+ZF9uYW1lLCAiLiIpID09IDAgfHwgc3RyY21wKGVudC0+ZF9uYW1l
LCAiLi4iKSA9PSAwKQoJCQkJY29udGludWU7CgkJCWNoYXIgYWJvcnRbMzAwXTsKCQkJc25wcmlu
dGYoYWJvcnQsIHNpemVvZihhYm9ydCksICIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMvJXMvYWJv
cnQiLCBlbnQtPmRfbmFtZSk7CgkJCWludCBmZCA9IG9wZW4oYWJvcnQsIE9fV1JPTkxZKTsKCQkJ
aWYgKGZkID09IC0xKSB7CgkJCQljb250aW51ZTsKCQkJfQoJCQlpZiAod3JpdGUoZmQsIGFib3J0
LCAxKSA8IDApIHsKCQkJfQoJCQljbG9zZShmZCk7CgkJfQoJCWNsb3NlZGlyKGRpcik7Cgl9IGVs
c2UgewoJfQoJd2hpbGUgKHdhaXRwaWQoLTEsIHN0YXR1cywgX19XQUxMKSAhPSBwaWQpIHsKCX0K
fQoKc3RhdGljIHZvaWQgcmVzZXRfbG9vcCgpCnsKCWNoYXIgYnVmWzY0XTsKCXNucHJpbnRmKGJ1
Ziwgc2l6ZW9mKGJ1ZiksICIvZGV2L2xvb3AlbGx1IiwgcHJvY2lkKTsKCWludCBsb29wZmQgPSBv
cGVuKGJ1ZiwgT19SRFdSKTsKCWlmIChsb29wZmQgIT0gLTEpIHsKCQlpb2N0bChsb29wZmQsIExP
T1BfQ0xSX0ZELCAwKTsKCQljbG9zZShsb29wZmQpOwoJfQp9CgpzdGF0aWMgdm9pZCBzZXR1cF90
ZXN0KCkKewoJcHJjdGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7CglzZXRw
Z3JwKCk7Cgl3cml0ZV9maWxlKCIvcHJvYy9zZWxmL29vbV9zY29yZV9hZGoiLCAiMTAwMCIpOwp9
CgpzdGF0aWMgdm9pZCBleGVjdXRlX29uZSh2b2lkKTsKCiNkZWZpbmUgV0FJVF9GTEFHUyBfX1dB
TEwKCnN0YXRpYyB2b2lkIGxvb3Aodm9pZCkKewoJaW50IGl0ZXIgPSAwOwoJZm9yICg7OyBpdGVy
KyspIHsKCQlyZXNldF9sb29wKCk7CgkJaW50IHBpZCA9IGZvcmsoKTsKCQlpZiAocGlkIDwgMCkK
CWV4aXQoMSk7CgkJaWYgKHBpZCA9PSAwKSB7CgkJCXNldHVwX3Rlc3QoKTsKCQkJZXhlY3V0ZV9v
bmUoKTsKCQkJZXhpdCgwKTsKCQl9CgkJaW50IHN0YXR1cyA9IDA7CgkJdWludDY0X3Qgc3RhcnQg
PSBjdXJyZW50X3RpbWVfbXMoKTsKCQlmb3IgKDs7KSB7CgkJCWlmICh3YWl0cGlkKC0xLCAmc3Rh
dHVzLCBXTk9IQU5HIHwgV0FJVF9GTEFHUykgPT0gcGlkKQoJCQkJYnJlYWs7CgkJCXNsZWVwX21z
KDEpOwoJCQlpZiAoY3VycmVudF90aW1lX21zKCkgLSBzdGFydCA8IDUwMDApCgkJCQljb250aW51
ZTsKCQkJa2lsbF9hbmRfd2FpdChwaWQsICZzdGF0dXMpOwoJCQlicmVhazsKCQl9Cgl9Cn0KCnZv
aWQgZXhlY3V0ZV9vbmUodm9pZCkKewptZW1jcHkoKHZvaWQqKTB4MjAwMDAwNDAsICJyZWlzZXJm
c1wwMDAiLCA5KTsKbWVtY3B5KCh2b2lkKikweDIwMDAwMTAwLCAiLi9maWxlMFwwMDAiLCA4KTsK
Kih1aW50NjRfdCopMHgyMDAwMDIwMCA9IDB4MjAwMTAwMDA7Cm1lbWNweSgodm9pZCopMHgyMDAx
MDAwMCwgIlx4MDBceDQwXHgwMFx4MDBceDY4XHgwMlx4MDBceDAwXHg5N1x4M2RceDAwXHgwMFx4
MTJceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHg4NFx4M2RceDAwXHgwMFx4MDBceDAxXHgw
MFx4MDBceDYxXHgxY1x4YWRceDQ5XHhlMVx4MDBceDAwXHgwMFx4MWVceDAwXHgwMFx4MDBceDAw
XHgwMFx4MDBceDAwXHgwMFx4MTBceGVjXHgwM1x4MDJceDAwXHgwMVx4MDBceDUyXHg2NVx4NDlc
eDczXHg0NVx4NzJceDMzXHg0Nlx4NzNceDAwXHgwMFx4MDBceDAyXHgwMFx4MDBceDAwXHgwMiIs
IDY5KTsKKih1aW50NjRfdCopMHgyMDAwMDIwOCA9IDB4NDU7CioodWludDY0X3QqKTB4MjAwMDAy
MTAgPSAweDEwMDAwOwoqKHVpbnQ2NF90KikweDIwMDAwMjE4ID0gMHgyMDAxMTEwMDsKbWVtY3B5
KCh2b2lkKikweDIwMDExMTAwLCAiXHg4MFx4MDBceDAwXHgwM1x4MDBceDIwXHgwMFx4MDBceDAw
XHgwMFx4MDBceDAwXHgxMlx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDg0XHgzZFx4MDBc
eDAwXHgwMFx4MDFceDAwXHgwMFx4NjFceDFjXHhhZFx4NDlceGUxIiwgMzMpOwoqKHVpbnQ2NF90
KikweDIwMDAwMjIwID0gMHgyMTsKKih1aW50NjRfdCopMHgyMDAwMDIyOCA9IDB4M2Q5NjAwMDsK
Kih1aW50NjRfdCopMHgyMDAwMDIzMCA9IDB4MjAwMDAyODA7Cm1lbWNweSgodm9pZCopMHgyMDAw
MDI4MCwgIlx4MDFceDAwXHgwMlx4MDBceDc1XHgwZlx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4
MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDFceDAwXHgw
MFx4MDBceDAyXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAw
XHgwMFx4MjBceDAwXHhlMFx4MGZceDEwXHgwMFx4MDFceDAwXHgwMFx4MDBceDAyXHgwMFx4MDBc
eDAwXHgwMVx4MDBceDAwXHgwMFx4ZjRceDAxXHgwMFx4MDBceDAyXHgwMFx4MjNceDAwXHhiZFx4
MGZceGY5XHgwYlx4NzFceDg1XHhmMVx4MWFceGM4XHgwOVx4MTBceDhjXHg3N1x4OGRceDUxXHhl
M1x4ZTBceDQzXHhjYlx4NDJceDIwXHgyM1x4NjFceDc0XHhjN1x4OGNceDQyXHhiMVx4NzlceDVi
XHgzN1x4M2NceGNmXHg1NVx4MzdceGZhXHg2Y1x4OGJceDRjXHgxYlx4YWJceGQ3XHhmMVx4Y2Nc
eGYzXHg0OFx4MDdceDU1XHg3NVx4MWJceGM1XHgzMFx4YzlceGE3XHhmYlx4NzJceDQxXHhiZFx4
NzNceGNjXHgwMlx4ODJceGFlXHgzM1x4ZGNceDFlXHg4ZFx4MzVceGUzXHhiM1x4MGZceDViXHhm
Zlx4ZjNceDNlXHgwY1x4MTBceGJkXHhjM1x4MzRceDExXHg2Zlx4YjNceDE5XHgzNlx4MjZceDZk
XHg3NFx4OTNceDY5XHhlZlx4NWZceDQ2XHgyOFx4NjZceDMyXHhhZVx4ZGRceGE4XHg2OFx4MjFc
eDc5XHhkNFx4ZDJceDkwXHgwMFx4MDBceDAwXHgwMFx4OGRceGJkXHg0NFx4ZGRceGM0XHhhMVx4
YzdceDVhXHhiN1x4OWJceDViXHg5NFx4ZDZceDVjXHhkMVx4OTVceDg4XHg1NVx4NDBceGQxXHhj
MFx4M2RceDY4XHg0MFx4MjNceDJkXHhkZFx4YThceDNkXHhkNlx4NzBceGI2XHgzN1x4NzhceDc0
XHhkMFx4ZjFceDUxXHhhMlx4MWJceDY4XHgyN1x4NzdceDliXHhmN1x4YjFceDBmXHhmOFx4NjBc
eDdhXHg2NVx4ODNceDc3XHhkOVx4MDBceDAwXHgwY1x4Y2JceGJhXHhhN1x4YzVceGU3XHgxYlx4
ZjJceDFkXHg4OVx4ZTFceGUyXHg0Nlx4ZWNceDFjXHg5OFx4OTZceDY3XHgyNlx4MDRceDBiXHgz
MVx4YWNceDdmXHg1NFx4YzlceDdhXHg2N1x4MWJceDUzXHhmOVx4OTlceDBkXHhhY1x4MTFceGYw
XHg3OVx4YmRceGE0XHhkYlx4NTdceGM5XHgzZlx4YTFceDAxXHhkOVx4ZDVceDMzXHgxN1x4NDBc
eGVmXHg5Ylx4OWRceDY5XHhjM1x4MjhceGEwXHhlYVx4ZGZceDI5XHhjOFx4YzZceDNkXHhlMlx4
NDhceGM3XHg5NVx4OTNceDI4XHgxNVx4MGZceDE3XHhiOVx4Y2ZceDcyIiwgMzA4KTsKKih1aW50
NjRfdCopMHgyMDAwMDIzOCA9IDB4MTM0OwoqKHVpbnQ2NF90KikweDIwMDAwMjQwID0gMHgzZDk3
MDAwOwoqKHVpbnQ4X3QqKTB4MjAwMTE0MDAgPSAwOwpzeXpfbW91bnRfaW1hZ2UoMHgyMDAwMDA0
MCwgMHgyMDAwMDEwMCwgMCwgMywgMHgyMDAwMDIwMCwgMCwgMHgyMDAxMTQwMCk7Cgp9CmludCBt
YWluKHZvaWQpCnsKCQlzeXNjYWxsKF9fTlJfbW1hcCwgMHgxZmZmZjAwMHVsLCAweDEwMDB1bCwg
MHVsLCAweDMydWwsIC0xLCAwdWwpOwoJc3lzY2FsbChfX05SX21tYXAsIDB4MjAwMDAwMDB1bCwg
MHgxMDAwMDAwdWwsIDd1bCwgMHgzMnVsLCAtMSwgMHVsKTsKCXN5c2NhbGwoX19OUl9tbWFwLCAw
eDIxMDAwMDAwdWwsIDB4MTAwMHVsLCAwdWwsIDB4MzJ1bCwgLTEsIDB1bCk7CgkJCWxvb3AoKTsK
CXJldHVybiAwOwp9Cg==
--0000000000002c0ea405e46b02c0--
