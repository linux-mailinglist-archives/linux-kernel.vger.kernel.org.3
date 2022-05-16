Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC0527D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiEPFfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiEPFf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:35:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB2DF14
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:35:27 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 36DEF3FE01
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652679325;
        bh=9t0LaR/EfyJLcAPGO2VnOpYSq5gggFoXPd0Cpt56ARg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FyzxjH/tYgxCJtLA8SWcQCYJoKiJuF6JW+lryUY3UIdPSiiAOzxAJ5d8NzMYJKfWN
         dr07T4dBBMEo9SdjcGDPb1HVuhyDSXcFO5MeMuv30lqUnnv9k7jt1HcujqrdZbqeF4
         sIQKcF35DIu3H1O6dxW7Kchx2bhdzhGoWjqc1F6DP/9qL47IXLGPnUFCqkgxaE7D4A
         ylfce+k+wwIjc76HG16it7HHVj7AhFUfTX5FkOWCAFcZUSadd3QB3BfB2uW+5SIeJN
         3lEFvfP/jCtysXtf9ZWBVI3sHUkf5vG8RnRnlzHNDFOnW0kpJG6boZkH0F1Dhsgxn7
         CR3TgN7T+5ZRQ==
Received: by mail-pj1-f70.google.com with SMTP id h23-20020a17090a051700b001dc9132f2e6so6095665pjh.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9t0LaR/EfyJLcAPGO2VnOpYSq5gggFoXPd0Cpt56ARg=;
        b=Mke0GH3xWXX/tFdwsCFrPT1MBjc9HZsueNtdx+SeOhsEjJ8uXg/jPEV8Snq49Hjz2g
         7gmrR4urwZUuY41lZX8Na9qBmQrrNZswvPbmTILk8p93jaKo24rk0agy1wEz1n7AgAat
         XPtDstQ+JhsmhBfeIPVmsoEgpH3nb7/S+NfhKu7rHCIHsVy/i5B+blcaPX7NmKqsQV00
         x2242zfXzIrxFVna2scyum3vqxAvDLav8mtt2P5J5xz+D+HC59T0+Lil+e0yWZgmgPE0
         iUIyP/6c1iHd36dT5QR5P4WCkOxinMos5g5tvxmGtwhLnF1LAfb6WDWTwfkeYCtp4Se0
         Xyiw==
X-Gm-Message-State: AOAM530pfFb3DNUFaCusnFfK77O0qVGeQRMGUVphDsytX2deLyx3D8rq
        bJJK90Ziv030CyGyKcOya8OX2iXdQpfr0bPxW/rgcuTqnZr6ffQf9tSlBRalcymX0fn5QT+noGz
        QFPxohoQkz2Sb2CZh7GBkitX4pCyWTpPlms+atdWPjus7tttyjqvcf8Ho3A==
X-Received: by 2002:a63:87c6:0:b0:3c6:a7d9:5d01 with SMTP id i189-20020a6387c6000000b003c6a7d95d01mr14073754pge.341.1652679322596;
        Sun, 15 May 2022 22:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4g5mQxdykZS6WDBN/H9ndjxBYrdeRBey9ijR5dghSmzk9P19zc0y4XuDRinvJnVYD9hDi0+TN0HJAI8kZrCw=
X-Received: by 2002:a63:87c6:0:b0:3c6:a7d9:5d01 with SMTP id
 i189-20020a6387c6000000b003c6a7d95d01mr14073741pge.341.1652679322291; Sun, 15
 May 2022 22:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
 <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
 <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
 <Yn5Zf6lONff1AoOA@localhost.localdomain> <6efae367-12fa-1a58-7438-1b39dc0d6ef8@huawei.com>
In-Reply-To: <6efae367-12fa-1a58-7438-1b39dc0d6ef8@huawei.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Date:   Mon, 16 May 2022 17:35:10 +1200
Message-ID: <CAKAwkKs6AWtkRNX_vMKCr6p1dssvQymvLk4cVFZwD-J7OGVauw@mail.gmail.com>
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef, Kuai,

Josef, thank you for attaching your patch. No worries about being on vacati=
on,
I hope you enjoyed your time off.

Josef, I built your patch ontop of 5.18-rc6 with no other patches applied, =
and
ran the testcase in my original message. After 3x loops, a hang occurred, a=
nd
we see the usual -32 error:

May 16 03:38:35 focal-nbd kernel: block nbd15: NBD_DISCONNECT
May 16 03:38:35 focal-nbd kernel: block nbd15: Send disconnect failed -32

The hang lasted 30 seconds, no doubt caused by the "30 * HZ" timeout in you=
r
patch, and things started moving forward again:

May 16 03:39:05 focal-nbd kernel: block nbd15: Connection timed out,
retrying (0/1 alive)
May 16 03:39:05 focal-nbd kernel: block nbd15: Connection timed out,
retrying (0/1 alive)
May 16 03:39:05 focal-nbd kernel: blk_print_req_error: 128 callbacks suppre=
ssed
May 16 03:39:05 focal-nbd kernel: I/O error, dev nbd15, sector 1023488
op 0x0:(READ) flags 0x80700 phys_seg 14 prio class 0
May 16 03:39:05 focal-nbd kernel: I/O error, dev nbd15, sector 1023608
op 0x0:(READ) flags 0x80700 phys_seg 16 prio class 0
May 16 03:39:05 focal-nbd kernel: block nbd15: Device being setup by
another task

