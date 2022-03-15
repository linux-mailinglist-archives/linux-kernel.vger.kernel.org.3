Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35B4D936D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbiCOEsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiCOEsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:48:08 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DFD4889E;
        Mon, 14 Mar 2022 21:46:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f38so35074103ybi.3;
        Mon, 14 Mar 2022 21:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRzn8eRjAosB0Lq3ZWrtgrXgceRWX7F0ljBW2WcAAuc=;
        b=Atm2WiiAo9JQYiZ54eHBar5EM7t6k8oreb77UJm36jBv61Z8ggABk3JCHao5vOqZdG
         A2WtZz/mFh8vtddJGi9FpafmvP1w7ukAMc6aw3zDT6RUPZFse6OhzLnzWmE7ozAubDjQ
         Z5rVBq5W7G0QNKGFZ5ZgFhc3c7DRmQQ69DtotwWg+J0IVfA8BCrZWczXjCErNVyVSvFG
         jma4CP/IujVZMKT1Ti+wMHKGt2hgO3+EbXDwIfiFeLvpeWOkP1F1uHsnXlMC/B/T8dab
         dtCyMDcMWCrJj168ZHGXEVJMZ5dkrJrpo0eFLKo/cYYBq78Wxt0AJ2bm6gyxvoLDB27d
         HvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRzn8eRjAosB0Lq3ZWrtgrXgceRWX7F0ljBW2WcAAuc=;
        b=AFXcLP5sXmxT9qJCX0wuDNCqS69G8Go3zSyvxkcFkmsG+CPzOF3qhXPOCfz0zI4NFT
         l1fACk9mK+zy/GCayU/ClMCG8D5c0PSgRf7/7fD2lkpPPurR7YxLjJ1QMX3RlBGeb5mm
         6O9Jf5tBe8j5yOp7VyJlbH66DWV3vhHnavkedLw8XsNGybjtC6gOk72z10qm5+ec2YQD
         uk5zvC4zQ/1sk1alVoM4zJ8VdcH5Z+sg5NE5NKhSPrV++Ir9Qp4A+T3uouQoxZGChnLs
         iM7oNpce3kUxbYSF9l4i/CVw4ijQSSvREAnmgneM43al8MCZHT8fshik5EWi4z8ucgPX
         ey/A==
X-Gm-Message-State: AOAM530eiVKsODwvVP23XK7J2k1t1bU6HM+FNBZv6f+tp37//inRSRpZ
        voMxCqdj7Ko8Mq6j94apcop3LlbX3mszcoz4064=
X-Google-Smtp-Source: ABdhPJzmCidjr9dfWF7dVZ1dVXksr637xOg3dKCefU+Cg+on0TbWj+1xLMnaW4AWnWS6y9iFVYTAFCp38Bk+0pEU3WY=
X-Received: by 2002:a25:b2a4:0:b0:628:c38e:43cf with SMTP id
 k36-20020a25b2a4000000b00628c38e43cfmr21245908ybj.21.1647319616015; Mon, 14
 Mar 2022 21:46:56 -0700 (PDT)
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
 <CAD-N9QXN_DEmoqTEpFdCp=Gne1O3U=+8WpwjP638wbUn1Vb6hA@mail.gmail.com> <CAD-N9QVcSnboZqS7tXgU_iD8zzg5a_ubB3W2qtCFequS5u6jqQ@mail.gmail.com>
In-Reply-To: <CAD-N9QVcSnboZqS7tXgU_iD8zzg5a_ubB3W2qtCFequS5u6jqQ@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 15 Mar 2022 13:46:44 +0900
Message-ID: <CAKFNMo=uYDbrwDpqeehbdT5va3X1yw5uBoec1q8AoNAADtrELw@mail.gmail.com>
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

On Tue, Mar 15, 2022 at 10:59 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Sun, Mar 13, 2022 at 9:35 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Sun, Mar 13, 2022 at 12:01 AM Ryusuke Konishi
> > <konishi.ryusuke@gmail.com> wrote:
> > >
> > > Hi Pavel and Dongliang,
> > >
> > > On Sun, Mar 13, 2022 at 12:16 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > > >
> > > > Hi Ryusuke,
> > > >
> > > > On 3/12/22 18:11, Ryusuke Konishi wrote:
> > > > >> In case of nilfs_attach_log_writer() error code jumps to
> > > > >> failed_checkpoint label and calls destroy_nilfs() which should call
> > > > >> nilfs_sysfs_delete_device_group().
> > > > >
> > > > > nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> > > > > if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> > > > > function tests this flag.
> > > > >
> > > > > The flag is set after init_nilfs() succeeded at the beginning of
> > > > > nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> > > > >
> > > > > So,  nilfs_sysfs_delete_group() seems to be called in case of
> > > > > the above failure.   Am I missing something?
> > > > >
> > > >
> > > > Yeah, that's what I mean :) I can't see how reported issue is possible
> > > > with current code.
> > > >
> > > >
> > > > Sorry for not being clear
> > >
> > > Understood, thanks for the reply.
> > >
> > > If so,  the case where nilfs_sysfs_create_device_group() itself failed,
> > > is suspicious as mentioned in the previous mail.   A possible scenario
> > > I guess is :
> > >
> > > - nilfs_sysfs_create_device_group() on the first mount try fails and leaks
> > >   due to lack of kobject_del() in the error path.
> > > - Then, nilfs_sysfs_create_device_group() on the next mount try hits
> > >   the leak detector at kobject_init_and_add().
> > >
> > > So, if the leak bug is reproducible, I'd like to ask Dongliang to
> > > test the effect of the first patch.
> >
> > If my local syzkaller instance gets a reproducer, I will try to do this.
> >
> > >
> > > Regards,
> > > Ryusuke Konishi
>
> Hi Ryusuke,
>
> The crash still occurred in my newly set up syzkaller instance. It
> appears after two days' fuzzing.
>
> I remember you suggested me to add kobject_del just for testing,
> right? And let's see if this crash still occurs any more.

You need a few days to reproduce it ?
If so, I think this confirmation method is uncertain.
In that case, I will try inserting an artificial error by changing
nilfs_sysfs_create_device_group() a bit to confirm if the same crash occurs.

Ryusuke Konishi
