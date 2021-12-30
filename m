Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2A481DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhL3QJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:09:59 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:38571 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbhL3QJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:09:59 -0500
Received: by mail-qv1-f46.google.com with SMTP id o10so22476531qvc.5;
        Thu, 30 Dec 2021 08:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezClZAHT1R+O8T1YXwhFSh7VZXrZAFgQTaj9xuZLzog=;
        b=oqQLStt5X0evvIZJRzAPpSgruG3BhDY2s1T/JU6CgGlSq7IbfR/5lpGT9XhuCl0yKK
         RPTFAG/7xUal9BF8OyjzPp4E3P2ElKixocuUhB0Ec0a2QuFdV9vPD70j5xlxo+shTB+T
         GTOo9TTQxq2jDpJvAKb2YHHnBDO9hZh507dTZCMFObJxgiEDSaBpWb47OowMNZDDTtjZ
         v54s2rGIf9sYhhM4V/alNdRBO5/Uxp7k1H0xhe0bBJygdYZg3IVvl8JOS6mhNEdGsj9d
         2cvHqu3jJ0EzeL4AabIoo914yadDR/ehBavEgUXYXT3dQ5QCwDCqCMznqKTxuxlmzyFz
         zqmQ==
X-Gm-Message-State: AOAM5338OB/SMNLpqxoasU67b3xe3mJjB4ihQEW5EcJoFH5cHnD4ijpr
        6ILOZgnzYvne+iq3g/devDVm7nj6iiw14EdUHgo=
X-Google-Smtp-Source: ABdhPJyN6mgj3ogQflSFsdGVVT7vwczPwYi2O0a40J14P8I3C0lWzPd9RpcwRZHoFFXgvBijaWrWvKG/9zU0e4uodnU=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr27959264qvd.52.1640880598311;
 Thu, 30 Dec 2021 08:09:58 -0800 (PST)
MIME-Version: 1.0
References: <1640761407-2028-1-git-send-email-quic_manafm@quicinc.com>
In-Reply-To: <1640761407-2028-1-git-send-email-quic_manafm@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:09:47 +0100
Message-ID: <CAJZ5v0hApA+fnuRmT_xDdJiqmkGfrfku=8rNG7G_YohGYZm5nw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/core: Clear all mitigation when thermal zone
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

On Wed, Dec 29, 2021 at 8:03 AM Manaf Meethalavalappu Pallikunhi
<quic_manafm@quicinc.com> wrote:
>
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via thermal
> core API or via thermal zone sysfs. Once it is disabled, the framework
> bails out any re-evaluation of thermal zone. It leads to a case where
> if it is already in mitigation state, it will stay the same state
> until it is re-enabled.

You seem to be arguing that disabling a thermal zone should prevent it
from throttling anything, which is reasonable, but I'm not sure if the
change below is sufficient for that.

> To avoid above mentioned issue, on thermal zone disable request
> reset thermal zone and clear mitigation for each trip explicitly.
>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>  drivers/thermal/thermal_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 51374f4..5f4e35b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -427,6 +427,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>                                         enum thermal_device_mode mode)
>  {
>         int ret = 0;
> +       int trip;

This can be declared in the block in which it is used.

>
>         mutex_lock(&tz->lock);
>
> @@ -449,8 +450,14 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>
>         if (mode == THERMAL_DEVICE_ENABLED)

The coding style asks for braces here if they are used after the else.

>                 thermal_notify_tz_enable(tz->id);
> -       else
> +       else {
> +               /* make sure all previous throttlings are cleared */
> +               thermal_zone_device_init(tz);
> +               for (trip = 0; trip < tz->trips; trip++)
> +                       handle_thermal_trip(tz, trip);

So I'm not sure if this makes the throttling go away in all cases (eg.
what if the current temperature is still above the given trip at this
point?).

> +
>                 thermal_notify_tz_disable(tz->id);
> +       }
>
>         return ret;
>  }
>