Note the timestamp increment of 30s. There were a whole host of I/O errors,
and after a few more loops, the hang occurred again, again lasting for 30
seconds, and then doing a few more loops before getting stuck again.

Pastebin of journalctl: https://paste.ubuntu.com/p/Cx6MBC8Vgj/

Unfortunately, your patch doesn't quite solve the issue.

Kuai, I tested your suspicions by building Josef's patch ontop of 5.18-rc6 =
with
your below patch applied:

nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
https://lists.debian.org/nbd/2022/04/msg00212.html.

The behaviour was different this time from Josef's patch alone. On the very
second iteration of the loop, I got a bunch of I/O errors, and the nbd subs=
ystem
hung, and did not recover. I started getting stuck request messages, and
the usual hung task timeout oops messages.

Pastebin of journalctl here: https://paste.ubuntu.com/p/C9rjckrWtp/

I went back and did some more testing of Kuai's two commits:

nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
https://lists.debian.org/nbd/2022/04/msg00212.html

nbd: fix io hung while disconnecting device
https://lists.debian.org/nbd/2022/04/msg00207.html

I left the testcase running for about 20 minutes, and it never hung. It did
get a bit racey from time to time trying to get a write lock for the qcow i=
mage,
where the disconnect completed after the call to mkfs.ext4 started, but sim=
ply
saying "y" let the loop run for another 5 minutes before the race occurred
again.

Formatting 'foo.img', fmt=3Dqcow2 size=3D524288000 cluster_size=3D65536
lazy_refcounts=3Doff refcount_bits=3D16
qemu-img: foo.img: Failed to get "write" lock
Is another process using the image [foo.img]?
/dev/nbd15 disconnected
mke2fs 1.45.5 (07-Jan-2020)
/dev/nbd15 contains a ext4 file system labelled 'root'
    created on Mon May 16 05:23:01 2022
Proceed anyway? (y,N)

Through my whole time testing Kuai's fixes, I never saw a hang. The behavio=
ur
seen is the same as the workaround of preventing systemd from watching nbd
devices with inotify. I think we should go with Kuai's patches.

So for Kuai's two patches:

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

Thanks,
Matthew

On Sat, May 14, 2022 at 3:39 PM yukuai (C) <yukuai3@huawei.com> wrote:
>
> =E5=9C=A8 2022/05/13 21:13, Josef Bacik =E5=86=99=E9=81=93:
> > On Fri, May 13, 2022 at 02:56:18PM +1200, Matthew Ruffell wrote:
> >> Hi Josef,
> >>
> >> Just a friendly ping, I am more than happy to test a patch, if you sen=
d it
> >> inline in the email, since the pastebin you used expired after 1 day, =
and I
> >> couldn't access it.
> >>
> >> I came across and tested Yu Kuai's patches [1][2] which are for the sa=
me issue,
> >> and they indeed fix the hang. Thank you Yu.
> >>
> >> [1] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not complet=
ed
> >> https://lists.debian.org/nbd/2022/04/msg00212.html
> >>
> >> [2] nbd: fix io hung while disconnecting device
> >> https://lists.debian.org/nbd/2022/04/msg00207.html
> >>
> >> I am also happy to test any patches to fix the I/O errors.
> >>
> >
> > Sorry, you caught me on vacation before and I forgot to reply.  Here's =
part one
> > of the patch I wanted you to try which fixes the io hung part.  Thanks,
> >
> > Josef
> >
> >
> >>From 0a6123520380cb84de8ccefcccc5f112bce5efb6 Mon Sep 17 00:00:00 2001
> > Message-Id: <0a6123520380cb84de8ccefcccc5f112bce5efb6.1652447517.git.jo=
sef@toxicpanda.com>
> > From: Josef Bacik <josef@toxicpanda.com>
> > Date: Sat, 23 Apr 2022 23:51:23 -0400
> > Subject: [PATCH] timeout thing
> >
> > ---
> >   drivers/block/nbd.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 526389351784..ab365c0e9c04 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -1314,7 +1314,10 @@ static void nbd_config_put(struct nbd_device *nb=
d)
> >               kfree(nbd->config);
> >               nbd->config =3D NULL;
> >
> > -             nbd->tag_set.timeout =3D 0;
> > +             /* Reset our timeout to something sane. */
> > +             nbd->tag_set.timeout =3D 30 * HZ;
> > +             blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
> > +
> >               nbd->disk->queue->limits.discard_granularity =3D 0;
> >               nbd->disk->queue->limits.discard_alignment =3D 0;
> >               blk_queue_max_discard_sectors(nbd->disk->queue, 0);
> >
> Hi, Josef
>
> This seems to try to fix the same problem that I described here:
>
> nbd: fix io hung while disconnecting device
> https://lists.debian.org/nbd/2022/04/msg00207.html
>
> There are still some io that are stuck, which means the devcie is
> probably still opened. Thus nbd_config_put() can't reach here.
> I'm afraid this patch can't fix the io hung.
>
> Matthew, can you try a test with this patch together with my patch below
> to comfirm my thought?
>
> nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
> https://lists.debian.org/nbd/2022/04/msg00212.html.
>
> Thanks,
> Kuai
