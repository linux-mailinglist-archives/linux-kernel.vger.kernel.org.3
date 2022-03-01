Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6DE4C8EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiCAPPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCAPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:14:59 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F523B57E;
        Tue,  1 Mar 2022 07:14:15 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id d62so18725747iog.13;
        Tue, 01 Mar 2022 07:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOOBOVCokHHeUPL/R+u3XXyAdjLnib+28aXKeKhvB+c=;
        b=jWae6WLtJH8uwwBVD/nsBpkEoBFozaklJp8j4kt4fM016PmfF0IErfWIivVmqzuLcl
         Y8zudLauNjDBWVn5gTw7fEEmq9V8H1RY+fNA4pIp/ux8Wss5Dub6RsUzpyySv9/9n9z7
         ZLubGVwSHySPGQX1aXEm/IiL6Xsg0SCcZHunbAZ5k62dikXAuniDjmatChiIRtJlq2hX
         uferdofPQeeD2bKqL2N8S5BHb2qdzHXDQx3R0XO1O2QYJpKnAEb461WXbK30lSSXvkGR
         DTqtV+HJdtI1Na198KO0djwQZSRChr7Bs71p75HlV3t6yq8i517wNW1lJD4SCbKiJK94
         1xVA==
X-Gm-Message-State: AOAM531xJ2xFCgBOWFY7HJxCd5ngUd/l/tNhBKOGtTWJq2bwlUkV32rn
        Q5uGnuqAChibrUS+cXt/FVnd0Jbb+GyrAjJLTCQ=
X-Google-Smtp-Source: ABdhPJyxNVqd85ScQLI9HnmuucOsf7El8O4BB94OOAU6wRQpS9FTlCYTFaWVad42kLXH/UkBnK/YAwu2/5N7WzlQvHc=
X-Received: by 2002:a02:9f86:0:b0:311:b694:ef5c with SMTP id
 a6-20020a029f86000000b00311b694ef5cmr21613194jam.96.1646147655299; Tue, 01
 Mar 2022 07:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr> <20220228110351.20518-2-nicolas.cavallari@green-communications.fr>
In-Reply-To: <20220228110351.20518-2-nicolas.cavallari@green-communications.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 16:14:04 +0100
Message-ID: <CAJZ5v0iW0KvBsJZbjBoMU6RukH0AmppxpFO9RrfD+K3OcaxOUQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: genetlink: Fix TZ_GET_TRIP NULL pointer dereference
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
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

On Mon, Feb 28, 2022 at 12:04 PM Nicolas Cavallari
<nicolas.cavallari@green-communications.fr> wrote:
>
> Do not call get_trip_hyst() if the thermal zone does not define one.
>
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> ---
>  drivers/thermal/thermal_netlink.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index a16dd4d5d710..73e68cce292e 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -419,11 +419,12 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
>         for (i = 0; i < tz->trips; i++) {
>
>                 enum thermal_trip_type type;
> -               int temp, hyst;
> +               int temp, hyst = 0;
>
>                 tz->ops->get_trip_type(tz, i, &type);
>                 tz->ops->get_trip_temp(tz, i, &temp);
> -               tz->ops->get_trip_hyst(tz, i, &hyst);
> +               if (tz->ops->get_trip_hyst)
> +                       tz->ops->get_trip_hyst(tz, i, &hyst);
>
>                 if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
>                     nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
> --

Applied, but I think this needs to go into 5.17-rc, doesn't it?

Daniel?
