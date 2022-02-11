Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D474B1CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiBKDb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:31:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBKDb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:31:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2CC2710
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:31:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fj5so17047980ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkYzQovnG+JzphAeX+hFVWJIG/IX9DACKj6/sgTk7o0=;
        b=UzbSBoVTO1UhTNtbIB9ffqqKPbxthw1paA3sOvjM4IHI+jwp/Z68ta50UwDawkXGCO
         ptdkbIDpmnXS1LZrTmW6tPZsPtuMrRHiXw7Eu6DMl5+4LWbjn+UObXaGINSfD5VhOG3x
         QLwoz1tLndJpq2njEhH2i5khZrbZrEIxmToQz0DF8chUtnmi7zE8L3axpEOp+doclGEZ
         gFjsgLs7H8Yr4o7XAUC/6OYOJxRbSqcAtmdY7tWzoliNNui01jEXw/RqiY1kmMB700U5
         AvbTFx0PAh5NjKlWA55EF2X9lp6L76klEla/NbWNe8D5ZIrG1BZI+7GssyUfeuPHZ20D
         INtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkYzQovnG+JzphAeX+hFVWJIG/IX9DACKj6/sgTk7o0=;
        b=EwXJ+FAi+3wRnMoXX9TYRB+XdWKszuauyT6lBL9S/asq6//ombMYzk/ChJDySBLciV
         AXnCW7tJL3fTbGm7loqeCAMMNhrRVY8uKAP9JdMfyo69K8vCe+n3rU6C5JvVxDW44+PM
         ggvLocdg3wP9KeTuUFrJVJiHckkBEiISHUjyHJdTpjtNKCYIKkYlhybqfZnUhHC9YrkO
         Ch2t8J17K3HOeV4dCkKiU/0URiGR9d5CQSAxf71nPVJaFBMTodNkEtOzwj3wJujyA8W3
         X20pE1422WT4rqtkY3f61x7vDvii2Y2ANpbVO3S3voXqx0Mvap3uKb7hrsk36dWWLRJH
         S60Q==
X-Gm-Message-State: AOAM533f/XwISg+SppmVTG77tY8Gcwv96YMFVnai2ntsqx77SVWJi9UD
        HcLobWulHjb0U94QQ3fu3y7Qk78fA5OFMcSQ6B3MZReIsNkM0A==
X-Google-Smtp-Source: ABdhPJx6SPgSdU5VtV+tT54s9KxBNTpIW0oaURQpOPhHEJ00NtvAufjm/FenYM5ooFX9zzk5gUUJD3P1O1l+Hr+xmDg=
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr8575241ejc.225.1644550314463;
 Thu, 10 Feb 2022 19:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20220117194836.vj2rxr3wocrtdx7k@treble> <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble> <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble> <20220119234303.tmebbcrg2vpnri4s@treble>
 <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com>
 <20220120171751.gibauc4zovoskjns@treble> <CAPDLWs_28zYabLjsyT2gq-o6vEzidWB4mpGuUGdiYr0qb6YFWQ@mail.gmail.com>
 <20220206202859.butmvavyw3tce4hs@treble> <CAPDLWs88HXMW_yPH4zC=XFz6p6aTJs55BoZCXYYPSmDwRBbdRg@mail.gmail.com>
In-Reply-To: <CAPDLWs88HXMW_yPH4zC=XFz6p6aTJs55BoZCXYYPSmDwRBbdRg@mail.gmail.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Fri, 11 Feb 2022 09:01:38 +0530
Message-ID: <CAPDLWs_rY4YGvKy10s=-fgfquKWtE_S+jeFmzeDJc6ETYPsJhw@mail.gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
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

It works !

$ .../linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x124
do_the_work+0x124/0x15e:
do_the_work at .../oops_tryv2.c:62
$

Will you now upstream this patch?

Thanks!

On Mon, Feb 7, 2022 at 7:53 AM Kaiwan N Billimoria
<kaiwan.billimoria@gmail.com> wrote:
>
> On Mon, Feb 7, 2022 at 1:59 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Jan 21, 2022 at 01:35:13AM +0530, Kaiwan N Billimoria wrote:
> > > > Try this one?
> > >
> > > Definitely better !
> > > This is the o/p i now get:
> > >
> > > $ <...>linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko
> > > do_the_work.cold+0x68/0x126
> > > do_the_work.cold+0x68/0x126:
> > > delay_sec at <...>/oops_tryv2/../../convenient.h:279
> > > $
> > >
> > > The source file+line-no doesn't show up here though... (as it's a foo.cold()?).
> > > (I'm unsure why the line delay_sec at <...>convenient.h:279   shows up
> > > ; i don't call this delay_sec() func directly... anyway, that's my
> > > problem.)
> >
> > Hm... do you get the same result with addr2line?
>
> addr2line works correctly.
> And, so does the patched faddr2line, when i tried it out now on
> another VM! Lemme check some more and get back, thanks.
> - Kaiwan.
> >
> >
> > --
> > Josh
> >
