Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA357E48A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiGVQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:38:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314159B1B1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:38:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b11so9419887eju.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NBunux7mrOollq5hvSvo0a9Z7T8alUFOipmy11b8qZI=;
        b=cUEbeCebAbKQS1jL4ZGdvTqwDQ16U0gg1PtMxvOVjay61fi7yi78kFAf8D6B4Zq58Q
         LXaKfczR6cXxB6Mk7JNLOEuUaRPid6TQctJzlfIpkqsimD6mHKU7cX1GiFEgeCVl3rHl
         MesDi+p9StsN8j+/1JLXf4M1hzWKc7spPbu8oNhNFHBk1Ro1jdyvZy+OwLTcoPs0xdKZ
         1cQSXav1b3RT1MJ+2Ez816mVDeUEdHdGHCwefUcYEz8GhDVr6Pq0dn1tv6hRzUH74R+v
         UxOabNcQbdY+kWjhQqh2hPY6QsjLrn6yS/FOf7qinJmo/KNCJY9E+ZZGjnPhPFcu+TkD
         Ue+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NBunux7mrOollq5hvSvo0a9Z7T8alUFOipmy11b8qZI=;
        b=7t69h5QCWhaQpLeemrtPGwOhQUAKUGkAd0EItxpzRgRRCJgIAftTmnFF1R8KPYlJK2
         zOplYQ2bs8IBDqzIOPGCp7iljbjQNjgOadCcF+BsGhywgDnIPchR1Dh1ofSS6Uy8dno9
         N9YO5wxmRcePalplDDe5tmE3+nmmaZEHsR/R0By68Gs5ElKskINox9y1RPmf3GtR0ntS
         lv0QZhBHhjbHq38+6+5JH+wcI50UhBjv6y1VycYZ8RGtxMHlkgG1MEH7lQybE0bm7Rzj
         LrRzO+eSXUYMK3qNYidtkGhKhoRCUF1bSn0bCqCYobq/U01MbMEMKGZ2SF/bLbVH/eZ7
         JeZg==
X-Gm-Message-State: AJIora8aZcoszCtAYnUuXmaQoVxnepVicmCwl02Q4KsglMGccKNwVRk/
        3wKlloN6g4w4zFyEP0T8A28wGz3Ao+DeNklcd7o=
X-Google-Smtp-Source: AGRyM1vfG1FdDkypi3cf3sGGoFSF7pChv8ocZB4j4um4C0V+fOmPx6jWX2b5fKGI+QvgdHpKIy9jjl8AymCJjYHCaUQ=
X-Received: by 2002:a17:907:a05b:b0:72b:33f9:f927 with SMTP id
 gz27-20020a170907a05b00b0072b33f9f927mr561192ejc.707.1658507883630; Fri, 22
 Jul 2022 09:38:03 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Fri, 22 Jul 2022 09:37:52 -0700
Message-ID: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
Subject: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
To:     perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org,
        consult.awy@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="0000000000004323bf05e4677536"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004323bf05e4677536
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
affected file: sound/core/pcm_native.c
kernel version: 5.10.131
kernel commit: de62055f423f5dcb548f74cebd68f03c8903f73a
git tree: upstream
kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
crash reproducer: attached
======================================================
Crash log:
======================================================
BUG: KASAN: vmalloc-out-of-bounds in memset include/linux/string.h:384 [inline]
BUG: KASAN: vmalloc-out-of-bounds in snd_pcm_hw_params+0x19b0/0x1db0
sound/core/pcm_native.c:799
Write of size 2097152 at addr ffffc900113b2000 by task syz-executor.5/14437

