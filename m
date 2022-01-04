Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97752483981
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiADAi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiADAi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:38:26 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F850C061761;
        Mon,  3 Jan 2022 16:38:26 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d1so82804561ybh.6;
        Mon, 03 Jan 2022 16:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uFWLtAhbxZ1dykBXmjE0uy378BtXhhbFxG7BiV7KYUs=;
        b=Q/8jAU/jRJz02vjz0S6rhA3mR5RnnkpWrDqSqdaekyz6AdINBYt0U2g/KEhZm0IS3Y
         O4JGMCgY6qAihs0UsnQlQV1ar1zLt1RW34peBx6W81jUVwZd1IZT3g2GRhJ+k4mwvLqf
         rwVFFGXurahYtb3tGybIx8y4J3+isi39QOu6u/lkRH0LKjmhk33Jp+CH4I9RV/UdPHmM
         efSNRq+VwSSZ4KUbMngVHuGT5VEpVAooLk7y3VHwBtSIAATOrgabCY05zL+SMQLFXkyY
         EtKa3hpv5zNr0jcHSJHFOr2PR1xvaVzTEvMe8ZwoROtiD0Y5+/hT9a8MB97NddmwcfEo
         6XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uFWLtAhbxZ1dykBXmjE0uy378BtXhhbFxG7BiV7KYUs=;
        b=ypXs3Y7jZQvhqDL4YG06hBwBUm4XwcSdn4VIYlvsMjK+I7E7qnEbSy81NIc2pfyflV
         zHjQbeChbNouZ3NWcpSZTEiQRSXUi8qEaLbkTqu9z2SOsCZLmhCvc6jPQcPuXxQnV39P
         K5KvelffAVHsy+kFiwHVyeethkytF8LE3LcaeVgkzHAsOAn7lpRLwGyIFo9pn1zkDNmX
         oVH3wIdFgne6wm18KHbt/b5ZaO4Ab0P7OeIEAeOztdiAF3N9A6Y90DO/Qf+FC1qYIm0r
         whogZu4CFO2M1IqqSp30Ot+/Z8DLRBf2JV0zCBCoXOApWPKIWGs3UEuRHfKrKPOXORt0
         0G7Q==
X-Gm-Message-State: AOAM532kHnbvWB619exIFx0eHnAZlIZtnMQYaxK34gmXWPM/pn+jjJ4k
        vpg9wgmMhCx+bQZDVAFpG/JpODnf0R2XC5B3qg2dRTfiG2k=
X-Google-Smtp-Source: ABdhPJwTPr/4meWs34BPi+bP/lZX8sgbCSV1VJTQTozjxurS18x4KThzZJU+tiSxnTx+zkx7Tx3ovhbzDomiPP3T8Fg=
X-Received: by 2002:a05:6902:1149:: with SMTP id p9mr32328313ybu.398.1641256705555;
 Mon, 03 Jan 2022 16:38:25 -0800 (PST)
MIME-Version: 1.0
References: <36ec2e79-7544-ba14-8bdd-d748dfad0ea7@eknoes.de>
In-Reply-To: <36ec2e79-7544-ba14-8bdd-d748dfad0ea7@eknoes.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 3 Jan 2022 16:38:14 -0800
Message-ID: <CABBYNZJwqb0xKa+iX4zOBYpZ2j0ZFbHPRztQ1z5xJL7kq6-9Ag@mail.gmail.com>
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

