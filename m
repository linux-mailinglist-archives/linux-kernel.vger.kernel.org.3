Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FC573FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiGMW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGMW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:56:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88894F67B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:56:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fz10so512841pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ALmsjo20iDq07XHHp8hpMGpJ3WDhp0g9JmzUyOXBoCM=;
        b=JHtzZWeUscDe/NjfuYFmLnY1UjC/BzmUB4H+A2+N3HrOgtyNPI0iG5FaA1VaXxybCp
         mHZVBAhRW9cXndUaawFFIXstvQ6oojNbyZmEvvWPXCd9nxggREDJlDVQk+1aDN6Bq5Vc
         Ej/MBMxV71S3F1TZqh5POlcnQRkVcg6haDsv8est59YY8SzzTsQEZ9rFPxnY6oZMZI7O
         maJ4x/HoxSBZbupP2IkXd0WPHa3PWS4JfuyMJmxl6x0iu+xHWGSQZh4CSHlQZsBQJdlS
         stuDk4v/KIZv1gMLII6nxGLnx8L4iAWUr68vzt/G9+pQfpsQHTZW/UWyEQwZfXthBpVf
         q/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ALmsjo20iDq07XHHp8hpMGpJ3WDhp0g9JmzUyOXBoCM=;
        b=5yClwImjWvgq3QGW9QBfQKfd6P0HFd/twkIz42tWTcD4coNW1q5FWagaCuJgWObWbj
         RpJv4/09+a4HjdoZEzNn4/8w4YjaBIURoepV4WPwLCVNvmJ9zRrU2CNfTkPjXoedkBV6
         K+TrVXI6v1+oK3IQ9ZC5/kIpSpx4qlu7pEVAf0Tds6t4UONC26Kq9usqWoIen1HBu6PD
         plbv6JZMeYy8+7lMbLOKB3KzErW0pV7Cv7sRF+mVcd5VI5YqqrtDIaRkpjxR0oCvP1S5
         aQucZcZ18tPAKhCvEXxCqJ3V60V0MX9I6UJPst4HK3YZAdF52xmkv3ntfZvzZgCSCMcx
         a4Xg==
X-Gm-Message-State: AJIora+2GHt3wzycOk4+4hswtTkPPXgvG7NF85KekV7KTx/DpR9t0bNF
        tQr7lV8Bx6ZCKFpYP6rZyCA=
X-Google-Smtp-Source: AGRyM1ssTP6Thy3UB20epNnuCWSDPBTNSUJXlSgGX6sg8IBzM8ZlJakJTn9/vCXGS5PpybokpfWpXA==
X-Received: by 2002:a17:90a:590e:b0:1f0:1dd9:bf6c with SMTP id k14-20020a17090a590e00b001f01dd9bf6cmr6148501pji.15.1657752989217;
        Wed, 13 Jul 2022 15:56:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y20-20020aa79af4000000b00518764d09cdsm59039pfp.164.2022.07.13.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:56:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 15:56:27 -0700
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
Message-ID: <20220713225627.GC32544@roeck-us.net>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
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

On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > > >
> > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > >
> > > > That patch looks sane to me, but I guess Guenter would need to check
> > >
> > > I still see the failure in my builds with this patch. But surprisingly
> > > I dont see the build failure (with or without this patch) with gcc-12,
> > > only with gcc-11.
> >
> > Arrghs. "build failure"?
> 
> Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> powerpc64-linux-ld, hard float and soft float.
> But I dont see this problem with gcc-12, only with gcc-11.
> 

Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
gcc 11.2.0 / binutils 2.36.1.

Guenter
