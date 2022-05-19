Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F7652DCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbiESShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiESShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:37:34 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E825FF137A;
        Thu, 19 May 2022 11:37:32 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ff155c239bso66078717b3.2;
        Thu, 19 May 2022 11:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS1kEN+GXXpbhqkK6UqZTr2vL0SVZ2tag5VCxMz5nz0=;
        b=jmrIfPusZI5fyymMsLl4c3Iq9DmivzrHUNu/I44fgo+jvKx/OWw3eeWc0T1+qJsud1
         ShqudmELo0J8Efaj06AEY2YokyN8vyIu1lLFknZH6czkZ9h2lDe5iqVC3x1qGkLZEjWl
         8LaLrAJPYybJDRuxMDUPB4Wi+UMXh69osi4KnRTVvm+2u5qNxWpi6rr0/L54URYq1ulE
         3I0HptHzxn5KPXnl9QNM11SEPZUu/ttooBkDP5YbeQZU7Ff06xbvlZvRHJSJwVE6jPvu
         eiQ1vorRNWbUK7BDgVSEl4TeFQVWORBh0OEwJU2I55cBia+kzK1Zo5UStCMGqPIPwbOV
         XGQQ==
X-Gm-Message-State: AOAM531JVbuxTJOpuV0lOPcC/tOXQRl1PoGfFlk4AkhcgCWUMj40ka9k
        Y0HKv1xqEe71id7IrgTOy6LyvoOfAjOs3o1cvAs=
X-Google-Smtp-Source: ABdhPJxWx4suARB6p5108TodMZoK6QfRDz1CDtEyftKwKTyQe+rLtQu08lC+lkjXIM1zM+NGYEffev9rMGnJpUozft8=
X-Received: by 2002:a81:91d4:0:b0:2fe:e300:3581 with SMTP id
 i203-20020a8191d4000000b002fee3003581mr6273739ywg.7.1652985452189; Thu, 19
 May 2022 11:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 20:37:21 +0200
Message-ID: <CAJZ5v0gaaCYzCYdWhXjn7-S7MyAcDuM4epNp2eOr2_7h-cu4tw@mail.gmail.com>
Subject: Re: [PATCH 00/14] PM: domains: Various improvements for genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Wed, May 11, 2022 at 4:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The main goal with this series is to improve the way genpd deals with its
> governor(s). Especially it turns allocation of governor related data to be
> dynamically allocated. It also improves the execution path for runtime-
> suspend/resume of devices (attached to a genpd of course) and the similar is
> also done for genpd's power-on/off path.
>
> Note that, patch 1->3 have already been sent before in a separate series [1],
> but for simplicity I have included them here again.
>
> Tests/reviews are as usual highly appreciated!
>
> Kind regards
> Ulf Hansson
>
> [1]
> https://www.spinics.net/lists/kernel/msg4335838.html
>
> Ulf Hansson (14):
>   PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
>   PM: domains: Drop redundant code for genpd always-on governor
>   PM: domains: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
>   PM: domains: Rename irq_safe_dev_in_no_sleep_domain() in genpd
>   PM: domains: Skip another warning in irq_safe_dev_in_sleep_domain()
>   PM: domains: Allocate gpd_timing_data dynamically based on governor
>   PM: domains: Move the next_wakeup variable into the struct
>     gpd_timing_data
>   PM: domains: Measure suspend/resume latencies in genpd based on
>     governor
>   PM: domains: Fixup QoS latency measurements for IRQ safe devices in
>     genpd
>   PM: domains: Fix initialization of genpd's next_wakeup
>   PM: domains: Clean up some code in pm_genpd_init() and genpd_remove()
>   PM: domains: Allocate governor data dynamically based on a genpd
>     governor
>   PM: domains: Measure power-on/off latencies in genpd based on a
>     governor
>   PM: domains: Trust domain-idle-states from DT to be correct by genpd
>
>  drivers/base/power/domain.c          | 201 +++++++++++++++++----------
>  drivers/base/power/domain_governor.c |  65 +++++----
>  include/linux/pm_domain.h            |  18 ++-
>  3 files changed, 173 insertions(+), 111 deletions(-)
>
> --

All of the changes made by this series make sense to me, so I've
queued it for 5.19.

Thanks!
