Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80D554C0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbiFOE4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbiFOE4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:56:13 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D5337003
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:56:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 184so10331146pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6x1p/cHxOzHrXaTiqFWMaZjgSTu7MFxfKrtukk0Ctcc=;
        b=FgH88KSnMz7Lni9M9mJ+gpGZvHZufaDlqff3aEelp0mrqNatoTJFWHAoMOm0MqP4OD
         LD5I0POzKL1dSXFNwurSJFp1XWfZgyk1kBYMDhOqy/pflpKBZHZ9u0T/d+kNP//30ms4
         C+7ixsTdShgBVwUOEglxjnxRrjEAAaaWDNl3/QcWS7IyuJa/59yaJ1FxXpvXojZEr6d9
         RHOMKh+TYKLC9UEs/UjzX4OfM2vJHHIuIXF8YWv29z54xQ6mDxni5Vi9D0jcZAcTtbLz
         WyIEz1QVuTmZ2KB/gj8zmumGE6jINtdP7EZpLZ3GtmCBM3bkQZflanp+ay2xtUTAQZaP
         Hu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6x1p/cHxOzHrXaTiqFWMaZjgSTu7MFxfKrtukk0Ctcc=;
        b=Y0g7f2OlF7oA2aMeSPgKOpfZ85z77h6luNz6SAl0IO8/XPUWCWaYCXqmHEpwjtJUqF
         RJvwNggNKjXW6/Lh/VUb/7HTjURxiyYnlIlREhGYltQhFjT3iottwgo1kdP6iUPMnQPw
         +SIZlGOiG4tFFQ0ipDHJS2z6i+nluGS52ihL6ZpAkCCjUz3ACCLIRO2vptJQ+VTLvo5K
         vJ+fN+h/xBUhIC2OSbXmweZwnisW4Cqcs9wok5N91K+su9Ootk9G6J0UqBH7W5njM9Qa
         ccL1eE53szigt5oWFsfZrOrsQntsnHZhDzBxWCShEH5YeHoMKOF8mQMOTTLT/MvN0giP
         ik2Q==
X-Gm-Message-State: AOAM532nrYVo8vct4hiQESjV8rEnBRjcKCTWnzVZXKR0Zx+FcXDQfQoO
        BHRwhRHmhEc257mxLsBI1oZ0vg==
X-Google-Smtp-Source: ABdhPJwu24Nqyc94Rp20DIAhF45O/DYl99akByKaRyIrjnaeH6YZTymTppQh5tNgyehnPcZJihUJhA==
X-Received: by 2002:a05:6a00:814:b0:51c:1878:4943 with SMTP id m20-20020a056a00081400b0051c18784943mr8129630pfk.62.1655268971775;
        Tue, 14 Jun 2022 21:56:11 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b00168b113f222sm8127431plp.173.2022.06.14.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 21:56:11 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:26:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yi Yang <yiyang13@huawei.com>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
Message-ID: <20220615045608.pwranz6b633xmymf@vireshk-i7>
References: <20220521063534.138930-1-yiyang13@huawei.com>
 <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
 <CAJZ5v0jCx0v-Q2=aW4nSSAHHajUnLdVtQMe3w1cX1w-o=mSesg@mail.gmail.com>
 <CAJZ5v0g-rCSd+S4YPBR8Jv2PqePhjQd0K97Rj2+TX3OrWAP0NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g-rCSd+S4YPBR8Jv2PqePhjQd0K97Rj2+TX3OrWAP0NA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-22, 15:48, Rafael J. Wysocki wrote:
> On Tue, Jun 14, 2022 at 3:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, May 24, 2022 at 9:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 21-05-22, 14:35, Yi Yang wrote:
> > > > Function scnprintf() would reserve space for the trailing '\0' and return
> > > > value is the number of characters written into buf not including the
> > > > trailing '\0'. internally meaning the next scnprintf() would write begin
> > > > the trailing '\0'. The code specifying "PAGE_SIZE - i - 2" here is trying
> > > > to reserve space for "\n\0" which would cause scnprintf() to reserve an
> > > > additional byte making the tail of the buf looks like this: "\n\0\0".
> > > > Thus. we should reserve only the space for one '\0'. passing in
> > > > "PAGE_SIZE - i - 1".
> > > >
> > > > Additionally, each iteration would replace the trailing '\0' from the last
> > > > iteration with a space, and append 4 additional bytes to the string making
> > > > it a total of 5 additional bytes. That means we should stop printing into
> > > > the buffer if the remaining size is less than 7 bytes(1 for the ' ', 4 for
> > > > the %u and 2 for the tailing "\n\0")
> > > >
> > > > Signed-off-by: Yi Yang <yiyang13@huawei.com>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 1f6667ce43bd..60c005c9961e 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -844,9 +844,9 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
> > > >
> > > >       for_each_cpu(cpu, mask) {
> > > >               if (i)
> > > > -                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
> > > > -             i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
> > > > -             if (i >= (PAGE_SIZE - 5))
> > > > +                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), " ");
> > > > +             i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), "%u", cpu);
> > > > +             if (i >= (PAGE_SIZE - 6))
> > > >                       break;
> > > >       }
> > > >       i += sprintf(&buf[i], "\n");
> > >
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Applied as 5.20 material, thanks!
> 
> And dropped, because it has been superseded by this one:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/b9fa08171c09343ace94a7343553a4bee4695c90.1653565641.git.viresh.kumar@linaro.org/

The $Subject patch is still required AFAICT, it is fixing a different problem.
Though it needs to be rebased on top of your branch now.

-- 
viresh
