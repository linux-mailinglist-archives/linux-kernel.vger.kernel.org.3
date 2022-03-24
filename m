Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5E4E6990
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353094AbiCXT4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiCXT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9482A1458
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648151683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdYDWTYECuLIafc6e23p/YKZqEma3phzCNCrwtbaXcs=;
        b=aqwg0EG5G0nHN/V8oaJyO8H6Knh7H1kTnpVRV/bMS42lGTTzYQ0ekRxKZ/WZyy8bMiDYeT
        Q9oxD2MN47uK/dxmCIo47r655SgF6oFKxYo7Mw2zxMT0vKoZtW0ZQTOkuA93Zqg5RKeoQe
        POy8h//JfyS3La7LdnKaW26i9ukXjBc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-hqhBF7IwNzKMkVK6ka3Yuw-1; Thu, 24 Mar 2022 15:54:41 -0400
X-MC-Unique: hqhBF7IwNzKMkVK6ka3Yuw-1
Received: by mail-pg1-f200.google.com with SMTP id l6-20020a637006000000b003811a27370aso2791074pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mdYDWTYECuLIafc6e23p/YKZqEma3phzCNCrwtbaXcs=;
        b=fNy94ri8bQx5o7aQGawl4M7koHbgE7+pRFU6pp9fgESfkRNtFc05XxB6JH9zp2cz19
         4lrmfAhJFhgKpyRcTXpkMK5uZ4fXOymCXuINsXVWGWVD1/YmSSYpiaebuNsaudEWiDwI
         qAlEF2u6i5XPo19fvtefOMKTP0zr61vldmnTCyz3fV11hXc69c+sD4SQKBlMJQ2HxRqD
         HpWpZapej7CJqGyg1SH3m8B6DCPp03yYDyN5bi3yuMtLZUzNWfGasNFuYvO8EOXh4TOQ
         fbYiH/5mEIn+bDnDuAo9wJ7oVW3ZBsNuyEbfCUh8i5PpcsTRN3akrwSrwu21AwO9hZoj
         yxFw==
X-Gm-Message-State: AOAM5321a6NwU3HSw+k86kiIkgkR3GCbPBsbsCb1rAdMTnMkbsbZWTMZ
        UKND7qP+vB9mJrmjlWh3zP+BU+P1vx34mcKIgzpvzjFQLflNfVAuyq0NvI9FnZQCxJevQe45kLP
        mMOsnD8YKQpMVif2lGJ/b2E3ZObD1Sw4Kl+wRWGYT
X-Received: by 2002:a65:5bc3:0:b0:378:4f82:d73d with SMTP id o3-20020a655bc3000000b003784f82d73dmr5280055pgr.191.1648151680349;
        Thu, 24 Mar 2022 12:54:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYCokz76bQIjxlPPqBpzA8zKlvluSoVHMtHWuHNlBtpMcqIkWyAFwAqDWDdVrYLMcrLMaQhESEq9Nxhz6ELHI=
X-Received: by 2002:a65:5bc3:0:b0:378:4f82:d73d with SMTP id
 o3-20020a655bc3000000b003784f82d73dmr5280039pgr.191.1648151680008; Thu, 24
 Mar 2022 12:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <Yifr4etBFPu1a2Ct@hermes> <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
 <Yjvm1F3ZrJnyAOE6@hermes>
In-Reply-To: <Yjvm1F3ZrJnyAOE6@hermes>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 24 Mar 2022 20:54:29 +0100
Message-ID: <CAO-hwJLW=UT6APsKKZaRHBvKn5GOe5xg+bLQH7TGy-PH8N4yUQ@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
To:     =?UTF-8?Q?Manuel_Sch=C3=B6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 4:34 AM Manuel Sch=C3=B6nlaub
<manuel.schoenlaub@gmail.com> wrote:
>
> On Wed, Mar 23, 2022 at 09:22:49PM +0000, Filipe La=C3=ADns wrote:
> > On Tue, 2022-03-08 at 16:50 -0700, Manuel Sch=C3=B6nlaub wrote:
> > > The HID++ protocol allows to set multicolor (RGB) to a static color.
> > > Multiple of such LED zones per device are supported.
> > > This patch exports said LEDs so that they can be set from userspace.
> > >
> > > Signed-off-by: Manuel Sch=C3=B6nlaub <manuel.schoenlaub@gmail.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 188 +++++++++++++++++++++++++++++=
++
> > >  1 file changed, 188 insertions(+)
> >
> > *snip*
> >
> > Hi Manuel,
> >
> > Thanks for putting this forward, although I am not sure if this is the =
best way
> > to handle this.
> >
> > Before anything, could you elaborate a bit on what lead to you wanting =
this?
> >
> > There are a couple of reasons why merging this in the kernel might be
> > problematic.
> >
> > 1) I don't think we will ever support the full capabilities of the devi=
ces, so
> > configuration via userspace apps will always be required, and here we a=
re
> > introducing a weird line between the two.
> >
> > 2) There is already an ecosystem of userspace configuration apps, with =
which
> > this would conflict. They might not be in the best maintenance state du=
e to lack
> > of time from the maintainers, but moving this functionality to the kern=
el, which
> > is harder change, and harder to ship to users, will only make that wors=
e.
> >
> > Cheers,
> > Filipe La=C3=ADns
>
> Hi Filipe,
>
> sure.
>
> While I realize that there is e.g. ratbagd which supports a great deal of=
 the
> HIDPP features and should allow you to control LEDs, unfortunately for my=
 G305
> it does not support the LED (and as far as I remember my G403 does not
> work at all with it).
>
> Then I figured that actually having the LEDs in kernel would allow led tr=
iggers
> to work with them, so you could do fancy stuff like showing disk or CPU a=
ctivity
> or free physical memory... and here we are now.

The one thing that concerns me with those gaming LEDs, is that there
is much more than just color/intensity.
Those LEDs have effects that you can enable (breathing, pulse, color
changing, etc...) and I am not sure how much you are going to be able
to sync with the simple LED class.

>
> As for supporting the full capabilities of these devices: The patch just =
adds
> RGB leds, which is something already quite standardized in the linux kern=
el for
> a variety of devices.
> Some roccat mice even have support for changing the actual DPI in their k=
ernel
> driver, which arguably is a whole different story though and not scope of=
 this patch.
> There are also other features (like on-board profiles) which I would defi=
nitely
> see being better off in user space, especially as long as there is no add=
itional
> benefit in having them in the kernel.
>
> Regarding the conflict in userspace: ratbagd currently seems to always wr=
ite
> LED state in RAM and the on-board profiles at the same time, so I would
> argue that the use case here is different: The user space tools want to
> set the LED color in a persistent way, while here we want to have interac=
tion with
> LED triggers and a more transient way. E.g. the driver would overwrite
> only the transient LED color, not the onboard-profiles.
>
> If that is already too much, what about a module option that allows a use=
r to
> deactivate the feature?

Please no. I am tired of having way too many options that nobody uses
except for a couple of people and we can not remove/change them
because of those 2 persons.

Either you manage to sync the LED class state somehow (in a sensible
manner), or I don't think having such LEDs in the kernel is a good
thing because we are going to fight against userspace.

Cheers,
Benjamin

>
> Best Regards,
>
> Manuel
>

