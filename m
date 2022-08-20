Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6E59ADBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbiHTL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiHTL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:57:21 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C45248E2;
        Sat, 20 Aug 2022 04:57:20 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-333a4a5d495so182359727b3.10;
        Sat, 20 Aug 2022 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eFv+Oj3QaofeetDmZ1hWU31f01S4gXzOn+W40f2bcH8=;
        b=Jh9VYy5RF6o3w+4t2LygfX4yCtFcAj+toPFoYCAvMWoNJCb340EE6H2jNoUVEER67j
         Oof6U81HeY5G2lxcydW7TLSZp0DuQxsvl872ON+MxqNCD1MVfR2zqD58U7mGHJJxaRhs
         dvLX2jNP7jWbeSgqfCwRXeoiV4ypDgLsQP+dzGmnF6zUt21JjPWT8dwKGLhyY9p6kqrm
         qXCPEgRQJ17hi9oYKJ4jqe1g2DVaULlUy52kwKGAiBam4KFIIL5+5WAFwaikg7F41Ifq
         JCobYAIBRVa9KCWJADGJjh7YpfvATF+irt6dGz27jdP944/yq4r39b1x1N0U5K16845Z
         JAjw==
X-Gm-Message-State: ACgBeo3V7U5nzltHxIOW19X4yw8aArUvdpQwyvHuc081/fxGuWgZ5GzK
        7Ur1LUJkTQBMEkZ0jho3LPtXMbYgmUb8tj7CbHk=
X-Google-Smtp-Source: AA6agR6zWHtnabZ6V306XrP13eJqyDVES8EsSaAH+ECiBaAuEnvGN7G48D/WRufhiU2j2MyLI1HC14c/WpW02memvng=
X-Received: by 2002:a81:104e:0:b0:336:37f1:9686 with SMTP id
 75-20020a81104e000000b0033637f19686mr12206283ywq.149.1660996639914; Sat, 20
 Aug 2022 04:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
 <CGME20220812131216eucas1p266cfd4e51b59fc3cf8056474a6910094@eucas1p2.samsung.com>
 <20220812131202.1331238-1-daniel.lezcano@linaro.org> <ab708272-efe0-343e-2dfc-299187126a2a@samsung.com>
 <c0c5b306-9fd5-1048-ba08-044d292cbf7a@linaro.org>
In-Reply-To: <c0c5b306-9fd5-1048-ba08-044d292cbf7a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 20 Aug 2022 13:57:09 +0200
Message-ID: <CAJZ5v0gL=k-1SxbfSSdoFYaTWk=YvY72d3r0oEyu9dZA5YJLbw@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Fix lockdep_assert() warning
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
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

On Fri, Aug 12, 2022 at 3:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/08/2022 15:34, Marek Szyprowski wrote:
> > On 12.08.2022 15:12, Daniel Lezcano wrote:
> >> The function thermal_zone_device_is_enabled() must be called with the
> >> thermal zone lock held. In the resume path, it is called without.
> >>
> >> As the thermal_zone_device_is_enabled() is also checked in
> >> thermal_zone_device_update(), do the check in resume() function is
> >> pointless, except for saving an extra initialization which does not
> >> hurt if it is done in all the cases.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > This fixes the warning I've reported. Feel free to add:
> >
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Great, thanks for testing

Do you want me to apply this for -rc3?
