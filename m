Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACC148B756
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiAKT2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiAKT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:28:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA8C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:28:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x15so362302plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9GGnh4ZAPicH6zFbaaibhXVxtkqcKWl+gDZ/9uGstY=;
        b=XJK8WGVdpyWBTW2rl6/42XtxFt9UrgnqqMQzJoOJEHvBzE5ADG38zKOh8jNEzOzfVa
         OV8Ev2SH3em9lpNTeMncSLR63IzJSOQ3uCrPfKhO/cvEZ23mFf8PenF061eqHnIJL4We
         J7B3DqG7aKDJ9jhdpTer+qaNvtAJW7O3cENRZnc6zG0VVpZXuEqq0/cD/qDyRgwrzyOz
         HK9hzbm2TcA49nYlmVZI+ehPKC9zRKi0SE9NZD6zcKHGlv0Lm9VcJ/GibNqcF61mMlgv
         6B3QyrW6v+xcPyw7BynwSsxIxBgZMSpmAhb32RAaKLg9mUXR8C4vql++jG6GA8lrqwhd
         bRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9GGnh4ZAPicH6zFbaaibhXVxtkqcKWl+gDZ/9uGstY=;
        b=EVkPfkKtrf5E1KfPB2vCJxvdBmqdMqaRmcFo+riafD+ksXq0PqVG4URppS1HStym7P
         QsIQrQIflDyp2lLh1PwMLm+swSBK11Npoq39gDZRUSCHHXW5cm4lOZFg9L7rjwY0oXaJ
         SqqZZFWezAeeXypLoV3SHEaFcnlz02yqMqCEnECGjWDdeuSsEGrf46/BMeS3te4zKXIb
         cp5Y/HS/DbGi2Zva6nbXmIiNU4Ug4nFlrOGWFbgCC1ITb2Cmu55By6oe4IakD0+Zwk56
         9ztomCEbT9A3W/xJgjbFSlBB/8thMQf8dSo+nQKJ7hP9Ff8rM1ajE6rcq+84YqTejHBA
         bC9A==
X-Gm-Message-State: AOAM533UqAHM/fKCuByVAoBgmr9McUwSYHpJ+Pw2XbsGdE0oLr58TJoW
        HGyoS6CvlL2GINs9FWG2FwWtrw==
X-Google-Smtp-Source: ABdhPJwn6iFqQcbHTGhaXHMnTyxbURXfuNpqLv1VIhHz64R5T9Ua0/tnAfrcYo1lrQMclNym60pNsw==
X-Received: by 2002:a17:90a:c254:: with SMTP id d20mr4829393pjx.226.1641929289251;
        Tue, 11 Jan 2022 11:28:09 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id t27sm11926893pfg.41.2022.01.11.11.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:28:08 -0800 (PST)
Date:   Wed, 12 Jan 2022 08:28:06 +1300
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: add support for TAS5805M digital amplifier
Message-ID: <20220111192806.GA10345@nyquist.nev>
References: <61dccc59.1c69fb81.e1d98.02e3@mx.google.com>
 <Yd26p8rF3arufd2R@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd26p8rF3arufd2R@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 05:13:11PM +0000, Mark Brown wrote:
> > +static void tas5805m_refresh_unlocked(struct snd_soc_component *component)
> > +{
> > +	struct tas5805m_priv *tas5805m =
> > +		snd_soc_component_get_drvdata(component);
> > +	uint8_t v[4];
> > +	unsigned int i;
> > +	uint32_t x;
> 
> > +	snd_soc_component_write(component, REG_PAGE, 0x00);
> > +	snd_soc_component_write(component, REG_BOOK, 0x8c);
> > +	snd_soc_component_write(component, REG_PAGE, 0x2a);
> 
> This isn't using the regmap paging support and I'm not seeing anything
> that resets the page here.

Hi Mark,

The blob of register writes we get given from PPC3 contains a whole lot
of explicit page and book changes, and there's not an easy way to tell
regmap about this, as far as I know. Do you think it's acceptable to
stick with explicit paging for this reason, or is there a way to make
this work with regmap's paging?

I'll go ahead and address your other comments before resubmitting.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
