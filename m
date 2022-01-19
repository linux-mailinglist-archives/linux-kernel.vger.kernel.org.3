Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2AE494168
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbiASUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:03:27 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:35600 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiASUDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:03:19 -0500
Received: by mail-qv1-f52.google.com with SMTP id a8so4403590qvx.2;
        Wed, 19 Jan 2022 12:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6H2VKS3zi/cgFysvmh7unIKg4DB6PbdGxzowpLmDaU=;
        b=CJ99qgEFoDUo2ZIZ14ec9g/86Zdw0vNX7lI02lowM6WJWAtKkTmdbcAULWMww4fQeu
         NRscoXuttUo4nxC31JmISH1sO/Mxaht+nbFdUcenzdjICAUIKV1IgIp3DD4SaCoY4bOu
         7QJUdcAS1xSgJrqsZeswn5k2aSywOLq9av02T6ywq2nCqRsyzJ9S9rILkmT+XyyYoNur
         4AEr3XailYPRUuxhODl4FCt8O2Vc+Rz7XW2yHdimjLntog1b5HpamKlPHUm5LLshVo5M
         f0TSLpmsV857p65lmGD1Z2bWs1OtPw38NrYbtjI0+jKYkqdNHPAyL/5NU1cBntDu05Vs
         nJ+Q==
X-Gm-Message-State: AOAM53318llr9Q7SK59UPGpV+eTmpZSXn1fuB99+b0LQelrt9hN+veNZ
        l0/A7VwVLfjDXzSnxtJyRHD6kODg7jnmIlV0zLo=
X-Google-Smtp-Source: ABdhPJzdALW3SvsJguJtgX59bIlxS60hq/WRQkKiDMElgbYYw99/mWKTR8dPKC61ilAxM7f1iHdfDo5yers+g5u0M90=
X-Received: by 2002:a05:6214:509e:: with SMTP id kk30mr28063261qvb.61.1642622598524;
 Wed, 19 Jan 2022 12:03:18 -0800 (PST)
MIME-Version: 1.0
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
In-Reply-To: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jan 2022 21:03:07 +0100
Message-ID: <CAJZ5v0jVgpjyHfuvzDYu-4yjMsRh4dJpGhKi1wwT5AOA4rsA_A@mail.gmail.com>
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 7:57 PM Manaf Meethalavalappu Pallikunhi
<quic_manafm@quicinc.com> wrote:
>
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via thermal
> core API or via thermal zone sysfs. Once it is disabled, the framework
> bails out any re-evaluation of thermal zone. It leads to a case where
> if it is already in mitigation state, it will stay the same state
> until it is re-enabled.
>
> To avoid above mentioned issue, on thermal zone disable request
> reset thermal zone and clear mitigation for each trip explicitly.
>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>  drivers/thermal/thermal_core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 51374f4..e288c82 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>
>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> -       if (mode == THERMAL_DEVICE_ENABLED)
> +       if (mode == THERMAL_DEVICE_ENABLED) {
>                 thermal_notify_tz_enable(tz->id);
> -       else
> +       } else {
> +               int trip;
> +
> +               /* make sure all previous throttlings are cleared */
> +               thermal_zone_device_init(tz);
> +               for (trip = 0; trip < tz->trips; trip++)
> +                       handle_thermal_trip(tz, trip);
> +

It looks to me like this has a potential of confusing user space by
setting the temperature to invalid before notifying it that the zone
has been disabled.

>                 thermal_notify_tz_disable(tz->id);
> +       }
>
>         return ret;
>  }
>
