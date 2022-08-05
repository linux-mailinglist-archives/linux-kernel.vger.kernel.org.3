Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E8258A5F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiHEGj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiHEGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:39:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09572EC7;
        Thu,  4 Aug 2022 23:39:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-324293f1414so16587497b3.0;
        Thu, 04 Aug 2022 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+HMohhGyweMhIzKHTWtejYZYutFOLonOQxMpd/tWt8Q=;
        b=pg/8JT7UyuGlPrRJ+2LQobjUgAuAQY9r2cQ+sQ99VOxFCABKbl7evpB9/VIboXfvyD
         /s5WzUibPd6EcMYaKgsYP8v/FYnStcvUZnXx9W32Nm9oHP38obULIw1a8gPaMGdvfQPz
         n8kGXGkb4/8PAqxslzf2NLw6jVF8vvjwHA0ectmf8uqxbzSqrQebxCwy3kKswqwHbcz0
         zM1qq3HrhhvrtxlVvdTui4k3vZZMsBYRAfQFozSfCSnoBsmCOP664Ez0jqIJhn5/uYlb
         ABnNfaXS+SimrG4cBqw9Tte6gzVkS/0F+5mcqMnJYAGHkc5+zphl+Yq10Pm/EL7zBFLO
         fy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+HMohhGyweMhIzKHTWtejYZYutFOLonOQxMpd/tWt8Q=;
        b=MyGwUPHfN3ew1TIvd3QQCaiTuuRdzuMfqYStA/dHBvhuCeQbTs6taXZeizk0s1yFfe
         OMBPxoHr2crIvqY4N6uPZk5a6U37P4czxTPvgcRBX30ia2I29r4Tlqp+oJld1ldmW1z5
         nVaLkYPDqerbN1ON942ngo9LTeXQ+zWUCbd4I8V9T+ZFMt+8EKsaS5wL9LJmGcWnwdry
         SKfswFpRPmBLY7Bl5Qjy2F1CjBSZ9FTziQtzL4rDPwR+J1hSdTkcD6JEmyGKlYcX1JwQ
         9etEseLvqe45JYXRIvDzZugBj1yZm+lPo7R5pmGyOo05+N7kamG69jCZjRMG4ZcRf3q/
         2oiQ==
X-Gm-Message-State: ACgBeo1o/ok6Dtx8FSH9N1RsPRuXz6yKjRq7fKlErYtEITXk8OKNwQ0c
        Oisx0VGWtWOTEGWuivC110kFcBtXV0zcDhEZKLU=
X-Google-Smtp-Source: AA6agR6WkscG/ILZIJPc9ZQv0+GfINu9/9mcuZD/iEHyJmSlIsbOHQ8yztEQvir74orenW4wu/nU0ltvY3fqGmYdkxA=
X-Received: by 2002:a81:7702:0:b0:328:297a:fdcb with SMTP id
 s2-20020a817702000000b00328297afdcbmr4653126ywc.335.1659681562232; Thu, 04
 Aug 2022 23:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
