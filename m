Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930614A79D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347347AbiBBU4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBBU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:56:32 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92901C061714;
        Wed,  2 Feb 2022 12:56:32 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id bs32so826469qkb.1;
        Wed, 02 Feb 2022 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2oBJmK/+RBc8FE7PZmIHJK5BlYsD+KPlOD7Zr3SmWis=;
        b=IjdRGcpiq/kU8e8JDfGm198uCN3Ay9NCRoeG99nRmaxObU0Z+Ri617Om8zaXoE25N4
         14JG8CM/RGyQyTEmEZ4+/xrPY+FzfOxqvsNsFXoObz3HbjxApLOC/Q2tIYS0PXZlKNRE
         LGa3aOcDFelY+Q1eIAIpWuM3dDiKp3hE1S1lbZDZRGDTBlcMXUrplj4T8l/imyPfc9DB
         4UEBGlNi1HXoYdj3tVip7++2N72fQcrBvGXKPlWkWAOZJbnwjYU5Q4o2Ghh6+5VSlg+9
         qhjojkaaqoKpnZaAUJc4hvxiQ3SS3GvcdCOnivES0J+XlIII3au78CeA64LzN25BvjtQ
         aAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oBJmK/+RBc8FE7PZmIHJK5BlYsD+KPlOD7Zr3SmWis=;
        b=hm66H5HgdWqX9okOW0VTVXelXXtLURWsGam0L6T9/WZw3ZmGNJqL3l3vbI+kSdNaHQ
         MBs2KZUYFyOCJ+XNvMMwfbVAKj9hsIXE6oHSpldpbl4zggjuq5wOWvV4e5szA1pDsMan
         Vj5Wc89ibGM6O/FgkGaS1HXQXA0T7FUfRHji3Gvv2+4/nqUzFPQH+/J/zVtB77Ws3393
         2qbqn4w7u11TejC+XJUvJEsK4p6lvO8YuwdUGQECi9S0cZXDoa9kjpb0K8LQhI/cskzM
         1tGGeCnw4DLDoNkcBz5ZeMRabKHm/NY9qRID4e1Ain+Q0pKHQqrFVkJXThQiAfrIUOJG
         m80w==
X-Gm-Message-State: AOAM532CiQC1o0VZsvSjqUWtwOUBlvVh78XTHA1Y7fAPwOeHcVnRDVcH
        WW7McOJno49COsrrDzBsPS8=
X-Google-Smtp-Source: ABdhPJzZXB9Y3XZwRz0Y8ng7Vr5OzC7UnSl3/1MEpsMNYDrSC2FkfaMUKQHSNxKCEcO0f3zWWJ2T8w==
X-Received: by 2002:a05:620a:319b:: with SMTP id bi27mr21596353qkb.505.1643835391682;
        Wed, 02 Feb 2022 12:56:31 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id b8sm1772339qtx.79.2022.02.02.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:56:30 -0800 (PST)
Date:   Wed, 2 Feb 2022 15:56:28 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, andy.shevchenko@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v13 08/11] iio: afe: rescale: add RTD temperature sensor
 support
Message-ID: <Yfrv/K8ohqTINEED@shaak>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-9-liambeguin@gmail.com>
 <cb48ec7c-da91-cadd-ee7f-02691671e7be@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb48ec7c-da91-cadd-ee7f-02691671e7be@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On Wed, Feb 02, 2022 at 05:58:25PM +0100, Peter Rosin wrote:
> Hi!
> 
> On 2022-01-30 17:10, Liam Beguin wrote:
> > An RTD (Resistance Temperature Detector) is a kind of temperature
> > sensor used to get a linear voltage to temperature reading within a
> > give range (usually 0 to 100 degrees Celsius). Common types of RTDs
> > include PT100, PT500, and PT1000.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > Reviewed-by: Peter Rosin <peda@axentia.se>
> > ---

-- snip --

> > +
> > +	tmp = r0 * iexc * alpha / MEGA;
> > +	factor = gcd(tmp, MEGA);
> > +	rescale->numerator = MEGA / factor;
> > +	rescale->denominator = tmp / factor;
> > +
> > +	rescale->offset = -1 * ((r0 * iexc) / MEGA * MILLI);
> 
> The inner (unneeded) brackets are not helping with clarifying
> the precedence. The most "problematic" operation is the last
> multiplication inside the outer brackets. Extra brackets are
> more useful like this, methinks:
> 
> 	rescale->offset = -1 * ((r0 * iexc / MEGA) * MILLI);
> 
> But, what is more important is that you in v10 had:
> 
> 	rescale->offset = -1 * ((r0 * iexc) / 1000);
> 
> What you tricked yourself into writing when you converted to
> these prefix defines is not equivalent. You lose precision.
> 
> I.e. dividing by 1000000 and then multiplying by 1000 is not
> the same as dividing directly with 1000. And you know this, but
> didn't notice perhaps exactly because you got yourself entangled
> in prefix macros that blurred the picture?

Apologies for this oversight. Your observation is correct, I looked at
the prefix changes and failed to catch this mistake.

Would you be okay with the following:

	rescale->offset = -1 * ((r0 * iexc) / KILO);

This would keep things consistent with what I said here[1].

[1] https://lore.kernel.org/linux-iio/YfmJ3P1gYaEkVjlY@shaak/

> These macros have wasted quite a bit of review time. I'm not
> fully convinced they represent an improvement...

Sorry for the wasted cycles here.

Cheers,
Liam

> Cheers,
> Peter
> 
> > +
> > +	return 0;
> > +}
> > +
> >  enum rescale_variant {
> >  	CURRENT_SENSE_AMPLIFIER,
> >  	CURRENT_SENSE_SHUNT,
> >  	VOLTAGE_DIVIDER,
> > +	TEMP_SENSE_RTD,
> >  };
> >  
> >  static const struct rescale_cfg rescale_cfg[] = {
> > @@ -414,6 +456,10 @@ static const struct rescale_cfg rescale_cfg[] = {
> >  		.type = IIO_VOLTAGE,
> >  		.props = rescale_voltage_divider_props,
> >  	},
> > +	[TEMP_SENSE_RTD] = {
> > +		.type = IIO_TEMP,
> > +		.props = rescale_temp_sense_rtd_props,
> > +	},
> >  };
> >  
> >  static const struct of_device_id rescale_match[] = {
> > @@ -423,6 +469,8 @@ static const struct of_device_id rescale_match[] = {
> >  	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
> >  	{ .compatible = "voltage-divider",
> >  	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
> > +	{ .compatible = "temperature-sense-rtd",
> > +	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, rescale_match);
