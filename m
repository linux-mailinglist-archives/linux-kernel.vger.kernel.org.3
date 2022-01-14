Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9017348EF61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiANRvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:51:43 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39747 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiANRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:51:40 -0500
Received: by mail-qt1-f169.google.com with SMTP id bp39so11408377qtb.6;
        Fri, 14 Jan 2022 09:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVQGLqQvJbwoy9xCNJlVEudmBlmdf+BHE1MexcrTM00=;
        b=otKcZFyqtzqGheCqcSFT0B8poIB8loPOMWWFX+mJUeGr5Br6KJQi1lwm0aAtDhesFn
         qHVoGVgA8R/ZHqvljVBh3pW0R1uiU2kaeTfB8RF1OK+udD520ZO9c/Vu9YZC+reT/mWZ
         +AwTUq85/QU7v68M12FXHoTMFHJfSmcbEtfP+uTycVObglUZcLwusMvnf0EeoaCKr5fm
         rYPngVFth36wv3yE0ZNZwSk1QMoErjaBws3uiR+/3kzvCctxJtf+Kn9DsUe82cdmVBcC
         7WGZAJtQsS929NHQFCaAl2FjO8h3KqkuxEUiNY8DISoMYSqbIR2ATGdk+aimMPN+0UZz
         pYNw==
X-Gm-Message-State: AOAM531Z5RD2foVFIT7GyYKgDSZ/GK7Jf0NyIr2KggYMQFqPYcaXbGXM
        yVur32HI2e3dJExkFmriIs2t4QWEBnO84rka2n8=
X-Google-Smtp-Source: ABdhPJy9pR7Mnowkd0KohKvx8Ey6a0toGyrWLkMNTm/UVqZjGJWU/mmT1XO06fDtnN1gbd87tjrbSRkXkpmeJcWR8Ho=
X-Received: by 2002:a05:622a:44e:: with SMTP id o14mr8740079qtx.369.1642182699155;
 Fri, 14 Jan 2022 09:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
 <20220113170728.1953559-5-tanureal@opensource.cirrus.com> <s5hee5a47et.wl-tiwai@suse.de>
In-Reply-To: <s5hee5a47et.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jan 2022 18:51:28 +0100
Message-ID: <CAJZ5v0ijGWNd9s-4mrFgK-QbPDhnj2K3DF+Z45t7ckV6ET0hpQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ACPI / scan: Create platform device for CLSA0100
To:     Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 5:19 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 13 Jan 2022 18:07:28 +0100,
> Lucas Tanure wrote:
> >
> > The ACPI device with CLSA0100 is a sound card with
> > multiple instances of CS35L41 connected by I2C to
> > the main CPU.
> >
> > We add an ID to the i2c_multi_instantiate_idsi list
> > to enumerate all I2C slaves correctly.
> >
> > Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>
> I think it's better to merge this from sound git tree together with
> others in the patch set, presumably for rc1.
>
> It'd be great if ACPI people can take a review and give an ack/nack.

Hans, what do you think?

> > ---
> >  drivers/acpi/scan.c                          | 2 ++
> >  drivers/platform/x86/i2c-multi-instantiate.c | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index c215bc8723d0..2a68031d953e 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1753,6 +1753,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
> >        */
> >               {"BCM4752", },
> >               {"LNV4752", },
> > +     /* Non-conforming _HID for Cirrus Logic already released */
> > +             {"CLSA0100", },
> >               {}
> >       };
> >
> > diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> > index 4956a1df5b90..a51a74933fa9 100644
> > --- a/drivers/platform/x86/i2c-multi-instantiate.c
> > +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> > @@ -147,6 +147,12 @@ static const struct i2c_inst_data int3515_data[]  = {
> >       {}
> >  };
> >
> > +static const struct i2c_inst_data cs35l41_hda[] = {
> > +     { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> > +     { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> > +     {}
> > +};
> > +
> >  /*
> >   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
> >   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> > @@ -155,6 +161,8 @@ static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
> >       { "BSG1160", (unsigned long)bsg1160_data },
> >       { "BSG2150", (unsigned long)bsg2150_data },
> >       { "INT3515", (unsigned long)int3515_data },
> > +     /* Non-conforming _HID for Cirrus Logic already released */
> > +     { "CLSA0100", (unsigned long)cs35l41_hda },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> > --
> > 2.34.1
> >
