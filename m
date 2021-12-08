Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522D746C9DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhLHBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhLHBZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:25:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2DBC061574;
        Tue,  7 Dec 2021 17:21:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h24so801531pjq.2;
        Tue, 07 Dec 2021 17:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z0bljh6EJq+wxTrn/V7wpzQV1b1xwFWCIC5wfhl5ahA=;
        b=GuXWUU2PyWjwPjxxIu/w5Fo/rFi4TJHJ4hjsmka4GleikSlZo1KASKMsvbGRY4FFlE
         GwZSVZVIK5w+PEUsxImML+7wdVS9LJPJbm17g5Vo4ENTcDOCpiHg4TfBsQJTfsl8eTXV
         5NGNywX2mpMwdZaPFrOoIrUulff484fLXg5C00th8Nqy9B/FL7XCKikdtNFfoPZ6KpYD
         0EJ14lYWyaXCX6zQ6qbDA8W4HTPnshxt7GNL+1Kydrp7a3IraJRGPqjoZrLC5CPPBOQF
         /XNfDXPo9WAkI2m++1yEfMbEc5eFlkcwLI47ju6ojll188HCYv1EhwbUoDYBSOcEJo+o
         7TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0bljh6EJq+wxTrn/V7wpzQV1b1xwFWCIC5wfhl5ahA=;
        b=LJ7y4BPuvu6tqj7zSHR7k8i5fZ2LLZ3kazmu6qPS4fr1NDGMxeO6QYsK5bu0zRE3zA
         LlrMBo1i3XyqAVp4Kuz1GAc+cHClK3ehYiXJ3rdd0p2PHU1VbPz2JaXbyZ054RlJX1EG
         31CofXuz6Ip30oF3R7Kd1JrNGJCjghe2Fhn+t5WlNcFL3mNSmcIfuvyEYJHDPLVKSPgp
         rCUy2AYpZWNJf7WDj3SmeVnW5dretZyYPIYDx6QElbhexSjBEK4AQs9/+e+wCweAU4/b
         iy6LbRpJTmEL+1kiB0KKO1pfzC6z2OYoDJGTjiWkIjwOlgGDizUfdF51bVViAEhUVqNJ
         DLfA==
X-Gm-Message-State: AOAM532ZR4AFN/klh7o4u5Tq2xk9PGwv8J6VOxWQv6R1KCop/m8fT51D
        bZNldgrFczHWjBvpN4vsWxQ=
X-Google-Smtp-Source: ABdhPJysbrwraKR++/jAJlekM85tS8QtypDhde4CV8yOw8D8DBucTny2NuIzA8kxyv77Cn6iuGpGaA==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr3489345pjb.218.1638926504107;
        Tue, 07 Dec 2021 17:21:44 -0800 (PST)
Received: from sol (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id p128sm1001617pfg.125.2021.12.07.17.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 17:21:43 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:21:36 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [RFC v3 02/12] drivers: Add hardware timestamp engine (HTE)
Message-ID: <20211208012136.GA18163@sol>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-3-dipenp@nvidia.com>
 <20211126013041.GA10380@sol>
 <246d1ff4-ec51-b4bf-a664-4559c45021fb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246d1ff4-ec51-b4bf-a664-4559c45021fb@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:36:35PM -0800, Dipen Patel wrote:
> Hi,
> 

[snip]

> >> +/**
> >> + * enum hte_return- HTE subsystem return values used during callback.
> >> + *
> >> + * @HTE_CB_HANDLED: The consumer handled the data successfully.
> >> + * @HTE_RUN_THREADED_CB: The consumer needs further processing, in that case HTE
> >> + * subsystem will invoke kernel thread and call secondary callback provided by
> >> + * the consumer during devm_of_hte_request_ts and hte_req_ts_by_dt_node call.
> >> + * @HTE_CB_TS_DROPPED: The client returns when it can not store ts data.
> >> + * @HTE_CB_ERROR: The client returns error if anything goes wrong.
> >> + */
> >> +enum hte_return {
> >> +	HTE_CB_HANDLED,
> >> +	HTE_RUN_THREADED_CB,
> >> +	HTE_CB_TS_DROPPED,
> >> +	HTE_CB_ERROR,
> >> +};
> >> +typedef enum hte_return hte_return_t;
> >> +
> > Wrt HTE_CB_TS_DROPPED, why is the client dropping data any of hte's
> > business?  It is also confusing in that I would expect the dropped_ts
> > gauge, that you increment when this code is returned, to indicate the
> > events dropped by the hardware, not the client.  But then you have no
> > indication of events dropped by hardware at all, though you could
> > determine that from gaps in the sequence numbers.
> > Anyway, the client can do the math in both cases if they care to, so not
> > sure what its purpose is here.
> 
> It is used for statistical purpose and hte being subsytem it can provide
> 
> standard interface in debugfs (so that clients do not have to) to anyone interested.
> 
> The dropped_ts could represent total dropped ts by both hardware and
> 
> client. I can add debugfs interface to break it down further if it helps in statistics.
> 

Updating stats is not what the return code here is for.

And what if the client discards the event AFTER returning from the
handler, say in the threaded cb?

If you want stats fedback then provide a function for the client to call
to update stats, rather than piggy-backing it on the callback return.
I'm unconvinced that stats are a worthwhile addition, and you certainly
don't need to bake it into your core api.

Cheers,
Kent.
