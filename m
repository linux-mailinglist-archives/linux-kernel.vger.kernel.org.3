Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780FE4D973F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiCOJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiCOJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:12:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03D4DF6E;
        Tue, 15 Mar 2022 02:11:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o5so7136080ybe.2;
        Tue, 15 Mar 2022 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuPnyAyMJk/3njlZ9gcwzbh+ihMGKNAAbYLpOKNzeIk=;
        b=omeoxDtk8AhX/Dymq7tg0jOwKOnUlKYMiT5n62V9Ttl6cwMBGp9GWIHczzLZMdpFYq
         Ha5S/bZd3QT77r8jtGOuSFUQuh0GvR1M+BdsnRAgV1EH6661k7BI/lIg29B7Rtgg7hEv
         YfFRAaJ1VWR+jjRouRknMRL4TaH9dGp7nteFLBoKpg5h8fp2bVwkzz0/Homw+U4PU2yt
         bvWntBzaKtgSWGYH5KHIFFgQCPLoavdVh+PX6GLkSlR5bqAPYYfCC3J3YZ+yT0iH2sdJ
         qPJohWg95iNB1WF6o0DXjeIv6LnT0IyjS5C+2NA3Kt3+FyTn0XcQy2nr2fr+iTZ/SnYR
         O2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuPnyAyMJk/3njlZ9gcwzbh+ihMGKNAAbYLpOKNzeIk=;
        b=sgHXqPdeunKGkZExTMECI85tq2z6KCD6bTiMnlsAbFlOr8qGgz6+SeI3egNsQWl10g
         xAUpXjmVLsnzB9pWGwHH/kS+BgKostW7+9nkIHPAPyF7CClr2/582JATEYfH9wXemmjy
         1FwJa6KMtrVHyFMKYLXShy6vOm+7CTqSKIQ52DIVUna7AMHMLWAT4NS/QzvnLKOzKJOt
         c5sOMc5vSUrs5L+RlRnRcqBAAPJpn1Yvy+yeQsIHMDjGUNIQDi6rJeulGmjJrAUtSJM8
         ksbguuIIDd7zEJe1HDvGa5zVZzYXMUHqgiVpINrBPYlC9UC9CYJMy4dgWgVuJkws86bU
         3vyw==
X-Gm-Message-State: AOAM531wAemli957ZbUMe/Mx1rc36eA/a+FP4i5DUGqSpniX1xkDy9Bi
        GuDdyZKGVc/SAmrA+EVlj+Nxun7Zy3w0rmhHBmw=
X-Google-Smtp-Source: ABdhPJzgNRc9qXycl51f+r+Ddkw8x2drMWMz6Z1h1pjWm6L+LHdfPmxd5OChDx5qEZtJOZBYsvJ/b37FAiGk38/wbyY=
X-Received: by 2002:a25:fe04:0:b0:628:af01:f734 with SMTP id
 k4-20020a25fe04000000b00628af01f734mr22278936ybe.441.1647335485807; Tue, 15
 Mar 2022 02:11:25 -0700 (PDT)
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
 <CAD-N9QVcSnboZqS7tXgU_iD8zzg5a_ubB3W2qtCFequS5u6jqQ@mail.gmail.com>
 <CAKFNMo=uYDbrwDpqeehbdT5va3X1yw5uBoec1q8AoNAADtrELw@mail.gmail.com> <CAD-N9QVOPXmm3pPX+F7X2SATaVHA=s1P9zD-3W8WyJWEY1HF5w@mail.gmail.com>
In-Reply-To: <CAD-N9QVOPXmm3pPX+F7X2SATaVHA=s1P9zD-3W8WyJWEY1HF5w@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 15 Mar 2022 18:11:13 +0900
Message-ID: <CAKFNMonQwnHj=QnaBGb3s-V8hL1zbxrogLU4yutPd1dMfoCBMA@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Dongliang Mu <mudongliangabcd@gmail.com>
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

Hi Dongliang,

