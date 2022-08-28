Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E15A3D21
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiH1KHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:07:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95FD52FFB;
        Sun, 28 Aug 2022 03:07:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h5so6766514wru.7;
        Sun, 28 Aug 2022 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gN5wff+7D49gSmIVwVq0k68HaEIv4gh2Z+uJl/v6os4=;
        b=UTQKI75Of0dE8+F7Os670doSJ2pnyqRE6C4z2lo0cDm0my3i91eh0uUaaqTl7C8OZI
         RGo+W5rG+eAlSpjY9V2wO5VMT/62D4uyiD5a1O6kyoz+Yjp52Knkgp2q4TQqpZjNoEcL
         vqAigBpWEu4r11TYF9CfNeC1zeQzsL4fQzqq3+ozmTKlKGdwWWRBxKch2Uof7O7gyowg
         a94a0NGgXY0Rw79jfuQq7RUiwEALDb1WWhmtgEu071Eu9BZW44aSWu3ZoBTw1MReESdf
         JZezsNml4boheXrA3oirydVeD4oUcQTrkv8XeITE4vpsA9WK7/mU7tNXcK4ovLQI219u
         uCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gN5wff+7D49gSmIVwVq0k68HaEIv4gh2Z+uJl/v6os4=;
        b=k9ftOw21Vy4QcMj3MVpbSuSZraE5a73/0sVma845t+yzBo2dAw/bH11P6sYyHbrodL
         CPZdAod+DKgxmATgGE+g/ZeayhZgh+y0mKMPVNp+MwYhsEisbwTCy8wfqjyMyGa/qq9F
         cnFnI2etp62OC154XdMBBvDZWH9aRX4W+lspUtRw8UdyPuXnqSRVdYvtNQbPwE2++feu
         kXkwlCzHFGrQeaKXrdbU+ym6+ajjBaLQHb8zbFvkYkIh+gFRaxSHyEwhK4JEBeOoOLHO
         5U0InmVuLKMNczI1qLFRLCPvOds6goWeCUTSt3ynvi8uS3YTdZ5rgfddxFiR6PZPDZyX
         fUtQ==
X-Gm-Message-State: ACgBeo2YYYzPo1AfzHcBpkmrJnPrB8rg86PG9QHdyf3I04EmRtPeYP6X
        MNwCuVFOcUX93ZszTe3fOrMp4R7JglVUoQ==
X-Google-Smtp-Source: AA6agR7orfVETcNZNBzso4oBSDv8P3rDpZFzUexWwMDg5Y6Y8fbxAkMzcArvLoz+rB9cDMVmJ5xy+A==
X-Received: by 2002:adf:fa81:0:b0:224:f260:2523 with SMTP id h1-20020adffa81000000b00224f2602523mr3811529wrr.26.1661681237187;
        Sun, 28 Aug 2022 03:07:17 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a63a3b55c3sm6138227wmi.14.2022.08.28.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 03:07:16 -0700 (PDT)
Date:   Sun, 28 Aug 2022 12:07:14 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Stefan Hansson <newbie13xd@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220828100714.GA182607@elementary>
References: <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary>
 <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
 <20220804182445.GA16569@elementary>
 <CAO-hwJ+hBipNJpeYaHRr2-rKXA5d79XT7zE2fo2oEKUKJtKJ0g@mail.gmail.com>
 <20220813110922.GA47526@elementary>
 <d8b91029-4a6e-1508-1512-faea768ae580@redhat.com>
 <97ec87e6-b0c3-f2c9-4412-41a5884b6a24@gmail.com>
 <CAO-hwJ+MtU5w9M5rqbOPYjUUZtJ609Q0GwPJpy-9egDEjo9m7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+MtU5w9M5rqbOPYjUUZtJ609Q0GwPJpy-9egDEjo9m7g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:25:52AM +0200, Benjamin Tissoires wrote:
> On Sun, Aug 21, 2022 at 1:45 AM Stefan Hansson <newbie13xd@gmail.com> wrote:
> >
> > > FWIW, I found the issue: the hid-uclogic driver is emitting input data
> > > behind hid-input, and the state between the 2 is desynchronized.
> > >
> > > The following patch seems to be working (with the Huion v1 protocol I
> > > have here that I have tweaked to resemble a v2):
> > > ---
> > >  From aeedd318e6cb4dbee551f67616302cc7c4308c58 Mon Sep 17 00:00:00 2001
> > > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Date: Thu, 18 Aug 2022 15:09:25 +0200
> > > Subject: [PATCH] Fix uclogic
> > >
> > > ---
> > >   drivers/hid/hid-input.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > > index c6b27aab9041..a3e2397bb3a7 100644
> > > --- a/drivers/hid/hid-input.c
> > > +++ b/drivers/hid/hid-input.c
> > > @@ -1530,7 +1530,10 @@ void hidinput_hid_event(struct hid_device *hid,
> > > struct hid_field *field, struct
> > >                * assume ours
> > >                */
> > >               if (!report->tool)
> > > -                hid_report_set_tool(report, input, usage->code);
> > > +                report->tool = usage->code;
> > > +
> > > +            /* drivers may have changed the value behind our back,
> > > resend it */
> > > +            hid_report_set_tool(report, input, report->tool);
> > >           } else {
> > >               hid_report_release_tool(report, input, usage->code);
> > >           }
> >
> > What branch should this be applied on top of?
> >
> 
> Sorry for that. I had some local commits in my tree that made the
> patch unusable. I just formally sent the patch [0] based on the
> hid.git/for-next branch which is actually applying on top of v5.19 or
> even v5.18.
> 
> Cheers,
> Benjamin
> 
> [0] https://lore.kernel.org/linux-input/20220822062247.1146141-1-benjamin.tissoires@redhat.com/T/#u
> 

As I already commented in the patch, the problem is now solved on
hid/for-next.

Thanks!
