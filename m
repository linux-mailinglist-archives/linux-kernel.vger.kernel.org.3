Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF999573F26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiGMVup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGMVuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:50:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271E2D1D4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:50:43 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31c8bb90d09so126664067b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2pu4moFR6OZfbNnmmlWYDiflwcBu9QRadHD8oHB0DA=;
        b=Wl/S4XdDh6uSlJZCE6qwqiRw7llHQunIS/4w+LANKgOkbCXNk5VswazBrrHx/8VCEs
         EHUTnoMTA7WOv9rEsprogenqBEcHP83ulXJP/mwKgT66InOiiZ3tpsbVG8998rw0ZUB+
         JA2FTd3HgIGTfMy8VKne1C7AJ9qbFB+bG79+sOEvFkixQwYQD5PoiKisfjJKfwOJjCsz
         ZPpCFwsXpZdIfZek2Yq91hXx8HBCc4HMSfLKs505z8xYEew8D2PEkhDubK2IRkiNODSu
         4kftXkS8XGm2WcrJ3veaREUcsQI+2Qm4zaeBTSFSbVXvfZ8N3CM28kNKAqdBmIsBfZ97
         QKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2pu4moFR6OZfbNnmmlWYDiflwcBu9QRadHD8oHB0DA=;
        b=szZ3o436lQzDJYmFou2491d1Gm65zuxdVo/j8B6S+/khzJKF7rwLjqR6XjlEtWRe3s
         9mac3Ea8esSEWzqY0teEWv+ilT2MqdW05Xyo/HjlQ+ISZmOEKIJ4OOCUvOCDxt2z5SRJ
         +BYxNm8ORoiGNCtxxOEZElUUfE/4BXcW9l2JVo81ZP/akVpUaGANSDyArAL1m+Eh2WC1
         9PxBPUh5wVNP7rdp1TPRhW4yWgtcLzEiZlN3PoSiqVU73Rd9VTghxwBqBabREZjw6/aR
         y/mmvR2kNDuFtVrWxHqz/w0tAZvEeI9EchMwweNOYt84DDn0qqZku/n52F6SFN1ZHJbP
         bIdA==
X-Gm-Message-State: AJIora8Itdk2+4PfUh5ENYDJwm5KUE+4ECtug73gel45p5PvqAQOq6p/
        kKFDWYDvm87AgWN2Y7shEP/Equgvn4FQbzYxtVM=
X-Google-Smtp-Source: AGRyM1s5vhr8Crl//JQCBry1DQg8dljPCkZtXw8TlEZ3/E1XNcAEAeOVweBVFcYiYz9kJcDuAJQhHhXTlVM7/K40IOg=
X-Received: by 2002:a0d:f602:0:b0:31d:a033:3438 with SMTP id
 g2-20020a0df602000000b0031da0333438mr6551634ywf.39.1657749043210; Wed, 13 Jul
 2022 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk> <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com> <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
In-Reply-To: <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 13 Jul 2022 22:50:06 +0100
Message-ID: <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
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

On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > > >
> > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > >
> > > That patch looks sane to me, but I guess Guenter would need to check
> >
> > I still see the failure in my builds with this patch. But surprisingly
> > I dont see the build failure (with or without this patch) with gcc-12,
> > only with gcc-11.
>
> Arrghs. "build failure"?

Uhh.. no, sorry.. I meant the same problem which Guenter reported with
powerpc64-linux-ld, hard float and soft float.
But I dont see this problem with gcc-12, only with gcc-11.


-- 
Regards
Sudip
