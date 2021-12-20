Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FEA47B03F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhLTP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbhLTP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:28:41 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189EC0317DF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:15:43 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id p37so18267239uae.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbcK5C+KX0nC+Vsrvih3RpE8RP5maH+bjnVo1AerElw=;
        b=JTjwC3NJoJzwnSCibno9sOQqh0lEtf7yIhD5vCp4L1MsAA3r92MCjQWZstDvSpK2vA
         IypeP/atX6ElOBS9XN1C4LGnZnVKKH3II26gxB36ZAbtbRGNgUNMsHuq7C6H0h7nvkkf
         RtoY9y0RVmYvk0KDOumeKAJX1oirG2CHO1JYewjp+Jkwi5ZKosf/6oWb9xTl4p2gg8CZ
         6vSfFzFGxaPxa4wvu7SW7n3ImHV7mHSeSp31Ffc9UqS3NskxN8UBnmNQqEr3/Lf+J1xU
         V2dr2jkCyw+NqG37b+gO8pABE2Ron7peBC5KPIxQrBIMu7b9dl3F5bzhOg2nBmN9A15I
         igWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbcK5C+KX0nC+Vsrvih3RpE8RP5maH+bjnVo1AerElw=;
        b=B7KW/j4ipCuvDo//p5CnYkPipONGELWgd4znLtaMjIavvZqg8WeNKLSIb4/omLT1gQ
         tNgGi1PKljQqq08PwVAO0fTqGi1QI+O5aLP94lGE0wtzlpuNtlGVGSov6vNy9CCWo7rQ
         jfQq1AeRRQOnnkIPnR9pXikHhIzLlifquS5hxB2/jZyV874SdzoWvh6O9E6rzDu+Cpr1
         HhpcgDdq1D4fXMVkpinYi2XWGBjsl4fbTh0kyKeM6eVrFOK8Ypc7bEKt+y+zl1QNBCp2
         H4wDPjrxkojEKSBBiclnwTdBlb+1tpaUJkk/Kb78qaKEUg6STGnxw8uPLN+HBING2Lw/
         w2MA==
X-Gm-Message-State: AOAM533MH9rp4EQbMZUUyZ55F8v8gcZvwduvdzlItOcjFoAlKw/+4UoG
        PignE1x+9QN0ciTkcrsvhsymC9FNQXxxchZoW0Wjaw==
X-Google-Smtp-Source: ABdhPJzg0GMHLLFkikV4NDJ9qt+SCAV5yNLudGVwoNFr9yexyB3HkIv98/XSF6M22Zbe/ve9KUa+e9XNSZ0W4Jvey7k=
X-Received: by 2002:a67:be12:: with SMTP id x18mr5123119vsq.86.1640013343089;
 Mon, 20 Dec 2021 07:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20211212170247.30646-1-semen.protsenko@linaro.org> <b618ff5b-ee41-2c29-5074-24fd4d0f0933@canonical.com>
In-Reply-To: <b618ff5b-ee41-2c29-5074-24fd4d0f0933@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 20 Dec 2021 17:15:31 +0200
Message-ID: <CAPLW+4=wcWv4P_M8kQDjB=QfT5N+mFKm0mUdSDjGSgLg=pRGSw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410: Fix getting the optional clock
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 at 19:50, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 12/12/2021 18:02, Sam Protsenko wrote:
> > "watchdog_src" clock is optional and may not be present for some SoCs
> > supported by this driver. Nevertheless, in case the clock is provided
> > but some error happens during its getting, that error should be handled
> > properly. Use devm_clk_get_optional() API for that. Also report possible
> > errors using dev_err_probe() to handle properly -EPROBE_DEFER error (if
> > clock provider is not ready by the time WDT probe function is executed).
> >
> > Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/watchdog/s3c2410_wdt.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>

Hi Guenter,

If there are no outstanding concerns, can you please apply this one?
Would be nice to see it in v5.17 if that's possible.

Thanks!

>
> Best regards,
> Krzysztof
