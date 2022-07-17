Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48857577696
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiGQOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGQOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:06:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89513E35;
        Sun, 17 Jul 2022 07:06:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oy13so16986835ejb.1;
        Sun, 17 Jul 2022 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y4vXOKtWt6QudNRwdhOrmI986Fj4AOLEo7FHegSVg8g=;
        b=kNX4d5WosdHgzJsVD2eiy6059iYqeWB5SzY3EGaGAgQV7IiV7ge+qIEiI9iUgILkb+
         /BI8HBipz8vobY5TMXvdW+baBYjd96keMJx10J1o9+gmnn+1xCvOMLMKgykSWvL0uLWb
         YKzcw+cAoQblnymryIVyThStANtl4r8w7zRTYxJxQT1b9w4BHQ3Ily8VmvVz2Vgnh1pE
         BldvVfgeSBFH6uEelWXrOqR4W8Nta+/1ZzrmrEXmigjPV5wkRfzPPsRgE8m9a3sE6jxA
         DAqeIpE0UDHqzK3JrhXPRc2KPH6R5iB0q0QFLKDOZc1jLs8iM8d+vKkQHS7WGlVsYeQx
         Vgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y4vXOKtWt6QudNRwdhOrmI986Fj4AOLEo7FHegSVg8g=;
        b=JE0OVBntereW33kkpM1fSSkRD829Un6OSMOlCjgkoMSWrjUO1WlaJ1SR+iCQ0jyXwy
         tYUD9NnUF1JoIZSQvNZ8KtUwuPNiyVuCci7d5wfwiuAnnMIes8ReYRgZP+t3N/H8RFN5
         J3Qx6xijoJgh14VXgtWn0ZDUKNrNzWP9YlpGECfPpQslY2snEscHnvPljptm4fx0qhHz
         dyRaD68wx0NqOg8zbbEaDvGWBJGBI+RE8GpEzRSIm/6Mm7Cd+BBX54yHZNFuU96vgXV0
         qVbs0DWHwZrMJcZXR/FX4fqosYToahKjfH2mpYKCiwt7mA6JE+mFahT2GGpaFPwTvtp4
         lSTQ==
X-Gm-Message-State: AJIora+OTtYMhFcqPET2orVoQ8AuQ5ZY/sXOvmXMgwNdw94uud71CJDv
        elmItiTr94HpHVEtHhS5vYl9ned4bLcl0GwvnduQQJ1rpAz8gA==
X-Google-Smtp-Source: AGRyM1sYfrlVPB7NBbyP75uUtosZk5s563gw1ETMg5BJ3HvdpEMaoD0lNaSskF8CNrYxgdsX9MX/VH9RqWUVX0DyLG4=
X-Received: by 2002:a17:907:6d1d:b0:72b:6d8a:ca64 with SMTP id
 sa29-20020a1709076d1d00b0072b6d8aca64mr21430968ejc.371.1658066811326; Sun, 17
 Jul 2022 07:06:51 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 17 Jul 2022 22:06:16 +0800
Message-ID: <CAO4mrfc=oS37CJtvPt+dWm-24mkV-5XRTGNZDr5ZopAE7pY3WQ@mail.gmail.com>
Subject: WARNING in loop_add
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1JxspkioQiZrQQ9BwsRjm5KJVY6z2KCTW/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1b7QJc_OVw-U7ugxWyvisfMbyQe-aBjWZ/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1ymwqhBp9VYd7jRdpcfwiqUSUV0BnzCC0/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

WARNING: CPU: 0 PID: 8479 at block/genhd.c:537 device_add_disk+0x8aa/0xf20
Modules linked in:
CPU: 0 PID: 8479 Comm: syz-executor Not tainted 5.15.0-rc5+ #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:device_add_disk+0x8aa/0xf20
Code: 00 48 8b 44 24 10 89 18 e8 93 8e 6a fd 4c 89 e7 e8 7b 66 fb ff
4c 89 e7 e8 73 ca 03 00 45 31 f6 e9 b1 fe ff ff e8 76 8e 6a fd <0f> 0b
e9 96 fe ff ff e8 6a 8e 6a fd 0f 0b 41 be ea ff ff ff e9 93
RSP: 0018:ffffc9000b297d28 EFLAGS: 00010283
RAX: ffffffff841b4a0a RBX: 0000000000000007 RCX: 0000000000040000
RDX: ffffc90002211000 RSI: 000000000002f3b2 RDI: 000000000002f3b3
RBP: ffff88803017bb00 R08: ffffffff841b4899 R09: ffffed100c7864a2
R10: ffffed100c7864a2 R11: 0000000000000000 R12: ffff88802f915000
R13: 00000000ffffffea R14: 1ffff11005f22a00 R15: 1ffff11005f22a01
FS:  00007ff387033700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f65c6510000 CR3: 0000000030409000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 loop_add+0x62d/0x8c0
 loop_control_ioctl+0x11d/0x770
 __se_sys_ioctl+0x10a/0x190
 do_syscall_64+0x3d/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff389acac4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff387032c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff389bf10a0 RCX: 00007ff389acac4d
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000004
RBP: 00007ff387032c90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000026
R13: 00007fff0e90e49f R14: 00007fff0e90e640 R15: 00007ff387032dc0

Best,
Wei
