Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF34849A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiADVEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiADVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:04:13 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BF8C061761;
        Tue,  4 Jan 2022 13:04:12 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d1so91199955ybh.6;
        Tue, 04 Jan 2022 13:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6377wHxN6R1C6kPtXozOzYT8mRATeA4crVA4OMhFag=;
        b=Jj6ItsVtnQDpbQHDkJW3MC9Odl73IRDwzQ4SVubCPFKiZP3cvnFdcJqSj3kOSnLGu/
         2xzCpRfY2JgvqO++LNqQNAjfYlYuGYQrboxL9/dk54lPSXJDKTiF0iuBHaMJilp/T1Dz
         JW0v4FRBjVledoTUKRa8eL/p8CGBeTEl5jPAnDunGAtpaF5WR/k3bZtwAHTPJ+Yr9xnX
         JBNI5NFD7pqt4KhOa7IKshf4G8Tiq+jvp+Izj0roojIT6OeBBco+EWJQqQkIXqy3l8lB
         eKscHNFBTGN6Z8JwVzAF4f0tRpGP/CFf1UjKQ4IX9E7zfQOQoVu1Eb4UfFlQFAfnkM31
         q3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6377wHxN6R1C6kPtXozOzYT8mRATeA4crVA4OMhFag=;
        b=lyMpD8KKajd4WTondVJfrPCsNNKNTL5cKJS4l12g/8JYsHW8K8LuImEowzVLkhIyOZ
         MoDhP3oCArB3PuOWZDXDMPemlafRVOneU2gmw7hctqCID216gWITDs/zsuWEIZ5XHi8C
         mfccwG36lICf8JY2kcs0hLy9z5rG1lVNamItziN344fj1m/pnUC0LxBXNRUT8Sr/g8z3
         /eBDt30wPhyFs1wGsGwMyrnO0KvIQ/+DyQ5ayPlpz7eIL/59ENwg257ewAnZ6ask0ilb
         2MxeBFYl+VJTOvV3HrCEnVVP5wKPnv1zBFqw1hON0van00iN2e9j1DsT42XeByzEF6i2
         5yXw==
X-Gm-Message-State: AOAM530eaG8Z5usfb1Ka4Lw3UnusZ2+GDceBshVjxKJf4zScwd3KuSlF
        JD6+L3RUus3Uc4/7oOzrK8xegH67Eo0cfessCV+9/ya11qk=
X-Google-Smtp-Source: ABdhPJwIidh6vIOVdHznbgKW4pi3FTMuFiCqdaMl1iJWiuE7gXZYlASf1B6ZGWgqjn3XhYhXSJ0C5lrI5/XucnxsyCY=
X-Received: by 2002:a25:7287:: with SMTP id n129mr63499779ybc.351.1641330251894;
 Tue, 04 Jan 2022 13:04:11 -0800 (PST)
MIME-Version: 1.0
References: <36ec2e79-7544-ba14-8bdd-d748dfad0ea7@eknoes.de>
 <CABBYNZJwqb0xKa+iX4zOBYpZ2j0ZFbHPRztQ1z5xJL7kq6-9Ag@mail.gmail.com>
 <91bface3-975d-b79c-2da0-77e24e355fa7@eknoes.de> <CABBYNZLrXh-Zc8wHSzZkvpx0oZGLsR0r_59V2zhAmtRQXTC9yg@mail.gmail.com>
In-Reply-To: <CABBYNZLrXh-Zc8wHSzZkvpx0oZGLsR0r_59V2zhAmtRQXTC9yg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Jan 2022 13:04:01 -0800
Message-ID: <CABBYNZJCuUj7J=egUEc-mbHN-gcvN-wQA7a=EQrvRgWqpEEByQ@mail.gmail.com>
Subject: Re: [BUG] Page Fault in hci_inquiry_result_with_rssi_evt
To:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi S=C3=B6nke,

