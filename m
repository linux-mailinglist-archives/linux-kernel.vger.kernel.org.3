Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8858F5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiHKCMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiHKCMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:12:17 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D63E61D6D;
        Wed, 10 Aug 2022 19:12:16 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id bi51so4209229vkb.5;
        Wed, 10 Aug 2022 19:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=/awAE9nhqySswQljYiC8HCKODPtyTqoyguGMkSKMP/4=;
        b=eo3K0LjIpEFKf3eudAPBMfLRhngWZg3zEbklaiBl35/559cpzr7fhRRQau9F7jLAsc
         UnBH6okuB5h0l7wfQqDZHH5ChY2qF1+GwScIhEPNMQpDZn3R9cR1R93z6H5iTCAlubMk
         D6FnhJcHNY0lnDPKDDJYatExrL8G0bhtg3I0HpU94nR6/JC6Q77vRkXh+U85CiFY37qb
         zLiJyaaUSndjgj8c6h6HaW3VXTlKLrrftRjBW86xX9kd89Yv0es3ENnX4g6vbdmXRXug
         TJrH9UezDqcS3BNScQH+4UsqYFU0axjHADF3wajCvay02RBoLdA9329/UoyTFlYrjnB9
         AsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/awAE9nhqySswQljYiC8HCKODPtyTqoyguGMkSKMP/4=;
        b=UTP0LPtX3+mMTxvSFIyF4b0EbioKzsPXLLcCJPDM7lGwRWGS1TX+JvdItWToW43vFW
         UqD/Jd9Yneo7L71JtPBaCtlIBG9IYZw8mTTIgHh9twcc+nz6i4jLrsPOLGIxavNPfl3W
         1wwSvD7Bt0J6kaXTZy8VFLA8HZxtJNusQygnUeCdG4VdQGAqQixojjC6WakhbTp4ffZY
         1Rx348OaeriryKe82vEkEdM2Y7d+VOw1yfcmWM4CbHZSb1Ow8Ta2YyFc9kkvVSbJWKrc
         JlWsC7GrqFgGb/RIdTzEdweabuglzXNQNd387LmnSxkLTobCQ8BA1nFVlxgK8fEmusAU
         nzlA==
X-Gm-Message-State: ACgBeo3S2757DvHnM1fIqdJeEzf93RsargWZJAaQ1PaM5FOjMGv3rq+b
        iZ0rPAnb1SLuxIotxmSZxzLaLchtn0lwyDx0qzA=
X-Google-Smtp-Source: AA6agR7pM5EWmbIgOUNgUvbDBv9lDtpWUTHpM1oPZNyL9eD5zDS1HR7QnFWvPRfX2VfwI9TUEmawc3HXdfurkAdqMuY=
X-Received: by 2002:a1f:1787:0:b0:377:2d45:b897 with SMTP id
 129-20020a1f1787000000b003772d45b897mr13451145vkx.36.1660183935518; Wed, 10
 Aug 2022 19:12:15 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 11 Aug 2022 10:12:04 +0800
Message-ID: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
Subject: kernel v5.19 warn in usb_ep_queue
To:     balbi@kernel.org, andriy.shevchenko@linux.intel.com,
        jakobkoschel@gmail.com, quic_wcheng@quicinc.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver 5.19.0-rc4-00208-g69cb6c6556ad,
the following crash was triggered.

HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
git tree: upstream

kernel config: https://pastebin.com/KecL2gaG
C reproducer: https://pastebin.com/wLDJ9cnP
console output: https://pastebin.com/t0r8EwTw

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0xbaf, product id:
0x121, with function: midi and ms_null).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

It seems that an error state in struct usb_ep trigger such kernel warning.

The crash report is as follow:

```
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: CPU: 3 PID: 3442 at drivers/usb/gadget/udc/core.c:283
usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
Modules linked in:
CPU: 3 PID: 3442 Comm: file-storage Not tainted
5.19.0-rc4-00208-g69cb6c6556ad #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
Code: 46 05 0f 92 c3 31 ff 89 de e8 f1 e9 49 fd 84 db 0f 85 16 01 00
00 e8 c4 e8 49 fd 44 89 e0 5b 5d 41 5c 41 5d c3 e8 b5 e8 49 fd <0f> 0b
41 bc 94 ff ff ff e9 73 ff ff ff e8 a3 e8 49 fd 65 8b 1d cc
RSP: 0018:ffffc9000490fd00 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff888110e0d580
RDX: 0000000000000000 RSI: ffff888110e0d580 RDI: 0000000000000002
RBP: ffff88810ae84158 R08: ffffffff83fb31eb R09: 0000000000000000
R10: 0000000000000001 R11: ffffed10221c1ab0 R12: 0000000000000cc0
R13: ffff888111843f10 R14: ffff888111843f10 R15: ffff88811084e000
FS: 0000000000000000(0000) GS:ffff88811a980000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f841985e020 CR3: 000000010d19a000 CR4: 0000000000350ee0
Call Trace:
<TASK>
start_transfer.isra.0+0x26/0x100
drivers/usb/gadget/function/f_mass_storage.c:527
start_out_transfer.isra.0+0xf0/0x1b0
drivers/usb/gadget/function/f_mass_storage.c:560
get_next_command drivers/usb/gadget/function/f_mass_storage.c:2249 [inline]
fsg_main_thread+0x377/0x6fc0 drivers/usb/gadget/function/f_mass_storage.c:2572
kthread+0x2ef/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
</TASK>


```
