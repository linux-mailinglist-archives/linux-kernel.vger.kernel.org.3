Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3645575EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGOJee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGOJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:34:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74A7B7BD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:34:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso41644537b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayS4WjR+67psD2vTxMdscs9JVmSfKJeEmETeoMNiN74=;
        b=J6oftZ4YxvHxMDEtCHluswHh++rLfXFf+1FzpUgaz43eq2rFUpNuRIaNourLloq0S4
         be9eBJSeqJBq8yGaa4hSbg3hs4WwMxrMs6AbOpkyMbKbLNABk7Xii69kvbsanz/Qz4sc
         Voq1pm1J8SI2X8V5MbesKFBE/DM1vIiv3cn/jW+Jc95Kgxc9qpaKByLJZDsGacVl8rm6
         KYzycacvwK7kDhlVE3kgF6De7T8KtOSJwKRhzVjZc5zitcb/Tjk5Y9QedjXAchbbasRw
         HbSqzfK759z5tCGudcTatK3/lcXOLQMF1w9Q0+ql+SY6Ji/JpTMJ/7j+rH4SS+jiszkD
         eTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayS4WjR+67psD2vTxMdscs9JVmSfKJeEmETeoMNiN74=;
        b=4xfLPv9HzAtDsiVpuCDXyxPMUmcXJOBA2u4RybbixTLz/81Iytb2tSpAVv8/eKtXDN
         iZ7gTdeEJRsclFP4cp+tHRFy+hkmhiOGhBbeUWbB+TS2XCgiw6PtlRZvN1LaLZ6CnkEV
         uN3D6KKLLygsFPKWm2174lZkOFLL1A6eyxIfwcgc6CweTx4tacjrLcsJ2VwLxm40/lEx
         B9mXZXqUgQe3yUqOk3vkOaJeHobnbFfV65vTtqrJT6wy6qPKEfDBJ64BlGAyhLndAWlB
         TwPrVGSJgCQTbGonbKX2MRMopCkNQd4rcY5ZJEzJLfCaUsaG/y8Nhv8iwvK8h6DUQIiT
         TCoQ==
X-Gm-Message-State: AJIora+kEvz+yF7q4KSdB7OTqGL4+1XGzSs1ClZDi65iS01ROdwAhzDV
        +y1ECz4Kv5E3WH/KbOnmCe37rHf+1+/k6C6MFts=
X-Google-Smtp-Source: AGRyM1smyXtSVObDs+Zf7m/60pxrCys9dxGjP2XzE8Pi+TP3J+a4xmssY21qpiOE/VP9OPJH8jkSMkOLprWTuHC2x7g=
X-Received: by 2002:a0d:db50:0:b0:31d:83a4:cbba with SMTP id
 d77-20020a0ddb50000000b0031d83a4cbbamr15062685ywe.478.1657877671544; Fri, 15
 Jul 2022 02:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com> <9d18166d534dc30d83f2255d4512619aa6b3b517.camel@russell.cc>
In-Reply-To: <9d18166d534dc30d83f2255d4512619aa6b3b517.camel@russell.cc>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 15 Jul 2022 10:33:55 +0100
Message-ID: <CADVatmPHN6+5G0oMLEebhrCsHiF_kExTbCT2VivKRcs0M2Ng0Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Russell Currey <ruscur@russell.cc>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Leo Li <sunpeng.li@amd.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Jul 15, 2022 at 12:34 AM Russell Currey <ruscur@russell.cc> wrote:
>
> Hi Linus,
>
> On Wed, 2022-07-13 at 14:32 -0700, Linus Torvalds wrote:
> > On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com>
> > wrote:
> > >
> > > If you want to apply Guenter's patch original patch:
> > > https://patchwork.freedesktop.org/patch/490184/
> > > That's fine with me.
> >
> > Honestly, by this time I feel that it's too little, too late.
> >
> > The ppc people apparently didn't care at all about the fact that this
> > driver didn't compile.
> >
> > At least Michael Ellerman and Daniel Axtens were cc'd on that thread
> > with the proposed fix originally.
> >
> > I don't see any replies from ppc people as to why it happened, even
> > though apparently a bog-standard "make allmodconfig" just doesn't
> > build.
>
> I believe Michael Ellerman has been on holiday for some time, and
> Daniel Axtens no longer works on powerpc (and wasn't the one that
> submitted the patch, it was submitted by Paul Mackerras, who wasn't on
> CC).
>
> The proposed fix didn't get sent to linuxppc-dev either, so it's
> unlikely many ppc people knew about it.
>
> We certainly should have noticed allmodconfig was broken, and should
> have more than just Michael keeping an eye on all his automated builds.

Not sure if I have added the correct people in my another mail, but
thats also ppc allmodconfig with gcc-12.
https://lore.kernel.org/lkml/Ys%2FaDKZNhhsENH9S@debian/



-- 
Regards
Sudip
