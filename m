Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD2152A74E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbiEQPqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350954AbiEQPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:46:18 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB1BDCD;
        Tue, 17 May 2022 08:45:59 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2fedd26615cso79230487b3.7;
        Tue, 17 May 2022 08:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYWNzMuuewxR1SV/ukbRTxfo/sdpKRPPvAFXL4eruR8=;
        b=6XqMOD8uig4GB0Zemf0k0haKksXwhLBiIE8SA18r80Z3ssHwQqnybXwg1GszlAQwR1
         L6rAua2PC3iq2lBO2ZWMQVEQYwh4fMc244dVv4QF+Zqe1NHR8Bew42T+AvlA5W2lxE5G
         +bx2dyrtPCWBXbYcvpEMYrsDQswgMWPKUSp7wkgS+q0yx4j7Ykpie9f8486pVIlg2+Ff
         tEDRx4LYqTasZtWpWg9wOBUUtTVZQ49ih13QA3AbgAY21Pxd1p8O14O4nZ9gaN+lq8zN
         qryzsKC2HJlib5tcBDhrgSVwAh0ZD7weMxjgGKHaEUW6gVEClbyzsOlv2bnfOe5u2VTt
         YoVQ==
X-Gm-Message-State: AOAM532x5t3PcW5P5IxchrKKSgIO9aMHO4nfRmHVBFNYCWmJOKpljgfe
        XFSvLvOGtm594a7EhgPmO1i3FrlVijrtSCPvZaV8hk6u
X-Google-Smtp-Source: ABdhPJyZF4TFOOHUnKIQbbE6OWyLZ7lurMBsWJS+zPoAHDBvBWAUU9dMN0H3v61AiA1KxsbQ2EKFYjLAckJbsa6oFc8=
X-Received: by 2002:a0d:c5c7:0:b0:2fe:e955:2c45 with SMTP id
 h190-20020a0dc5c7000000b002fee9552c45mr14037451ywd.19.1652802359160; Tue, 17
 May 2022 08:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org> <20220507125443.2766939-4-daniel.lezcano@linexp.org>
In-Reply-To: <20220507125443.2766939-4-daniel.lezcano@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 17:45:48 +0200
Message-ID: <CAJZ5v0iYf0DQ+4DuN7ad4QSTmzE66MR9cgiSUn1Nh5Vu+EDBWA@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] thermal/core: Remove duplicate information when
 an error occurs
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
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

On Sat, May 7, 2022 at 2:55 PM Daniel Lezcano <daniel.lezcano@linexp.org> wrote:
>
> The pr_err already tells it is an error, it is pointless to add the
> 'Error:' string in the messages. Remove them.
>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 1a405854748a..dc5a03d51f5c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1197,23 +1197,23 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         struct thermal_governor *governor;
>
>         if (!type || strlen(type) == 0) {
> -               pr_err("Error: No thermal zone type defined\n");
> +               pr_err("No thermal zone type defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> -               pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> +               pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
>                        type, THERMAL_NAME_LENGTH);
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> -               pr_err("Error: Incorrect number of thermal trips\n");
> +               pr_err("Incorrect number of thermal trips\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (!ops) {
> -               pr_err("Error: Thermal zone device ops not defined\n");
> +               pr_err("Thermal zone device ops not defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> --

Do these need to be pr_err() messages at all?  They all seem to be
debug-type messages regarding thermal zone drivers.
