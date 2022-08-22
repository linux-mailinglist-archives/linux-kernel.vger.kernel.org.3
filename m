Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BF59B965
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiHVG0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiHVG0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26F13CDD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661149567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwSti8yn5JhvKkSnURac/0DzJgMzOZTPalZfFbDV6e8=;
        b=afA5AzhsZ72lgRrifVahz7eXXEF/gzAbq7JZcKDeQx5zE6UTbqvbiVzbEcxeh+OXWjj2Qy
        F47IwEEMPyIb2M+c60/iuWBN/4lxJRmt7QZImi4ZyHRMsEohEB8UdJMgBM5ww3Z5NIed0y
        pwXCz7SJ4ezEziQCAAFVAKIT99OcTDg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-HmjJGUQfMCSObNaLUznJXw-1; Mon, 22 Aug 2022 02:26:05 -0400
X-MC-Unique: HmjJGUQfMCSObNaLUznJXw-1
Received: by mail-pg1-f198.google.com with SMTP id a186-20020a6390c3000000b00422cc29268eso4280886pge.16
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NwSti8yn5JhvKkSnURac/0DzJgMzOZTPalZfFbDV6e8=;
        b=wOU+RnRXhLPf+95X7T6anzA3TkA9N3Pe5yJ1u6oBrT/DRThwduOoG3jf1ySU46Z+2J
         IqHB0EhbBVMbz/C+9I8xerechZEEWOW0K7vUosKQ6hTkoLa9wGw2Qaawthb980hYuLeP
         Xzd96lt6RYKPgkpFDBP6JxWrdbDph0e8e9IR0yoBVLO9DE5mX+BBG79YiGB3XB9v11yd
         EG36I6vQCSh0Ze1IjZYexyRVjpBkF3OyfRn47ze8UPd7nDH0DHuJ/vBlows/S5IgeyLl
         Hv9ApMAvYYKS/VQf4yWIUOfZbt4ca+gXorst/KfnilS+/g9zZfZ8IE4ryBoK6rhvC//7
         VNBQ==
X-Gm-Message-State: ACgBeo365fjHtvwylMAqTxcmtDD8nuV2b6Br+fc+jW7DHzyETsi0EMGh
        CKCCA8vp5ivPD9MTBctq0G4ZNYp9NU2CRIx9Ctt3o1LrnEDCqo+Coz6bI3vzk/guF5Fuh2t158J
        14kRNOvAN3TiCczJxXvWFc1ePwHS5MPI6t6DV61b/
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id a10-20020a170902b58a00b0016ef91a486bmr19622457pls.119.1661149563479;
        Sun, 21 Aug 2022 23:26:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6R3ckquzQqzKIhkeh4cNBZ6LWcA4oFdZ894XbI43YF4aLUPLFX40NMVo5P6+4eDnHLRRpHPuREANNSuNunTDk=
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id
 a10-20020a170902b58a00b0016ef91a486bmr19622434pls.119.1661149563143; Sun, 21
 Aug 2022 23:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm> <20220724114849.GA32182@elementary>
 <20220725224841.GA75640@elementary> <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
 <20220804182445.GA16569@elementary> <CAO-hwJ+hBipNJpeYaHRr2-rKXA5d79XT7zE2fo2oEKUKJtKJ0g@mail.gmail.com>
 <20220813110922.GA47526@elementary> <d8b91029-4a6e-1508-1512-faea768ae580@redhat.com>
 <97ec87e6-b0c3-f2c9-4412-41a5884b6a24@gmail.com>
In-Reply-To: <97ec87e6-b0c3-f2c9-4412-41a5884b6a24@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 22 Aug 2022 08:25:52 +0200
Message-ID: <CAO-hwJ+MtU5w9M5rqbOPYjUUZtJ609Q0GwPJpy-9egDEjo9m7g@mail.gmail.com>
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
To:     Stefan Hansson <newbie13xd@gmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 1:45 AM Stefan Hansson <newbie13xd@gmail.com> wrote:
>
> > FWIW, I found the issue: the hid-uclogic driver is emitting input data
> > behind hid-input, and the state between the 2 is desynchronized.
> >
> > The following patch seems to be working (with the Huion v1 protocol I
> > have here that I have tweaked to resemble a v2):
> > ---
> >  From aeedd318e6cb4dbee551f67616302cc7c4308c58 Mon Sep 17 00:00:00 2001
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Date: Thu, 18 Aug 2022 15:09:25 +0200
> > Subject: [PATCH] Fix uclogic
> >
> > ---
> >   drivers/hid/hid-input.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index c6b27aab9041..a3e2397bb3a7 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1530,7 +1530,10 @@ void hidinput_hid_event(struct hid_device *hid,
> > struct hid_field *field, struct
> >                * assume ours
> >                */
> >               if (!report->tool)
> > -                hid_report_set_tool(report, input, usage->code);
> > +                report->tool = usage->code;
> > +
> > +            /* drivers may have changed the value behind our back,
> > resend it */
> > +            hid_report_set_tool(report, input, report->tool);
> >           } else {
> >               hid_report_release_tool(report, input, usage->code);
> >           }
>
> What branch should this be applied on top of?
>

Sorry for that. I had some local commits in my tree that made the
patch unusable. I just formally sent the patch [0] based on the
hid.git/for-next branch which is actually applying on top of v5.19 or
even v5.18.

Cheers,
Benjamin

[0] https://lore.kernel.org/linux-input/20220822062247.1146141-1-benjamin.tissoires@redhat.com/T/#u

