Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAAA49A393
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2368425AbiAXX7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847649AbiAXXUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:20:15 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0EC028C26;
        Mon, 24 Jan 2022 13:28:14 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id r14so1812532qtt.5;
        Mon, 24 Jan 2022 13:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=slA4hKk3SRch55eW3a2SaAckanXwGcMXYthRdgb6F60=;
        b=StyMdhim9hb/9ea2tVx958yAlIb9nMm7Edt1qSWsnGyh/fBU4p3xeiq7Z+BPkrxhzx
         hvkt/JspEakv9QGMOvyic0F7+5XriBZUYv9A1C+VyvGSfDxp2bcKcCL2K4Bg20NJNpa1
         CzWsW1Upz6eaEOlHU6sg84RdhrB2yVynS1UM4ga0CgHRymCi8OPdZ2UG8NtYqzutsgPB
         /igRscwNvxqKQClIVHj7Ie/QrOhfnzIq5ZWebJU+fWJBmHcnl2P7F8HRwiIfJWgJJSJG
         iU/RqM5ts6AHks+pVyyyOSVLdNOeOIYTUH0Pep4R6SGPkyxu1A1ZS8YcxkKxez99mijz
         gQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=slA4hKk3SRch55eW3a2SaAckanXwGcMXYthRdgb6F60=;
        b=CdLQK+nxOfIX2lwz/i9mJHlmcNGo/dFArWLgIFMuiTIeoHf2FhTUJE3Pt39dVehbW6
         ubGrfWjvRaswU0ZP+6LWajFuZYQkdrd1fLIrORiuJgTAq4vWK0UZpF+0aBElN78OyWqy
         gl4tK3BuAtQB7tM542dNciDSRQ2PuH7b8pAApnEDQqUyeSYzBiqOB3rgzw/8LHkITYie
         heyRiwEnyNul20qUKYlrkamtJNJTNpanOLB8FeoJSmoZXxp+EXDMb793XX0NX7Y0PC9a
         jqCmFYczDNFF/1DM4ySzIeK4P/HT+v2MNJcwXMh8NWZjTioZsRCPjvmwTW02LMlEgWZR
         V+Qg==
X-Gm-Message-State: AOAM533KE26K9GwhanBdeNDFtGniXKK0S7y5wfz4vi0+U9a21M+7/xox
        mwtbzqPiyaPw/hMQr8AmHNo=
X-Google-Smtp-Source: ABdhPJxr1X9COMZLR6jW4yup+IW6IyJRcstvSb5FoEcZSfZWyozW2KfzV0ISVXICiVD3Akpz9hnNCg==
X-Received: by 2002:ac8:5b51:: with SMTP id n17mr2893765qtw.594.1643059693753;
        Mon, 24 Jan 2022 13:28:13 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id d13sm5486316qtx.35.2022.01.24.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 13:28:12 -0800 (PST)
Date:   Mon, 24 Jan 2022 16:28:09 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <Ye8Z6dS5cCji9LNQ@shaak>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> > On Mon, 10 Jan 2022 21:31:04 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > Instead of custom data type re-use generic struct s32_fract.
> > > No changes intended.
> > > 
> > > The new member is put to be the first one to avoid additional
> > > pointer arithmetic. Besides that one may switch to use fract
> > > member to perform container_of(), which will be no-op in this
> > > case, to get struct rescale.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I'm not totally sold on this series showing there is a strong case for
> > these macros so interested to hear what others think.
> 
> So far no news :-)

Like I mentioned briefly in the other thread[1], I don't really see the
advantage for the AFE driver given that it's almost just like renaming
the parameters.

For the other drivers affected by the change, it drops the definition of
the structure which is nice. So overall, it's a plus IMO :-)

[1] https://lore.kernel.org/linux-iio/20220108205319.2046348-1-liambeguin@gmail.com/

Cheers,
Liam

> > Boiler plate removal is always nice of course...
> 
> That's what I considered nice as well.
> 
> ...
> 
> > > I found this better in order how code is structurally (re)organized.
> > > I may rebase this on top of ongoing AFE series.
> > > 
> > > Also reveals possibility to switch to rational best approximation.
> > > But this is another story...
> > 
> > Now that may well justify introducing this shared infrastructure :)
> 
> We also have mult_frac() macro which can be extended by mult_fract() for
> these structures.
> 
> ...
> 
> > >  	rescale = iio_priv(indio_dev);
> > > -
> > > +	rescale->source = source;
> > 
> > There seems to be more reorganizing going on in here than is necessary
> > for the function of this patch. At very least, description should
> > call it out.  Why move setting source?
> 
> Yeah, I agree that this may be in a separate change before of after the series.
> I will split.
> 
> > >  	rescale->cfg = of_device_get_match_data(dev);
> > > -	rescale->numerator = 1;
> > > -	rescale->denominator = 1;
> > >  
> > > -	ret = rescale->cfg->props(dev, rescale);
> > > +	fract = &rescale->fract;
> > > +	fract->numerator = 1;
> > > +	fract->denominator = 1;
> 
> > > -	rescale->source = source;
> > > -
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
