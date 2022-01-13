Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83A548DD86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiAMSPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMSPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:15:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66964C061574;
        Thu, 13 Jan 2022 10:15:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u25so26278354edf.1;
        Thu, 13 Jan 2022 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixB+cDjTF6trUNfivYB0goIOsvM4IpCVj51WXKq++M8=;
        b=SHLc8jIQswuWmXLusJb2kfh8Z5x+jw74Lzo+jB+jpblTWTPPlyLymOACZ+yy0Nvl9a
         fdniOuf14v3C+tFX4dO/HI/6AeVxvkwBVAvy4r/0uKuFclcY48c/R5WAjtV/7CdF8q5a
         vZXqWL9lE0EoQLN9Ett4wbk5/toJVXSqoL5eRCY4VfxlBFo0mOMLFj+ChZ5mdZ8bsasY
         zzxfKtAEhGhukpKPorF2tu/euDpVxjqiEaUWT9nWcsSAV6QiDL+MxGL9fxTia/eugLyu
         /swzYoBiAFjf/IuCS7R+mDTBfFeKObP7sHHckfELZ+KEQ2aozQUuBqN7fCMYZdLSLeJ8
         Ic5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixB+cDjTF6trUNfivYB0goIOsvM4IpCVj51WXKq++M8=;
        b=LbKDnxCzqA0pm2xNit5anH49LJlUK+4DYYITyBMr+4PrDN7GEqUNWnB8VAbmJRv/C4
         Wh953vRnNFVlj1eG+lTboPkUZNS8ESCj9yqZGZaG6CZTfyYK2Tt+UE8dN0ww52G3xwSV
         0ISIHqf/u+46+oXzMqWtU40uammMH5ciyz57djFWrdE/X9D0N+R+vRnHqDXkuenw42aD
         jBd1ulsS6l+cPBeF8kyBVAsKkfJ28bxg2GPwTzreFRBoGmzzVw6PzDD+YQOnUC5ShSn2
         eZQCofLpUVF573Q1hDdpeJAVTcw4NnkQDMc5SSuO8CX6itW/A1VoxvbG7ZtyX2iEVWPQ
         MQvA==
X-Gm-Message-State: AOAM530fiwcOGP/nS6FiD6rlXBBde+X/NxB1/o5j6ZH8ChTmxpzM+vLc
        K0iDqcCQzf4Bsa7j8690N0kmnNZYml8vH3ejw94=
X-Google-Smtp-Source: ABdhPJxQ4nL/MJTrU4OfOQDsgdo+2sx7cJBfjPvPJA4jPnCfZZ15HjugqoqDz7oSPjIa76mbSOAowC5rX5KcCjWcB9A=
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr4556641ejc.132.1642097721964;
 Thu, 13 Jan 2022 10:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-8-tanureal@opensource.cirrus.com> <CAHp75VdQGBixkUStPiq3VuoL+9TJo946ObfRA-L-D72DaFHnrw@mail.gmail.com>
 <66351fd6-f434-775f-d8d5-2a6baf098269@opensource.cirrus.com>
In-Reply-To: <66351fd6-f434-775f-d8d5-2a6baf098269@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Jan 2022 20:13:36 +0200
Message-ID: <CAHp75Vc=x0AanRhkGHvbgs0M9VLdZfEFKJUxRTEMFvT5YwDtzA@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] hda: cs35l41: Add support for CS35L41 in HDA systems
To:     Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:53 PM Lucas tanure
<tanureal@opensource.cirrus.com> wrote:
> On 1/6/22 12:29, Andy Shevchenko wrote:
> > On Fri, Dec 17, 2021 at 5:45 PM Lucas Tanure
> > <tanureal@opensource.cirrus.com> wrote:


...

> >> +        * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
> >
> > So, you need to add mapping tables and switch to regular APIs, tell
> > me, why it won't work.
> I will submit a patch series to fix most of the issues you pointed out.

Thanks!

> The part about how the driver access the ACPI table is going to be
> improved later if possible.
> The laptop has already shipped and doesn't have a _DSD node, so the
> driver needs to read the reset GPIO from a hard coded index inside a
> node that contains more than one cs35l41.

We have a lot of cases like this, hint: `git grep -n -w
devm_acpi_dev_add_driver_gpios`.

...

> >> +int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
> >> +                     struct regmap *regmap)
> >
> >> +       if (IS_ERR(regmap))
> >> +               return PTR_ERR(regmap);
> >
> > Why?
> It is up to the I2C/SPI module to create the regmap and provide to the
> main module. If that fails the main module can't continue.

So, this is band-aiding the issue, which is in the caller. Caller
shouldn't call this function without the regmap being ready-to-use.

...

> >> +       {"CLSA0100", 0 },
> >> +       {"CSC3551", 0 },
> >
> > I believe these IDs are officially allocated by the Cirrus Logic, right?
> CLSA010* is not a valid id for Cirrus Logic, but the Bios is already in
> production, so we must support it.
> CSC3551 is a valid id for Cirrus Logic.

Thank you for elaborating. Can we be sure that there won't be any
abuse of ACPI specification in the future (meaning all IDs will follow
the ACPI/PNP registries and be allocated by certain vendor)?

-- 
With Best Regards,
Andy Shevchenko
