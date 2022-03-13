Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB94D7582
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiCMNhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiCMNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:37:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C2E88B32;
        Sun, 13 Mar 2022 06:35:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g20so16411700edw.6;
        Sun, 13 Mar 2022 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zccpOQGxg8zf/WLe0i30SR+gOarK/aak88fI8Ek82bM=;
        b=C1imkZfR0+iA22h6UvM4AKtVsucnecGU+wrW6CQR32fv6HLYi7X22LWDofpOIEQ8+X
         2RKicOYjoHqopuDO7688f17Lug1fGWJelIpj0w4AyhNW5YCKERwsrdp+ij5W+VuJMIk0
         6Rgzv8d3y8AlVRur4PELK8/RoJNzJ/6YiznWRVzIjKchnIAo15L3rOQmQTnVFpULh3KE
         1MtPWHpS/OF4XOLewG1YkKj4f9X+Z8RETjSmtvO+EXl+Y0t8arzsP7FHds+WP5jwY/Nm
         xIyMqJLLJSVZRRFRpE1v6MsUHelVWRdBpTgqnJ62amy3Vi5b3CkvgpruS/M417jJTY/n
         3QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zccpOQGxg8zf/WLe0i30SR+gOarK/aak88fI8Ek82bM=;
        b=CoDTkzaxcWzw+VrV01Uv+RGyGGqoGDdVAgxbxY4pHuoHYKKdxj8zZsKu/rrUtloRjw
         LgziezNbBq/UdGzwVPIMOai6anGfTKfPKGzJgC9+JXVDSB1ZevOiqujF2FB/kHq38Xs+
         chLu34QvNFi+5wdEXk5lS5v+KBoReoeJ2WvVAYTGz94xT+y+xo0uUrqQUMfM58Woty++
         ShIYhxc34fMDJZ2eOUOYQH5L59247FdTwGYFvxyZBUjQqCMkxrRTQ3PSxeh4A4eTKoUG
         ya1eWCQGVmzGKRSaAYn4xeS5XXpXNxvGewSfX2Rh8ol6DL0uMnH/pwL2TEuaXkgcdlPP
         TdQA==
X-Gm-Message-State: AOAM53126QOaLgNVnsy5ngkPlSjNFpsmJdBUsXCPOgB0LRqYW1XA4bSk
        RFKRHSQTci7uCuVtENCr7ETK2PO1ZXQiMWGlvJU=
X-Google-Smtp-Source: ABdhPJwDaKiA7mZwMjPRFvi46UM+gfZO0wd/+GANR3v6DWT7gfqecoyAxBXxA69E/xnZTICRWH7oGp7Ah33gAsjFXIM=
X-Received: by 2002:a50:d903:0:b0:416:17b1:8557 with SMTP id
 t3-20020a50d903000000b0041617b18557mr16333836edj.372.1647178551186; Sun, 13
 Mar 2022 06:35:51 -0700 (PDT)
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
In-Reply-To: <CAKFNMon7cdJ092Ppne_kU6A23pRUb+1tThCkoB2vn0HN-rWUUg@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sun, 13 Mar 2022 21:35:25 +0800
Message-ID: <CAD-N9QXN_DEmoqTEpFdCp=Gne1O3U=+8WpwjP638wbUn1Vb6hA@mail.gmail.com>
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

On Sun, Mar 13, 2022 at 12:01 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> Hi Pavel and Dongliang,
>
> On Sun, Mar 13, 2022 at 12:16 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> >
> > Hi Ryusuke,
> >
> > On 3/12/22 18:11, Ryusuke Konishi wrote:
> > >> In case of nilfs_attach_log_writer() error code jumps to
> > >> failed_checkpoint label and calls destroy_nilfs() which should call
> > >> nilfs_sysfs_delete_device_group().
> > >
> > > nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> > > if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> > > function tests this flag.
> > >
> > > The flag is set after init_nilfs() succeeded at the beginning of
> > > nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> > >
> > > So,  nilfs_sysfs_delete_group() seems to be called in case of
> > > the above failure.   Am I missing something?
> > >
> >
> > Yeah, that's what I mean :) I can't see how reported issue is possible
> > with current code.
> >
> >
> > Sorry for not being clear
>
> Understood, thanks for the reply.
>
> If so,  the case where nilfs_sysfs_create_device_group() itself failed,
> is suspicious as mentioned in the previous mail.   A possible scenario
> I guess is :
>
> - nilfs_sysfs_create_device_group() on the first mount try fails and leaks
>   due to lack of kobject_del() in the error path.
> - Then, nilfs_sysfs_create_device_group() on the next mount try hits
>   the leak detector at kobject_init_and_add().
>
> So, if the leak bug is reproducible, I'd like to ask Dongliang to
> test the effect of the first patch.

If my local syzkaller instance gets a reproducer, I will try to do this.

>
> Regards,
> Ryusuke Konishi
>
> >
> >
> >
> > With regards,
> > Pavel Skripkin