In-Reply-To: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 5 Aug 2022 08:39:11 +0200
Message-ID: <CAKXUXMyQgNQf9O5Dvok7LCg-8nmk6LwTHbiew1q+anup=OkrMQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: dvb-usb: fix memory leak in dvb_usb_adapter_init()
To:     Mazin Al Haddad <mazinalhaddad05@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 11:42 PM Mazin Al Haddad
<mazinalhaddad05@gmail.com> wrote:
>
> Fix a memory leak in dvb_usb_adapter_init() reported by syzkaller. The
> problem is due to the error path exiting before incrementing
> num_adapters_initalized, which is used as a reference counter to free
> adapter's private data. There are multiple error paths that
> dvb_usb_adapter_init() can exit from before incrementing the counter,
> which lead to a memory leak as the current iteration is not accounted for.
> Fix this by freeing the current iteration's adap->priv in each of the
> error paths.
>
> Syz Report:
> BUG: memory leak
> unreferenced object 0xffff8881172f1a00 (size 512):
>   comm "kworker/0:2", pid 139, jiffies 4294994873 (age 10.960s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff844af012>] dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:75 [inline]
>     [<ffffffff844af012>] dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:184 [inline]
>     [<ffffffff844af012>] dvb_usb_device_init.cold+0x4e5/0x79e drivers/media/usb/dvb-usb/dvb-usb-init.c:308
>     [<ffffffff830db21d>] dib0700_probe+0x8d/0x1b0 drivers/media/usb/dvb-usb/dib0700_core.c:883
>     [<ffffffff82d3fdc7>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
>     [<ffffffff8274ab37>] call_driver_probe drivers/base/dd.c:542 [inline]
>     [<ffffffff8274ab37>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:621
>     [<ffffffff8274ae6c>] really_probe drivers/base/dd.c:583 [inline]
>     [<ffffffff8274ae6c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:752
>     [<ffffffff8274af6a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:782
>     [<ffffffff8274b786>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:899
>     [<ffffffff82747c87>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
>     [<ffffffff8274b352>] __device_attach+0x122/0x260 drivers/base/dd.c:970
>     [<ffffffff827498f6>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
>     [<ffffffff82745cdb>] device_add+0x5fb/0xdf0 drivers/base/core.c:3405
>     [<ffffffff82d3d202>] usb_set_configuration+0x8f2/0xb80 drivers/usb/core/message.c:2170
>     [<ffffffff82d4dbfc>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
>     [<ffffffff82d3f49c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
>     [<ffffffff8274ab37>] call_driver_probe drivers/base/dd.c:542 [inline]
>     [<ffffffff8274ab37>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:621
>     [<ffffffff8274ae6c>] really_probe drivers/base/dd.c:583 [inline]
>     [<ffffffff8274ae6c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:752
>
> Link: https://syzkaller.appspot.com/bug?id=4d54f8bf7b98eecf6cd76ed5aaea883c5d9e502a
> Reported-by: syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com
> Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
> ---
>
> Changes in v2:
> - Remove variable that is used to refcount and instead free current
>   iteration private data.
>
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index 61439c8f33ca..69520d7ca25d 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -80,16 +80,22 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>                 }
>
>                 ret = dvb_usb_adapter_stream_init(adap);
> -               if (ret)
> +               if (ret) {
> +                       kfree(adap->priv);
>                         return ret;
> +               }
>
>                 ret = dvb_usb_adapter_dvb_init(adap, adapter_nrs);
> -               if (ret)
> +               if (ret) {
> +                       kfree(adap->priv);
>                         goto dvb_init_err;
> +               }
>
>                 ret = dvb_usb_adapter_frontend_init(adap);
> -               if (ret)
> +               if (ret) {
> +                       kfree(adap->priv);
>                         goto frontend_init_err;
> +               }
>
>                 /* use exclusive FE lock if there is multiple shared FEs */
>                 if (adap->fe_adap[1].fe)
> @@ -112,6 +118,7 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
>
>  frontend_init_err:
>         dvb_usb_adapter_dvb_exit(adap);
> +       return ret;
>  dvb_init_err:
>         dvb_usb_adapter_stream_exit(adap);
>         return ret;

Mazin,

I did not review if this patch is right semantically, but concerning
how to write and to modify error handling paths, there are a few
questions and potential improvements for your patch:

Before your patch,  dvb_usb_adapter_init() had three exit paths:

- an early return when dvb_usb_adapter_stream_init() fails
- a path to label dvb_init_err when dvb_usb_adapter_dvb_init() fails
- a path to label frontend_init_err when dvb_usb_adapter_stream_exit() fails

When dvb_usb_adapter_stream_exit() fails, the operations needed to
roll back dvb_usb_adapter_dvb_init() were also needed.
In other words, the execution path from frontend_init_err continues
into the operations of the label dvb_init_err and does not just
return.

With your patch, you changed this:

Why do you now not need to call dvb_usb_adapter_stream_exit() in the
frontend_init_err case?

Now, a simple syntactic and stylistic improvement to consider:

You would like to have a kfree on all three error paths, rather than
adding them three times you could just add them once. I have not
checked if kfree(...) needs to be called before
dvb_usb_adapter_dvb_exit() and dvb_usb_adapter_stream_exit(), or if it
is fine to just call it after. Usually, this patch below implements a
pretty standard pattern, though:

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c
b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 61439c8f33ca..58eea8ab5477 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -81,7 +81,7 @@ static int dvb_usb_adapter_init(struct
dvb_usb_device *d, short *adapter_nrs)

                ret = dvb_usb_adapter_stream_init(adap);
                if (ret)
-                       return ret;
+                       goto stream_init_err;

                ret = dvb_usb_adapter_dvb_init(adap, adapter_nrs);
                if (ret)
@@ -114,6 +114,8 @@ static int dvb_usb_adapter_init(struct
dvb_usb_device *d, short *adapter_nrs)
        dvb_usb_adapter_dvb_exit(adap);
 dvb_init_err:
        dvb_usb_adapter_stream_exit(adap);
+stream_init_err:
+       kfree(adap->priv);
        return ret;
 }


I hope this helps a bit in your work.


Just another hint:

It might help if you can describe how somebody else (e.g., another
mentee) can trigger the memory leak without your patch and see it
being gone with your patch applied:

Provide the kernel config (better even just the fragment needed), the
link to a rootfs, the exact qemu command and the C reproducer.

Then ask other mentees to test before and after the application of
your patch and report their results. It is perfectly fine to ask
others in the community to help you---they will help if they know you
will help them in the future as well. The simpler the task and the
better the task needed for testing is described, the higher chances
that somebody may help here.

In the end that interaction among mentees will also convince the
maintainers (in this case: Mauro) that picking this patch into his
tree is the right thing to do.

Good luck.

Lukas
