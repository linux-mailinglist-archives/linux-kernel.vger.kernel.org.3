Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D14B3026
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353987AbiBKWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353972AbiBKWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:10:23 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79586CF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:10:21 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a28so9688929qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iooqrKL/TYKESHWFoTeWiMda07ElhGSHsB3+rvUAXTc=;
        b=OIFJCtL0TIDGkxIy5Vrst5bSQPa/mSJFeS9QHgtF/3vFUl2qyr+aeayenkgj2jctzP
         KLyhJ7i+t4CfEPXG46X6aDUU28UnJTd9GkfBjdZiK65xRzw/E1/jCU7uhGQ3+29eShdD
         nHa46sW4KiQRV7r2DADj2lBdjvwWLr/RJB6uhGiHJ9uItIo98z+OwzwzJpsKefkaaKve
         e4wNIR4cEKZUJtNFDp1OnKgk0YhrWDUJrEP+xe2oV0aY6fGO9LjYwC+BsjVIP9YBT/ze
         9HoSoXux5z06ajB8Knjw2oMGGcGT1EvjWOckxpxOIgUvDIuVBmLvgRz+l5jwK6qVfyzn
         Pe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iooqrKL/TYKESHWFoTeWiMda07ElhGSHsB3+rvUAXTc=;
        b=juAP4vBzHztAyXroBE5UwL93ENZAZ4n/L4s/bVbDFogHrvvukKWts4YIY4PRSnnUQM
         fNeesL2nfUyt1gsuQ+wNFv8d3/0G026ildWGZsaBgviMUKF/7v34zKhTIsc8vVzo8Wu8
         Cb+VrvuXljrjNY74vxxMGCy+3LTFza5A0u1cMlrgnWcEZwm59Vwy7bkRwInqjq3zd8n9
         M7Pt7NJvlDl1FwzCkTHn38GlQ7CGzLGQdt7vYmjru95qArIbBMzvVROSSUNw/jp+NJol
         DPo5OC14vyw1pcRVXmtFHekVAH6uCJ9TC5f0vZ8WOisCWwrWlJv9Adv9IvH20fr4wFzF
         wJhw==
X-Gm-Message-State: AOAM530g1R3q5DaG88DIDVE2gALvk+/98Yf/5+hndiJ7uonDi1Qdw39l
        MxYptwuB1ZuUiA7qFMy8es9WSpMc3s/ZzYUo9FQ0m1VqIg0=
X-Google-Smtp-Source: ABdhPJxp8S9VJImdFVqSHvN6RlJCimbqaTkqaMSo4k3HBycjg2DjJINA5+C1RV7s+2iCmW7ijIMK5tYdOhGj9nPvkmU=
X-Received: by 2002:a05:6214:29e1:: with SMTP id jv1mr1644340qvb.55.1644617420675;
 Fri, 11 Feb 2022 14:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20220210170434.3924169-1-dmitry.baryshkov@linaro.org> <20220211140523.738c14327b03647f535c4df8@linux-foundation.org>
In-Reply-To: <20220211140523.738c14327b03647f535c4df8@linux-foundation.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 12 Feb 2022 01:10:09 +0300
Message-ID: <CAA8EJpo_7x28BkvwOma4=-=4ricqRYCb42dXc72i4wcSceyV5w@mail.gmail.com>
Subject: Re: [PATCH] container_of.h: make container_of const-aware
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2022 at 01:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 10 Feb 2022 20:04:34 +0300 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > container_of() macro has one major drawback. It does not check whether
> > the passed ptr has a const pointer, the result will always be a
> > non-const pointer. Use a _Generic() construct (supported since gcc 4.9
> > and Clang 3.0) to teach container_of that if converting a const pointer,
> > the returned pointer should also have the const modifier.
> >
>
> Nice idea, but my x86_64 allnoconfig build explodes with zillions of
> warnings.
>
> In file included from ./include/linux/list.h:5,
>                  from ./include/linux/module.h:12,
>                  from init/do_mounts.c:2:
> ./include/net/sock.h: In function 'sk_entry':
> ./include/linux/container_of.h:17:42: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Are these warnings legit? In other words, is the code converting a
const pointer into a modifiable one? I've stumbled upon this in drm
drivers.
How do we proceed with this patch?


-- 
With best wishes
Dmitry
