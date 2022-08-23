Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AB59EC33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiHWTYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiHWTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:24:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23276F3274;
        Tue, 23 Aug 2022 11:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5258B82024;
        Tue, 23 Aug 2022 18:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B4C433B5;
        Tue, 23 Aug 2022 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661278057;
        bh=ALiLsy5rWj2IwLak7owuMvsRWCIEP4P7EQvrdrGgVWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ICqNjAy+QzvznnAQFTRGCtbXnX4PUfLZCoMt6DUK0mwXDs9FPZ3PjHC1uTQPbm+QE
         lupIFYGP5+fv+VrhUtq/o3rQQEHk4rIvQDdAn8G3t2K70ubc4JorrP2HEsCD1bQqmt
         esYp7JjLfGur+diC41fIftl5rL598OXyrUjHCb21xHlQcUb+nHjBQpqpjm/EiWSr4m
         7MdLrBDX3GzAZJkAIja1jPq0RVakWhQelBesEMKcpl2SvmppSTLkEvemMtVIieZfui
         0v62VFXjMd1246UmpowI8G35K5tyb5E70OTaa+ncV2b+oa/D9mOLO9oHZm0FmcvINV
         eKkZmDDglIO9w==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31f445bd486so400219127b3.13;
        Tue, 23 Aug 2022 11:07:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo31fZNyKroO3H8Anq8HKeNR95P6dRIoSLI9d0I1w714NK5Xgzab
        jXXOikaeH4zU3sc0z1p69UOOS3Ce10GcXcBVVpw=
X-Google-Smtp-Source: AA6agR5R4sfcdbhDn7v8P0yn8wpWGtkJyMR8kyA3/Scfe2CpHcmnP0nQevqIqCMTqV8aU+Rm5WBq/z/FYojLbBv1niE=
X-Received: by 2002:a05:6902:110d:b0:670:b10b:d16e with SMTP id
 o13-20020a056902110d00b00670b10bd16emr25550193ybu.259.1661278056460; Tue, 23
 Aug 2022 11:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1659633958-32756-1-git-send-email-ssengar@linux.microsoft.com> <a939c6f6-1df8-77ac-8366-7121abc2f57b@linux.dev>
In-Reply-To: <a939c6f6-1df8-77ac-8366-7121abc2f57b@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 Aug 2022 11:07:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6KRYSXsq-+4ghHuA+-EvBXvtCxYDWYMGwVqbdtFie+bQ@mail.gmail.com>
Message-ID: <CAPhsuW6KRYSXsq-+4ghHuA+-EvBXvtCxYDWYMGwVqbdtFie+bQ@mail.gmail.com>
Subject: Re: [PATCH] md : Replace snprintf with scnprintf
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Shaohua Li <shli@fb.com>, NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ssengar@microsoft.com, mikelley@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 6:10 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrot=
e:
>
>
>
> On 8/5/22 1:25 AM, Saurabh Sengar wrote:
> > Current code produces a warning as shown below when total characters
> > in the constituent block device names plus the slashes exceeds 200.
> > snprintf() returns the number of characters generated from the given
> > input, which could cause the expression =E2=80=9C200 =E2=80=93 len=E2=
=80=9D to wrap around
> > to a large positive number. Fix this by using scnprintf() instead,
> > which returns the actual number of characters written into the buffer.
> >
> > [ 1513.267938] ------------[ cut here ]------------
> > [ 1513.267943] WARNING: CPU: 15 PID: 37247 at <snip>/lib/vsprintf.c:250=
9 vsnprintf+0x2c8/0x510
> > [ 1513.267944] Modules linked in:  <snip>
> > [ 1513.267969] CPU: 15 PID: 37247 Comm: mdadm Not tainted 5.4.0-1085-az=
ure #90~18.04.1-Ubuntu
> > [ 1513.267969] Hardware name: Microsoft Corporation Virtual Machine/Vir=
tual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
> > [ 1513.267971] RIP: 0010:vsnprintf+0x2c8/0x510
> > <-snip->
> > [ 1513.267982] Call Trace:
> > [ 1513.267986]  snprintf+0x45/0x70
> > [ 1513.267990]  ? disk_name+0x71/0xa0
> > [ 1513.267993]  dump_zones+0x114/0x240 [raid0]
> > [ 1513.267996]  ? _cond_resched+0x19/0x40
> > [ 1513.267998]  raid0_run+0x19e/0x270 [raid0]
> > [ 1513.268000]  md_run+0x5e0/0xc50
> > [ 1513.268003]  ? security_capable+0x3f/0x60
> > [ 1513.268005]  do_md_run+0x19/0x110
> > [ 1513.268006]  md_ioctl+0x195e/0x1f90
> > [ 1513.268007]  blkdev_ioctl+0x91f/0x9f0
> > [ 1513.268010]  block_ioctl+0x3d/0x50
> > [ 1513.268012]  do_vfs_ioctl+0xa9/0x640
> > [ 1513.268014]  ? __fput+0x162/0x260
> > [ 1513.268016]  ksys_ioctl+0x75/0x80
> > [ 1513.268017]  __x64_sys_ioctl+0x1a/0x20
> > [ 1513.268019]  do_syscall_64+0x5e/0x200
> > [ 1513.268021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Fixes: 766038846e875 ("md/raid0: replace printk() with pr_*()")
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

The patch doesn't apply. Could you please rebase and resend?

Thanks,
Song

> > ---
> >   drivers/md/raid0.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> > index b21e101..b6f0fc1 100644
> > --- a/drivers/md/raid0.c
> > +++ b/drivers/md/raid0.c
> > @@ -48,7 +48,7 @@ static void dump_zones(struct mddev *mddev)
> >               int len =3D 0;
> >
> >               for (k =3D 0; k < conf->strip_zone[j].nb_dev; k++)
> > -                     len +=3D snprintf(line+len, 200-len, "%s%s", k?"/=
":"",
> > +                     len +=3D scnprintf(line+len, 200-len, "%s%s", k?"=
/":"",
> >                                       bdevname(conf->devlist[j*raid_dis=
ks
> >                                                              + k]->bdev=
, b));
> >               pr_debug("md: zone%d=3D[%s]\n", j, line);
>
> Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>
> Thanks,
> Guoqing
