Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF85834D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiG0V3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG0V3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:29:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4A5F9A0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:28:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s9so3804577edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8FW5b1dp1sRdNeatGSAMcF8uH7fwV3D/tMqMm+pXGzE=;
        b=YMoGNHl8J2bXC00IyDxF/vk/8c3j4gp5OmLjDVJDFtzblOTQVGn5gIoAfxJMLhb5to
         JkAZjju4fmL336SuZuXxJN9HIZZjpxH/npoBFh/M7fzjp/5dUIQp5JRjOhxPVQa88L+n
         0QDwqFuDrmmx9QVm/9PAm6lKuDousvcfTPulbfxVxJhz6eGeO0usqtT+8XoV/R8MF4DC
         QxyFSttx1rIOU7Ct6y1CC2tcU3spws22kZPsCxHulqJwvA/COKF4EwPf/sN8FT9f18OS
         kXxXSdjDmRIaSN13uy4/Yeruy0lcwkS3kM0OSRIO0C9xY1ENlh8hpQ1p4elkzm4lZVfT
         cjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8FW5b1dp1sRdNeatGSAMcF8uH7fwV3D/tMqMm+pXGzE=;
        b=nib0wux5g4+YSwQhqMccCZywqERdb3ykcfdla8psqtqkjzl97gbYAd6wckt2ctSg5P
         04Pm8SyrK1OL2/bYdh0N6JLBJMFl5iCw0wWTX29+g+VOgJDUhhvtv14oIASi/d10qwxu
         xM+/C9Iny9amRGsqpwGhmYjDTAfgXEYSxld4GgD+5RNj4fzg5ZJoyP/Jl2UYkRkLjpUh
         NQ7pAbAkBaPRGROyR6G9Feo29SFUkUc3yno/SWqGTFmOIhNHJzBeM+/6d1jLKoCCwzUw
         INxXPZYvAkqOZsbp962A8/mI25F5wnMlH8rxNAng1mxlgWGLx9aYpOE6RlpwX0SD+h9V
         saHQ==
X-Gm-Message-State: AJIora/RpB5Lk2AG8WcGA+UR5k8G1poJP/RIOXIEcUsjvs7nNX/O4GlN
        Jcrkv4l0hhaWe1UaKbKWjIybrV/bMiDE+GHlaFo=
X-Google-Smtp-Source: AGRyM1vTzXM4yv3+pToQNe0MIx7yn14a7l7vLsLsWgh3LZLyrpMOErfOIPwFThdK4awxJ6J7U27tqQ+s0mLg9iUmtKs=
X-Received: by 2002:aa7:cac4:0:b0:43b:ddac:aa79 with SMTP id
 l4-20020aa7cac4000000b0043bddacaa79mr24256777edt.202.1658957337072; Wed, 27
 Jul 2022 14:28:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Wed, 27 Jul 2022 14:28:45 -0700
Message-ID: <CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com>
Subject: KASAN: use-after-free Read in post_one_notification
To:     dhowells@redhat.com, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org, fmdefrancesco@gmail.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="000000000000c63d2305e4d01ab2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c63d2305e4d01ab2
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: KASAN: use-after-free Read in post_one_notification
affected file: kernel/watch_queue.c
kernel version: 5.10.131
kernel commit: 8f95261a006489c828f1d909355669875649668b
git tree: upstream
kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
crash reproducer: attached
patch: This bug was previously reported by syzkaller for kernel
version 5.17. The same patch works for kernel version 5.10 as well,
i.e., we tested that the repro can no longer triggers the reported
crash with this patch:
https://syzkaller.appspot.com/text?tag=Patch&x=13b8c83c080000
======================================================
Crash log:
======================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3867/0x5840
kernel/locking/lockdep.c:4824
Read of size 8 at addr ffff8880aa5f8ca8 by task syz-executor.5/1878

