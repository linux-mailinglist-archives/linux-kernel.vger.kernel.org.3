Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98798573FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiGMXKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiGMXKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:10:02 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ADA3F326
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:10:00 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c8a1e9e33so1004817b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8O302/7c4M+y4oSPuw97osYexdl2kGKky6mRepNyHk=;
        b=H09N2BCSGmpudE0ji2Q/gaZvJBtiZgN4m8BvrTevY/CHTWDL6gz4rjztzk441wczCU
         RX4gyudPZ0x6/dcPIjtS/PqA7m1mhDKscwmdHN5W5vsacoMRaca1xaX8Bi9c0vJ7912Y
         35miB9lQMLd1D54hGVRZ74ghp5WHLHU3DqsSCrXST6bNWO3IViYh+VjOlJqDoPapciKK
         B7ndbKU+2YYtw13rtVJZGEvMBwcAMWJwOye8ekF9n9tnm7IFdOyOki4IqzxnTMm2I4P6
         CmVlhgirpkFIW2USMZ6EmJ3cqChrEZJsbzK6ZtsZBz+KrDoC4VrgBy2HHOHBzZPFxO6H
         +T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8O302/7c4M+y4oSPuw97osYexdl2kGKky6mRepNyHk=;
        b=0ZAg8/XthfPJ2Hk1GsnnCxeVBFJLVA7xPaoLtEE/msrCvRpzFuzbxmp6YrhwM9B3NY
         zAieISQSV1wdbiUo/sLglBYq0yL5oxxXzjT3NzRja1dkvXjUzgpRSsaMFU51OUp/j16I
         f3xKn1Ti++9+R3jTRRMqINgSvrz171b9SI09zP6Je3sZiydm1MwZujlaNUdeD9MA/M/H
         Q4cGMWwMuCvpgGB56Q8zphv7R8M0DQDsE7w8aglvrxos+MsHqG57he4DLUrzNRvqAYg8
         JcuTnHDlv862ETvmALEQo0kNV3+zwRd2atfxPxZ2F7Ihfh6+DIqVqS2NLrTVKc3YyqRH
         idog==
X-Gm-Message-State: AJIora9WLZE0n1Rh5TGCaj6KOQMnBp0mAW7wzZqWhUpqQ7EOWJemeH5F
        zKCvUUmmf1ZukBmwGK1gD8eU10AqT5xIteFzAsDp6+10NSU=
X-Google-Smtp-Source: AGRyM1ta1KjbW6tgvLYjpf/6k/gpgB7wBMLpjjuGdsSpq+y6Of+DnuhfTohzZB61/WRXkJef9Gp/OdBu/c/GkCpjDpE=
X-Received: by 2002:a81:158a:0:b0:31c:a84a:d772 with SMTP id
 132-20020a81158a000000b0031ca84ad772mr6811397ywv.233.1657753800010; Wed, 13
 Jul 2022 16:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk> <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com> <20220713225627.GC32544@roeck-us.net>
In-Reply-To: <20220713225627.GC32544@roeck-us.net>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 14 Jul 2022 00:09:24 +0100
Message-ID: <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Jul 13, 2022 at 11:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> > On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > >
> > > > > >
> > > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > > >
> > > > > That patch looks sane to me, but I guess Guenter would need to check
> > > >
> > > > I still see the failure in my builds with this patch. But surprisingly
> > > > I dont see the build failure (with or without this patch) with gcc-12,
> > > > only with gcc-11.
> > >
> > > Arrghs. "build failure"?
> >
> > Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> > powerpc64-linux-ld, hard float and soft float.
> > But I dont see this problem with gcc-12, only with gcc-11.
> >
>
> Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
> gcc 11.2.0 / binutils 2.36.1.

Its entirely possible that I have messed up, there are references to
many patches in this thread. :)
Can you please paste the link of the patch that you say is working for
you. I will try a clean build with that.


-- 
Regards
Sudip
