Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54434B1DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiBKFUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:20:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBKFUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:20:12 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7970210C4;
        Thu, 10 Feb 2022 21:20:12 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 9so10161424iou.2;
        Thu, 10 Feb 2022 21:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RnKxUHtnbhzwXGNKdtmQDoXhiCrf6JjPF2F+d5F+Qr8=;
        b=oJ4RWzm3vjpJ/gEQhojKVN4XU2pIU/Ql/Gv/lB4dlX9cchxTNE04H4p1hqu7A1I12w
         xhv6HI48PbdFMeqFzQHRk4xVPyRI1X3bCZqG7XhH1VU7wKVl7NwDjRqxB8RFshZAOBN+
         p0XmQa28u+pWn8T1Kwt9wwrKNKA4Gu0/Sp0AQ5PfR3N1rBGXx9nvxCulh93v9PYF5qiI
         S/AE4P77fJ/5uKzSkLDsTP6P0se+PrOCwrdgyKZ5/XTVfHXUhXOyMrrSNPRx88XzydRv
         9H4opvj3h+lXNS+xK/Oig6sx2bq1PYjc8KCp9RK+lJY2NUOF8Cknzvn1xaxRDxMVwPOl
         LevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RnKxUHtnbhzwXGNKdtmQDoXhiCrf6JjPF2F+d5F+Qr8=;
        b=UOUKemOnnR5ignBUyhoH2mGgHo7bjLyTOeH+iAu7cibHL4mVHs4D7qHtFGVGG9oiyX
         eBhlRpWhbusUqxHshr905YEHymZlyBBCHJnpRwTRwOC1GNo9mpQVN5GcTrwhoXOTarTH
         ttVLP+Bxv4sEU2lzWt6+DrAHsf/xXfUtMHPvTXjfuyQoT/LQtAjYpGU5sPYaHK7sYxLQ
         dEyNp4XQ9BH8ppXlQzBQX35i81A4G8JwWRkEbTcCvZexK88JnI6MnpReKXOe0fIF2JNe
         Ee6AmpjZlGTno2mY5RYgB0NSBHsZl8hOzEBpYOMj1y6VSolBRemC1MRw61+RbU+5R3UA
         cv1A==
X-Gm-Message-State: AOAM532JltFz6PN2fhgdtbbvdZr04GoPvalyQvqdy8om1NwemfDMPlHs
        wFN82KdVoxCs/B+yq22aIbM=
X-Google-Smtp-Source: ABdhPJxpl+RJjMaPZAxbSgQnCb9NcO2odpTzUjPcv6pia2XEKvvx1DOyhbvGA/Fc2LfhgNxqxHyD0g==
X-Received: by 2002:a02:b0c3:: with SMTP id w3mr6064874jah.1.1644556811791;
        Thu, 10 Feb 2022 21:20:11 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id s9sm42687ilv.50.2022.02.10.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 21:20:11 -0800 (PST)
Date:   Thu, 10 Feb 2022 21:17:59 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/49] cpufreq: replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <YgXxh4++3/ykjjl+@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-18-yury.norov@gmail.com>
 <20220211043057.t6ukpdtakcht3frc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211043057.t6ukpdtakcht3frc@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:00:57AM +0530, Viresh Kumar wrote:
> On 10-02-22, 14:49, Yury Norov wrote:
> > drivers/cpufreq calls cpumask_weight() to check if any bit of a given
> > cpumask is set. We can do it more efficiently with cpumask_empty() because
> > cpumask_empty() stops traversing the cpumask as soon as it finds first set
> > bit, while cpumask_weight() counts all bits unconditionally.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for SCMI cpufreq driver)
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
> >  drivers/cpufreq/scmi-cpufreq.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> I already applied it yesterday and replied to you as well. Did I miss
> something ?

It appeared in next today after I prepared this series, that's why it
slipped through. Sorry for that. Please ignore this patch.

Thanks,
Yury
