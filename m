Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4794D9265
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344358AbiCOCAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiCOCAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:00:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69712753;
        Mon, 14 Mar 2022 18:59:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qt6so38015502ejb.11;
        Mon, 14 Mar 2022 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtN/jbkQYVBp1obBwl/awmjNIsL5JS0RMZsDYUjJRLU=;
        b=inIIZasC0nzTHagFiVWYnEJPjMezzne2C7jx84dqB13QiQTNNk4QRacDeNyz1LUJWM
         nhCoyEllJsHr5Cp/5SOpQGVzNNv4+yH5U+ZhANMPeyXgqUIWhqGgoIKakece3iT8wDwn
         xjVg73emSuPj6qcxX+LFMPsGpHSFQprIm6hT3Piexdx0tMgmegT3B6EIc/sG2U7GqpZV
         cs2wXLqUGT2WLcCZNjXEu+XmymA1dNNQ1wyXNXi3rPnETvjbwUl9K1tirGLqyxsygwKC
         ylKcaZrt/2kHRyCDStHtAkuFhbgyp5k4Ne7imYmorvgSJK4x7GAHJ6GuLuJVfaaibdzO
         X+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtN/jbkQYVBp1obBwl/awmjNIsL5JS0RMZsDYUjJRLU=;
        b=bk2CnwOjlLtbSxrEDtRmMYqtnLAxv+MtzvRxvM2TS1wiYvsPX2P5Qj+inCzJFlqkUN
         Ur3wR38CCiTWzjVjaS5Ix8db25OGRIsy8fTahz9xLOZ1VnDrZ6tryndlLTgutXddhB81
         94Dsnk385uhq1OvtHrMJW2z8z5VtZFOht6j2E7eI2OFEIV05vfQKPhFExp4L21CcFRAA
         Jgw1XLKmXbH/Ekf+N0OvjKPT/b48mril2edmL7f5DQd/YYy+3h7efYDQriEthKkcogfb
         +wQzJStoUnn3KQ7BpwlS7vwalAHzd6uyasKNqz22DtNX7MvsiSV4FgBkCj0grtX0b0gu
         pVlQ==
X-Gm-Message-State: AOAM533aQlnNYCVClwyWDi3W3OzrEICCLEjJzleo4uuEdFxLy4x6DT29
        LylJxZv005HNAsM3k5GGDmkAWmSy5fo1mtw+iMA=
X-Google-Smtp-Source: ABdhPJzVNpFAK3V2ptELOJfJsiUjLoiRlUDqJ5H3ktji5fQsQxG85Q0UilSKLsfpiV+L2HEetSnF7Ir5XQXTt8zWN4U=
X-Received: by 2002:a17:907:9482:b0:6da:a24e:e767 with SMTP id
 dm2-20020a170907948200b006daa24ee767mr20271779ejc.479.1647309548400; Mon, 14
 Mar 2022 18:59:08 -0700 (PDT)
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
In-Reply-To: <CAD-N9QXN_DEmoqTEpFdCp=Gne1O3U=+8WpwjP638wbUn1Vb6hA@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 15 Mar 2022 09:58:42 +0800
Message-ID: <CAD-N9QVcSnboZqS7tXgU_iD8zzg5a_ubB3W2qtCFequS5u6jqQ@mail.gmail.com>
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

On Sun, Mar 13, 2022 at 9:35 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Sun, Mar 13, 2022 at 12:01 AM Ryusuke Konishi
> <konishi.ryusuke@gmail.com> wrote:
> >
> > Hi Pavel and Dongliang,
> >
> > On Sun, Mar 13, 2022 at 12:16 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > >
> > > Hi Ryusuke,
> > >
> > > On 3/12/22 18:11, Ryusuke Konishi wrote:
> > > >> In case of nilfs_attach_log_writer() error code jumps to
> > > >> failed_checkpoint label and calls destroy_nilfs() which should call
> > > >> nilfs_sysfs_delete_device_group().
> > > >
> > > > nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> > > > if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> > > > function tests this flag.
> > > >
> > > > The flag is set after init_nilfs() succeeded at the beginning of
> > > > nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> > > >
> > > > So,  nilfs_sysfs_delete_group() seems to be called in case of
> > > > the above failure.   Am I missing something?
> > > >
> > >
> > > Yeah, that's what I mean :) I can't see how reported issue is possible
> > > with current code.
> > >
> > >
> > > Sorry for not being clear
> >
> > Understood, thanks for the reply.
> >
> > If so,  the case where nilfs_sysfs_create_device_group() itself failed,
> > is suspicious as mentioned in the previous mail.   A possible scenario
> > I guess is :
> >
> > - nilfs_sysfs_create_device_group() on the first mount try fails and leaks
> >   due to lack of kobject_del() in the error path.
> > - Then, nilfs_sysfs_create_device_group() on the next mount try hits
> >   the leak detector at kobject_init_and_add().
> >
> > So, if the leak bug is reproducible, I'd like to ask Dongliang to
> > test the effect of the first patch.
>
> If my local syzkaller instance gets a reproducer, I will try to do this.
>
> >
> > Regards,
> > Ryusuke Konishi

Hi Ryusuke,

The crash still occurred in my newly set up syzkaller instance. It
appears after two days' fuzzing.

I remember you suggested me to add kobject_del just for testing,
right? And let's see if this crash still occurs any more.

> >
> > >
> > >
> > >
> > > With regards,
> > > Pavel Skripkin