CPU: 1 PID: 14437 Comm: syz-executor.5 Tainted: G           OE     5.10.131+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x4f7 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:194 [inline]
 check_memory_region+0x187/0x1e0 mm/kasan/generic.c:200
 memset+0x20/0x40 mm/kasan/common.c:85
 memset include/linux/string.h:384 [inline]
 snd_pcm_hw_params+0x19b0/0x1db0 sound/core/pcm_native.c:799
 snd_pcm_kernel_ioctl+0xd1/0x240 sound/core/pcm_native.c:3401
 snd_pcm_oss_change_params_locked+0x17b6/0x3aa0 sound/core/oss/pcm_oss.c:965
 snd_pcm_oss_change_params+0x76/0xd0 sound/core/oss/pcm_oss.c:1107
 snd_pcm_oss_make_ready+0xb7/0x170 sound/core/oss/pcm_oss.c:1166
 snd_pcm_oss_set_trigger.isra.0+0x34f/0x770 sound/core/oss/pcm_oss.c:2074
 snd_pcm_oss_poll+0x679/0xb40 sound/core/oss/pcm_oss.c:2858
 vfs_poll include/linux/poll.h:90 [inline]
 do_pollfd fs/select.c:872 [inline]
 do_poll fs/select.c:920 [inline]
 do_sys_poll+0x63c/0xe40 fs/select.c:1014
 __do_sys_poll fs/select.c:1079 [inline]
 __se_sys_poll fs/select.c:1067 [inline]
 __x64_sys_poll+0x18c/0x490 fs/select.c:1067
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f095de4f4ed
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f095bdffbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00007f095df6df60 RCX: 00007f095de4f4ed
RDX: 0000000000000009 RSI: 0000000000000001 RDI: 00000000200000c0
RBP: 00007f095bdffc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001d
R13: 00007ffff286ceff R14: 00007f095df6df60 R15: 00007f095bdffd80


Memory state around the buggy address:
 ffffc900115b1d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900115b1d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900115b1e00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc900115b1e80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900115b1f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================

-- 
Thanks and Regards,

Dipanjan

--0000000000004323bf05e4677536
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wop3q81>
X-Attachment-Id: f_l5wop3q81

