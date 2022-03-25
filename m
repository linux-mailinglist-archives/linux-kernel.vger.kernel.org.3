Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317F24E6BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357309AbiCYBbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbiCYBbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:31:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06722535;
        Thu, 24 Mar 2022 18:29:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w8so6568322pll.10;
        Thu, 24 Mar 2022 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0Qs2noJ7T/SsB6vM+NPxtq+5bcl036xXLJJQ7i88WI8=;
        b=KKWmr8keBLvOKi9KLDjOqjRVtFZn9YsFwQqdXXewbMlQrKldc3R8S2nGfLASTUDBq+
         2vyuhM/+LZQyiolqZr05OnrFueB+EQUz4+hFj2pFJQHij9b6bjbRrnhGqlGUMzBGsmtW
         Rh80fb+GTI9uhjE2+F1ecP/x2ypqWfW+Ed3Xd+9RzD5UCxrmPSZsBABM5U3Qnh5AI/yA
         xCte7PUP3tc+Bavte/Bwh1EAEfmm1Hlr0Abs84JyBY0ZQ5vxC3SDLHnPK2NWbsK0OLxU
         JeZkwJXw2S6mv0m1KQbNVL8E3q9H9rKmQ39C2ctg5PVDgMr+uCMfwv2yIe3P5Sgu6REo
         TI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0Qs2noJ7T/SsB6vM+NPxtq+5bcl036xXLJJQ7i88WI8=;
        b=0H/NN0DzubM8LXVF3WkHHv0uPQmt6u5zgQ7aswkOsTnq8VwtiSNB3/m7+7eOQYU6ns
         frOqjsEt2JFn9N8UDWp90oGxmnA0j2hv5SrfoMWbnuV4LgKKOr4wY6CE1baGFGbc7b3j
         GDqGj+2SfbQQn27No1/P+AtVzQYQMBTfCZ5Yxq7c7reZjzE69UjaTPtbI2sen+agRbHa
         0irRJZ/2UNWASPj7CaaEfUnqH1n6Gxx5+Ygwe5EySlKsygUtuxjD+vVkYts4VkIGknsu
         lOACwh5yj5bme+LIm/er0UOiH00gMinmLra87TyjUyIRWsWUIkXdFlsRftW/et3BAQCV
         l4zQ==
X-Gm-Message-State: AOAM531FJi8o1dRvwB1u/9LU9dli6iOZpf/oJdl5S6mh4Ic57Lg7pQlG
        vnpxjETkiM+kci+IfVMSHaA=
X-Google-Smtp-Source: ABdhPJwYuYVo6hbvAkvcKzYkFdmwGxdsNpu3uD2mFwRTXQIu2k7LLwf1cSBNW30tgyqDy59Ol37vFg==
X-Received: by 2002:a17:90b:1c01:b0:1c6:dc49:d146 with SMTP id oc1-20020a17090b1c0100b001c6dc49d146mr21276361pjb.29.1648171770603;
        Thu, 24 Mar 2022 18:29:30 -0700 (PDT)
Received: from hermes ([2604:3d09:e80:800::72d9])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79902000000b004fb05c04b53sm965484pff.103.2022.03.24.18.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 18:29:30 -0700 (PDT)
Date:   Thu, 24 Mar 2022 19:29:28 -0600
From:   Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <Yj0a+OwfSqDVMyTK@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
 <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
 <Yjvm1F3ZrJnyAOE6@hermes>
 <CAO-hwJLW=UT6APsKKZaRHBvKn5GOe5xg+bLQH7TGy-PH8N4yUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJLW=UT6APsKKZaRHBvKn5GOe5xg+bLQH7TGy-PH8N4yUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:54:29PM +0100, Benjamin Tissoires wrote:
> On Thu, Mar 24, 2022 at 4:34 AM Manuel Schönlaub
> <manuel.schoenlaub@gmail.com> wrote:
> >
> > On Wed, Mar 23, 2022 at 09:22:49PM +0000, Filipe Laíns wrote:
> > > On Tue, 2022-03-08 at 16:50 -0700, Manuel Schönlaub wrote:
> > > > The HID++ protocol allows to set multicolor (RGB) to a static color.
> > > > Multiple of such LED zones per device are supported.
> > > > This patch exports said LEDs so that they can be set from userspace.
> > > >
> > > > Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
> > > > ---
> > > >  drivers/hid/hid-logitech-hidpp.c | 188 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 188 insertions(+)
> > >
> > > *snip*
> > >
> > > Hi Manuel,
> > >
> > > Thanks for putting this forward, although I am not sure if this is the best way
> > > to handle this.
> > >
> > > Before anything, could you elaborate a bit on what lead to you wanting this?
> > >
> > > There are a couple of reasons why merging this in the kernel might be
> > > problematic.
> > >
> > > 1) I don't think we will ever support the full capabilities of the devices, so
> > > configuration via userspace apps will always be required, and here we are
> > > introducing a weird line between the two.
> > >
> > > 2) There is already an ecosystem of userspace configuration apps, with which
> > > this would conflict. They might not be in the best maintenance state due to lack
> > > of time from the maintainers, but moving this functionality to the kernel, which
> > > is harder change, and harder to ship to users, will only make that worse.
> > >
> > > Cheers,
> > > Filipe Laíns
> >
> > Hi Filipe,
> >
> > sure.
> >
> > While I realize that there is e.g. ratbagd which supports a great deal of the
> > HIDPP features and should allow you to control LEDs, unfortunately for my G305
> > it does not support the LED (and as far as I remember my G403 does not
> > work at all with it).
> >
> > Then I figured that actually having the LEDs in kernel would allow led triggers
> > to work with them, so you could do fancy stuff like showing disk or CPU activity
> > or free physical memory... and here we are now.
> 
> The one thing that concerns me with those gaming LEDs, is that there
> is much more than just color/intensity.
> Those LEDs have effects that you can enable (breathing, pulse, color
> changing, etc...) and I am not sure how much you are going to be able
> to sync with the simple LED class.
> 
Sure. 
I actually had thought a bit about that and would say that the concept
of breathing, pulse etc.. can be modeled quite well with hardware patterns. 

> > As for supporting the full capabilities of these devices: The patch just adds
> > RGB leds, which is something already quite standardized in the linux kernel for
> > a variety of devices.
> > Some roccat mice even have support for changing the actual DPI in their kernel
> > driver, which arguably is a whole different story though and not scope of this patch.
> > There are also other features (like on-board profiles) which I would definitely
> > see being better off in user space, especially as long as there is no additional
> > benefit in having them in the kernel.
> >
> > Regarding the conflict in userspace: ratbagd currently seems to always write
> > LED state in RAM and the on-board profiles at the same time, so I would
> > argue that the use case here is different: The user space tools want to
> > set the LED color in a persistent way, while here we want to have interaction with
> > LED triggers and a more transient way. E.g. the driver would overwrite
> > only the transient LED color, not the onboard-profiles.
> >
> > If that is already too much, what about a module option that allows a user to
> > deactivate the feature?
> 
> Please no. I am tired of having way too many options that nobody uses
> except for a couple of people and we can not remove/change them
> because of those 2 persons.

That's true. I would certainly hate that too.

> 
> Either you manage to sync the LED class state somehow (in a sensible
> manner), or I don't think having such LEDs in the kernel is a good
> thing because we are going to fight against userspace.

I'd like to give it a shot and come up with a follow-up patch series
implementing e.g. breathing. Let's see how that turns out.

> Cheers,
> Benjamin
> 
> >
> > Best Regards,
> >
> > Manuel
> >
> 