CPU: 0 PID: 1878 Comm: syz-executor.5 Tainted: G           OE     5.10.131+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x4f7 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 __lock_acquire+0x3867/0x5840 kernel/locking/lockdep.c:4824
 lock_acquire kernel/locking/lockdep.c:5564 [inline]
 lock_acquire+0x1a8/0x4b0 kernel/locking/lockdep.c:5529
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:167
 spin_lock_irq include/linux/spinlock.h:379 [inline]
 post_one_notification+0x59/0x860 kernel/watch_queue.c:86
 __post_watch_notification kernel/watch_queue.c:206 [inline]
 __post_watch_notification+0x562/0x840 kernel/watch_queue.c:176
 post_watch_notification include/linux/watch_queue.h:109 [inline]
 notify_key security/keys/internal.h:199 [inline]
 __key_update security/keys/key.c:774 [inline]
 key_create_or_update+0xbff/0xd00 security/keys/key.c:977
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key security/keys/keyctl.c:74 [inline]
 __x64_sys_add_key+0x2ab/0x4b0 security/keys/keyctl.c:74
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fc85a2514ed
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc858201be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 00007fc85a36ff60 RCX: 00007fc85a2514ed
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007fc85a2bd2e1 R08: fffffffffffffffc R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffde3e9524f R14: 00007fc85a36ff60 R15: 00007fc858201d80

Allocated by task 1368:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
 kasan_set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:471
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:664 [inline]
 alloc_pipe_info+0x10c/0x500 fs/pipe.c:789
 get_pipe_inode fs/pipe.c:880 [inline]
 create_pipe_files+0x8f/0x7d0 fs/pipe.c:912
 __do_pipe_flags+0x41/0x240 fs/pipe.c:961
 do_pipe2+0x77/0x160 fs/pipe.c:1009
 __do_sys_pipe2 fs/pipe.c:1027 [inline]
 __se_sys_pipe2 fs/pipe.c:1025 [inline]
 __x64_sys_pipe2+0x50/0x70 fs/pipe.c:1025
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 1402:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:57
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:363
 __kasan_slab_free+0x111/0x150 mm/kasan/common.c:427
 slab_free_hook mm/slub.c:1542 [inline]
 slab_free_freelist_hook mm/slub.c:1576 [inline]
 slab_free mm/slub.c:3149 [inline]
 kfree+0xfa/0x460 mm/slub.c:4125
 put_pipe_info+0xb9/0xe0 fs/pipe.c:710
 pipe_release+0x1d2/0x260 fs/pipe.c:733
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xe0/0x1a0 kernel/task_work.c:151
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
 exit_to_user_mode_prepare+0x195/0x1b0 kernel/entry/common.c:191
 syscall_exit_to_user_mode+0x38/0x260 kernel/entry/common.c:266
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880aa5f8c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 168 bytes inside of
 512-byte region [ffff8880aa5f8c00, ffff8880aa5f8e00)
The buggy address belongs to the page:
page:000000000cd222be refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0xaa5f8
head:000000000cd222be order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888100041280
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880aa5f8b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880aa5f8c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880aa5f8c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880aa5f8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880aa5f8d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


-- 
Thanks and Regards,

Dipanjan

