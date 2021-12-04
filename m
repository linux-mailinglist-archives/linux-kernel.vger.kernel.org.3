Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF046838A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384460AbhLDJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:22:53 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35683 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354732AbhLDJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:22:50 -0500
Received: by mail-io1-f69.google.com with SMTP id x11-20020a0566022c4b00b005e702603028so4436418iov.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BicH4dGqa6TUkl2ShVq9M06ILM657TfQbaGTPgoqbnQ=;
        b=Kdk03sP6qoAng9sg6fNlLadf63bqICNSTbKHkq475roono/IP3FdQ5+nqPJRg+R98n
         cPRKZEn/l4YcRWiLZSDiJGJR9Ka4UzAhdxxTt2dvyGchNMxFou1KfuVHvScDuFYOii3J
         zNJB9A1fO0Jg/Kqs+8LmZSkW6tScowFHGJ/FThwJeYUzcP/6VCumSvtORm88oeh6uPfP
         rSaIRRRUYHxojSahuOo0T5EtPOFjLayshVQQo6oQKDhskZYZri5Qa0SRjxiRCNkf/i9i
         aUw9tbg0BD8SjVkPBcKWjVuXl36EI+SeyZfoDFoDoXIGrvjsnv5lwcqFo3QKegPso9zf
         /XmA==
X-Gm-Message-State: AOAM532xludRqmu1NFBIjxO1Ci8qYDyBtW8SLNLvkkNVZZGL7yLai6Ac
        Rz0itrTE316k3QgASrK9ik0LGwZW9dqCBYlg5AQ3fMo8xG4P
X-Google-Smtp-Source: ABdhPJxaDskuNMOqx543yVdjktzwWtyCKXJmxZUGBRy35VwCo3Qe+7ehEUNLmEXZEZjBMy57Et2OQnGgt/hH2DgMNH6S5zPlOkg3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d07:: with SMTP id c7mr25090984iow.46.1638609564793;
 Sat, 04 Dec 2021 01:19:24 -0800 (PST)
Date:   Sat, 04 Dec 2021 01:19:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009022a05d24e85fc@google.com>
Subject: [syzbot] general protection fault in virtio_gpu_object_create
From:   syzbot <syzbot+62d1cf88cc39247b2e23@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kraxel@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    136057256686 Linux 5.16-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14029126b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf85c53718a1e697
dashboard link: https://syzkaller.appspot.com/bug?extid=62d1cf88cc39247b2e23
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62d1cf88cc39247b2e23@syzkaller.appspotmail.com

RBP: 00007f96f6d2a1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffde5383b0f R14: 00007f96f6d2a300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 PID: 32308 Comm: syz-executor.2 Not tainted 5.16.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:183 [inline]
RIP: 0010:virtio_gpu_object_create+0x29b/0xd90 drivers/gpu/drm/virtio/virtgpu_object.c:249
Code: 89 de e8 38 11 09 fd 48 85 db 0f 85 9f 03 00 00 e8 9a 0e 09 fd 49 8d 7f 0c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82
RSP: 0018:ffffc90002fafad0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900242c8000
RDX: 0000000000000000 RSI: ffffffff846dc446 RDI: 0000000000000000
RBP: ffff8880257af000 R08: 0000000000000000 R09: ffffffff8bcca173
R10: ffffffff846dc438 R11: 0000000000000000 R12: ffffc90002fafbd0
R13: ffff8880430e0010 R14: ffff8880430e0000 R15: fffffffffffffff4
FS:  00007f96f6d2a700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000009af988 CR3: 0000000053153000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virtio_gpu_gem_create drivers/gpu/drm/virtio/virtgpu_gem.c:42 [inline]
 virtio_gpu_mode_dumb_create+0x319/0x5c0 drivers/gpu/drm/virtio/virtgpu_gem.c:90
 drm_mode_create_dumb+0x26c/0x2f0 drivers/gpu/drm/drm_dumb_buffers.c:96
 drm_ioctl_kernel+0x27d/0x4e0 drivers/gpu/drm/drm_ioctl.c:782
 drm_ioctl+0x51e/0x9d0 drivers/gpu/drm/drm_ioctl.c:885
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f96f97b4ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f96f6d2a188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f96f98c7f60 RCX: 00007f96f97b4ae9
RDX: 0000000020000040 RSI: 00000000c02064b2 RDI: 0000000000000003
RBP: 00007f96f6d2a1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffde5383b0f R14: 00007f96f6d2a300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 7991b533e1b66750 ]---
RIP: 0010:virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:183 [inline]
RIP: 0010:virtio_gpu_object_create+0x29b/0xd90 drivers/gpu/drm/virtio/virtgpu_object.c:249
Code: 89 de e8 38 11 09 fd 48 85 db 0f 85 9f 03 00 00 e8 9a 0e 09 fd 49 8d 7f 0c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82
RSP: 0018:ffffc90002fafad0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900242c8000
RDX: 0000000000000000 RSI: ffffffff846dc446 RDI: 0000000000000000
RBP: ffff8880257af000 R08: 0000000000000000 R09: ffffffff8bcca173
R10: ffffffff846dc438 R11: 0000000000000000 R12: ffffc90002fafbd0
R13: ffff8880430e0010 R14: ffff8880430e0000 R15: fffffffffffffff4
FS:  00007f96f6d2a700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000009af988 CR3: 0000000053153000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 38 11 09 fd       	callq  0xfd09113f
   7:	48 85 db             	test   %rbx,%rbx
   a:	0f 85 9f 03 00 00    	jne    0x3af
  10:	e8 9a 0e 09 fd       	callq  0xfd090eaf
  15:	49 8d 7f 0c          	lea    0xc(%r15),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	82                   	.byte 0x82


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
