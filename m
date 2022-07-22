Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0C57E87B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiGVUlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiGVUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:40:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B9193C1;
        Fri, 22 Jul 2022 13:40:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so10486095ejr.5;
        Fri, 22 Jul 2022 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Wl5gR5vAHlXiQGvKoe9EFXSn+yArqUhIBdK+xeI6k/M=;
        b=Lz9uJrdxJEztDateAo2xQ+agvqiJTi4lZnSKk/QSJuF5521OYK3I1DG4mvz491goVx
         /rf6//NUYX0eUOYlJTd/FwdkHz7ycQMSjyahbTePTx4/hik7KMw0XukxExbYqwX5f/wU
         SQlPQC+7i0ZdoYy593o74U4452LXHHiicEbEAnDJrqZhwvIPfdaLgDuBcJWO9vYPcF1f
         CPMFEwkfH2jz6GAS4ZJnx++VH+lQvi7HgWHTPChi8VZVdY1KZA410mxVKfZDrYuSJ58u
         o5dpikscTjN2s/5nlMiOl7pOm8OWw0GpRXNTlfO29KLJBWP6cL/vKg5qVa+IoFtna6YN
         irVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Wl5gR5vAHlXiQGvKoe9EFXSn+yArqUhIBdK+xeI6k/M=;
        b=DsShzCWOR2W51wNmgh8woUtSFJvFuE8qGOMxcYoum+TkGZo0TqbVgPL4C67kHIOobV
         NLc1cuGnfWCzoC9DOWhOlhePtCUszDw0EexMVHBrPUWtQ7AvHMdw2nZfI5abQlZbWib/
         nZ0YBbnEDLwhPA2OTTLYTWZ7G2U1NCOpipUyh+Gt7fIXOgOlOBataQ3HR1YDmGJHL3Ao
         sD9DOLXOt+ZeYPEapFHE4M0NK1XzrBVP7IUN+pM2BURwC2hZ4+jcG1AuX/zAo08qhheP
         t7DBF2KKfHz+5hKinszyCThegg4pttEfeok8sJTFQIfP1jCYXzqr78D7PngKf39COonn
         kfAw==
X-Gm-Message-State: AJIora/r2zMz4AmjLaluwm8xArXNN84opL/o81eTzjUSJ66VEk0ULhuI
        m3JTMOhRqS781q6zW84IFgEN/Md3jXNZUMz+Kv0bfqXJ6tcXc3Jv
X-Google-Smtp-Source: AGRyM1vuMbzYjd/ZeNFNGJRiOka9TmLlc04Mn1YH3+LwnkSXAEpdUhVk6YaIEmIuGllQIU76M1HeJlXsZnDeJLX9aUA=
X-Received: by 2002:a17:906:9be4:b0:72b:cf9:99d8 with SMTP id
 de36-20020a1709069be400b0072b0cf999d8mr1218367ejc.747.1658522455547; Fri, 22
 Jul 2022 13:40:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Fri, 22 Jul 2022 13:40:44 -0700
Message-ID: <CANX2M5ZGXGq0UV=Ycv8JpserFwP4BNkf2zEgLxrAoh0wjWGWTw@mail.gmail.com>
Subject: general protection fault in start_motor
To:     efremov@linux.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d0e73005e46ad9bf"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d0e73005e46ad9bf
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: general protection fault in start_motor
affected file: drivers/block/floppy.c
kernel version: 5.10.131
kernel commit: de62055f423f5dcb548f74cebd68f03c8903f73a
git tree: upstream
kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
crash reproducer: attached
======================================================
Crash log:
======================================================
general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8820 Comm: kworker/u4:48 Tainted: G           OE     5.10.131+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: floppy fd_timer_workfn
RIP: 0010:start_motor+0x3a/0x3f0 drivers/block/floppy.c:1905
Code: 08 e8 4a 15 1c fd 48 8b 1d 03 30 4d 0b 48 b8 00 00 00 00 00 fc
ff df 0f b6 2d 72 22 4d 0b 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6
04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e be 02 00
RSP: 0018:ffffc90000a47cc0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff845483d6 RDI: ffffffff84549f90
RBP: 0000000000000000 R08: ffff88803a2b1ac0 R09: fffffbfff19dad22
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff84549f90
R13: 0000000000000000 R14: ffff88810c148000 R15: ffff888100069800
FS:  0000000000000000(0000) GS:ffff88811a000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fb22000 CR3: 000000002daa9001 CR4: 0000000000170ef0
Call Trace:
 floppy_ready+0x7f/0x1950 drivers/block/floppy.c:1932
 process_one_work+0x953/0x15c0 kernel/workqueue.c:2279
 worker_thread+0x96/0xe20 kernel/workqueue.c:2425
 kthread+0x374/0x490 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in: uio_ivshmem(OE) uio(E)
