Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7754B27C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiFNNsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFNNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:48:33 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA73631F;
        Tue, 14 Jun 2022 06:48:32 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3137eb64b67so29775247b3.12;
        Tue, 14 Jun 2022 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4wtwPGdIM+P1rhGIHteBYdQYP+P9hfjr/NYNmIuZpc=;
        b=QB0zVauU2WW8dej5g3l7mRT3cKx07SL9Vcp6XzxLFixpacQ5kxViO3/c2j7l3MpXMr
         egJexA8GKv6XNHSwm2lGQIBn62QD3jRNDM8HVYink9jgpvSbeOc5ZZudmL2WXqbS1xeb
         kZr9C9dE3PTIxrNFcUQ9VB0UN5DKQbOswPMnfdi7zOcCEQDRlPqU5tqk0s4uPmzt9tkJ
         LelQa4fZ1jfYp0DNJdy0/I2bNuhoV6bCVAed59HsJlfqDOWqjCuim85bfl8/HH3/ZBjf
         tLspuJLMv4kaYWVj8sSmTv6jBeeSfjGbPAfszNuORslMAslThM8xR1m8ypeuwBSaKCgc
         b1VA==
X-Gm-Message-State: AJIora+EM/AKT+c1YIwfRXbZVL1bY/WpAVapsx7/SzbUcWBu/tb6Pe+/
        IadmIOVYATWOhdoeclh9hD22sjirL31yb1sHOSsZydEnNpY=
X-Google-Smtp-Source: AGRyM1tHTVAzMA5tdZ41ucoCFVMSECmhAE6hxkkAqmkIljdU9N0NkHEtkb0HGrsatq7sLa8zReUoEAXc1ZVPcrJpLSY=
X-Received: by 2002:a81:1512:0:b0:314:1e60:880a with SMTP id
 18-20020a811512000000b003141e60880amr5719151ywv.515.1655214511577; Tue, 14
 Jun 2022 06:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220521063534.138930-1-yiyang13@huawei.com> <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
 <CAJZ5v0jCx0v-Q2=aW4nSSAHHajUnLdVtQMe3w1cX1w-o=mSesg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jCx0v-Q2=aW4nSSAHHajUnLdVtQMe3w1cX1w-o=mSesg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 15:48:20 +0200
Message-ID: <CAJZ5v0g-rCSd+S4YPBR8Jv2PqePhjQd0K97Rj2+TX3OrWAP0NA@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yi Yang <yiyang13@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 3:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 9:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-05-22, 14:35, Yi Yang wrote:
> > > Function scnprintf() would reserve space for the trailing '\0' and return
> > > value is the number of characters written into buf not including the
> > > trailing '\0'. internally meaning the next scnprintf() would write begin
> > > the trailing '\0'. The code specifying "PAGE_SIZE - i - 2" here is trying
> > > to reserve space for "\n\0" which would cause scnprintf() to reserve an
> > > additional byte making the tail of the buf looks like this: "\n\0\0".
> > > Thus. we should reserve only the space for one '\0'. passing in
> > > "PAGE_SIZE - i - 1".
> > >
> > > Additionally, each iteration would replace the trailing '\0' from the last
> > > iteration with a space, and append 4 additional bytes to the string making
> > > it a total of 5 additional bytes. That means we should stop printing into
> > > the buffer if the remaining size is less than 7 bytes(1 for the ' ', 4 for
> > > the %u and 2 for the tailing "\n\0")
> > >
> > > Signed-off-by: Yi Yang <yiyang13@huawei.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 1f6667ce43bd..60c005c9961e 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -844,9 +844,9 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
> > >
> > >       for_each_cpu(cpu, mask) {
> > >               if (i)
> > > -                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
> > > -             i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
> > > -             if (i >= (PAGE_SIZE - 5))
> > > +                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), " ");
> > > +             i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), "%u", cpu);
> > > +             if (i >= (PAGE_SIZE - 6))
> > >                       break;
> > >       }
> > >       i += sprintf(&buf[i], "\n");
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Applied as 5.20 material, thanks!

And dropped, because it has been superseded by this one:

https://patchwork.kernel.org/project/linux-pm/patch/b9fa08171c09343ace94a7343553a4bee4695c90.1653565641.git.viresh.kumar@linaro.org/
