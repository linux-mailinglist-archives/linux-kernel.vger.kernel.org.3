Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC550A80D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391355AbiDUS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391488AbiDUS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:43 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBFA4B434
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:24:32 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e604f712ecso6182845fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+GdX+UHkH0eNAo6meXUpaGI295KhOZ6FvwD5VZUQ1q4=;
        b=HLxkEVymYTQCsjUwqen0K6SOKvIDhcrZuxWFvtbOcGQfYdk6NLPdgkpPTek9qryaxg
         eWWdxl6NdFqtLZQTb7+oNmOm7UqWaUNvG3Gg0w3C57LZY/+lsD+2igwTPa9NlOyhZL8s
         Wq0CdIrR8joZbkS6dfZEi3g23f7VYNvNR1OOLQ24FUL6vnD14qvLI5vICXmfu2tyRPRs
         mmsLihqeQYX1WHRCXCQr6PFqBH+kDcKtGx0exxtMX2mT87Pfb6FMblGejIZvudf0cOdh
         EEs/TZUxnbsplsNpcmrBbXJ5880bqjjC8bRzKCyubtRyXOSJ0YM0Hp5iruKH9uveeD9g
         Enug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+GdX+UHkH0eNAo6meXUpaGI295KhOZ6FvwD5VZUQ1q4=;
        b=lQMuYoU5yac365YwMWQkuBR4yKjHo13JKlNo39OHeS6tluTkGe3DA0T3/3C6ccMjH/
         2JmvRMFz6tzLybkLau4RVsEF/EkIvYp3z9VW6Elk9nQ+9wpcRWN6eoMCuH1JWejkX9jR
         lq0Q6t4q9F9jSWIgKCeibKSlwFvl9wh9qrjBmudESbMHIum7HXaW7nUKUuakGg+49CBu
         DPv7N0pHnqWmKXhoVqPMUGmkayQv/h8RiRcCPwC+1qq1CeWykA7sjcCl8FmHg/WJp1st
         10Y1DPyAM5KbIKMO92vGrgl7Vf68qkcxXW5FlheLQGgYWokpqKCax1QMyPQUEia0vGAB
         Qlcg==
X-Gm-Message-State: AOAM531c6BQ1yIzneUJ34PWB6/YPYZotFxD+zlLxX//J1w5oKuX1SwoY
        wCl3qXiNtE88k0NIpE2uR6a/xWePzLOASD4Oyn5WDZx1ssAbcA==
X-Google-Smtp-Source: ABdhPJxFE3Q94kGfOLByOPoI+McHxYQH8P04zsF1TGjlY1NjCe0CqDJ4K9oR5jaWpu0DTs6dF64eL2C1V+dgGUEPf6c=
X-Received: by 2002:a05:6870:a40d:b0:e5:ea09:df91 with SMTP id
 m13-20020a056870a40d00b000e5ea09df91mr354423oal.99.1650565471898; Thu, 21 Apr
 2022 11:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de> <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
 <dce29330-e40c-860e-2c72-7ddebdd96e20@redhat.com> <CAMeQTsYYpw5+uLgmDrbB6PUBotRC4F+_rfK+sxT0CpPHoiOmmw@mail.gmail.com>
 <10c81e57-2f09-f4f8-dc2f-6bd05ef819d7@redhat.com> <CADvTj4oms8R1fhFpyZ+juU=4Eozie6f-3fzz4+jtptj3M9VCbw@mail.gmail.com>
 <ce65d1b0-44ad-54cb-d53f-ed0f7df4d247@suse.de> <c3ed82bc-cc15-7d0d-8968-b71ad3d4003f@suse.de>