On Tue, Jan 4, 2022 at 11:31 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi S=C3=B6nke,
>
> On Tue, Jan 4, 2022 at 3:50 AM S=C3=B6nke Huster <soenke.huster@eknoes.de=
> wrote:
> >
> > Hi Luiz,
> >
> > On 04.01.22 01:38, Luiz Augusto von Dentz wrote:
> > > Hi S=C3=B6nke,
> > >
> > > On Mon, Jan 3, 2022 at 3:41 PM S=C3=B6nke Huster <soenke.huster@eknoe=
s.de> wrote:
> > >>
> > >> Hello,
> > >>
> > >> While fuzzing bluetooth-next I found the following bug:
> > >>
> > >> [   27.333034] BUG: unable to handle page fault for address: fffff61=
a1a1a1a1a
> > >> [   27.333241] #PF: supervisor read access in kernel mode
> > >> [   27.333241] #PF: error_code(0x0000) - not-present page
> > >> [   27.333241] PGD 6dfd2067 P4D 6dfd2067 PUD 0
> > >> [   27.333241] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > >> [   27.333241] CPU: 0 PID: 45 Comm: kworker/u3:2 Not tainted 5.16.0-=
rc1+ #81
> > >> [   27.333241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > >> [   27.333241] Workqueue: hci0 hci_rx_work
> > >> [   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x950
> > >> [   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 07=
 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
> > >> [   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
> > >> [   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: ffff=
ffff834663d1
> > >> [   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: ffff=
88800affb074
> > >> [   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: ffff=
ffff83487b35
> > >> [   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: ffff=
88800affb000
> > >> [   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: ffff=
88800aae0000
> > >> [   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)=
 knlGS:0000000000000000
> > >> [   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 0000=
0000000006f0
> > >> [   27.333241] Call Trace:
> > >> [   27.333241]  <TASK>
> > >> [   27.333241]  ? wait_for_completion_io+0x270/0x270
> > >> [   27.333241]  ? hci_inquiry_result_evt+0x4b0/0x4b0
> > >> [   27.333241]  hci_event_packet+0x3b11/0x7b10
> > >> [   27.333241]  ? lock_chain_count+0x20/0x20
> > >> [   27.333241]  ? hci_cmd_status_evt.constprop.0+0x4ea0/0x4ea0
> > >> [   27.333241]  ? sysvec_reboot+0x50/0xc0
> > >> [   27.333241]  ? find_held_lock+0x2c/0x110
> > >> [   27.333241]  ? lock_release+0x3b2/0x6f0
> > >> [   27.333241]  ? skb_dequeue+0x110/0x1a0
> > >> [   27.333241]  ? mark_held_locks+0x9e/0xe0
> > >> [   27.333241]  ? lockdep_hardirqs_on_prepare+0x17b/0x400
> > >> [   27.333241]  hci_rx_work+0x4d3/0xb90
> > >> [   27.333241]  process_one_work+0x904/0x1590
> > >> [   27.333241]  ? lock_release+0x6f0/0x6f0
> > >> [   27.333241]  ? pwq_dec_nr_in_flight+0x230/0x230
> > >> [   27.333241]  ? rwlock_bug.part.0+0x90/0x90
> > >> [   27.333241]  ? _raw_spin_lock_irq+0x41/0x50
> > >> [   27.333241]  worker_thread+0x578/0x1310
> > >> [   27.333241]  ? process_one_work+0x1590/0x1590
> > >> [   27.333241]  kthread+0x3b2/0x490
> > >> [   27.333241]  ? _raw_spin_unlock_irq+0x1f/0x40
> > >> [   27.333241]  ? set_kthread_struct+0x100/0x100
> > >> [   27.333241]  ret_from_fork+0x22/0x30
> > >> [   27.333241]  </TASK>
> > >> [   27.333241] Modules linked in:
> > >> [   27.333241] CR2: fffff61a1a1a1a1a
> > >> [   27.333241] ---[ end trace 6a6825484c8fefa6 ]---
> > >> [   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x950
> > >> [   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 07=
 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
> > >> [   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
> > >> [   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: ffff=
ffff834663d1
> > >> [   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: ffff=
88800affb074
> > >> [   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: ffff=
ffff83487b35
> > >> [   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: ffff=
88800affb000
> > >> [   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: ffff=
88800aae0000
> > >> [   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)=
 knlGS:0000000000000000
> > >> [   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 0000=
0000000006f0
> > >> [   27.379996] kworker/u3:2 (45) used greatest stack depth: 27736 by=
tes left
> > >>
> > >> It occurs when sending the following frame to the kernel:
> > >>
> > >> $ xxd crashes/hci_inquiry_result_with_rssi_evt
> > >> 00000000: 0422 24d0 d0d0 d0d0 d0ff ff              ."$........
> > >>
> > >> The bug was introduced with the commit "Bluetooth: HCI: Use skb_pull=
_data to parse Inquiry Result with RSSI event" (https://git.kernel.org/pub/=
scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=3D8d08d324fdcb=
7).
> > >
> > > That is pretty weird, the data seems to be the following:
> > >
> > > 04 -> HCI_EVENT_PKT
> > > 22 -> HCI_EV_INQUIRY_RESULT_WITH_RSSI
> > > 24 -> hci_ev_inquiry_result_rssi.num
> > > d0 d0d0 d0d0 d0ff ff
> > >
> > > But this should never evaluate to true for:
> > >
> > > if (skb->len =3D=3D flex_array_size(ev, res2->info, ev->res2->num)) {
> > > ...
> > > } else if (skb->len =3D=3D flex_array_size(ev, res1->info, ev->res1->=
num)) {
> > >
> >
> > I'm sorry, I forgot to mention the affected source code, the check seem=
s to be too late. GDB says it is already happening in net/bluetooth/hci_eve=
nt.c:4519:
> >
> > (gdb) list *hci_inquiry_result_with_rssi_evt+0x9b
> > 0xffffffff83470d8b is in hci_inquiry_result_with_rssi_evt (net/bluetoot=
h/hci_event.c:4519).
> > 4514            struct inquiry_data data;
> > 4515            int i;
> > 4516
> > 4517            bt_dev_dbg(hdev, "num_rsp %d", ev->res1->num);
> > 4518
> > 4519            if (!ev->res1->num) # <- page fault here
> > 4520                    return;
> >
> > I just reproduced it on the HEAD of bluetooth-next (for-net-next-2021-1=
2-29).
>
> That would mean there is less data than the hci_ev.min_len, but that
> is checked in hci_event_func prior to calling the hci_ev.func:
>
> if (skb->len < ev->min_len) {
> bt_dev_err(hdev, "unexpected event 0x%2.2x length: %u < %u",
>    event, skb->len, ev->min_len);
> return;
> }
>
> >
> > > These requires the data to be multiple of sizeof(struct
> > > inquiry_info_rssi_pscan) =3D 15 bytes or sizeof(struct
> > > inquiry_info_rssi) =3D 14 bytes respectively where the data left is j=
ust
> > > 8 bytes long, besides with the number of entries being 0x24 this shal=
l
> > > be well beyond skb->len which shall have cause the else clause:
> > >
> > >   } else {
> > >       bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
> > >                          HCI_EV_INQUIRY_RESULT_WITH_RSSI);
> > >   }
> > >
> >
> > I think prior to the commit that introduced that, the check was made be=
fore casting it to the struct, so from the "raw" skb->data:
> >
> > -       int num_rsp =3D *((__u8 *) skb->data);
> > -       if ((skb->len - 1) / num_rsp !=3D sizeof(struct inquiry_info_wi=
th_rssi)) {
>
> That is still being checked, anyway that would cause a page fault when
> accessing num_rsp so I don't understand why it would cause a page
> fault now when previously it didn't even check if there were any bytes
> to be read, perhaps there is some memory alignment at play.
>
> > > Anyway the bluetooth-next has been updated since last week so I first
> > > attempt to reproduce with a fresh clone of it since we did some fixup=
s
> > > since then.
> > >
> >
> > Btw, what is the best way to provide an easily reproducible bug report =
here, I did not figure that out yet.
> >
> > Also, when searching for bugs (to ideally provide patches), I am curren=
tly searching on the HEAD of bluetooth-next. As far as I understood it, the=
 tags "for-net-..." should be more or less stable, as they are merged to ne=
t-next which makes its way to mainline, right?
>
> Yep, those are the tags we sent to net-next but in general
> bluetooth-next shall also be stable since we run CI on every patch
> nowadays.

Ive just sent a patch trying to eliminate the use of the union since
that perhaps cause the compiler to use a different alignment, Im also
thinking on introducing some mechanism to our emulator to generate
arbitrary events in a form a command that generates an event based on
its parameter.

https://patchwork.kernel.org/project/bluetooth/patch/20220104210051.2982871=
-1-luiz.dentz@gmail.com/

--=20
Luiz Augusto von Dentz