---[ end trace 345300e45e5eb538 ]---
RIP: 0010:start_motor+0x3a/0x3f0 drivers/block/floppy.c:1905
Code: 08 e8 4a 15 1c fd 48 8b 1d 03 30 4d 0b 48 b8 00 00 00 00 00 fc
ff df 0f b6 2d 72 22 4d 0b 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6
04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e be 02 00
RSP: 0018:ffffc90000a47cc0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff845483d6 RDI: ffffffff84549f90
RBP: 0000000000000000 R08: ffff88803a2b1ac0 R09: fffffbfff19dad22
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff84549f90
R13: 0000000000000000 R14: ffff88810c148000 R15: ffff888100069800
FS:  0000000000000000(0000) GS:ffff88811a000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fee2b352038 CR3: 00000000425db005 CR4: 0000000000170ef0
----------------
Code disassembly (best guess):
   0: 08 e8                or     %ch,%al
   2: 4a 15 1c fd 48 8b    rex.WX adc $0xffffffff8b48fd1c,%rax
   8: 1d 03 30 4d 0b        sbb    $0xb4d3003,%eax
   d: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  14: fc ff df
  17: 0f b6 2d 72 22 4d 0b movzbl 0xb4d2272(%rip),%ebp        # 0xb4d2290
  1e: 48 89 da              mov    %rbx,%rdx
  21: 48 c1 ea 03          shr    $0x3,%rdx
  25: 89 e9                mov    %ebp,%ecx
  27: 41 89 ed              mov    %ebp,%r13d
* 2a: 0f b6 04 02          movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e: 83 e1 03              and    $0x3,%ecx
  31: 41 83 e5 03          and    $0x3,%r13d
  35: 84 c0                test   %al,%al
  37: 74 08                je     0x41
  39: 3c 03                cmp    $0x3,%al
  3b: 0f                    .byte 0xf
  3c: 8e                    .byte 0x8e
  3d: be                    .byte 0xbe
  3e: 02 00                add    (%rax),%al

-- 
Thanks and Regards,

Dipanjan

