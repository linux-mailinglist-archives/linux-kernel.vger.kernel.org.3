Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F788573FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiGMXCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGMXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:02:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A952AC73
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:02:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso492134pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3DTffoizvAtkAXY7UkJCahcmR2dJ0DU6CtEuKHCRq9o=;
        b=k7/ZW/Sdqy4R6zQJQ1ct1EO+pB3HgV5W6cnvjNo06ybO0jIfWwv1AQJo2P9gm9dK7r
         rdacX3XXknIHJE/YghqOYhzAFcIHXvoqSW/7Zkwfycpq7njz6tX20Bop0OOIlu+JvkI9
         PFrBIhPVnvsnMFgv71usju89docCmUEJr+JBRp2n2dXoqcJIVf/YSkygQCrILg72xlHx
         11+ODprynW00kWeuM9v/sFjHnvZkuHVnJcwb1cMdYCgdvcK4SGccAgd1BSlly1eQsZV+
         imNH+UyzeroXK1g2nUCfbuxiFTUufJi+TzTt0ek2ucTViceMOe8gAWgIUYMI/qBUsBi8
         uV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3DTffoizvAtkAXY7UkJCahcmR2dJ0DU6CtEuKHCRq9o=;
        b=NG8SRhE9s/X2oor8ftAnX3fJzEhE2EZCrtW0qrb2dFwlJekoWk+22fkeWZ8Ys+Oe/1
         UrJUYBejx41AgqysckKYQvEtboc+RiGfsuSvOjDLwC+NOPdNomxSXuzsiZi1s+QaJjNz
         bMXhK6ffUk9vaxicvOwWMgbbDyQWERs7mrxohoY7y4iS0MfZBWiL6TMpa6WsR6x6hRKd
         4aVXuVPNFRYSECDCezuhlRF7onjBPbHvHrpZOFFq7pGyFShCsnhzsW2DnIuvhCh1i0aJ
         GDWQdULIwASLBzhXPiJfUr/N32I+S2OJOh+JBoQra/mkVQeHL2fIGKgpcX6yf1YlZE5B
         Foww==
X-Gm-Message-State: AJIora92FGBPzxI8VEQDRIKbNQrqK9Q1ShP4GezcyOChK86hzFptR0dP
        Xcn15gyO9m27PQlW69el9lw=
X-Google-Smtp-Source: AGRyM1tAukgwSUDLM2s8DTW1z2VMC3B4PF4X7AJrrp22zHg8TsoXCbl0m15KHsB1DfqgJB4DtXOqoA==
X-Received: by 2002:a17:90a:e58a:b0:1e2:fe75:dd5f with SMTP id g10-20020a17090ae58a00b001e2fe75dd5fmr12829460pjz.138.1657753350426;
        Wed, 13 Jul 2022 16:02:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79596000000b00525373aac7csm83390pfj.26.2022.07.13.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 16:02:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 16:02:27 -0700
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
Message-ID: <20220713230227.GD32544@roeck-us.net>
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

I am wondering ... you say "my builds". Is this possibly not
allmodconfig ? It may well be that there are other configurations
which still have a problem after my patch has been applied.

Guenter
