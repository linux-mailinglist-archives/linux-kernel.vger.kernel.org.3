Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D5588691
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiHCEg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:36:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5354D146
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:36:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kb8so14768513ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrONgrMU4/j0YqOE8LxJizn19E/WThMbzwNaGuk0yHw=;
        b=qowGaHhGR4RLjP9feKVtZpOeO1uUG0FmeEHBdll2wtdYVbbTqUg+t7ZPy5w2UXJ7xk
         JDi9OIPw0UJDGIG5PFeN1as94WT20LblKu/9x/t9NwRA6Ysn+Ko6fNSA/CzY0UkzQ7tA
         N8C8SDPmpN0SveMiH8dNIcerL7L2Uj8w9ijvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrONgrMU4/j0YqOE8LxJizn19E/WThMbzwNaGuk0yHw=;
        b=J5lfSBKP9bUS3eTs0nOavo8HOt0sDwHuQQk3cl5q6Xd4xReUlQXFCmjdH8susS/5kS
         rGzDF3uZaTfpYs7/eTtq4AvO4w9lAxdTYmtl5xzFJLe8hzug/MvfgBtmNNFoyZ+5ES6i
         U5WdwMyKlgP0Ryfmaulmgv8nIhUuX6VNtcl1kDf3gnNOMi2+oo8eGuyDhfLnxyp8ZEUm
         Ew12GFVALFri+n8Xj5KJ+JIupi7+SJaMDDn3a8SHVvO3lfoEOGnG+3Os3BP9HJ9oO3fL
         D50vGuQuwwPiu4dw2qeQfK72xYwxx0oEWnTWjwPJdn81Wx4CFIcE1083wxY2VlXyEjkM
         ItQg==
X-Gm-Message-State: AJIora+4mLyo09tg2CTqmTM4HwrVntBbAUN6swiXhNdtKb6evEXYQPE3
        Jr7hsXR1PZjnCgeUTuND79hbq34BjuSW5IFM9Ul8Fr1kM/2MRgWm
X-Google-Smtp-Source: AGRyM1uGNnWdKexSU/vpaoXc5D0QH6TWSpKHZBMfW2czqTBdzoco+WHXeLVYCMFi6CIDXAOHzg+mUq61R5ZSHDiq+eI=
X-Received: by 2002:a17:907:2855:b0:72b:700e:21eb with SMTP id
 el21-20020a170907285500b0072b700e21ebmr19087858ejc.270.1659501410566; Tue, 02
 Aug 2022 21:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bdee330594070441@google.com>
In-Reply-To: <000000000000bdee330594070441@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Aug 2022 06:36:39 +0200
Message-ID: <CAJfpeguS6Ta9LcGU0A_JkfvPWZup_Ndg+tpvpbzXJuWPNZwGgw@mail.gmail.com>
Subject: Re: memory leak in cap_inode_getsecurity
To:     syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: multipart/mixed; boundary="00000000000014ef9a05e54ec82d"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000014ef9a05e54ec82d
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