On Tue, Mar 15, 2022 at 2:50 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 12:46 PM Ryusuke Konishi
> <konishi.ryusuke@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 10:59 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > >
> > > On Sun, Mar 13, 2022 at 9:35 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > > >
> > > > On Sun, Mar 13, 2022 at 12:01 AM Ryusuke Konishi
> > > > <konishi.ryusuke@gmail.com> wrote:
> > > > >
> > > > > Hi Pavel and Dongliang,
> > > > >
> > > > > On Sun, Mar 13, 2022 at 12:16 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > > > > >
> > > > > > Hi Ryusuke,
> > > > > >
> > > > > > On 3/12/22 18:11, Ryusuke Konishi wrote:
> > > > > > >> In case of nilfs_attach_log_writer() error code jumps to
> > > > > > >> failed_checkpoint label and calls destroy_nilfs() which should call
> > > > > > >> nilfs_sysfs_delete_device_group().
> > > > > > >
> > > > > > > nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> > > > > > > if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> > > > > > > function tests this flag.
> > > > > > >
> > > > > > > The flag is set after init_nilfs() succeeded at the beginning of
> > > > > > > nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> > > > > > >
> > > > > > > So,  nilfs_sysfs_delete_group() seems to be called in case of
> > > > > > > the above failure.   Am I missing something?
> > > > > > >
> > > > > >
> > > > > > Yeah, that's what I mean :) I can't see how reported issue is possible
> > > > > > with current code.
> > > > > >
> > > > > >
> > > > > > Sorry for not being clear
> > > > >
> > > > > Understood, thanks for the reply.
> > > > >
> > > > > If so,  the case where nilfs_sysfs_create_device_group() itself failed,
> > > > > is suspicious as mentioned in the previous mail.   A possible scenario
> > > > > I guess is :
> > > > >
> > > > > - nilfs_sysfs_create_device_group() on the first mount try fails and leaks
> > > > >   due to lack of kobject_del() in the error path.
> > > > > - Then, nilfs_sysfs_create_device_group() on the next mount try hits
> > > > >   the leak detector at kobject_init_and_add().
> > > > >
> > > > > So, if the leak bug is reproducible, I'd like to ask Dongliang to
> > > > > test the effect of the first patch.
> > > >
> > > > If my local syzkaller instance gets a reproducer, I will try to do this.
> > > >
> > > > >
> > > > > Regards,
> > > > > Ryusuke Konishi
> > >
> > > Hi Ryusuke,
> > >
> > > The crash still occurred in my newly set up syzkaller instance. It
> > > appears after two days' fuzzing.
> > >
> > > I remember you suggested me to add kobject_del just for testing,
> > > right? And let's see if this crash still occurs any more.
> >
> > You need a few days to reproduce it ?
> > If so, I think this confirmation method is uncertain.
> > In that case, I will try inserting an artificial error by changing
> > nilfs_sysfs_create_device_group() a bit to confirm if the same crash occurs.

I tried to change the code of nilfs_sysfs_create_device_group() so that
an error occurs once every two times.
As a result, the leak bug was not reproduced.

In addition, by kobject debug messages, I saw that the device name
("loop2" in your case) was properly freed through kobject_put() even in
the erroneous case.

So, my previous guess was wrong.
Looks like there is another cause for the leak of the device name.
It may not be a nilfs2 issue, I don't know.

> I am reproducing another bug [1] recently. If you can spare some time
> figuring out the underlying issue, that's really great. Or we can wait
> some time for the bug to disclose more, after all, it is only a rare
> memory leak.
>
> [1] https://syzkaller.appspot.com/bug?extid=045796dbe294d53147e6

According to the log, it looks like "erofs_put_super() ->
erofs_unregister_sysfs()" hits:

  kobject: '(null)' (ffff88807b550190): is not initialized, yet
kobject_put() is being called.

This warning is output in kobject_put() if kobj argument is not in
'state_initialized':

  void kobject_put(struct kobject *kobj)
  {
         if (kobj) {
                    if (!kobj->state_initialized)
                              WARN(1, KERN_WARNING
                                "kobject: '%s' (%p): is not
initialized, yet kobject_put() is being called.\n",
                             kobject_name(kobj), kobj);
                    kref_put(&kobj->kref, kobject_release);
         }
  }

How about chasing this abnormal condition ?
Anyway, please ask erofs maintainers and linux-erofs mailing list for this.

Regards,
Ryusuke Konishi
