Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BFC58F5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiHKCFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiHKCFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:05:19 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC01114C;
        Wed, 10 Aug 2022 19:05:17 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id c3so16990426vsc.6;
        Wed, 10 Aug 2022 19:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=vLxr2bQK3g/gwesvzUPWXFQq5fWzWxBoO1b59V1Nd+U=;
        b=NIhfrobHuK4vGWIMBY3FGau7ECbC5r8vGBt8w0Ldu4wdEcvnuVta1gwXPSrQ2LmjI6
         nkn8YaSzhJhl1N3z8Rk5AbrdCqEb8Yj6qQZbrZroF67/QA8LdpFnnG22RJRpdOA6LzJD
         TzNAJklq8yq2gfQuMHG7YEoUfaIY/z8+piJ1j/FNkDVZMH3brnxnPm73cj58tvf+ltjg
         PO1aqPseJBx4XNgP1yyft/tDL8Y+dndx6Qzivk8HXoH/bqTMUK8LGZVJAXnoRQRIGklG
         9r2dNrKSHa6hYKPGiEu2hTuwh7KqVuUFIYZGAxPbyzqSEAeoqY4PTtHNT+MCFsdMV0hV
         tWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vLxr2bQK3g/gwesvzUPWXFQq5fWzWxBoO1b59V1Nd+U=;
        b=ciBQ3MtRCP6hDtnBUqoGjGy0vqhVYiJXbpbkoQocvZ/XjtrSyTaRTtMZTAWxLTrLkl
         DnpP9fT66EJtOnTxmEKJCjJ2VIJeL2ANmpuv07vvT1kQk0q8F95IFcefJmOS4mTGM7H/
         hlSKs4ocrl3kENi8y9fgdiJlJebNvNEb4v4cfbwx1UFIFJ0/6tR5dNRnM2BBcyGhRHij
         BNMfziJg7lUAfJu45J1LQkU93gQhiJEG4t4O5u9D/tm0nXt/cR+enTbpz4SMDvMI+3Nb
         DC3ytCHe+jDBpMCvEMdnJdLaupZ933Z4ylH+28dJh/1g+CTX87DfBgazMlJ453HZKYz+
         yiyg==
X-Gm-Message-State: ACgBeo0I44CCyFSR05U3R5vOQAurojGqMrVFMzaY9MIQaTBlEy7gVIHv
        ZQIx6zPAoZ5h4LA+t9OBoBzb++1hv2DWrD9HYhGHkamIJHhSk7YTB2c=
X-Google-Smtp-Source: AA6agR6GHGkEVikkoNpNcsV83bd7tr9VZn9T9GATj6NCxGevsx6q32Jj3C2s7zTC6lKy8ftjjn4KX0ZSAcrh9r/sICE=
X-Received: by 2002:a67:e0cf:0:b0:386:d6fc:cf19 with SMTP id
 m15-20020a67e0cf000000b00386d6fccf19mr12620346vsl.49.1660183516481; Wed, 10
 Aug 2022 19:05:16 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 11 Aug 2022 10:05:05 +0800
Message-ID: <CAB7eexLk-XM=-x_dtKSiSdR6RsTkR4bsXQTL=Mz1HArast6vkg@mail.gmail.com>
Subject: kernel v5.18 warn in usb_stor_msg_common
To:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
git tree: upstream

kernel config: https://pastebin.com/KecL2gaG
C reproducer: https://pastebin.com/KcSa8fCB
console output: https://pastebin.com/zcM1f6ra

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0xcf2, product id:
0x6250, with function: phonet_null and ms_null).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

It seems that when function usb_stor_msg_common tries to call
usb_submit_urb, the value in current_urb on struct us_data cause
usb_submit_urb return a error, which makes the kernel panic on warn

The crash report is as follow:

```
------------[ cut here ]------------
URB ffff888111cb3700 submitted while active
WARNING: CPU: 0 PID: 1204 at drivers/usb/core/urb.c:378
usb_submit_urb+0x136b/0x1820 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 0 PID: 1204 Comm: kworker/0:2 Not tainted 5.18.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_freezable usb_stor_scan_dwork
RIP: 0010:usb_submit_urb+0x136b/0x1820 drivers/usb/core/urb.c:378
Code: 89 de e8 18 94 95 fd 84 db 0f 85 21 f5 ff ff e8 eb 92 95 fd 4c
89 fe 48 c7 c7 60 9d a7 86 c6 05 c8 6c 86 05 01 e8 16 0e 10 02 <0f> 0b
e9 ff f4 ff ff 41 be ed ff ff ff e9 f4 f4 ff ff e8 be 92 95
RSP: 0018:ffffc90000527ad8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88810d6c3900 RDI: fffff520000a4f4d
RBP: 1ffff920000a4f6d R08: ffffffff812beb18 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1023504f09 R12: ffffc90000527b88
R13: ffff88810b970e00 R14: 00000000fffffff0 R15: ffff888111cb3700
FS: 0000000000000000(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558d2f1c9338 CR3: 000000010c890000 CR4: 0000000000350ef0
Call Trace:
<TASK>
usb_stor_msg_common+0x233/0x550 drivers/usb/storage/transport.c:143
usb_stor_control_msg+0x377/0x4f0 drivers/usb/storage/transport.c:205
usb_stor_Bulk_max_lun+0xfa/0x1e0 drivers/usb/storage/transport.c:1081
usb_stor_scan_dwork+0x19f/0x270 drivers/usb/storage/usb.c:906
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2ef/0x3a0 kernel/kthread.c:346
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
</TASK>


```
