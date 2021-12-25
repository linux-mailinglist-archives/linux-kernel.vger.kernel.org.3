Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C747F3D9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhLYQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLYQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:37:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1BC061401;
        Sat, 25 Dec 2021 08:37:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w16so44332815edc.11;
        Sat, 25 Dec 2021 08:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp14R7GSqiYR9/6km+gt56wkm7AN4wImp9Bt9uzwo8A=;
        b=orr5VkWZ2RUz2gwv5ntyrfNI0H2QPgETyCgYMeL66rWrSs93CuRYKa39T3GzmGTAYm
         Ex+Mq7yilvbI/tGjq+JmQG2LYqcKosCRTr3Fd4e+0Fk4FRVM/ACaLG/ktAL9hQmpcoOl
         vYrG+CLyp1Vi6Nls4lm6wE1RdzhLel/9A72g9zdvfeo0dYeJhbLK7MCLRJ2rftALhfOT
         h/KOJU1VbQcep/HAEoOG+ZchVUjPaoGhFi6JK0xuRqxed6yIhCDutv6PselSOCBpFDUp
         UekBOsEe0PyUP3O66BI6JFHiF+UkHtz7ur9OawOXgKuNj7f3G4rrHH+DWTeJjLfas5bz
         03TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp14R7GSqiYR9/6km+gt56wkm7AN4wImp9Bt9uzwo8A=;
        b=fFTzaE+L5qeVlTD4pHV+2e/37Msr4vD1I5hDqdGvmRsQOYuqzP0Ldb/iOpDmYQZpOM
         YmKIi2oL+DjXi79eT/68QkJh+Itbza5WfOMDKaLoXbJakxtXSzv+BSF3a4CN1R+cQyAh
         E1T0TfgW0vom5yKM18U0As7Y9QiBayNtu9X3XJtDvcAELUce9Cbyviuxex4ZQff1P0PM
         L8hPPDMSpZ5fsuq/wRQs/IbBDhWUrWBcZK+kjXlINKLmdLKkS19u90G6lqtQEWKvzdFV
         zUCwp1NrklkWa28KLzph1LFYaumyegQoAUjSZRSRUu2zKY8N+dR+Mbyb9hMrf5kaeM59
         5lJQ==
X-Gm-Message-State: AOAM5339LzzwjtuFFnSy7f/JlpxQl4e9zIBR3aV6EBddZTinwr/duabr
        G7anDTfIz4N62HkvjTkefbSXsJs3A8suGKWzbYx21C8lqLBsJw==
X-Google-Smtp-Source: ABdhPJzLELowdgw2LAqP2+ZLzXCIwhbHFPm0W89lpc2u8NuEknXTdv50O0phcI6Q9cloPRJuZPYsHEgMlmbZwKiTbWo=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8369159ejj.636.1640450268909;
 Sat, 25 Dec 2021 08:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20211117020346.4088302-1-swboyd@chromium.org> <20211203044718.b6nqn5rcbkrnpchp@vireshk-i7>
In-Reply-To: <20211203044718.b6nqn5rcbkrnpchp@vireshk-i7>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:37:12 +0200
Message-ID: <CAHp75VdkxbJP7T-qaS=NKAUb7dXJdKeGRneQw+A1XN5AGtajeA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-hw: Use optional irq API
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 5:26 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-11-21, 18:03, Stephen Boyd wrote:
> > Use platform_get_irq_optional() to avoid a noisy error message when the
> > irq isn't specified. The irq is definitely optional given that we only
> > care about errors that are -EPROBE_DEFER here.

> > +     data->throttle_irq = platform_get_irq_optional(pdev, index);
> > +     if (data->throttle_irq == -ENXIO)
> > +             return 0;
> > +     if (data->throttle_irq < 0)
> > +             return data->throttle_irq;

This adds more work for the future.
The best approach is

ret = platform_get_irq_optional(...);
if (ret < 0 && ret != -ENXIO)
  return ret;
if (ret > 0)
  ...we got it...

It will allow the future API fix of platform_get_irq_optional() to be
really optional.

-- 
With Best Regards,
Andy Shevchenko
