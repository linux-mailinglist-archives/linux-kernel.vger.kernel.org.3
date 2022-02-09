Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B614AF6D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiBIQf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiBIQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:35:52 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A6C0613C9;
        Wed,  9 Feb 2022 08:35:53 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id y8so2254421qtn.8;
        Wed, 09 Feb 2022 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VIQd4zPChyzCUCXWagCLUCs42aJXJ04YlLh4elTWbTg=;
        b=Zcku7i3lXjZOuAom/GOkwZhqovFOc7qJd4cMsGYlvFaBYaT/XylJBapHFNs6JfhQfZ
         nO6xUPiMclr6P3wSv4A9CyceOZTBDaMDDd7XqoEAlt8Blihl1cu51DvAcPUzzlVrGG31
         qGJOGc1VizsZk+Bzy677E/6o3vlAdO774YFyacjiSzwhE01YYshEFCZZ7beqW5asAmxZ
         EJMbY2SYzEa4jpe/LqI0vhAt5/TCiJmgG5dyHp8YDwlT6Gwdgiurh+n+WXIbL42jaWRT
         N7NEUh/+nolJvlvXxVTltMrIOikbma2fvnXgKWVxQcham9OJ0rSe/j2yJiFmPoK7NoR/
         51Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIQd4zPChyzCUCXWagCLUCs42aJXJ04YlLh4elTWbTg=;
        b=7FMSMlznUdMj9PbRNsppXl3vEBT5zVJCDvL1JdIE1hcDShYVcH8gGfWfPoeq5Ckvcd
         2QzqAsPNBeip5y0VjythdMPo2h8y/tNTtqaPuWdI3Qw7xFeG7q7E+mJyIP3ZVDIxxvsY
         nTs997zpP8VsiPDpF8tlZUQkWxHKkyYbEjxGkjVXiwis+cVtyZMmgyd9lCVUJMQ8anPU
         W9R9xXiFXdJgLHLe/rqtJ/CwFyGXUgIyoNJMThOpp9MKIlYq3x540teU+y6ltBHdI5lr
         dtdo3OhaEiCONKMnhYlXf+GLt9mEott8N+ZibF4zPt1B5a8NRYnRCThIWQzKRcNov7Jm
         RUkQ==
X-Gm-Message-State: AOAM530Fl8mtZIsNxCPzNmFfzqDXS9ZXH5SFpYSyD/+z7F1gh/tU+3w9
        8qS0WpFymH2cqQUb2XwpD/JqIuEBQjg=
X-Google-Smtp-Source: ABdhPJyp/mFi7actjWTN5uvus07lhuZuHrTCeYXQf09kWa9lay6uPLb3/ndJfWVfYb49WvWua+UvVA==
X-Received: by 2002:a05:622a:1313:: with SMTP id v19mr1924456qtk.219.1644424553009;
        Wed, 09 Feb 2022 08:35:53 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id x18sm9395050qta.57.2022.02.09.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:35:52 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:35:50 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v14 03/11] iio: afe: rescale: add offset support
Message-ID: <YgPtZpYGWvjX5c4U@shaak>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-4-liambeguin@gmail.com>
 <CAHp75Vd7OfLyfziraV4AHWrnTSCPPN9gzGNxaFa+V6uNe8-YUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd7OfLyfziraV4AHWrnTSCPPN9gzGNxaFa+V6uNe8-YUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Feb 08, 2022 at 03:42:22PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 8, 2022 at 4:04 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > This is a preparatory change required for the addition of temperature
> > sensing front ends.
> 
> ...
> 
> > +               if (iio_channel_has_info(rescale->source->channel,
> > +                                        IIO_CHAN_INFO_OFFSET)) {
> > +                       ret = iio_read_channel_offset(rescale->source,
> > +                                                     &schan_off, NULL);
> 
> > +                       if (ret != IIO_VAL_INT)
> > +                               return ret < 0 ? ret : -EOPNOTSUPP;
> 
> Wonder if this actually should be
> 
>    if (ret < 0)
>        return ret;
>    if (ret != ...)
>        return -EOP...;

Unless someone has a stong objection, I'd rather keep it as is.

Cheers,
Liam

> > +               }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
