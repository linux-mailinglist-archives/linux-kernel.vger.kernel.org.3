Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B0574009
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiGMX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGMX1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:27:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C5548CBA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:27:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id h62so393959ybb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLq1U+d1bmcNfWsFJ6K/IL9XxkkFgeH5akYdfwOXkK0=;
        b=FBksoOy+S0aCWxyI2UXUB//mYF0XarHhcELqYLWfX3aGKjJxSFOD66c7QrR8mpgvCh
         ml1NaWom7AqZ77+nocy4d9LotD5hYlTKy5970upnY2Gv00mmNhdx5Zx8p6JhT1ACiZvo
         wkTY46EsuUBjwFTrS+n79bQRzJI4cWK1C8+NeuN7ggVr53XJHDy8ddXfdytSOz2Q1SN0
         1RC1HFTkSFmAzlO2eYvoLQYCopfJY2AUgxgaiQGtlJ/+eSb4qqrOdXilLT+6WLc4nKk7
         SppEjQZXkFXd/egJyHTziLcw1TVnnVxpDRCgtJ+0WdijwURE2AwGUivYMsc1azFQLp8p
         g+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLq1U+d1bmcNfWsFJ6K/IL9XxkkFgeH5akYdfwOXkK0=;
        b=a8Gdbq83BEtS7XrgeUNVPJvJ+h4Vc9/e6p/dNZh5RLAk4HDiCbJuW6UCpnnwrAayli
         7aP1b677+drPGq9Ldt9QnE1Z/cRQcEssMyFAVU1fCmqDtTfFnyGrm8tqwYJqe1SzK1+K
         F32c2+OgXyczK3/LuO9JEnRUf8yBtnR/nHeG9cXRTtiDfj5ATWOjEEMj1465WiqUZwR/
         /fHSBHYyNWYrLd62RSHZOWYEJL4mSRizC3V7Buw/HBFrsaLxIxCVU9p2k7nc1ynd6huO
         XJsMnsT8QbmgH5ZFNU3Go9zvYQunUm1bo4uGmZ3PsCJwb4ajcMv4QqbFF5SBBUE8XBBI
         qDOA==
X-Gm-Message-State: AJIora84cy78a0abiai1UVvhWp27cu4SNJzZFQUaToIevsPUFpmbJRns
        xt1V6j+dz/Zl0TWF6feKbHGZs9qm5l9IMC6lFKY=
X-Google-Smtp-Source: AGRyM1tf2PHunlzOKcP68GnhEt7k26NxZu9hWDuRWB/2Njj21U6X5rwz525eL9VplaSor2/TBOx6Em3oBgtWDaurbG8=
X-Received: by 2002:a5b:20d:0:b0:66e:3b19:82c5 with SMTP id
 z13-20020a5b020d000000b0066e3b1982c5mr6229993ybl.517.1657754823917; Wed, 13
 Jul 2022 16:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk> <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
 <20220713225627.GC32544@roeck-us.net> <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
 <20220713231211.GF32544@roeck-us.net>
In-Reply-To: <20220713231211.GF32544@roeck-us.net>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 14 Jul 2022 00:26:27 +0100
Message-ID: <CADVatmOAnoiZ1WE7iDBYCXVSiMo8RvC_P6mBhR_F75asfDWr4w@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 12:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jul 14, 2022 at 12:09:24AM +0100, Sudip Mukherjee wrote:
> > On Wed, Jul 13, 2022 at 11:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> > > > On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > > >
> > > > > > > >
> > > > > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > > > > >
> > > > > > > That patch looks sane to me, but I guess Guenter would need to check
> > > > > >
> > > > > > I still see the failure in my builds with this patch. But surprisingly
> > > > > > I dont see the build failure (with or without this patch) with gcc-12,
> > > > > > only with gcc-11.
> > > > >
> > > > > Arrghs. "build failure"?
> > > >
> > > > Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> > > > powerpc64-linux-ld, hard float and soft float.
> > > > But I dont see this problem with gcc-12, only with gcc-11.
> > > >
> > >
> > > Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
> > > gcc 11.2.0 / binutils 2.36.1.
> >
> > Its entirely possible that I have messed up, there are references to
> > many patches in this thread. :)
> > Can you please paste the link of the patch that you say is working for
> > you. I will try a clean build with that.
> >
>
> The patch is at:
>
> https://lore.kernel.org/lkml/20220618232737.2036722-1-linux@roeck-us.net/raw

Thanks, that works. tested with gcc-11.3.1, and binutils 2.38 on top
of latest mainline (4a57a8400075bc5287c5c877702c68aeae2a033d)

When I said I still had the problem, I tested with
https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/


-- 
Regards
Sudip