cjAgPSBvcGVuYXQkYWRzcDEoMHhmZmZmZmZmZmZmZmZmZjljLCAmKDB4N2YwMDAwMDAwMDQwKSwg
MHgwLCAweDApCnBvbGwoJigweDdmMDAwMDAwMDBjMCk9W3tyMH1dLCAweDEsIDB4OSkgKGZhaWxf
bnRoOiAxMSkK
--0000000000004323bf05e4677536
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wop3pn0>
X-Attachment-Id: f_l5wop3pn0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxhcnBhL2luZXQuaD4K
I2luY2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+
CiNpbmNsdWRlIDxuZXQvaWYuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPHN0
ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRl
IDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1
ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMvc3lz
Y2FsbC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpbmNs
dWRlIDxsaW51eC9nZW5ldGxpbmsuaD4KI2luY2x1ZGUgPGxpbnV4L2lmX2FkZHIuaD4KI2luY2x1
ZGUgPGxpbnV4L2lmX2xpbmsuaD4KI2luY2x1ZGUgPGxpbnV4L2luNi5oPgojaW5jbHVkZSA8bGlu
dXgvbmVpZ2hib3VyLmg+CiNpbmNsdWRlIDxsaW51eC9uZXQuaD4KI2luY2x1ZGUgPGxpbnV4L25l
dGxpbmsuaD4KI2luY2x1ZGUgPGxpbnV4L3J0bmV0bGluay5oPgojaW5jbHVkZSA8bGludXgvdmV0
aC5oPgoKc3RhdGljIHZvaWQgdXNlX3RlbXBvcmFyeV9kaXIodm9pZCkKewoJY2hhciB0bXBkaXJf
dGVtcGxhdGVbXSA9ICIuL3N5emthbGxlci5YWFhYWFgiOwoJY2hhciogdG1wZGlyID0gbWtkdGVt
cCh0bXBkaXJfdGVtcGxhdGUpOwoJaWYgKCF0bXBkaXIpCglleGl0KDEpOwoJaWYgKGNobW9kKHRt
cGRpciwgMDc3NykpCglleGl0KDEpOwoJaWYgKGNoZGlyKHRtcGRpcikpCglleGl0KDEpOwp9Cgpz
dGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIqIGZpbGUsIGNvbnN0IGNoYXIqIHdoYXQs
IC4uLikKewoJY2hhciBidWZbMTAyNF07Cgl2YV9saXN0IGFyZ3M7Cgl2YV9zdGFydChhcmdzLCB3
aGF0KTsKCXZzbnByaW50ZihidWYsIHNpemVvZihidWYpLCB3aGF0LCBhcmdzKTsKCXZhX2VuZChh
cmdzKTsKCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsKCWludCBsZW4gPSBzdHJsZW4oYnVmKTsK
CWludCBmZCA9IG9wZW4oZmlsZSwgT19XUk9OTFkgfCBPX0NMT0VYRUMpOwoJaWYgKGZkID09IC0x
KQoJCXJldHVybiBmYWxzZTsKCWlmICh3cml0ZShmZCwgYnVmLCBsZW4pICE9IGxlbikgewoJCWlu
dCBlcnIgPSBlcnJubzsKCQljbG9zZShmZCk7CgkJZXJybm8gPSBlcnI7CgkJcmV0dXJuIGZhbHNl
OwoJfQoJY2xvc2UoZmQpOwoJcmV0dXJuIHRydWU7Cn0KCnN0cnVjdCBubG1zZyB7CgljaGFyKiBw
b3M7CglpbnQgbmVzdGluZzsKCXN0cnVjdCBubGF0dHIqIG5lc3RlZFs4XTsKCWNoYXIgYnVmWzQw
OTZdOwp9OwoKc3RhdGljIHZvaWQgbmV0bGlua19pbml0KHN0cnVjdCBubG1zZyogbmxtc2csIGlu
dCB0eXAsIGludCBmbGFncywKCQkJIGNvbnN0IHZvaWQqIGRhdGEsIGludCBzaXplKQp7CgltZW1z
ZXQobmxtc2csIDAsIHNpemVvZigqbmxtc2cpKTsKCXN0cnVjdCBubG1zZ2hkciogaGRyID0gKHN0
cnVjdCBubG1zZ2hkciopbmxtc2ctPmJ1ZjsKCWhkci0+bmxtc2dfdHlwZSA9IHR5cDsKCWhkci0+
bmxtc2dfZmxhZ3MgPSBOTE1fRl9SRVFVRVNUIHwgTkxNX0ZfQUNLIHwgZmxhZ3M7CgltZW1jcHko
aGRyICsgMSwgZGF0YSwgc2l6ZSk7CglubG1zZy0+cG9zID0gKGNoYXIqKShoZHIgKyAxKSArIE5M
TVNHX0FMSUdOKHNpemUpOwp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2F0dHIoc3RydWN0IG5sbXNn
KiBubG1zZywgaW50IHR5cCwKCQkJIGNvbnN0IHZvaWQqIGRhdGEsIGludCBzaXplKQp7CglzdHJ1
Y3QgbmxhdHRyKiBhdHRyID0gKHN0cnVjdCBubGF0dHIqKW5sbXNnLT5wb3M7CglhdHRyLT5ubGFf
bGVuID0gc2l6ZW9mKCphdHRyKSArIHNpemU7CglhdHRyLT5ubGFfdHlwZSA9IHR5cDsKCWlmIChz
aXplID4gMCkKCQltZW1jcHkoYXR0ciArIDEsIGRhdGEsIHNpemUpOwoJbmxtc2ctPnBvcyArPSBO
TE1TR19BTElHTihhdHRyLT5ubGFfbGVuKTsKfQoKc3RhdGljIHZvaWQgbmV0bGlua19uZXN0KHN0
cnVjdCBubG1zZyogbmxtc2csIGludCB0eXApCnsKCXN0cnVjdCBubGF0dHIqIGF0dHIgPSAoc3Ry
dWN0IG5sYXR0ciopbmxtc2ctPnBvczsKCWF0dHItPm5sYV90eXBlID0gdHlwOwoJbmxtc2ctPnBv
cyArPSBzaXplb2YoKmF0dHIpOwoJbmxtc2ctPm5lc3RlZFtubG1zZy0+bmVzdGluZysrXSA9IGF0
dHI7Cn0KCnN0YXRpYyB2b2lkIG5ldGxpbmtfZG9uZShzdHJ1Y3Qgbmxtc2cqIG5sbXNnKQp7Cglz
dHJ1Y3QgbmxhdHRyKiBhdHRyID0gbmxtc2ctPm5lc3RlZFstLW5sbXNnLT5uZXN0aW5nXTsKCWF0
dHItPm5sYV9sZW4gPSBubG1zZy0+cG9zIC0gKGNoYXIqKWF0dHI7Cn0KCnN0YXRpYyBpbnQgbmV0
bGlua19zZW5kX2V4dChzdHJ1Y3Qgbmxtc2cqIG5sbXNnLCBpbnQgc29jaywKCQkJICAgIHVpbnQx
Nl90IHJlcGx5X3R5cGUsIGludCogcmVwbHlfbGVuLCBib29sIGRvZmFpbCkKewoJaWYgKG5sbXNn
LT5wb3MgPiBubG1zZy0+YnVmICsgc2l6ZW9mKG5sbXNnLT5idWYpIHx8IG5sbXNnLT5uZXN0aW5n
KQoJZXhpdCgxKTsKCXN0cnVjdCBubG1zZ2hkciogaGRyID0gKHN0cnVjdCBubG1zZ2hkciopbmxt
c2ctPmJ1ZjsKCWhkci0+bmxtc2dfbGVuID0gbmxtc2ctPnBvcyAtIG5sbXNnLT5idWY7CglzdHJ1
Y3Qgc29ja2FkZHJfbmwgYWRkcjsKCW1lbXNldCgmYWRkciwgMCwgc2l6ZW9mKGFkZHIpKTsKCWFk
ZHIubmxfZmFtaWx5ID0gQUZfTkVUTElOSzsKCXNzaXplX3QgbiA9IHNlbmR0byhzb2NrLCBubG1z
Zy0+YnVmLCBoZHItPm5sbXNnX2xlbiwgMCwgKHN0cnVjdCBzb2NrYWRkciopJmFkZHIsIHNpemVv
ZihhZGRyKSk7CglpZiAobiAhPSAoc3NpemVfdCloZHItPm5sbXNnX2xlbikgewoJCWlmIChkb2Zh
aWwpCglleGl0KDEpOwoJCXJldHVybiAtMTsKCX0KCW4gPSByZWN2KHNvY2ssIG5sbXNnLT5idWYs
IHNpemVvZihubG1zZy0+YnVmKSwgMCk7CglpZiAocmVwbHlfbGVuKQoJCSpyZXBseV9sZW4gPSAw
OwoJaWYgKG4gPCAwKSB7CgkJaWYgKGRvZmFpbCkKCWV4aXQoMSk7CgkJcmV0dXJuIC0xOwoJfQoJ
aWYgKG4gPCAoc3NpemVfdClzaXplb2Yoc3RydWN0IG5sbXNnaGRyKSkgewoJCWVycm5vID0gRUlO
VkFMOwoJCWlmIChkb2ZhaWwpCglleGl0KDEpOwoJCXJldHVybiAtMTsKCX0KCWlmIChoZHItPm5s
bXNnX3R5cGUgPT0gTkxNU0dfRE9ORSkKCQlyZXR1cm4gMDsKCWlmIChyZXBseV9sZW4gJiYgaGRy
LT5ubG1zZ190eXBlID09IHJlcGx5X3R5cGUpIHsKCQkqcmVwbHlfbGVuID0gbjsKCQlyZXR1cm4g
MDsKCX0KCWlmIChuIDwgKHNzaXplX3QpKHNpemVvZihzdHJ1Y3Qgbmxtc2doZHIpICsgc2l6ZW9m
KHN0cnVjdCBubG1zZ2VycikpKSB7CgkJZXJybm8gPSBFSU5WQUw7CgkJaWYgKGRvZmFpbCkKCWV4
aXQoMSk7CgkJcmV0dXJuIC0xOwoJfQoJaWYgKGhkci0+bmxtc2dfdHlwZSAhPSBOTE1TR19FUlJP
UikgewoJCWVycm5vID0gRUlOVkFMOwoJCWlmIChkb2ZhaWwpCglleGl0KDEpOwoJCXJldHVybiAt
MTsKCX0KCWVycm5vID0gLSgoc3RydWN0IG5sbXNnZXJyKikoaGRyICsgMSkpLT5lcnJvcjsKCXJl
dHVybiAtZXJybm87Cn0KCnN0YXRpYyBpbnQgbmV0bGlua19zZW5kKHN0cnVjdCBubG1zZyogbmxt
c2csIGludCBzb2NrKQp7CglyZXR1cm4gbmV0bGlua19zZW5kX2V4dChubG1zZywgc29jaywgMCwg
TlVMTCwgdHJ1ZSk7Cn0KCnN0YXRpYyBpbnQgbmV0bGlua19xdWVyeV9mYW1pbHlfaWQoc3RydWN0
IG5sbXNnKiBubG1zZywgaW50IHNvY2ssIGNvbnN0IGNoYXIqIGZhbWlseV9uYW1lLCBib29sIGRv
ZmFpbCkKewoJc3RydWN0IGdlbmxtc2doZHIgZ2VubGhkcjsKCW1lbXNldCgmZ2VubGhkciwgMCwg
c2l6ZW9mKGdlbmxoZHIpKTsKCWdlbmxoZHIuY21kID0gQ1RSTF9DTURfR0VURkFNSUxZOwoJbmV0
bGlua19pbml0KG5sbXNnLCBHRU5MX0lEX0NUUkwsIDAsICZnZW5saGRyLCBzaXplb2YoZ2VubGhk
cikpOwoJbmV0bGlua19hdHRyKG5sbXNnLCBDVFJMX0FUVFJfRkFNSUxZX05BTUUsIGZhbWlseV9u
YW1lLCBzdHJubGVuKGZhbWlseV9uYW1lLCBHRU5MX05BTVNJWiAtIDEpICsgMSk7CglpbnQgbiA9
IDA7CglpbnQgZXJyID0gbmV0bGlua19zZW5kX2V4dChubG1zZywgc29jaywgR0VOTF9JRF9DVFJM
LCAmbiwgZG9mYWlsKTsKCWlmIChlcnIgPCAwKSB7CgkJcmV0dXJuIC0xOwoJfQoJdWludDE2X3Qg
aWQgPSAwOwoJc3RydWN0IG5sYXR0ciogYXR0ciA9IChzdHJ1Y3QgbmxhdHRyKikobmxtc2ctPmJ1
ZiArIE5MTVNHX0hEUkxFTiArIE5MTVNHX0FMSUdOKHNpemVvZihnZW5saGRyKSkpOwoJZm9yICg7
IChjaGFyKilhdHRyIDwgbmxtc2ctPmJ1ZiArIG47IGF0dHIgPSAoc3RydWN0IG5sYXR0ciopKChj
aGFyKilhdHRyICsgTkxNU0dfQUxJR04oYXR0ci0+bmxhX2xlbikpKSB7CgkJaWYgKGF0dHItPm5s
YV90eXBlID09IENUUkxfQVRUUl9GQU1JTFlfSUQpIHsKCQkJaWQgPSAqKHVpbnQxNl90KikoYXR0
ciArIDEpOwoJCQlicmVhazsKCQl9Cgl9CglpZiAoIWlkKSB7CgkJZXJybm8gPSBFSU5WQUw7CgkJ
cmV0dXJuIC0xOwoJfQoJcmVjdihzb2NrLCBubG1zZy0+YnVmLCBzaXplb2Yobmxtc2ctPmJ1Ziks
IDApOwoJcmV0dXJuIGlkOwp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF9kZXZpY2VfaW1wbChz
dHJ1Y3Qgbmxtc2cqIG5sbXNnLCBjb25zdCBjaGFyKiB0eXBlLAoJCQkJICAgIGNvbnN0IGNoYXIq
IG5hbWUpCnsKCXN0cnVjdCBpZmluZm9tc2cgaGRyOwoJbWVtc2V0KCZoZHIsIDAsIHNpemVvZiho
ZHIpKTsKCW5ldGxpbmtfaW5pdChubG1zZywgUlRNX05FV0xJTkssIE5MTV9GX0VYQ0wgfCBOTE1f
Rl9DUkVBVEUsICZoZHIsIHNpemVvZihoZHIpKTsKCWlmIChuYW1lKQoJCW5ldGxpbmtfYXR0cihu
bG1zZywgSUZMQV9JRk5BTUUsIG5hbWUsIHN0cmxlbihuYW1lKSk7CgluZXRsaW5rX25lc3Qobmxt
c2csIElGTEFfTElOS0lORk8pOwoJbmV0bGlua19hdHRyKG5sbXNnLCBJRkxBX0lORk9fS0lORCwg
dHlwZSwgc3RybGVuKHR5cGUpKTsKfQoKc3RhdGljIHZvaWQgbmV0bGlua19kZXZpY2VfY2hhbmdl
KHN0cnVjdCBubG1zZyogbmxtc2csIGludCBzb2NrLCBjb25zdCBjaGFyKiBuYW1lLCBib29sIHVw
LAoJCQkJICBjb25zdCBjaGFyKiBtYXN0ZXIsIGNvbnN0IHZvaWQqIG1hYywgaW50IG1hY3NpemUs
CgkJCQkgIGNvbnN0IGNoYXIqIG5ld19uYW1lKQp7CglzdHJ1Y3QgaWZpbmZvbXNnIGhkcjsKCW1l
bXNldCgmaGRyLCAwLCBzaXplb2YoaGRyKSk7CglpZiAodXApCgkJaGRyLmlmaV9mbGFncyA9IGhk
ci5pZmlfY2hhbmdlID0gSUZGX1VQOwoJaGRyLmlmaV9pbmRleCA9IGlmX25hbWV0b2luZGV4KG5h
bWUpOwoJbmV0bGlua19pbml0KG5sbXNnLCBSVE1fTkVXTElOSywgMCwgJmhkciwgc2l6ZW9mKGhk
cikpOwoJaWYgKG5ld19uYW1lKQoJCW5ldGxpbmtfYXR0cihubG1zZywgSUZMQV9JRk5BTUUsIG5l
d19uYW1lLCBzdHJsZW4obmV3X25hbWUpKTsKCWlmIChtYXN0ZXIpIHsKCQlpbnQgaWZpbmRleCA9
IGlmX25hbWV0b2luZGV4KG1hc3Rlcik7CgkJbmV0bGlua19hdHRyKG5sbXNnLCBJRkxBX01BU1RF
UiwgJmlmaW5kZXgsIHNpemVvZihpZmluZGV4KSk7Cgl9CglpZiAobWFjc2l6ZSkKCQluZXRsaW5r
X2F0dHIobmxtc2csIElGTEFfQUREUkVTUywgbWFjLCBtYWNzaXplKTsKCWludCBlcnIgPSBuZXRs
aW5rX3NlbmQobmxtc2csIHNvY2spOwoJaWYgKGVyciA8IDApIHsKCX0KfQoKc3RhdGljIHN0cnVj
dCBubG1zZyBubG1zZzsKCnN0YXRpYyBpbnQgaW5qZWN0X2ZhdWx0KGludCBudGgpCnsKCWludCBm
ZDsKCWZkID0gb3BlbigiL3Byb2MvdGhyZWFkLXNlbGYvZmFpbC1udGgiLCBPX1JEV1IpOwoJaWYg
KGZkID09IC0xKQoJZXhpdCgxKTsKCWNoYXIgYnVmWzE2XTsKCXNwcmludGYoYnVmLCAiJWQiLCBu
dGgpOwoJaWYgKHdyaXRlKGZkLCBidWYsIHN0cmxlbihidWYpKSAhPSAoc3NpemVfdClzdHJsZW4o
YnVmKSkKCWV4aXQoMSk7CglyZXR1cm4gZmQ7Cn0KCnN0YXRpYyB2b2lkIHNldHVwX2ZhdWx0KCkK
ewoJc3RhdGljIHN0cnVjdCB7CgkJY29uc3QgY2hhciogZmlsZTsKCQljb25zdCBjaGFyKiB2YWw7
CgkJYm9vbCBmYXRhbDsKCX0gZmlsZXNbXSA9IHsKCSAgICB7Ii9zeXMva2VybmVsL2RlYnVnL2Zh
aWxzbGFiL2lnbm9yZS1nZnAtd2FpdCIsICJOIiwgdHJ1ZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9k
ZWJ1Zy9mYWlsX2Z1dGV4L2lnbm9yZS1wcml2YXRlIiwgIk4iLCBmYWxzZX0sCgkgICAgeyIvc3lz
L2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxsb2MvaWdub3JlLWdmcC1oaWdobWVtIiwgIk4iLCBm
YWxzZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxsb2MvaWdub3JlLWdm
cC13YWl0IiwgIk4iLCBmYWxzZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2Vf
YWxsb2MvbWluLW9yZGVyIiwgIjAiLCBmYWxzZX0sCgl9OwoJdW5zaWduZWQgaTsKCWZvciAoaSA9
IDA7IGkgPCBzaXplb2YoZmlsZXMpIC8gc2l6ZW9mKGZpbGVzWzBdKTsgaSsrKSB7CgkJaWYgKCF3
cml0ZV9maWxlKGZpbGVzW2ldLmZpbGUsIGZpbGVzW2ldLnZhbCkpIHsKCQkJaWYgKGZpbGVzW2ld
LmZhdGFsKQoJZXhpdCgxKTsKCQl9Cgl9Cn0KCiNkZWZpbmUgTkw4MDIxNTRfQ01EX1NFVF9TSE9S
VF9BRERSIDExCiNkZWZpbmUgTkw4MDIxNTRfQVRUUl9JRklOREVYIDMKI2RlZmluZSBOTDgwMjE1
NF9BVFRSX1NIT1JUX0FERFIgMTAKCnN0YXRpYyB2b2lkIHNldHVwXzgwMjE1NCgpCnsKCWludCBz
b2NrX3JvdXRlID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsK
CWlmIChzb2NrX3JvdXRlID09IC0xKQoJZXhpdCgxKTsKCWludCBzb2NrX2dlbmVyaWMgPSBzb2Nr
ZXQoQUZfTkVUTElOSywgU09DS19SQVcsIE5FVExJTktfR0VORVJJQyk7CglpZiAoc29ja19nZW5l
cmljIDwgMCkKCWV4aXQoMSk7CglpbnQgbmw4MDIxNTRfZmFtaWx5X2lkID0gbmV0bGlua19xdWVy
eV9mYW1pbHlfaWQoJm5sbXNnLCBzb2NrX2dlbmVyaWMsICJubDgwMjE1NCIsIHRydWUpOwoJZm9y
IChpbnQgaSA9IDA7IGkgPCAyOyBpKyspIHsKCQljaGFyIGRldm5hbWVbXSA9ICJ3cGFuMCI7CgkJ
ZGV2bmFtZVtzdHJsZW4oZGV2bmFtZSkgLSAxXSArPSBpOwoJCXVpbnQ2NF90IGh3YWRkciA9IDB4
YWFhYWFhYWFhYWFhMDAwMiArIChpIDw8IDgpOwoJCXVpbnQxNl90IHNob3J0YWRkciA9IDB4YWFh
MCArIGk7CgkJaW50IGlmaW5kZXggPSBpZl9uYW1ldG9pbmRleChkZXZuYW1lKTsKCQlzdHJ1Y3Qg
Z2VubG1zZ2hkciBnZW5saGRyOwoJCW1lbXNldCgmZ2VubGhkciwgMCwgc2l6ZW9mKGdlbmxoZHIp
KTsKCQlnZW5saGRyLmNtZCA9IE5MODAyMTU0X0NNRF9TRVRfU0hPUlRfQUREUjsKCQluZXRsaW5r
X2luaXQoJm5sbXNnLCBubDgwMjE1NF9mYW1pbHlfaWQsIDAsICZnZW5saGRyLCBzaXplb2YoZ2Vu
bGhkcikpOwoJCW5ldGxpbmtfYXR0cigmbmxtc2csIE5MODAyMTU0X0FUVFJfSUZJTkRFWCwgJmlm
aW5kZXgsIHNpemVvZihpZmluZGV4KSk7CgkJbmV0bGlua19hdHRyKCZubG1zZywgTkw4MDIxNTRf
QVRUUl9TSE9SVF9BRERSLCAmc2hvcnRhZGRyLCBzaXplb2Yoc2hvcnRhZGRyKSk7CgkJaW50IGVy
ciA9IG5ldGxpbmtfc2VuZCgmbmxtc2csIHNvY2tfZ2VuZXJpYyk7CgkJaWYgKGVyciA8IDApIHsK
CQl9CgkJbmV0bGlua19kZXZpY2VfY2hhbmdlKCZubG1zZywgc29ja19yb3V0ZSwgZGV2bmFtZSwg
dHJ1ZSwgMCwgJmh3YWRkciwgc2l6ZW9mKGh3YWRkciksIDApOwoJCWlmIChpID09IDApIHsKCQkJ
bmV0bGlua19hZGRfZGV2aWNlX2ltcGwoJm5sbXNnLCAibG93cGFuIiwgImxvd3BhbjAiKTsKCQkJ
bmV0bGlua19kb25lKCZubG1zZyk7CgkJCW5ldGxpbmtfYXR0cigmbmxtc2csIElGTEFfTElOSywg
JmlmaW5kZXgsIHNpemVvZihpZmluZGV4KSk7CgkJCWludCBlcnIgPSBuZXRsaW5rX3NlbmQoJm5s
bXNnLCBzb2NrX3JvdXRlKTsKCQkJaWYgKGVyciA8IDApIHsKCQkJfQoJCX0KCX0KCWNsb3NlKHNv
Y2tfcm91dGUpOwoJY2xvc2Uoc29ja19nZW5lcmljKTsKfQoKdWludDY0X3QgclsxXSA9IHsweGZm
ZmZmZmZmZmZmZmZmZmZ9OwoKaW50IG1haW4odm9pZCkKewoJCXN5c2NhbGwoX19OUl9tbWFwLCAw
eDFmZmZmMDAwdWwsIDB4MTAwMHVsLCAwdWwsIDB4MzJ1bCwgLTEsIDB1bCk7CglzeXNjYWxsKF9f
TlJfbW1hcCwgMHgyMDAwMDAwMHVsLCAweDEwMDAwMDB1bCwgN3VsLCAweDMydWwsIC0xLCAwdWwp
OwoJc3lzY2FsbChfX05SX21tYXAsIDB4MjEwMDAwMDB1bCwgMHgxMDAwdWwsIDB1bCwgMHgzMnVs
LCAtMSwgMHVsKTsKCXNldHVwX2ZhdWx0KCk7CglzZXR1cF84MDIxNTQoKTsKCQkJdXNlX3RlbXBv
cmFyeV9kaXIoKTsKCQkJCWludHB0cl90IHJlcyA9IDA7Cm1lbWNweSgodm9pZCopMHgyMDAwMDA0
MCwgIi9kZXYvYWRzcDFcMDAwIiwgMTEpOwoJcmVzID0gc3lzY2FsbChfX05SX29wZW5hdCwgMHhm
ZmZmZmZmZmZmZmZmZjljdWwsIDB4MjAwMDAwNDB1bCwgMHVsLCAwdWwpOwoJaWYgKHJlcyAhPSAt
MSkKCQlyWzBdID0gcmVzOwoqKHVpbnQzMl90KikweDIwMDAwMGMwID0gclswXTsKKih1aW50MTZf
dCopMHgyMDAwMDBjNCA9IDA7CioodWludDE2X3QqKTB4MjAwMDAwYzYgPSAwOwoJaW5qZWN0X2Zh
dWx0KDExKTsKCXN5c2NhbGwoX19OUl9wb2xsLCAweDIwMDAwMGMwdWwsIDF1bCwgOSk7CglyZXR1
cm4gMDsKfQo=
--0000000000004323bf05e4677536--