On Mon, Jan 3, 2022 at 3:41 PM S=C3=B6nke Huster <soenke.huster@eknoes.de> =
wrote:
>
> Hello,
>
> While fuzzing bluetooth-next I found the following bug:
>
> [   27.333034] BUG: unable to handle page fault for address: fffff61a1a1a=
1a1a
> [   27.333241] #PF: supervisor read access in kernel mode
> [   27.333241] #PF: error_code(0x0000) - not-present page
> [   27.333241] PGD 6dfd2067 P4D 6dfd2067 PUD 0
> [   27.333241] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   27.333241] CPU: 0 PID: 45 Comm: kworker/u3:2 Not tainted 5.16.0-rc1+ =
#81
> [   27.333241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   27.333241] Workqueue: hci0 hci_rx_work
> [   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x950
> [   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 07 00 0=
0 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
> [   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
> [   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: ffffffff8=
34663d1
> [   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: ffff88800=
affb074
> [   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: ffffffff8=
3487b35
> [   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: ffff88800=
affb000
> [   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: ffff88800=
aae0000
> [   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlG=
S:0000000000000000
> [   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 000000000=
00006f0
> [   27.333241] Call Trace:
> [   27.333241]  <TASK>
> [   27.333241]  ? wait_for_completion_io+0x270/0x270
> [   27.333241]  ? hci_inquiry_result_evt+0x4b0/0x4b0
> [   27.333241]  hci_event_packet+0x3b11/0x7b10
> [   27.333241]  ? lock_chain_count+0x20/0x20
> [   27.333241]  ? hci_cmd_status_evt.constprop.0+0x4ea0/0x4ea0
> [   27.333241]  ? sysvec_reboot+0x50/0xc0
> [   27.333241]  ? find_held_lock+0x2c/0x110
> [   27.333241]  ? lock_release+0x3b2/0x6f0
> [   27.333241]  ? skb_dequeue+0x110/0x1a0
> [   27.333241]  ? mark_held_locks+0x9e/0xe0
> [   27.333241]  ? lockdep_hardirqs_on_prepare+0x17b/0x400
> [   27.333241]  hci_rx_work+0x4d3/0xb90
> [   27.333241]  process_one_work+0x904/0x1590
> [   27.333241]  ? lock_release+0x6f0/0x6f0
> [   27.333241]  ? pwq_dec_nr_in_flight+0x230/0x230
> [   27.333241]  ? rwlock_bug.part.0+0x90/0x90
> [   27.333241]  ? _raw_spin_lock_irq+0x41/0x50
> [   27.333241]  worker_thread+0x578/0x1310
> [   27.333241]  ? process_one_work+0x1590/0x1590
> [   27.333241]  kthread+0x3b2/0x490
> [   27.333241]  ? _raw_spin_unlock_irq+0x1f/0x40
> [   27.333241]  ? set_kthread_struct+0x100/0x100
> [   27.333241]  ret_from_fork+0x22/0x30
> [   27.333241]  </TASK>
> [   27.333241] Modules linked in:
> [   27.333241] CR2: fffff61a1a1a1a1a
> [   27.333241] ---[ end trace 6a6825484c8fefa6 ]---
> [   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x950
> [   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 07 00 0=
0 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
> [   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
> [   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: ffffffff8=
34663d1
> [   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: ffff88800=
affb074
> [   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: ffffffff8=
3487b35
> [   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: ffff88800=
affb000
> [   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: ffff88800=
aae0000
> [   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlG=
S:0000000000000000
> [   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 000000000=
00006f0
> [   27.379996] kworker/u3:2 (45) used greatest stack depth: 27736 bytes l=
eft
>
> It occurs when sending the following frame to the kernel:
>
> $ xxd crashes/hci_inquiry_result_with_rssi_evt
> 00000000: 0422 24d0 d0d0 d0d0 d0ff ff              ."$........
>
> The bug was introduced with the commit "Bluetooth: HCI: Use skb_pull_data=
 to parse Inquiry Result with RSSI event" (https://git.kernel.org/pub/scm/l=
inux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=3D8d08d324fdcb7).

That is pretty weird, the data seems to be the following:

04 -> HCI_EVENT_PKT
22 -> HCI_EV_INQUIRY_RESULT_WITH_RSSI
24 -> hci_ev_inquiry_result_rssi.num
d0 d0d0 d0d0 d0ff ff

But this should never evaluate to true for:

if (skb->len =3D=3D flex_array_size(ev, res2->info, ev->res2->num)) {
...
} else if (skb->len =3D=3D flex_array_size(ev, res1->info, ev->res1->num)) =
{

These requires the data to be multiple of sizeof(struct
inquiry_info_rssi_pscan) =3D 15 bytes or sizeof(struct
inquiry_info_rssi) =3D 14 bytes respectively where the data left is just
8 bytes long, besides with the number of entries being 0x24 this shall
be well beyond skb->len which shall have cause the else clause:

  } else {
      bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
                         HCI_EV_INQUIRY_RESULT_WITH_RSSI);
  }

Anyway the bluetooth-next has been updated since last week so I first
attempt to reproduce with a fresh clone of it since we did some fixups
since then.

--=20
Luiz Augusto von Dentz