In-Reply-To: <c3ed82bc-cc15-7d0d-8968-b71ad3d4003f@suse.de>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 21 Apr 2022 13:24:20 -0500
Message-ID: <CADvTj4oyW1yfJhCC_yL2kehPJcSPCYXA2YZU44=oMr5K=6=pTw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 1:23 PM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 21.04.22 um 20:22 schrieb Thomas Zimmermann:
> > Hi
> >
> > Am 21.04.22 um 19:39 schrieb James Hilliard:
> >> On Thu, Apr 21, 2022 at 8:22 AM Javier Martinez Canillas
> >> <javierm@redhat.com> wrote:
> >>>
> >>> On 4/21/22 14:54, Patrik Jakobsson wrote:
> >>>> On Thu, Apr 21, 2022 at 2:47 PM Javier Martinez Canillas
> >>>> <javierm@redhat.com> wrote:
> >>>
> >>> [snip]
> >>>
> >>>>>>>> diff --git a/drivers/gpu/drm/gma500/Kconfig
> >>>>>>>> b/drivers/gpu/drm/gma500/Kconfig
> >>>>>>>> index 0cff20265f97..a422fa84d53b 100644
> >>>>>>>> --- a/drivers/gpu/drm/gma500/Kconfig
> >>>>>>>> +++ b/drivers/gpu/drm/gma500/Kconfig
> >>>>>>>> @@ -2,11 +2,13 @@
> >>>>>>>>    config DRM_GMA500
> >>>>>>>>        tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> >>>>>>>>        depends on DRM && PCI && X86 && MMU
> >>>>>>>> +     depends on FB
> >>>>>>>
> >>>>>>> Why do we need FB here? Framebuffer support should be hidden by
> >>>>>>> DRM's
> >>>>>>> fbdev helpers.
> >>>>>>
> >>>>>> It is not needed but gives him video output since it enables the d=
rm
> >>>>>> fbdev emulation.
> >>>>>>
> >>>>>
> >>>>> I'm not sure to understand this. Shouldn't depend on
> >>>>> DRM_FBDEV_EMULATION then?
> >>>>
> >>>> No, it shouldn't depend on any FBDEV stuff since it's not actually
> >>>> required. It just happens to help in this case since weston + fbdev
> >>>> backend works but not weston with drm backend (or whatever config
> >>>> James have set).
> >>>
> >>> I see. Then the correct approach for them would be to just enable
> >>> CONFIG_FB
> >>> and DRM_FBDEV_EMULATION in their kernel config, rather than making
> >>> this to
> >>> depend on anything FB related as you said.
> >>
> >> Yeah, so it looks like CONFIG_FB_EFI is not needed but
> >> CONFIG_DRM_FBDEV_EMULATION is, I think I just assumed efifb
> >> was what was needed based on the kernel logs.
> >>
> >> This does not work:
> >> CONFIG_FB enabled
> >> CONFIG_DRM_FBDEV_EMULATION disabled
> >>
> >> This works:
> >> CONFIG_FB enabled
> >> CONFIG_DRM_FBDEV_EMULATION enabled
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> I looked some more at the logs and it seems weston doesn't work on
> >>>>>> his
> >>>>>> system without the fbdev backend. So the question is why weston is=
n't
> >>>>>> working without fbdev? Perhaps this is just a Weston configuration
> >>>>>> issue?
> >>>>>>
> >>>>>
> >>>>> But is weston using the fbdev emulated by DRM or the one registered=
 by
> >>>>> efifb? I thought that the latter from what was mentioned in this
> >>>>> thread.
> >>>>
> >>>> It's using drm fbdev emulation with gma500 so EFIFB has nothing to d=
o
> >>>> with this. I believe it was just simply incorrectly reported. If I'm
> >>>> correct then "depends on FB" is what makes video output work for
> >>>> James.
> >>>>
> >>>
> >>> Got it. Thanks for the clarification.
> >>
> >> Here's my weston.ini:
> >> [core]
> >> shell=3Dkiosk-shell.so
> >> modules=3Dsystemd-notify.so
> >> backend=3Ddrm-backend.so
> >> idle-time=3D0
> >> require-input=3Dfalse
> >> use-pixman=3Dtrue
> >>
> >> [shell]
> >> locking=3Dfalse
> >> cursor-theme=3DObsidian
> >> panel-position=3Dnone
> >>
> >> [output]
> >> name=3DDVI-D-1
> >> transform=3Drotate-270
> >>
> >> [output]
> >> name=3DDP-2
> >> mode=3Doff
> >>
> >> [output]
> >> name=3DLVDS-1
> >> mode=3Doff
> >
> > You mentioned that you want to use HDMI, but it's not configured here.
> > Is that intentionally?
>
> Nevermind. I just saw that DVI-D-1 is the HDMI port. (why?)

Not sure why the HDMI output is named DVI-D-1 but that's what
seems to configure it on this board.

>
> >
> > Best regards
> > Thomas
> >
> >>
> >> [libinput]
> >> touchscreen_calibrator=3Dtrue
> >>
> >>>
> >>> --
> >>> Best regards,
> >>>
> >>> Javier Martinez Canillas
> >>> Linux Engineering
> >>> Red Hat
> >>>
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
