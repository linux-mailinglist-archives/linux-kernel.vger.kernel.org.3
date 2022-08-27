Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4815A378B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiH0MFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0MFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:05:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5929612602;
        Sat, 27 Aug 2022 05:05:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t129so3978835pfb.6;
        Sat, 27 Aug 2022 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Xm1nhA4qs4Pjpc09I2GPMsrr76SU/YUnQePs9+vlA4Y=;
        b=PWCRF10ZlJ8x5xSxr1AjjIxi6mMod5unparcdBbL3CcXvXAQFnQ2TJoGEUCRy5POdy
         UhgUv0+3VT6SUzsIC9qjmOULw14A76zXogxudPTe5lPsfxZVTXNvPRRLXYYgf5B2jZD+
         59Q4eIhj9GdjbS23gzjW+4EwJpd8NFK9XOde7YUOlmMv263S/sNdE/375KtEmOsiNIgH
         +VZS31LlrnyxD+t8LCFijQzSJiiXH2U/fB0WLRbAkuzBI4FPKw3iF4e+VSQG7aPu6+nT
         PflxEjpZvfi4BcPt1IHw73VMAfYPxJdlgrystLflrRsW9K74a30q/vorUcCQaJg4NZpC
         7a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Xm1nhA4qs4Pjpc09I2GPMsrr76SU/YUnQePs9+vlA4Y=;
        b=VmdNJQLEBl4VfqqdOF4zYoDay4Rgvwiy16mN/MEekp6FKfBF+4/DP6haJqZFM3gDDb
         czmH7nK5pYKyirw8p+bVevHCZaLqlP0kvLLUCM7n8oHtr7bRvh6pKG7v3myV8ItPcPrx
         w/xsvAuWY9SlMzBM9rknv6l2EbgbeG7bo35ijsB+Dvtrh/zXfkAU6YgAzeM+SdjcQMYZ
         HL/OQpgp7O8bpiZN8u0Jes9C3ingxyUFmI1Ky2ntKyDgHM4NEUhAd+7TmIjoJJrfPBnw
         BvvpIIAgyolzlgj8/7iuaAJFMJ8qvv+eI/fssSEZBOxdmIgcvdMkY69Ecd8FZmAFfDWu
         TN+A==
X-Gm-Message-State: ACgBeo3NY0IF2AM/ipP/hGFg4n0lscNuyQ0r01hSB2I0lsLwOKmuPDaW
        NoA9cDOfy7mdmJN9dtdSDRg=
X-Google-Smtp-Source: AA6agR7NWXqJVbjUgWkTmIL7EezW2s1Rs+B6k/9g1ebsxLxD/uvFuUTj8hLYhwKfxJkfC/wEje0t+g==
X-Received: by 2002:a63:da13:0:b0:42a:7f03:a00e with SMTP id c19-20020a63da13000000b0042a7f03a00emr6777867pgh.332.1661601951215;
        Sat, 27 Aug 2022 05:05:51 -0700 (PDT)
Received: from DESKTOP-KA7F9LU.localdomain ([49.207.219.204])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b0017446f8d494sm2621921plb.240.2022.08.27.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:05:50 -0700 (PDT)
Date:   Sat, 27 Aug 2022 17:35:45 +0530
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     chinmoyghosh2001@gmail.com, Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: runtime: Add support to disable wakeup sources
Message-ID: <20220827120545.GA332@DESKTOP-KA7F9LU.localdomain>
References: <20220825173457.23298-1-vimal.kumar32@gmail.com>
 <YwnPFdYL0W3e5E+n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwnPFdYL0W3e5E+n@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 10:00:21AM +0200, Greg KH wrote:
> On Thu, Aug 25, 2022 at 11:04:41PM +0530, Vimal Kumar wrote:
> > User could find many wakeup sources available in the bsp, which
> > they won't be using. Currently users can only get the status and
> > list of enabled wakeup sources, but users can't disable it runtime.
> > It's very difficult to find the driver for each wakeup sources from
> > where it's getting enabled and make the changes for disabling it.
> > 
> > This will help users to disable any wakeup sources at runtime,
> > avoiding any code change and re-compilation. A new class attribute
> > "disable_ws" will be added in the wakeup calss. If user want to disable
> > any wakeup sources, user need to find the wakeup dev node associated
> > with the particular wakeup source and write the devnode name to the
> > class attribute "disable_ws".
> > 
> > Example:
> > Need to disable the wakeup source '1c08000.qcom,pcie'. The dev node
> > associated with this wakeup source is:
> > cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie", then for disabling
> > this wakeup source :
> > 	echo wakeup3 > /sys/class/wakeup/disable_ws
> > 
> > Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-wakeup | 16 +++++
> >  drivers/base/power/wakeup_stats.c            | 65 +++++++++++++++++++-
> >  2 files changed, 80 insertions(+), 1 deletion(-)
> 
> Based on previous discussions on the original submission that you seem
> to have taken private, sorry but no, I can't even consider this
> submission from you.
> 
> Please work on other portions of the kernel first to get used to the
> development process.
> 
> Rafael, please don't worry about this.
> 
> greg k-h

Hi Greg k-h,

My sincere apologies for responding privetly on the original
submission, It was not intended to do so. There was some issue
while responding via mutt and I end up responding privetly.

I have responded publicly on original submission as well. Please 
consider this second version, I have taken care of some previous
reviews.

Thanks Rafael, for the review comments as well, I will be respondig
to the queries in a seperate thread.  


Warm Regards,
Vimal Kumar