--000000000000d0e73005e46ad9bf
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wxehxo0>
X-Attachment-Id: f_l5wxehxo0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5o
PgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5
cy9wcmN0bC5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+
CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0
aW1lLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpbmNsdWRlIDxsaW51eC9mdXRleC5oPgoKc3Rh
dGljIHVuc2lnbmVkIGxvbmcgbG9uZyBwcm9jaWQ7CgpzdGF0aWMgdm9pZCBzbGVlcF9tcyh1aW50
NjRfdCBtcykKewoJdXNsZWVwKG1zICogMTAwMCk7Cn0KCnN0YXRpYyB1aW50NjRfdCBjdXJyZW50
X3RpbWVfbXModm9pZCkKewoJc3RydWN0IHRpbWVzcGVjIHRzOwoJaWYgKGNsb2NrX2dldHRpbWUo
Q0xPQ0tfTU9OT1RPTklDLCAmdHMpKQoJZXhpdCgxKTsKCXJldHVybiAodWludDY0X3QpdHMudHZf
c2VjICogMTAwMCArICh1aW50NjRfdCl0cy50dl9uc2VjIC8gMTAwMDAwMDsKfQoKc3RhdGljIHZv
aWQgdGhyZWFkX3N0YXJ0KHZvaWQqICgqZm4pKHZvaWQqKSwgdm9pZCogYXJnKQp7CglwdGhyZWFk
X3QgdGg7CglwdGhyZWFkX2F0dHJfdCBhdHRyOwoJcHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOwoJ
cHRocmVhZF9hdHRyX3NldHN0YWNrc2l6ZSgmYXR0ciwgMTI4IDw8IDEwKTsKCWludCBpID0gMDsK
CWZvciAoOyBpIDwgMTAwOyBpKyspIHsKCQlpZiAocHRocmVhZF9jcmVhdGUoJnRoLCAmYXR0ciwg
Zm4sIGFyZykgPT0gMCkgewoJCQlwdGhyZWFkX2F0dHJfZGVzdHJveSgmYXR0cik7CgkJCXJldHVy
bjsKCQl9CgkJaWYgKGVycm5vID09IEVBR0FJTikgewoJCQl1c2xlZXAoNTApOwoJCQljb250aW51
ZTsKCQl9CgkJYnJlYWs7Cgl9CglleGl0KDEpOwp9Cgp0eXBlZGVmIHN0cnVjdCB7CglpbnQgc3Rh
dGU7Cn0gZXZlbnRfdDsKCnN0YXRpYyB2b2lkIGV2ZW50X2luaXQoZXZlbnRfdCogZXYpCnsKCWV2
LT5zdGF0ZSA9IDA7Cn0KCnN0YXRpYyB2b2lkIGV2ZW50X3Jlc2V0KGV2ZW50X3QqIGV2KQp7Cgll
di0+c3RhdGUgPSAwOwp9CgpzdGF0aWMgdm9pZCBldmVudF9zZXQoZXZlbnRfdCogZXYpCnsKCWlm
IChldi0+c3RhdGUpCglleGl0KDEpOwoJX19hdG9taWNfc3RvcmVfbigmZXYtPnN0YXRlLCAxLCBf
X0FUT01JQ19SRUxFQVNFKTsKCXN5c2NhbGwoU1lTX2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRFWF9X
QUtFIHwgRlVURVhfUFJJVkFURV9GTEFHLCAxMDAwMDAwKTsKfQoKc3RhdGljIHZvaWQgZXZlbnRf
d2FpdChldmVudF90KiBldikKewoJd2hpbGUgKCFfX2F0b21pY19sb2FkX24oJmV2LT5zdGF0ZSwg
X19BVE9NSUNfQUNRVUlSRSkpCgkJc3lzY2FsbChTWVNfZnV0ZXgsICZldi0+c3RhdGUsIEZVVEVY
X1dBSVQgfCBGVVRFWF9QUklWQVRFX0ZMQUcsIDAsIDApOwp9CgpzdGF0aWMgaW50IGV2ZW50X2lz
c2V0KGV2ZW50X3QqIGV2KQp7CglyZXR1cm4gX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9f
QVRPTUlDX0FDUVVJUkUpOwp9CgpzdGF0aWMgaW50IGV2ZW50X3RpbWVkd2FpdChldmVudF90KiBl
diwgdWludDY0X3QgdGltZW91dCkKewoJdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMo
KTsKCXVpbnQ2NF90IG5vdyA9IHN0YXJ0OwoJZm9yICg7OykgewoJCXVpbnQ2NF90IHJlbWFpbiA9
IHRpbWVvdXQgLSAobm93IC0gc3RhcnQpOwoJCXN0cnVjdCB0aW1lc3BlYyB0czsKCQl0cy50dl9z
ZWMgPSByZW1haW4gLyAxMDAwOwoJCXRzLnR2X25zZWMgPSAocmVtYWluICUgMTAwMCkgKiAxMDAw
ICogMTAwMDsKCQlzeXNjYWxsKFNZU19mdXRleCwgJmV2LT5zdGF0ZSwgRlVURVhfV0FJVCB8IEZV
VEVYX1BSSVZBVEVfRkxBRywgMCwgJnRzKTsKCQlpZiAoX19hdG9taWNfbG9hZF9uKCZldi0+c3Rh
dGUsIF9fQVRPTUlDX0FDUVVJUkUpKQoJCQlyZXR1cm4gMTsKCQlub3cgPSBjdXJyZW50X3RpbWVf
bXMoKTsKCQlpZiAobm93IC0gc3RhcnQgPiB0aW1lb3V0KQoJCQlyZXR1cm4gMDsKCX0KfQoKc3Rh
dGljIGJvb2wgd3JpdGVfZmlsZShjb25zdCBjaGFyKiBmaWxlLCBjb25zdCBjaGFyKiB3aGF0LCAu
Li4pCnsKCWNoYXIgYnVmWzEwMjRdOwoJdmFfbGlzdCBhcmdzOwoJdmFfc3RhcnQoYXJncywgd2hh
dCk7Cgl2c25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgd2hhdCwgYXJncyk7Cgl2YV9lbmQoYXJn
cyk7CglidWZbc2l6ZW9mKGJ1ZikgLSAxXSA9IDA7CglpbnQgbGVuID0gc3RybGVuKGJ1Zik7Cglp
bnQgZmQgPSBvcGVuKGZpbGUsIE9fV1JPTkxZIHwgT19DTE9FWEVDKTsKCWlmIChmZCA9PSAtMSkK
CQlyZXR1cm4gZmFsc2U7CglpZiAod3JpdGUoZmQsIGJ1ZiwgbGVuKSAhPSBsZW4pIHsKCQlpbnQg
ZXJyID0gZXJybm87CgkJY2xvc2UoZmQpOwoJCWVycm5vID0gZXJyOwoJCXJldHVybiBmYWxzZTsK
CX0KCWNsb3NlKGZkKTsKCXJldHVybiB0cnVlOwp9CgpzdGF0aWMgbG9uZyBzeXpfb3Blbl9kZXYo
dm9sYXRpbGUgbG9uZyBhMCwgdm9sYXRpbGUgbG9uZyBhMSwgdm9sYXRpbGUgbG9uZyBhMikKewoJ
aWYgKGEwID09IDB4YyB8fCBhMCA9PSAweGIpIHsKCQljaGFyIGJ1ZlsxMjhdOwoJCXNwcmludGYo
YnVmLCAiL2Rldi8lcy8lZDolZCIsIGEwID09IDB4YyA/ICJjaGFyIiA6ICJibG9jayIsICh1aW50
OF90KWExLCAodWludDhfdClhMik7CgkJcmV0dXJuIG9wZW4oYnVmLCBPX1JEV1IsIDApOwoJfSBl
bHNlIHsKCQljaGFyIGJ1ZlsxMDI0XTsKCQljaGFyKiBoYXNoOwoJCXN0cm5jcHkoYnVmLCAoY2hh
ciopYTAsIHNpemVvZihidWYpIC0gMSk7CgkJYnVmW3NpemVvZihidWYpIC0gMV0gPSAwOwoJCXdo
aWxlICgoaGFzaCA9IHN0cmNocihidWYsICcjJykpKSB7CgkJCSpoYXNoID0gJzAnICsgKGNoYXIp
KGExICUgMTApOwoJCQlhMSAvPSAxMDsKCQl9CgkJcmV0dXJuIG9wZW4oYnVmLCBhMiwgMCk7Cgl9
Cn0KCnN0YXRpYyB2b2lkIGtpbGxfYW5kX3dhaXQoaW50IHBpZCwgaW50KiBzdGF0dXMpCnsKCWtp
bGwoLXBpZCwgU0lHS0lMTCk7CglraWxsKHBpZCwgU0lHS0lMTCk7Cglmb3IgKGludCBpID0gMDsg
aSA8IDEwMDsgaSsrKSB7CgkJaWYgKHdhaXRwaWQoLTEsIHN0YXR1cywgV05PSEFORyB8IF9fV0FM
TCkgPT0gcGlkKQoJCQlyZXR1cm47CgkJdXNsZWVwKDEwMDApOwoJfQoJRElSKiBkaXIgPSBvcGVu
ZGlyKCIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMiKTsKCWlmIChkaXIpIHsKCQlmb3IgKDs7KSB7
CgkJCXN0cnVjdCBkaXJlbnQqIGVudCA9IHJlYWRkaXIoZGlyKTsKCQkJaWYgKCFlbnQpCgkJCQli
cmVhazsKCQkJaWYgKHN0cmNtcChlbnQtPmRfbmFtZSwgIi4iKSA9PSAwIHx8IHN0cmNtcChlbnQt
PmRfbmFtZSwgIi4uIikgPT0gMCkKCQkJCWNvbnRpbnVlOwoJCQljaGFyIGFib3J0WzMwMF07CgkJ
CXNucHJpbnRmKGFib3J0LCBzaXplb2YoYWJvcnQpLCAiL3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25z
LyVzL2Fib3J0IiwgZW50LT5kX25hbWUpOwoJCQlpbnQgZmQgPSBvcGVuKGFib3J0LCBPX1dST05M
WSk7CgkJCWlmIChmZCA9PSAtMSkgewoJCQkJY29udGludWU7CgkJCX0KCQkJaWYgKHdyaXRlKGZk
LCBhYm9ydCwgMSkgPCAwKSB7CgkJCX0KCQkJY2xvc2UoZmQpOwoJCX0KCQljbG9zZWRpcihkaXIp
OwoJfSBlbHNlIHsKCX0KCXdoaWxlICh3YWl0cGlkKC0xLCBzdGF0dXMsIF9fV0FMTCkgIT0gcGlk
KSB7Cgl9Cn0KCnN0YXRpYyB2b2lkIHNldHVwX3Rlc3QoKQp7CglwcmN0bChQUl9TRVRfUERFQVRI
U0lHLCBTSUdLSUxMLCAwLCAwLCAwKTsKCXNldHBncnAoKTsKCXdyaXRlX2ZpbGUoIi9wcm9jL3Nl
bGYvb29tX3Njb3JlX2FkaiIsICIxMDAwIik7Cn0KCnN0cnVjdCB0aHJlYWRfdCB7CglpbnQgY3Jl
YXRlZCwgY2FsbDsKCWV2ZW50X3QgcmVhZHksIGRvbmU7Cn07CgpzdGF0aWMgc3RydWN0IHRocmVh
ZF90IHRocmVhZHNbMTZdOwpzdGF0aWMgdm9pZCBleGVjdXRlX2NhbGwoaW50IGNhbGwpOwpzdGF0
aWMgaW50IHJ1bm5pbmc7CgpzdGF0aWMgdm9pZCogdGhyKHZvaWQqIGFyZykKewoJc3RydWN0IHRo
cmVhZF90KiB0aCA9IChzdHJ1Y3QgdGhyZWFkX3QqKWFyZzsKCWZvciAoOzspIHsKCQlldmVudF93
YWl0KCZ0aC0+cmVhZHkpOwoJCWV2ZW50X3Jlc2V0KCZ0aC0+cmVhZHkpOwoJCWV4ZWN1dGVfY2Fs
bCh0aC0+Y2FsbCk7CgkJX19hdG9taWNfZmV0Y2hfc3ViKCZydW5uaW5nLCAxLCBfX0FUT01JQ19S
RUxBWEVEKTsKCQlldmVudF9zZXQoJnRoLT5kb25lKTsKCX0KCXJldHVybiAwOwp9CgpzdGF0aWMg
dm9pZCBleGVjdXRlX29uZSh2b2lkKQp7CglpbnQgaSwgY2FsbCwgdGhyZWFkOwoJZm9yIChjYWxs
ID0gMDsgY2FsbCA8IDEwOyBjYWxsKyspIHsKCQlmb3IgKHRocmVhZCA9IDA7IHRocmVhZCA8IChp
bnQpKHNpemVvZih0aHJlYWRzKSAvIHNpemVvZih0aHJlYWRzWzBdKSk7IHRocmVhZCsrKSB7CgkJ
CXN0cnVjdCB0aHJlYWRfdCogdGggPSAmdGhyZWFkc1t0aHJlYWRdOwoJCQlpZiAoIXRoLT5jcmVh
dGVkKSB7CgkJCQl0aC0+Y3JlYXRlZCA9IDE7CgkJCQlldmVudF9pbml0KCZ0aC0+cmVhZHkpOwoJ
CQkJZXZlbnRfaW5pdCgmdGgtPmRvbmUpOwoJCQkJZXZlbnRfc2V0KCZ0aC0+ZG9uZSk7CgkJCQl0
aHJlYWRfc3RhcnQodGhyLCB0aCk7CgkJCX0KCQkJaWYgKCFldmVudF9pc3NldCgmdGgtPmRvbmUp
KQoJCQkJY29udGludWU7CgkJCWV2ZW50X3Jlc2V0KCZ0aC0+ZG9uZSk7CgkJCXRoLT5jYWxsID0g
Y2FsbDsKCQkJX19hdG9taWNfZmV0Y2hfYWRkKCZydW5uaW5nLCAxLCBfX0FUT01JQ19SRUxBWEVE
KTsKCQkJZXZlbnRfc2V0KCZ0aC0+cmVhZHkpOwoJCQlpZiAoY2FsbCA9PSAzIHx8IGNhbGwgPT0g
NCB8fCBjYWxsID09IDUgfHwgY2FsbCA9PSA2KQoJCQkJYnJlYWs7CgkJCWV2ZW50X3RpbWVkd2Fp
dCgmdGgtPmRvbmUsIDUwKTsKCQkJYnJlYWs7CgkJfQoJfQoJZm9yIChpID0gMDsgaSA8IDEwMCAm
JiBfX2F0b21pY19sb2FkX24oJnJ1bm5pbmcsIF9fQVRPTUlDX1JFTEFYRUQpOyBpKyspCgkJc2xl
ZXBfbXMoMSk7Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1dGVfb25lKHZvaWQpOwoKI2RlZmluZSBXQUlU
X0ZMQUdTIF9fV0FMTAoKc3RhdGljIHZvaWQgbG9vcCh2b2lkKQp7CglpbnQgaXRlciA9IDA7Cglm
b3IgKDs7IGl0ZXIrKykgewoJCWludCBwaWQgPSBmb3JrKCk7CgkJaWYgKHBpZCA8IDApCglleGl0
KDEpOwoJCWlmIChwaWQgPT0gMCkgewoJCQlzZXR1cF90ZXN0KCk7CgkJCWV4ZWN1dGVfb25lKCk7
CgkJCWV4aXQoMCk7CgkJfQoJCWludCBzdGF0dXMgPSAwOwoJCXVpbnQ2NF90IHN0YXJ0ID0gY3Vy
cmVudF90aW1lX21zKCk7CgkJZm9yICg7OykgewoJCQlpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywg
V05PSEFORyB8IFdBSVRfRkxBR1MpID09IHBpZCkKCQkJCWJyZWFrOwoJCQlzbGVlcF9tcygxKTsK
CQkJaWYgKGN1cnJlbnRfdGltZV9tcygpIC0gc3RhcnQgPCA1MDAwKQoJCQkJY29udGludWU7CgkJ
CWtpbGxfYW5kX3dhaXQocGlkLCAmc3RhdHVzKTsKCQkJYnJlYWs7CgkJfQoJfQp9Cgp1aW50NjRf
dCByWzFdID0gezB4ZmZmZmZmZmZmZmZmZmZmZn07Cgp2b2lkIGV4ZWN1dGVfY2FsbChpbnQgY2Fs
bCkKewoJCWludHB0cl90IHJlcyA9IDA7Cglzd2l0Y2ggKGNhbGwpIHsKCWNhc2UgMDoKKih1aW50
MTZfdCopMHgyMDAwMDA0MCA9IDI7CioodWludDE2X3QqKTB4MjAwMDAwNDIgPSBodG9iZTE2KDB4
NGUyMCk7CioodWludDMyX3QqKTB4MjAwMDAwNDQgPSBodG9iZTMyKDApOwoqKHVpbnQ4X3QqKTB4
MjAwMDAwYzAgPSAwOwoqKHVpbnQ4X3QqKTB4MjAwMDAwYzEgPSAwOwoqKHVpbnQxNl90KikweDIw
MDAwMGMyID0gMHgzNDsKKih1aW50MzJfdCopMHgyMDAwMDBjNCA9IDA7Cm1lbWNweSgodm9pZCop
MHgyMDAwMDBjOCwgIlx4NGJceDJmXHgwOVx4ZmNceDQ3XHg2MVx4YjhceDYwXHhlNlx4N2ZceGU5
XHg0Nlx4ZDNceDczXHg0Mlx4YTdceDFlXHgwYlx4YmVceGUwXHhiMlx4NTJceDAwXHgxZlx4OGVc
eDA5XHhmMlx4YTRceDBiXHg1Zlx4MDZceDQ1XHg4MVx4NWVceDZjXHhlYVx4YWVceDg0XHg3YVx4
N2ZceDUwXHhhM1x4YjNceGViXHgwN1x4N2RceDk1XHgxMVx4NTBceDJjXHhlZVx4M2RceGVlXHhk
Zlx4YzlceDMwXHhlNlx4NmFceDQ2XHg5ZFx4NGVceDg4XHhjZFx4MWNceDY2XHg3MFx4NTVceGQw
XHg3Zlx4OWVceGY5XHg1Zlx4MGRceGQxXHhkMlx4NDJceDZhXHg5N1x4ZjVceGVkIiwgODApOwoJ
CXN5c2NhbGwoX19OUl9zZXRzb2Nrb3B0LCAtMSwgNiwgMHhlLCAweDIwMDAwMDQwdWwsIDB4ZDh1
bCk7CgkJYnJlYWs7CgljYXNlIDE6Cm1lbWNweSgodm9pZCopMHgyMDAwMDFjMCwgIi9kZXYvZmQj
XDAwMCIsIDkpOwoJCXJlcyA9IC0xOwpyZXMgPSBzeXpfb3Blbl9kZXYoMHgyMDAwMDFjMCwgMCwg
Myk7CgkJaWYgKHJlcyAhPSAtMSkKCQkJCXJbMF0gPSByZXM7CgkJYnJlYWs7CgljYXNlIDI6CgkJ
c3lzY2FsbChfX05SX2lvY3RsLCByWzBdLCAweDI0MSwgMCk7CgkJYnJlYWs7CgljYXNlIDM6Cioo
dWludDE2X3QqKTB4MjAwMDAwNDAgPSAyOwoqKHVpbnQxNl90KikweDIwMDAwMDQyID0gaHRvYmUx
NigweDRlMjApOwoqKHVpbnQzMl90KikweDIwMDAwMDQ0ID0gaHRvYmUzMigwKTsKKih1aW50OF90
KikweDIwMDAwMGMwID0gMDsKKih1aW50OF90KikweDIwMDAwMGMxID0gMDsKKih1aW50MTZfdCop
MHgyMDAwMDBjMiA9IDB4MzQ7CioodWludDMyX3QqKTB4MjAwMDAwYzQgPSAwOwptZW1jcHkoKHZv
aWQqKTB4MjAwMDAwYzgsICJceDRiXHgyZlx4MDlceGZjXHg0N1x4NjFceGI4XHg2MFx4ZTZceDdm
XHhlOVx4NDZceGQzXHg3M1x4NDJceGE3XHgxZVx4MGJceGJlXHhlMFx4YjJceDUyXHgwMFx4MWZc
eDhlXHgwOVx4ZjJceGE0XHgwYlx4NWZceDA2XHg0NVx4ODFceDVlXHg2Y1x4ZWFceGFlXHg4NFx4
N2FceDdmXHg1MFx4YTNceGIzXHhlYlx4MDdceDdkXHg5NVx4MTFceDUwXHgyY1x4ZWVceDNkXHhl
ZVx4ZGZceGM5XHgzMFx4ZTZceDZhXHg0Nlx4OWRceDRlXHg4OFx4Y2RceDFjXHg2Nlx4NzBceDU1
XHhkMFx4N2ZceDllXHhmOVx4NWZceDBkXHhkMVx4ZDJceDQyXHg2YVx4OTdceGY1XHhlZCIsIDgw
KTsKCQlzeXNjYWxsKF9fTlJfc2V0c29ja29wdCwgLTEsIDYsIDB4ZSwgMHgyMDAwMDA0MHVsLCAw
eGQ4dWwpOwoJCWJyZWFrOwoJY2FzZSA0OgptZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAsICIvZGV2
L2ZkI1wwMDAiLCA5KTsKc3l6X29wZW5fZGV2KDB4MjAwMDAwMDAsIC0xLCAweDQwMDApOwoJCWJy
ZWFrOwoJY2FzZSA1OgoJCXN5c2NhbGwoX19OUl9pb2N0bCwgclswXSwgMHgyNDEsIDApOwoJCWJy
ZWFrOwoJY2FzZSA2OgoJCXN5c2NhbGwoX19OUl9pb2N0bCwgclswXSwgMHgyNDcsIDApOwoJCWJy
ZWFrOwoJY2FzZSA3OgpzeXpfb3Blbl9kZXYoMCwgOCwgMHgyMDApOwoJCWJyZWFrOwoJY2FzZSA4
OgoqKHVpbnQzMl90KikweDIwMDAwMTgwID0gMjsKCQlzeXNjYWxsKF9fTlJfc2V0c29ja29wdCwg
LTEsIDYsIDB4MTQsIDB4MjAwMDAxODB1bCwgNHVsKTsKCQlicmVhazsKCWNhc2UgOToKCQlzeXNj
YWxsKF9fTlJfaW9jdGwsIHJbMF0sIDB4MjQ3LCAwKTsKCQlicmVhazsKCX0KCn0KaW50IG1haW4o
dm9pZCkKewoJCXN5c2NhbGwoX19OUl9tbWFwLCAweDFmZmZmMDAwdWwsIDB4MTAwMHVsLCAwdWws
IDB4MzJ1bCwgLTEsIDB1bCk7CglzeXNjYWxsKF9fTlJfbW1hcCwgMHgyMDAwMDAwMHVsLCAweDEw
MDAwMDB1bCwgN3VsLCAweDMydWwsIC0xLCAwdWwpOwoJc3lzY2FsbChfX05SX21tYXAsIDB4MjEw
MDAwMDB1bCwgMHgxMDAwdWwsIDB1bCwgMHgzMnVsLCAtMSwgMHVsKTsKCWZvciAocHJvY2lkID0g
MDsgcHJvY2lkIDwgODsgcHJvY2lkKyspIHsKCQlpZiAoZm9yaygpID09IDApIHsKCQkJbG9vcCgp
OwoJCX0KCX0KCXNsZWVwKDEwMDAwMDApOwoJcmV0dXJuIDA7Cn0K
--000000000000d0e73005e46ad9bf
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wxehy21>
X-Attachment-Id: f_l5wxehy21

