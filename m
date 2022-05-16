Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC055287E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiEPPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiEPPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:03:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43183B3F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:03:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a5so17139670wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPcoNO1j7RBUVdLDmW4cgoYiT4HTUVa7PDPtyl15FqY=;
        b=eMwIf/WdD+xUFg7sdlHf5jtEkLN7vjUXCx+87mSlVcar7bIXsEfUCJTzQ1ATm+vFz5
         FBJx/CPJZ6AGZDILpK9Kpa4OolZ34mcGsC8Spt+I7wPjclsLSOHPZ//fwCOSCSIuTIW7
         jzWjVyI9fIJduPh1z5it/q7kHd8fQhyhhqT4AlkhpKbz49Va9/+3IV/hwZdQCQ2qB3BU
         OhD3x0jIh2oSc9Cuhae9VdBXNyHhmliDZxWn5PqPdZKF/Zva/QRkJk0mAZTSz25hNsoq
         O6P1GEXdmM7AzqdKEl5odHUbvv4CJPIu4J3c1uRqJjSl1QVwIEFu3uiRK6O9+MEJSnAy
         79pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPcoNO1j7RBUVdLDmW4cgoYiT4HTUVa7PDPtyl15FqY=;
        b=k1jk7aV/UEocNrO642YS1UGTDm8rtdgHfJUb6LggwEbT3nYE21F/oY4+/VOuOCFd94
         LluvRXFfWOvt1/5wwB0V5FJ3DXP+Y8qbBIJuw2Gytt51kveMIrC11zInHlkReMuc5x5Q
         xp94jQdmPLOwdnuj5at52s3L6NEHDKEHQj/YOWLr4g/QAjLZljDcZpkTba0T+D25BXUE
         9TKsXJFzy/3zB8FuiJKv53DNHp90Fdzi7TWGSToCMWQSkIypt3sEJQ5IsRyO77FO0Z5S
         NLnOfgH1iP048MSeQE7epqx4+yT+PcSPfQFVwL3anKmRCQJmlMdZuQ2MAHJNP7Q2WELI
         Xkng==
X-Gm-Message-State: AOAM532tkRYiegp/2kknfkKSA5nU9lgTXIBnpRJIkQ2pTOlJlBEhRfjP
        O2twF3wRPJqRw/9U0qTuXr5a80+aIO/Jj3o+BbooDQ==
X-Google-Smtp-Source: ABdhPJwAiBWCzE3Q39L93qd73JMV1CCwtR75UcbTglNeEMc+h2FSFnSzvZd6HaawUGDnSDimqucIp1PajNZ8h/8l+TM=
X-Received: by 2002:a5d:6d0b:0:b0:20c:4ecb:1113 with SMTP id
 e11-20020a5d6d0b000000b0020c4ecb1113mr14301059wrq.203.1652713411223; Mon, 16
 May 2022 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220405183953.2094007-1-pceballos@google.com>
 <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm> <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com>
 <nycvar.YFH.7.76.2205121252090.28985@cbobk.fhfr.pm> <CAO9JgFwA5ZhwOOY0cU3HpMOV69CTumQ50zEgU6SPNAF0zDbCGg@mail.gmail.com>
 <Yn2OlQAa9I++N80B@penguin>
In-Reply-To: <Yn2OlQAa9I++N80B@penguin>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Mon, 16 May 2022 08:03:17 -0700
Message-ID: <CAO9JgFwR1kjaPawL9YcSCuy5PFKKtFx+4o0t1B7SBkq9xTEGHA@mail.gmail.com>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 3:48 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 03:35:00PM -0700, Pablo Ceballos wrote:
> > On Thu, May 12, 2022 at 3:53 AM Jiri Kosina <jikos@kernel.org> wrote:
> > > On Thu, 12 May 2022, Dmitry Torokhov wrote:
> > > > I am curious, could not this be achieved without a kernel driver by
> > > > simply using udev to map this usage code to KEY_RESERVED?
> > >
> > > Hmm, good point, using KEY_RESERVED mapping to achieve the key being
> > > actually ignored didn't immediately occur to me.
> > >
> > > Pablo, could you please verify that it behaves in the expected way, and
> > > confirm that we could drop the 'driver' in favor of udev rule?
Jiri, this driver can be dropped from 5.19. The udev rule works just as well.

> >
> > I think I've achieved the same result by adding the following to udev
> > hwdb. Dmitry, is this what you had in mind, or is there a better way
> > of doing this?
> >
> > evdev:input:b0003v18D1p8001*
> >  KEYBOARD_KEY_b002f=reserved
>
> No, that is exactly what I had in mind, thank you. Please submit this
> entry to upstream systemd/udev project (and we can cherry-pick it into
> our udev as well).
The pull request is here: https://github.com/systemd/systemd/pull/23372

>
> In general I think we should try to avoid trivial "fixup" HID drivers if
> it is possible. I also wondered if we could be supplying fixed-up HID
> descriptors via request_firmware() for HID devices.

Pablo
