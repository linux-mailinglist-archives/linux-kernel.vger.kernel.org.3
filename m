Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D034FF0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiDMHmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiDMHmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:42:43 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853391EEE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:40:21 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-deb9295679so1175458fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuyhuEqANzev0cKOLpM4ig8GGXWov+120f9VOJbnhrk=;
        b=FGfnS8WBE7XXHxeKpo3Ra2H6fp10rRmWaI0sCx2CTO7jRNsBZAIF0+guMeiM8PNVey
         CpHZ8Cf0n9AwTd55SmXSbJ3MmevU8Y67MuuqTwoVUSwwS7HXT7DwHfphCSVQsOa1drjz
         +zKbeDjsZAVxEF2LJOeWTy72s2OAARu4QMp0KDs8vCrQgDNozR3lqD5A3/lDebRRlBjj
         Zj0cupEumm35ZhWu5yjWQ3WCaC2mrZMsdBdwxmBVD5KJuth7vD/WuJtIRwrgd3Uv+1Pg
         49y7t7YwFUZxibK20vYSfh44oyqDFQRHg7UiZcXcbCpgcizEeC0y4ahSwdvHG0BpvWzu
         EbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuyhuEqANzev0cKOLpM4ig8GGXWov+120f9VOJbnhrk=;
        b=DUm227zKZVOpFYGii0mwnaw+dEeaw2HfRrTV1/5cEDSKh9d2l4gCi5XOjVE1GJBlMy
         fMzySHFfHk74uP098YIo+0n+SbcskPqPpZX3Hy8pU+9kcSijYVj8sM7xY69flp+mcoic
         ZB5W8eAuP8eRk6zfYakcJfb1TKgBOe0KPffK8GC0Td5OjYcvF+peCRO+Xuqh4UersDxk
         wmOhNawX732QrDjwvDQg1xgRWt1/5lhSFA0vhYp7URCd/nSq25GwYrVcQ8iNtXXECAGF
         V+FcK4B1o1SYcXFtCkYpvIzc42K64hG0NUIpnoUwXy1TVcQZSoda0Er2SV0AHotd46i5
         SFlg==
X-Gm-Message-State: AOAM531dpNv/2ekgAAaVlKud+ctngZoagvP/JpSYyzg08CXVizKJpzyK
        eJZ7dZg21TCPTGWXpzSULkNSdrWXlgq0jgOL1jqxOanRijo=
X-Google-Smtp-Source: ABdhPJwjCRxFPeTpF/Fr9wUtYwB9BHw1ev1cpy+Hr/RTIW4HU1x6eQiGAjLF7fPL9pR1+snBUeLgny5ltZNrlExylTg=
X-Received: by 2002:a05:6870:9728:b0:e2:c115:488f with SMTP id
 n40-20020a056870972800b000e2c115488fmr3842246oaq.152.1649835620885; Wed, 13
 Apr 2022 00:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220413071137.4023184-1-rfried.dev@gmail.com> <YlZ7fQIpXNJSbd+P@kroah.com>
In-Reply-To: <YlZ7fQIpXNJSbd+P@kroah.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Wed, 13 Apr 2022 10:40:09 +0300
Message-ID: <CAGi-RULbkLS0wRQni8mQ0Dp_dAGuRSj96TmqD7oD+Tj=zSo3Gg@mail.gmail.com>
Subject: Re: [PATCH] uio: make MAX_UIO_MAPS & MAX_UIO_PORT_REGIONS configurable
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 10:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 13, 2022 at 10:11:37AM +0300, Ramon Fried wrote:
> > MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS are hard-coded to 5.
> > This is not always sufficiant for some drivers.
>
> Why not?  What in-kernel drivers need more than this?
Obviously kernel drivers don't need more, but I'm developing a driver
that needs more.
>
> > Make the MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS configurable by
> > providing Kconfig int option with the defaut value of 5.
>
> Spelling check?
Ack, will do.
>
> >
> > Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> >  drivers/uio/Kconfig        | 14 ++++++++++++++
> >  include/linux/uio_driver.h |  4 ++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > index 2e16c5338e5b..bc1fe83cec13 100644
> > --- a/drivers/uio/Kconfig
> > +++ b/drivers/uio/Kconfig
> > @@ -13,6 +13,20 @@ menuconfig UIO
> >
> >  if UIO
> >
> > +config UIO_MAX_MAPS
> > +     int "Maximum of memory nodes each uio device support(1-128)"
>
> Space before "(" please.
Ack
>
> > +     range 1 128
> > +     default 5
> > +     help
> > +       Maximum memory mapping each uio device can support.
>
> Any hints as to what this means in more detail?
Sure.
>
> > +
> > +config UIO_MAX_PORT_REGIONS
> > +     int "Maximum of port regions each uio device support(1-128)"
> > +     range 1 128
> > +     default 5
> > +     help
> > +       Maximum port regions each uio device can support.
>
> Again more detail please.
Sure.
>
> thanks,
>
> greg k-h