On Thu, 3 Oct 2019 at 21:59, syzbot
<syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    0f1a7b3f timer-of: don't use conditional expression with m..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1329640d600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d66badf12ef344c
> dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1107b513600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
>
> 2019/10/03 14:00:37 executed programs: 36
> 2019/10/03 14:00:43 executed programs: 44
> 2019/10/03 14:00:49 executed programs: 63
> BUG: memory leak
> unreferenced object 0xffff8881202cb480 (size 32):
>    comm "syz-executor.0", pid 7246, jiffies 4294946879 (age 14.010s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000a8379648>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:43 [inline]
>      [<00000000a8379648>] slab_post_alloc_hook mm/slab.h:586 [inline]
>      [<00000000a8379648>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000a8379648>] __do_kmalloc mm/slab.c:3653 [inline]
>      [<00000000a8379648>] __kmalloc_track_caller+0x165/0x300 mm/slab.c:3670
>      [<000000008858463c>] __do_krealloc mm/slab_common.c:1638 [inline]
>      [<000000008858463c>] krealloc+0x7f/0xb0 mm/slab_common.c:1689
>      [<0000000057f9eb8e>] vfs_getxattr_alloc+0x100/0x180 fs/xattr.c:289
>      [<00000000c2154e30>] cap_inode_getsecurity+0x9c/0x2c0
> security/commoncap.c:389
>      [<00000000b2664a09>] security_inode_getsecurity+0x4c/0x90
> security/security.c:1314
>      [<00000000921624c0>] xattr_getsecurity fs/xattr.c:244 [inline]
>      [<00000000921624c0>] vfs_getxattr+0xf2/0x1a0 fs/xattr.c:332
>      [<000000001ff6977b>] getxattr+0x97/0x240 fs/xattr.c:538
>      [<00000000b945681f>] path_getxattr+0x6b/0xc0 fs/xattr.c:566
>      [<000000001a9d3fce>] __do_sys_getxattr fs/xattr.c:578 [inline]
>      [<000000001a9d3fce>] __se_sys_getxattr fs/xattr.c:575 [inline]
>      [<000000001a9d3fce>] __x64_sys_getxattr+0x28/0x30 fs/xattr.c:575
>      [<000000002e998337>] do_syscall_64+0x73/0x1f0
> arch/x86/entry/common.c:290
>      [<00000000f252aa21>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

--00000000000014ef9a05e54ec82d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="vfs_getxattr_alloc-dont-allocate-buf-on-failure.patch"
Content-Disposition: attachment; 
	filename="vfs_getxattr_alloc-dont-allocate-buf-on-failure.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l6d486bu0>
X-Attachment-Id: f_l6d486bu0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IHZmc19n
ZXR4YXR0cl9hbGxvYygpOiBkb24ndCBhbGxvY2F0ZSBidWYgb24gZmFpbHVyZQoKU29tZSBjYWxs
ZXJzIG9mIHZmc19nZXR4YXR0cl9hbGxvYygpIGFzc3VtZSB0aGF0IG9uIGZhaWx1cmUgdGhlIGFs
bG9jYXRlZApidWZmZXIgZG9lcyBub3QgbmVlZCB0byBiZSBmcmVlZC4KCkNhbGxlcnMgY291bGQg
YmUgZml4ZWQsIGJ1dCBmaXhpbmcgdGhlIHNlbWFudGljcyBvZiB2ZnNfZ2V0eGF0dHJfYWxsb2Mo
KSBpcwpzaW1wbGVyIGFuZCBtYWtlcyBzdXJlIHRoYXQgdGhpcyBjbGFzcyBvZiBidWdzIGRvZXMg
bm90IG9jY3VyIGFnYWluLgoKSWYgdGhpcyB3YXMgY2FsbGVkIGluIGEgbG9vcCAoaS5lLiB4YXR0
cl92YWx1ZSBjb250YWlucyBhbiBhbHJlYWR5CmFsbG9jYXRlZCBidWZmZXIpLCB0aGVuIGNhbGxl
ciB3aWxsIHN0aWxsIG5lZWQgdG8gY2xlYW4gdXAgYWZ0ZXIgYW4gZXJyb3IuCgpSZXBvcnRlZC1h
bmQtdGVzdGVkLWJ5OiBzeXpib3QrOTQyZDUzOTBkYjJkOTYyNGNlZDhAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbQpGaXhlczogMTYwMWZiYWQyYjE0ICgieGF0dHI6IGRlZmluZSB2ZnNfZ2V0eGF0
dHJfYWxsb2MgYW5kIHZmc194YXR0cl9jbXAiKQpTaWduZWQtb2ZmLWJ5OiBNaWtsb3MgU3plcmVk
aSA8bXN6ZXJlZGlAcmVkaGF0LmNvbT4KLS0tCiBmcy94YXR0ci5jIHwgICAgNSArKysrLQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZnMveGF0
dHIuYworKysgYi9mcy94YXR0ci5jCkBAIC0zODMsNyArMzgzLDEwIEBAIHZmc19nZXR4YXR0cl9h
bGxvYyhzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UKIAl9CiAKIAllcnJvciA9IGhhbmRsZXItPmdldCho
YW5kbGVyLCBkZW50cnksIGlub2RlLCBuYW1lLCB2YWx1ZSwgZXJyb3IpOwotCSp4YXR0cl92YWx1
ZSA9IHZhbHVlOworCWlmIChlcnJvciA8IDAgJiYgKnhhdHRyX3ZhbHVlID09IE5VTEwpCisJCWtm
cmVlKHZhbHVlKTsKKwllbHNlCisJCSp4YXR0cl92YWx1ZSA9IHZhbHVlOwogCXJldHVybiBlcnJv
cjsKIH0KIAo=
--00000000000014ef9a05e54ec82d--