--000000000000c63d2305e4d01ab2
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l644atw50>
X-Attachment-Id: f_l644atw50

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5o
PgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5
cy9wcmN0bC5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+
CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0
aW1lLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpbmNsdWRlIDxsaW51eC9mdXRleC5oPgoKI2lm
bmRlZiBfX05SX2Nsb3NlX3JhbmdlCiNkZWZpbmUgX19OUl9jbG9zZV9yYW5nZSA0MzYKI2VuZGlm
CgpzdGF0aWMgdm9pZCBzbGVlcF9tcyh1aW50NjRfdCBtcykKewoJdXNsZWVwKG1zICogMTAwMCk7
Cn0KCnN0YXRpYyB1aW50NjRfdCBjdXJyZW50X3RpbWVfbXModm9pZCkKewoJc3RydWN0IHRpbWVz
cGVjIHRzOwoJaWYgKGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmdHMpKQoJZXhpdCgx
KTsKCXJldHVybiAodWludDY0X3QpdHMudHZfc2VjICogMTAwMCArICh1aW50NjRfdCl0cy50dl9u
c2VjIC8gMTAwMDAwMDsKfQoKc3RhdGljIHZvaWQgdGhyZWFkX3N0YXJ0KHZvaWQqICgqZm4pKHZv
aWQqKSwgdm9pZCogYXJnKQp7CglwdGhyZWFkX3QgdGg7CglwdGhyZWFkX2F0dHJfdCBhdHRyOwoJ
cHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOwoJcHRocmVhZF9hdHRyX3NldHN0YWNrc2l6ZSgmYXR0
ciwgMTI4IDw8IDEwKTsKCWludCBpID0gMDsKCWZvciAoOyBpIDwgMTAwOyBpKyspIHsKCQlpZiAo
cHRocmVhZF9jcmVhdGUoJnRoLCAmYXR0ciwgZm4sIGFyZykgPT0gMCkgewoJCQlwdGhyZWFkX2F0
dHJfZGVzdHJveSgmYXR0cik7CgkJCXJldHVybjsKCQl9CgkJaWYgKGVycm5vID09IEVBR0FJTikg
ewoJCQl1c2xlZXAoNTApOwoJCQljb250aW51ZTsKCQl9CgkJYnJlYWs7Cgl9CglleGl0KDEpOwp9
Cgp0eXBlZGVmIHN0cnVjdCB7CglpbnQgc3RhdGU7Cn0gZXZlbnRfdDsKCnN0YXRpYyB2b2lkIGV2
ZW50X2luaXQoZXZlbnRfdCogZXYpCnsKCWV2LT5zdGF0ZSA9IDA7Cn0KCnN0YXRpYyB2b2lkIGV2
ZW50X3Jlc2V0KGV2ZW50X3QqIGV2KQp7Cglldi0+c3RhdGUgPSAwOwp9CgpzdGF0aWMgdm9pZCBl
dmVudF9zZXQoZXZlbnRfdCogZXYpCnsKCWlmIChldi0+c3RhdGUpCglleGl0KDEpOwoJX19hdG9t
aWNfc3RvcmVfbigmZXYtPnN0YXRlLCAxLCBfX0FUT01JQ19SRUxFQVNFKTsKCXN5c2NhbGwoU1lT
X2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRFWF9XQUtFIHwgRlVURVhfUFJJVkFURV9GTEFHLCAxMDAw
MDAwKTsKfQoKc3RhdGljIHZvaWQgZXZlbnRfd2FpdChldmVudF90KiBldikKewoJd2hpbGUgKCFf
X2F0b21pY19sb2FkX24oJmV2LT5zdGF0ZSwgX19BVE9NSUNfQUNRVUlSRSkpCgkJc3lzY2FsbChT
WVNfZnV0ZXgsICZldi0+c3RhdGUsIEZVVEVYX1dBSVQgfCBGVVRFWF9QUklWQVRFX0ZMQUcsIDAs
IDApOwp9CgpzdGF0aWMgaW50IGV2ZW50X2lzc2V0KGV2ZW50X3QqIGV2KQp7CglyZXR1cm4gX19h
dG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRPTUlDX0FDUVVJUkUpOwp9CgpzdGF0aWMgaW50
IGV2ZW50X3RpbWVkd2FpdChldmVudF90KiBldiwgdWludDY0X3QgdGltZW91dCkKewoJdWludDY0
X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMoKTsKCXVpbnQ2NF90IG5vdyA9IHN0YXJ0OwoJZm9y
ICg7OykgewoJCXVpbnQ2NF90IHJlbWFpbiA9IHRpbWVvdXQgLSAobm93IC0gc3RhcnQpOwoJCXN0
cnVjdCB0aW1lc3BlYyB0czsKCQl0cy50dl9zZWMgPSByZW1haW4gLyAxMDAwOwoJCXRzLnR2X25z
ZWMgPSAocmVtYWluICUgMTAwMCkgKiAxMDAwICogMTAwMDsKCQlzeXNjYWxsKFNZU19mdXRleCwg
JmV2LT5zdGF0ZSwgRlVURVhfV0FJVCB8IEZVVEVYX1BSSVZBVEVfRkxBRywgMCwgJnRzKTsKCQlp
ZiAoX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRPTUlDX0FDUVVJUkUpKQoJCQlyZXR1
cm4gMTsKCQlub3cgPSBjdXJyZW50X3RpbWVfbXMoKTsKCQlpZiAobm93IC0gc3RhcnQgPiB0aW1l
b3V0KQoJCQlyZXR1cm4gMDsKCX0KfQoKc3RhdGljIGJvb2wgd3JpdGVfZmlsZShjb25zdCBjaGFy
KiBmaWxlLCBjb25zdCBjaGFyKiB3aGF0LCAuLi4pCnsKCWNoYXIgYnVmWzEwMjRdOwoJdmFfbGlz
dCBhcmdzOwoJdmFfc3RhcnQoYXJncywgd2hhdCk7Cgl2c25wcmludGYoYnVmLCBzaXplb2YoYnVm
KSwgd2hhdCwgYXJncyk7Cgl2YV9lbmQoYXJncyk7CglidWZbc2l6ZW9mKGJ1ZikgLSAxXSA9IDA7
CglpbnQgbGVuID0gc3RybGVuKGJ1Zik7CglpbnQgZmQgPSBvcGVuKGZpbGUsIE9fV1JPTkxZIHwg
T19DTE9FWEVDKTsKCWlmIChmZCA9PSAtMSkKCQlyZXR1cm4gZmFsc2U7CglpZiAod3JpdGUoZmQs
IGJ1ZiwgbGVuKSAhPSBsZW4pIHsKCQlpbnQgZXJyID0gZXJybm87CgkJY2xvc2UoZmQpOwoJCWVy
cm5vID0gZXJyOwoJCXJldHVybiBmYWxzZTsKCX0KCWNsb3NlKGZkKTsKCXJldHVybiB0cnVlOwp9
CgpzdGF0aWMgdm9pZCBraWxsX2FuZF93YWl0KGludCBwaWQsIGludCogc3RhdHVzKQp7CglraWxs
KC1waWQsIFNJR0tJTEwpOwoJa2lsbChwaWQsIFNJR0tJTEwpOwoJZm9yIChpbnQgaSA9IDA7IGkg
PCAxMDA7IGkrKykgewoJCWlmICh3YWl0cGlkKC0xLCBzdGF0dXMsIFdOT0hBTkcgfCBfX1dBTEwp
ID09IHBpZCkKCQkJcmV0dXJuOwoJCXVzbGVlcCgxMDAwKTsKCX0KCURJUiogZGlyID0gb3BlbmRp
cigiL3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25zIik7CglpZiAoZGlyKSB7CgkJZm9yICg7OykgewoJ
CQlzdHJ1Y3QgZGlyZW50KiBlbnQgPSByZWFkZGlyKGRpcik7CgkJCWlmICghZW50KQoJCQkJYnJl
YWs7CgkJCWlmIChzdHJjbXAoZW50LT5kX25hbWUsICIuIikgPT0gMCB8fCBzdHJjbXAoZW50LT5k
X25hbWUsICIuLiIpID09IDApCgkJCQljb250aW51ZTsKCQkJY2hhciBhYm9ydFszMDBdOwoJCQlz
bnByaW50ZihhYm9ydCwgc2l6ZW9mKGFib3J0KSwgIi9zeXMvZnMvZnVzZS9jb25uZWN0aW9ucy8l
cy9hYm9ydCIsIGVudC0+ZF9uYW1lKTsKCQkJaW50IGZkID0gb3BlbihhYm9ydCwgT19XUk9OTFkp
OwoJCQlpZiAoZmQgPT0gLTEpIHsKCQkJCWNvbnRpbnVlOwoJCQl9CgkJCWlmICh3cml0ZShmZCwg
YWJvcnQsIDEpIDwgMCkgewoJCQl9CgkJCWNsb3NlKGZkKTsKCQl9CgkJY2xvc2VkaXIoZGlyKTsK
CX0gZWxzZSB7Cgl9Cgl3aGlsZSAod2FpdHBpZCgtMSwgc3RhdHVzLCBfX1dBTEwpICE9IHBpZCkg
ewoJfQp9CgpzdGF0aWMgdm9pZCBzZXR1cF90ZXN0KCkKewoJcHJjdGwoUFJfU0VUX1BERUFUSFNJ
RywgU0lHS0lMTCwgMCwgMCwgMCk7CglzZXRwZ3JwKCk7Cgl3cml0ZV9maWxlKCIvcHJvYy9zZWxm
L29vbV9zY29yZV9hZGoiLCAiMTAwMCIpOwp9CgpzdHJ1Y3QgdGhyZWFkX3QgewoJaW50IGNyZWF0
ZWQsIGNhbGw7CglldmVudF90IHJlYWR5LCBkb25lOwp9OwoKc3RhdGljIHN0cnVjdCB0aHJlYWRf
dCB0aHJlYWRzWzE2XTsKc3RhdGljIHZvaWQgZXhlY3V0ZV9jYWxsKGludCBjYWxsKTsKc3RhdGlj
IGludCBydW5uaW5nOwoKc3RhdGljIHZvaWQqIHRocih2b2lkKiBhcmcpCnsKCXN0cnVjdCB0aHJl
YWRfdCogdGggPSAoc3RydWN0IHRocmVhZF90Kilhcmc7Cglmb3IgKDs7KSB7CgkJZXZlbnRfd2Fp
dCgmdGgtPnJlYWR5KTsKCQlldmVudF9yZXNldCgmdGgtPnJlYWR5KTsKCQlleGVjdXRlX2NhbGwo
dGgtPmNhbGwpOwoJCV9fYXRvbWljX2ZldGNoX3N1YigmcnVubmluZywgMSwgX19BVE9NSUNfUkVM
QVhFRCk7CgkJZXZlbnRfc2V0KCZ0aC0+ZG9uZSk7Cgl9CglyZXR1cm4gMDsKfQoKc3RhdGljIHZv
aWQgZXhlY3V0ZV9vbmUodm9pZCkKewoJaW50IGksIGNhbGwsIHRocmVhZDsKCWZvciAoY2FsbCA9
IDA7IGNhbGwgPCA1OyBjYWxsKyspIHsKCQlmb3IgKHRocmVhZCA9IDA7IHRocmVhZCA8IChpbnQp
KHNpemVvZih0aHJlYWRzKSAvIHNpemVvZih0aHJlYWRzWzBdKSk7IHRocmVhZCsrKSB7CgkJCXN0
cnVjdCB0aHJlYWRfdCogdGggPSAmdGhyZWFkc1t0aHJlYWRdOwoJCQlpZiAoIXRoLT5jcmVhdGVk
KSB7CgkJCQl0aC0+Y3JlYXRlZCA9IDE7CgkJCQlldmVudF9pbml0KCZ0aC0+cmVhZHkpOwoJCQkJ
ZXZlbnRfaW5pdCgmdGgtPmRvbmUpOwoJCQkJZXZlbnRfc2V0KCZ0aC0+ZG9uZSk7CgkJCQl0aHJl
YWRfc3RhcnQodGhyLCB0aCk7CgkJCX0KCQkJaWYgKCFldmVudF9pc3NldCgmdGgtPmRvbmUpKQoJ
CQkJY29udGludWU7CgkJCWV2ZW50X3Jlc2V0KCZ0aC0+ZG9uZSk7CgkJCXRoLT5jYWxsID0gY2Fs
bDsKCQkJX19hdG9taWNfZmV0Y2hfYWRkKCZydW5uaW5nLCAxLCBfX0FUT01JQ19SRUxBWEVEKTsK
CQkJZXZlbnRfc2V0KCZ0aC0+cmVhZHkpOwoJCQlpZiAoY2FsbCA9PSAzKQoJCQkJYnJlYWs7CgkJ
CWV2ZW50X3RpbWVkd2FpdCgmdGgtPmRvbmUsIDUwKTsKCQkJYnJlYWs7CgkJfQoJfQoJZm9yIChp
ID0gMDsgaSA8IDEwMCAmJiBfX2F0b21pY19sb2FkX24oJnJ1bm5pbmcsIF9fQVRPTUlDX1JFTEFY
RUQpOyBpKyspCgkJc2xlZXBfbXMoMSk7Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1dGVfb25lKHZvaWQp
OwoKI2RlZmluZSBXQUlUX0ZMQUdTIF9fV0FMTAoKc3RhdGljIHZvaWQgbG9vcCh2b2lkKQp7Cglp
bnQgaXRlciA9IDA7Cglmb3IgKDs7IGl0ZXIrKykgewoJCWludCBwaWQgPSBmb3JrKCk7CgkJaWYg
KHBpZCA8IDApCglleGl0KDEpOwoJCWlmIChwaWQgPT0gMCkgewoJCQlzZXR1cF90ZXN0KCk7CgkJ
CWV4ZWN1dGVfb25lKCk7CgkJCWV4aXQoMCk7CgkJfQoJCWludCBzdGF0dXMgPSAwOwoJCXVpbnQ2
NF90IHN0YXJ0ID0gY3VycmVudF90aW1lX21zKCk7CgkJZm9yICg7OykgewoJCQlpZiAod2FpdHBp
ZCgtMSwgJnN0YXR1cywgV05PSEFORyB8IFdBSVRfRkxBR1MpID09IHBpZCkKCQkJCWJyZWFrOwoJ
CQlzbGVlcF9tcygxKTsKCQkJaWYgKGN1cnJlbnRfdGltZV9tcygpIC0gc3RhcnQgPCA1MDAwKQoJ
CQkJY29udGludWU7CgkJCWtpbGxfYW5kX3dhaXQocGlkLCAmc3RhdHVzKTsKCQkJYnJlYWs7CgkJ
fQoJfQp9Cgp1aW50NjRfdCByWzJdID0gezB4ZmZmZmZmZmZmZmZmZmZmZiwgMHgwfTsKCnZvaWQg
ZXhlY3V0ZV9jYWxsKGludCBjYWxsKQp7CgkJaW50cHRyX3QgcmVzID0gMDsKCXN3aXRjaCAoY2Fs
bCkgewoJY2FzZSAwOgoJCXJlcyA9IHN5c2NhbGwoX19OUl9waXBlMiwgMHgyMDAwMDE0MHVsLCAw
eDgwdWwpOwoJCWlmIChyZXMgIT0gLTEpCnJbMF0gPSAqKHVpbnQzMl90KikweDIwMDAwMTQwOwoJ
CWJyZWFrOwoJY2FzZSAxOgptZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAsICJiaWdfa2V5XDAwMCIs
IDgpOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwNDAsICJzeXoiLCAzKTsKKih1aW50OF90KikweDIw
MDAwMDQzID0gMHgyMTsKKih1aW50OF90KikweDIwMDAwMDQ0ID0gMDsKbWVtc2V0KCh2b2lkKikw
eDIwMDAwMDgwLCA2NCwgMSk7CgkJcmVzID0gc3lzY2FsbChfX05SX2FkZF9rZXksIDB4MjAwMDAw
MDB1bCwgMHgyMDAwMDA0MHVsLCAweDIwMDAwMDgwdWwsIDF1bCwgMHhmZmZmZmZmYyk7CgkJaWYg
KHJlcyAhPSAtMSkKCQkJCXJbMV0gPSByZXM7CgkJYnJlYWs7CgljYXNlIDI6CgkJc3lzY2FsbChf
X05SX3BpcGUyLCAwdWwsIDB4ODB1bCk7CgkJYnJlYWs7CgljYXNlIDM6CgkJc3lzY2FsbChfX05S
X2tleWN0bCwgMHgyMHVsLCByWzFdLCByWzBdLCAwdWwsIDApOwoJCWJyZWFrOwoJY2FzZSA0OgoJ
CXN5c2NhbGwoX19OUl9jbG9zZV9yYW5nZSwgclswXSwgLTEsIDB1bCk7CgkJYnJlYWs7Cgl9Cgp9
CmludCBtYWluKHZvaWQpCnsKCQlzeXNjYWxsKF9fTlJfbW1hcCwgMHgxZmZmZjAwMHVsLCAweDEw
MDB1bCwgMHVsLCAweDMydWwsIC0xLCAwdWwpOwoJc3lzY2FsbChfX05SX21tYXAsIDB4MjAwMDAw
MDB1bCwgMHgxMDAwMDAwdWwsIDd1bCwgMHgzMnVsLCAtMSwgMHVsKTsKCXN5c2NhbGwoX19OUl9t
bWFwLCAweDIxMDAwMDAwdWwsIDB4MTAwMHVsLCAwdWwsIDB4MzJ1bCwgLTEsIDB1bCk7CgkJCWxv
b3AoKTsKCXJldHVybiAwOwp9Cg==
--000000000000c63d2305e4d01ab2
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l644atwh1>
X-Attachment-Id: f_l644atwh1

cGlwZTIkd2F0Y2hfcXVldWUoJigweDdmMDAwMDAwMDE0MCk9ezxyMD0+MHhmZmZmZmZmZmZmZmZm
ZmZmfSwgMHg4MCkKcjEgPSBhZGRfa2V5KCYoMHg3ZjAwMDAwMDAwMDApPSdiaWdfa2V5XHgwMCcs
ICYoMHg3ZjAwMDAwMDAwNDApPXsnc3l6JywgMHgxfSwgJigweDdmMDAwMDAwMDA4MCk9J0AnLCAw
eDEsIDB4ZmZmZmZmZmZmZmZmZmZmYykKcGlwZTIkd2F0Y2hfcXVldWUoMHgwLCAweDgwKQprZXlj
dGwkS0VZQ1RMX1dBVENIX0tFWSgweDIwLCByMSwgcjAsIDB4MCkgKGFzeW5jKQpjbG9zZV9yYW5n
ZShyMCwgMHhmZmZmZmZmZmZmZmZmZmZmLCAweDApCg==
--000000000000c63d2305e4d01ab2--
