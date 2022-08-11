Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271058F5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiHKCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHKCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:08:56 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F08844C5;
        Wed, 10 Aug 2022 19:08:55 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 129so17004032vsq.8;
        Wed, 10 Aug 2022 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=OA8ik5onCrT3CKjTeluDsMAgLLfodb0WC4L067Q2EzI=;
        b=FoDMELBcM/z4Twa/6aKouqJtk67HKH6oMibFUaGrfJhEm8+AHLkOks46BFjqFuETIw
         Ip0hhR4TDW102ZOs4FKi6gPbFiKyHEg/4DcVAoUi2n8xYfVgTXh7luHt3C2zxPSyn3m+
         wnJzydgTasCpJoi3Z2RBTwVjCkABXGmh/e1ghvv/CLTiJIjKLugrKbyLvQWsHgje7hQH
         BXD3t/JdT2COh6IRdNPBG5Pd0GqyGHVFTUD172CwQ2X4N21ngZVCZ/fdzMwSEb0f1SVU
         OOpS5BOrTZpiT940Zsnmt2jvLfe9DYAyAjgBiA0CYAcKlYuQGM8iLsQ3oOtDxymHks4D
         MtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=OA8ik5onCrT3CKjTeluDsMAgLLfodb0WC4L067Q2EzI=;
        b=XHq0zkz7+lsaSeNLnRayEbVOitdIBTuYJV27Z7EvQeVpN9ldQBCHfroemzIt7B3zyi
         15ToXI4BTVXonFbwTWmNe6YjIY5m3LrJ1e8IHoQ3AHB7cJFt6nzcjjYLmp/zHpSAAG7p
         pQ279tcMqkGo4ur8R9GbnF3VVN3sT8+z5SKmQrlW57tzdeDO5+i1oa6hwD2FFXbSfjUM
         OUNjbLI65w2WwuGAbV3KAdNIWFAgL5Aks/4uGw9jsxwB89Vh8HlccUx8KpUPfUjJl+Am
         JJrHMXzhTCywREa2bOAB0Lb2g/iM9nUusC2k3N1gimTAQ1PdDTf0BFEk84GSrCOiwUpz
         MmEA==
X-Gm-Message-State: ACgBeo1rYOUgGJI724cP6UZgZ5vmtUyI9BU9LwAqhaf0eLaxpDRepI7t
        g4Wnw3qn3SOMU3q0etKo5EpMDWDJaV2TluBB+UI=
X-Google-Smtp-Source: AA6agR6DnHjYBAXpNOGniQV2PiFJII4Ydk5Qm5ilTVGxhX6tfXT5MmOKbahQj0Vm9uR5CO80Q6BH24713my8qVJeRUM=
X-Received: by 2002:a67:ba03:0:b0:385:b608:300d with SMTP id
 l3-20020a67ba03000000b00385b608300dmr12866005vsn.33.1660183734777; Wed, 10
 Aug 2022 19:08:54 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 11 Aug 2022 10:08:44 +0800
Message-ID: <CAB7eex+67KdT=dPiXwYwMw2BGMh-_KZ12+E+NfFGd_g3_8B5Ww@mail.gmail.com>
Subject: kernerl v5.18 warn in bpa10x_open/usb_submit_urb
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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
C reproducer: https://pastebin.com/r3wwCUAv
console output: https://pastebin.com/uL3vEh5E

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0x45e, product id:
0x6d, with function: loopback_null).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

It seems that an error state in struct hci_dev trigger such kernel warning.

The crash report is as follow:

```------------[ cut here ]------------
usb 7-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 10209 at drivers/usb/core/urb.c:502
usb_submit_urb+0x142c/0x1820 drivers/usb/core/urb.c:502
Modules linked in:
CPU: 0 PID: 10209 Comm: kworker/u9:0 Not tainted 5.18.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_power_on
RIP: 0010:usb_submit_urb+0x142c/0x1820 drivers/usb/core/urb.c:502
Code: 7c 24 18 e8 36 92 95 fd 48 8b 7c 24 18 e8 fc cf 1b ff 41 89 d8
44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 20 9f a7 86 e8 55 0d 10 02 <0f> 0b
e9 fe f2 ff ff e8 08 92 95 fd 66 90 e8 01 92 95 fd 41 be a6
RSP: 0018:ffffc9000319fa80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888107460000 RDI: fffff52000633f42
RBP: ffff8881076a4500 R08: ffffffff812beb18 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1023504f09 R12: 0000000000000001
R13: ffff888100865910 R14: 0000000000000002 R15: ffff888110724e00
FS: 0000000000000000(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555558340b8 CR3: 0000000111e11000 CR4: 0000000000350ef0
Call Trace:
<TASK>
bpa10x_submit_intr_urb drivers/bluetooth/bpa10x.c:149 [inline]
bpa10x_open+0x2c9/0x7c0 drivers/bluetooth/bpa10x.c:207
hci_dev_open_sync+0x1a3/0x2080 net/bluetooth/hci_sync.c:3898
hci_dev_do_open+0x32/0x70 net/bluetooth/hci_core.c:482
hci_power_on+0x133/0x630 net/bluetooth/hci_core.c:963
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2ef/0x3a0 kernel/kthread.c:346
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
</TASK>


```
