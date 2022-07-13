Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE773573FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiGMXMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiGMXMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:12:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFA5070A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:12:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so6189407pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pjvd38sMQ0s3XmHKT3cdWb0EkqYt/fWbMQjoxI+K9uc=;
        b=W6tKMLRIBvc6bvqVQFAHIge/0Ft/PiMVC0pIdzLaYsiLwrxDBGrm4gSwcJ/RAm1Bmx
         RkfHRmutCtraFJYBEeG683xsTgMHIhoJAA3KKsxgC7Lqz+Hiha5QEppoDtCnwND2ntv2
         pga2kH8CNoBqOJxIzsuepklAU7HIZXCM3KAZqPIpFCRl7AdGA+HhsDCxhFPbIfm/oFez
         8u+vZYdSI7OVGBfeFMsaUxcDkrDSPIlW3sBMd1xesuhjhs2L4b+kISqQJvz0Ckrabku7
         /+/uU3JH8tjEEXHS7eyym6tlwI4QKho1Rd7G2kqtppxzUzN/jxTvLMJEjFue6eWdGevn
         6niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pjvd38sMQ0s3XmHKT3cdWb0EkqYt/fWbMQjoxI+K9uc=;
        b=H5/bnGcv9Dr36GiJzwpeTaNeSk54untNkSWbVInQLxIvrOlMCPFz4VvQZAecnww5A/
         Vyj0VGtlm6XCf+qDvBN5WvNuWumMOJiG/PX1j7iHfeThRqF21TZ1Lq8ISGouD+lzckVh
         1om6sEMJvZXk3EU7gou2yAthJdVbtfPMAEvb/kRg6GTlM/hDVSDu3XNLuwhbq+U2hJUy
         KcRguS4dSYb6I4e53gvk8hqQ8E09fxZjbVqZtSg1yvdfw01wP9Xrl6bnTMmKMQFkVIDw
         D37ZTr3P2UOs8Nm5cq5BpakrngKPJDZkvgfrzX7JZzm8H2RTWmen+z8Q94O4UtxNMY1U
         obJQ==
X-Gm-Message-State: AJIora8ASStXG5kLg9vB9PM421+0d3xVm6/0DoOn/IEWISSeyT9vaYV0
        mTyLkHre4bn3VoBgd8IsbAY=
X-Google-Smtp-Source: AGRyM1u/CjJvF4vni4UIvSLlxLYhxu00JSEBts6bQ8UdOb4GRNyhtdb+lRlBjvTI+kX84b9MLYyFyQ==
X-Received: by 2002:a17:90a:e00c:b0:1ef:81e6:9044 with SMTP id u12-20020a17090ae00c00b001ef81e69044mr12664161pjy.169.1657753936028;
        Wed, 13 Jul 2022 16:12:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b30-20020aa78ede000000b005289eafbd08sm96382pfr.18.2022.07.13.16.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 16:12:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 16:12:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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
Subject: Re: Linux 5.19-rc6
Message-ID: <20220713231211.GF32544@roeck-us.net>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
 <20220713225627.GC32544@roeck-us.net>
 <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:09:24AM +0100, Sudip Mukherjee wrote:
> On Wed, Jul 13, 2022 at 11:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> > > On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > >
> > > > > > >
> > > > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > > > >
> > > > > > That patch looks sane to me, but I guess Guenter would need to check
> > > > >
> > > > > I still see the failure in my builds with this patch. But surprisingly
> > > > > I dont see the build failure (with or without this patch) with gcc-12,
> > > > > only with gcc-11.
> > > >
> > > > Arrghs. "build failure"?
> > >
> > > Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> > > powerpc64-linux-ld, hard float and soft float.
> > > But I dont see this problem with gcc-12, only with gcc-11.
> > >
> >
> > Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
> > gcc 11.2.0 / binutils 2.36.1.
> 
> Its entirely possible that I have messed up, there are references to
> many patches in this thread. :)
> Can you please paste the link of the patch that you say is working for
> you. I will try a clean build with that.
> 

The patch is at:

https://lore.kernel.org/lkml/20220618232737.2036722-1-linux@roeck-us.net/raw

Guenter
