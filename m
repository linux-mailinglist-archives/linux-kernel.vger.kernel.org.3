Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB1481021
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbhL2Fl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL2Fl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:41:27 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D80C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 21:41:27 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id j3-20020a056830014300b0058f4f1ef3c2so23169429otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 21:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=RQJ9Z7U78l7RlTESwOz0f8iotYMnV6+H622tZ3ZpcB0=;
        b=VY0ZPsavgmjZAqHD1Qmelq2rhCy45HgpUO550sIzC2/R+axkgD5HhY648G+/jFVL1K
         O/UYL0EYWC1BnlqI/sZMO4npOvpFCbxTyHEAnbeJR38a5pIf5hUnIQviBZoF+nYsMsuc
         EVC+f/4R3lpExIHPSz85mwFBjwcwacpS9VtQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=RQJ9Z7U78l7RlTESwOz0f8iotYMnV6+H622tZ3ZpcB0=;
        b=zYMc2O/RZmVBhYwS1gnUZef1CJiWQprrelKqDFxUePPvky+YolU2oY4nYMTf+6UFNo
         SXHj83+Hej8CnNeHJjquz15DtMheKxX3eKWzjKYQjgL7eQT96zQSqGgUzrGCHNDJocX2
         sckwloN7J+9If9/z1kllzhijxgRWWFRcU4NBZENSvW0nbADMuncXPoBuP6p4lv1Cq9Th
         0DYQhmF8zrXPUT/blfGUrNCGwszIOH4NKI4CYNlwYXMe+wmr2CFX5BeVwEGj/piM/Gu1
         gu/T+7OM34q4yeowpCn67V4y99VgXb2+EFIEZKKyp1EVcfIz7NT0mFtIWjeGyMPQ0Wtl
         f21A==
X-Gm-Message-State: AOAM530I3MKb0odEFzWXmxEVbfqc/WxkWBK66F7o5mmCbFDQzZj+ySco
        clNiQSa42wCyuDRJfP1+Dohm+/a4GmAzQI8k/LmBUg==
X-Google-Smtp-Source: ABdhPJzwplygFU01bLuJdOe/B/+d23LGng2feNHVIUOGf2lYk7CrK+WWD6iaU/XwUC+ZVg2QyqYm8XxBTkYXELNr4II=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr17845869otj.77.1640756478088;
 Tue, 28 Dec 2021 21:41:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Dec 2021 21:41:17 -0800
MIME-Version: 1.0
In-Reply-To: <00000000000058a5c505d43dd91c@google.com>
References: <00000000000058a5c505d43dd91c@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 28 Dec 2021 21:41:17 -0800
Message-ID: <CAE-0n52SNiv=GzDjM0nrvZzjLyttSjoNGAkz=Dvmt3R665mzug@mail.gmail.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in corrupted (2)
To:     hdanton@sina.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, miaoqinglang@huawei.com,
        qiang.zhang@windriver.com,
        syzbot <syzbot+a437546ec71b04dfb5ac@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting syzbot (2021-12-28 16:16:28)
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    ea586a076e8a Add linux-next specific files for 20211224
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bb71a5b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9c4e3dde2c568fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=a437546ec71b04dfb5ac
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1246b50db00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c902db00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a437546ec71b04dfb5ac@syzkaller.appspotmail.com

I see a fix has been sent[1] already. Here it is inline.

---8<---
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index eba1e8087bfd..b8b08f0a8c54 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -873,6 +873,7 @@ static int magicmouse_probe(struct hid_device *hdev,

 	return 0;
 err_stop_hw:
+	del_timer_sync(&msc->battery_timer);
 	hid_hw_stop(hdev);
 	return ret;
 }

>
> magicmouse 0003:05AC:0265.0001: hidraw0: USB HID v0.00 Device [HID 05ac:0265] on usb-dummy_hcd.0-1/input0
> magicmouse 0003:05AC:0265.0001: magicmouse input not registered
> magicmouse: probe of 0003:05AC:0265.0001 failed with error -12
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: timer_list hint: magicmouse_battery_timer_tick+0x0/0x360 include/linux/device.h:693
> WARNING: CPU: 1 PID: 25 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
> Modules linked in:
> CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 5.16.0-rc6-next-20211224-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
> Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 80 c1 05 8a 4c 89 ee 48 c7 c7 80 b5 05 8a e8 1e 28 25 05 <0f> 0b 83 05 35 9d a6 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffffc90000dfeb10 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> RDX: ffff8880157d3a80 RSI: ffffffff815f4208 RDI: fffff520001bfd54
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff815edf6e R11: 0000000000000000 R12: ffffffff89adf420
> R13: ffffffff8a05bbc0 R14: ffffffff81666980 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff4e854bf0 CR3: 000000000b88e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>

[1] https://lore.kernel.org/r/b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr
