Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD84D9422
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiCOFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiCOFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:51:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6E11C1A;
        Mon, 14 Mar 2022 22:50:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r25so472954eja.0;
        Mon, 14 Mar 2022 22:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/NSiwye0/hFc5Ki5jTq/kiisSJTkrE1fstQXau3UOY=;
        b=bCaW0sZA1MZVg9YuNMotfKZMSB0fJa/iu17/bP9jshrl/rMU7hMUj7wbbR27GexsPo
         fZoLEYKhXIkpjI16PCN0Wp56BJn7k0qNlx2T9dgjQrgP401JV7drtjmKos2HzBaqRtlI
         6LaCE/07zHIMauHzp6bMr7yBVxxg/tvHTY4jsrHx9wEY7kvV5j8WLmu7JJ1QtHpurfSu
         Mk5HHsrnn2RhLA1OSxwljqezAx8TDx/ERI+8amAIwndSTp4p6UAf9z+hRpC2f47qGILW
         8m0wJaY5+hYU2iPVCVq/h2FXWV9SQmbj32X3LpJtOP3JHcAzH8iV5ztqfKv7ctiLbvrz
         lnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/NSiwye0/hFc5Ki5jTq/kiisSJTkrE1fstQXau3UOY=;
        b=WTxYOte/CbDeiDLG5ZyeGHEdoCtX1ogB59NhJcIWTLO6zTFtJ0tjAkyjQKD7xh2wLy
         hTiLV69MXyWlo2FcBDGvXPUfuWW0aq3bu6Oxx7kYOZtqffM2jCN28HbiZtK0pgRfSwsP
         vcDaptliTacejDINyRhOz1dkL82Lqs70I3KA0h9vxh9y+Z4+MKdB0eik1LOHYMnnAamq
         dFvMJCbZxqIZlD/Q3OfLLwLcC8/jDFiPZ+OncQAyzEhLj0xGdIxiG5e3LjtXY3gsIBP8
         w36osRJN7rBo5g4Ymck92QrQpOYNMgzAu72Y/oLSwyIW2XtiSfSnOXgiRW0H43bNUdBd
         M/9A==
X-Gm-Message-State: AOAM532F//0R1TUvKqTPnp1phgFmuvU14mP4oYjQ04W7iCXA4rJF6Ejb
        MiMH4OgoRvZSskLUkggjLZKQG/Sfcp2SqeDOgGY=
X-Google-Smtp-Source: ABdhPJzUCkQUiBwPnLB/tNoIwlntFscXiBP/ERYCJkPX40/m9uswQ/pm5JytcEFVJYLLYWdq0wn0Q+pOcNX7h9u0xKQ=
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id
 kl22-20020a170907995600b006cfcd25c5a7mr20943914ejc.635.1647323405397; Mon, 14
 Mar 2022 22:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
 <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
 <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com>
 <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
 <dac7104a-21ac-24f4-6132-e51960fa0b7e@gmail.com> <CAKFNMon3=fFWtuUa1_wDyK9agpCXjbzA8b+rj=OYu=7Gs8nMqQ@mail.gmail.com>
 <7da316f4-aa65-896e-9020-2dfff2bbfc09@gmail.com> <CAKFNMon7cdJ092Ppne_kU6A23pRUb+1tThCkoB2vn0HN-rWUUg@mail.gmail.com>
 <CAD-N9QXN_DEmoqTEpFdCp=Gne1O3U=+8WpwjP638wbUn1Vb6hA@mail.gmail.com>
 <CAD-N9QVcSnboZqS7tXgU_iD8zzg5a_ubB3W2qtCFequS5u6jqQ@mail.gmail.com> <CAKFNMo=uYDbrwDpqeehbdT5va3X1yw5uBoec1q8AoNAADtrELw@mail.gmail.com>
In-Reply-To: <CAKFNMo=uYDbrwDpqeehbdT5va3X1yw5uBoec1q8AoNAADtrELw@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 15 Mar 2022 13:49:39 +0800
Message-ID: <CAD-N9QVOPXmm3pPX+F7X2SATaVHA=s1P9zD-3W8WyJWEY1HF5w@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:46 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 10:59 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Sun, Mar 13, 2022 at 9:35 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > >
> > > On Sun, Mar 13, 2022 at 12:01 AM Ryusuke Konishi
> > > <konishi.ryusuke@gmail.com> wrote:
> > > >
> > > > Hi Pavel and Dongliang,
> > > >
> > > > On Sun, Mar 13, 2022 at 12:16 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > > > >
> > > > > Hi Ryusuke,
> > > > >
> > > > > On 3/12/22 18:11, Ryusuke Konishi wrote:
> > > > > >> In case of nilfs_attach_log_writer() error code jumps to
> > > > > >> failed_checkpoint label and calls destroy_nilfs() which should call
> > > > > >> nilfs_sysfs_delete_device_group().
> > > > > >
> > > > > > nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> > > > > > if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> > > > > > function tests this flag.
> > > > > >
> > > > > > The flag is set after init_nilfs() succeeded at the beginning of
> > > > > > nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> > > > > >
> > > > > > So,  nilfs_sysfs_delete_group() seems to be called in case of
> > > > > > the above failure.   Am I missing something?
> > > > > >
> > > > >
> > > > > Yeah, that's what I mean :) I can't see how reported issue is possible
> > > > > with current code.
> > > > >
> > > > >
> > > > > Sorry for not being clear
> > > >
> > > > Understood, thanks for the reply.
> > > >
> > > > If so,  the case where nilfs_sysfs_create_device_group() itself failed,
> > > > is suspicious as mentioned in the previous mail.   A possible scenario
> > > > I guess is :
> > > >
> > > > - nilfs_sysfs_create_device_group() on the first mount try fails and leaks
> > > >   due to lack of kobject_del() in the error path.
> > > > - Then, nilfs_sysfs_create_device_group() on the next mount try hits
> > > >   the leak detector at kobject_init_and_add().
> > > >
> > > > So, if the leak bug is reproducible, I'd like to ask Dongliang to
> > > > test the effect of the first patch.
> > >
> > > If my local syzkaller instance gets a reproducer, I will try to do this.
> > >
> > > >
> > > > Regards,
> > > > Ryusuke Konishi
> >
> > Hi Ryusuke,
> >
> > The crash still occurred in my newly set up syzkaller instance. It
> > appears after two days' fuzzing.
> >
> > I remember you suggested me to add kobject_del just for testing,
> > right? And let's see if this crash still occurs any more.
>
> You need a few days to reproduce it ?
> If so, I think this confirmation method is uncertain.
> In that case, I will try inserting an artificial error by changing
> nilfs_sysfs_create_device_group() a bit to confirm if the same crash occurs.

I am reproducing another bug [1] recently. If you can spare some time
figuring out the underlying issue, that's really great. Or we can wait
some time for the bug to disclose more, after all, it is only a rare
memory leak.

[1] https://syzkaller.appspot.com/bug?extid=045796dbe294d53147e6

>
> Ryusuke Konishi