c2V0c29ja29wdCRpbmV0Nl90Y3BfVENQX01ENVNJRygweGZmZmZmZmZmZmZmZmZmZmYsIDB4Niwg
MHhlLCAmKDB4N2YwMDAwMDAwMDQwKT17QGluPXt7MHgyLCAweDRlMjAsIEBlbXB0eX19LCAweDAs
IDB4MCwgMHgzNCwgMHgwLCAiNGIyZjA5ZmM0NzYxYjg2MGU2N2ZlOTQ2ZDM3MzQyYTcxZTBiYmVl
MGIyNTIwMDFmOGUwOWYyYTQwYjVmMDY0NTgxNWU2Y2VhYWU4NDdhN2Y1MGEzYjNlYjA3N2Q5NTEx
NTAyY2VlM2RlZWRmYzkzMGU2NmE0NjlkNGU4OGNkMWM2NjcwNTVkMDdmOWVmOTVmMGRkMWQyNDI2
YTk3ZjVlZCJ9LCAweGQ4KQpyMCA9IHN5el9vcGVuX2RldiRmbG9wcHkoJigweDdmMDAwMDAwMDFj
MCksIDB4MCwgMHgzKQppb2N0bCRGTE9QUFlfRkRDTFJQUk0ocjAsIDB4MjQxKQpzZXRzb2Nrb3B0
JGluZXQ2X3RjcF9UQ1BfTUQ1U0lHKDB4ZmZmZmZmZmZmZmZmZmZmZiwgMHg2LCAweGUsICYoMHg3
ZjAwMDAwMDAwNDApPXtAaW49e3sweDIsIDB4NGUyMCwgQGVtcHR5fX0sIDB4MCwgMHgwLCAweDM0
LCAweDAsICI0YjJmMDlmYzQ3NjFiODYwZTY3ZmU5NDZkMzczNDJhNzFlMGJiZWUwYjI1MjAwMWY4
ZTA5ZjJhNDBiNWYwNjQ1ODE1ZTZjZWFhZTg0N2E3ZjUwYTNiM2ViMDc3ZDk1MTE1MDJjZWUzZGVl
ZGZjOTMwZTY2YTQ2OWQ0ZTg4Y2QxYzY2NzA1NWQwN2Y5ZWY5NWYwZGQxZDI0MjZhOTdmNWVkIn0s
IDB4ZDgpIChhc3luYykKc3l6X29wZW5fZGV2JGZsb3BweSgmKDB4N2YwMDAwMDAwMDAwKSwgMHhm
ZmZmZmZmZmZmZmZmZmZmLCAweDQwMDApIChhc3luYykKaW9jdGwkRkxPUFBZX0ZEQ0xSUFJNKHIw
LCAweDI0MSkgKGFzeW5jKQppb2N0bCRGTE9QUFlfRkRGTVRCRUcocjAsIDB4MjQ3KSAoYXN5bmMp
CnN5el9vcGVuX2RldiR2Y3NuKDB4MCwgMHg4LCAweDIwMCkKc2V0c29ja29wdCRpbmV0Nl90Y3Bf
VENQX1JFUEFJUl9RVUVVRSgweGZmZmZmZmZmZmZmZmZmZmYsIDB4NiwgMHgxNCwgJigweDdmMDAw
MDAwMDE4MCk9MHgyLCAweDQpCmlvY3RsJEZMT1BQWV9GREZNVEJFRyhyMCwgMHgyNDcpCg==
--000000000000d0e73005e46ad9bf--
