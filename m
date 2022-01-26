Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9049CEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiAZPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAZPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:54:26 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A984C06161C;
        Wed, 26 Jan 2022 07:54:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id b22so4820199qkk.12;
        Wed, 26 Jan 2022 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2hfJnq7WFG6jJbY1jQ64KsykK+O3FA7XQ9vdxvBn90=;
        b=fxrbuXDps7bOVDI3Pn+WxxehZMZBBY1HydEO72ENhhutcwBCI+hmGQ+wJgoWASvsgz
         cjhBQX1tKM9lDW6Zaj6ubROCjBk3rXIHp2R+GTeTBgO11RTbNF7BFgVBUtKgsML1Wp+2
         Sw6EZHJNwLfuZumruwVCnPDLIMWCUf3EmLXHCzhXzKpAwc4acw3fAUXRe4lSfG5Y4rBy
         ffITB/xAhu1rp926aEEHwRaf3FVxINsrX9DdfQu4OyhIbfzpV5SuzqbVTZmhZikxn+8j
         hGQ2lCR8QvMDeUyH/vCJqjdbNdHTHQM/ajihgBqfMBRE2o7v3Q3tUul1PjQ8vWfNp7GR
         UlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2hfJnq7WFG6jJbY1jQ64KsykK+O3FA7XQ9vdxvBn90=;
        b=Cj0zKpzavFoYf7jZzY7AhcVsVLLyhD+dLaRO+jPB1Nu6r2mp0OFkydPEzgoBgL0miN
         zBpK5/aTQoBPMOAYmMon3yEThJpOLDFkuqSyk1BEe46AKHGA25ZVUiPEkzFFBdpzFT51
         I8n0R/mwFFqj/GpQcr/RW7nZTc7zIe+JlmM3ff1s6k+u7okbj5VzoP2PWElS0qNpmK13
         ywJg5WBB8obFOoA6rbXY+LEYQelainCmznoTSrh8Knd/d/xsIh9FulLj2LvuQIzfX+or
         w8E9QntuAKMsYjj3nSSQbMOp8PyDp6FhspW3GzoVNelHrqEGV63kjTZHaqH5wxzxPSYu
         ZkVw==
X-Gm-Message-State: AOAM5334zTX6/D0BIpWdvGur5v7Evv/ZgFvlE0Mfbb/SRgyivDvJHAxl
        LYVNSWjU6rz2dx5xYf7VDII=
X-Google-Smtp-Source: ABdhPJz6xJBj7tZ4ymoR1vfWqzCoELsEIantQdyGfyRGT3CSIbDxgepmXmUiaHMksimv4ZaJorKDfw==
X-Received: by 2002:a05:620a:2915:: with SMTP id m21mr8359108qkp.374.1643212465186;
        Wed, 26 Jan 2022 07:54:25 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id b4sm10815876qkf.61.2022.01.26.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:54:24 -0800 (PST)
Date:   Wed, 26 Jan 2022 10:54:22 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <YfFurqdAmPpZ8PJ1@shaak>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak>
 <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfE45cImAQpOeziT@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
On Wed, Jan 26, 2022 at 02:04:53PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
> > On 2022-01-25 19:17, Andy Shevchenko wrote:
> > > On Tue, Jan 25, 2022 at 03:54:07PM +0100, Peter Rosin wrote:
> > >> On 2022-01-25 14:17, Andy Shevchenko wrote:
> > >>> On Mon, Jan 24, 2022 at 04:28:09PM -0500, Liam Beguin wrote:
> > >>>> On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
> > >>>>> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> > >>>>>> On Mon, 10 Jan 2022 21:31:04 +0200
> > >>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...

...

> The problem here is that every driver would like to do this differently
> and since it's related to the calculation we will have all possible error
> prone implementations which do miscalculations (yes, one may not notice
> traditional off-by-one until it becomes a huge issue by using additional
> conversion formulas or so).
> 
> > But sure, feel free to suggest something. But please hold until the
> > current work from Liam is merged.
> > That series is clearly more
> > important, and I'm not really interested in neither adding more work for
> > him nor a cleanup of the current code without those pending changes.
> 
> I'm very well fine with that. As I mentioned from the beginning, I may rebase
> this on top of the Liam's work.

I appreciate that! I'll make time to wrap things up so I don't hold you
up.

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
