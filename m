Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E74E73F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359250AbiCYNIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352493AbiCYNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:08:45 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7433A8ED5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:07:10 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-de3f2a19c8so8079724fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+UppTrxLQdaijQbmLi2ygRNUTwZayeuPKsfWsxc+Zo=;
        b=Mr3uMt15CEDF8Ba+6ECcUfzdpV5TOWE1Ts2aqBpikq7hdwnh2BhSkVNiY23MigyCo1
         5/0a00IeRbTP8IQd+UUBezGhidat0d2Q4XYVkN8AAv33xgeuAfUg9n1oA7xGp6R97U3+
         zbP7SRZnJPvIMAJ4+ZquoxHnZUTTk7qKxT+CsiVdM6zJRQZV8UW8naewzz38OZQPwjyL
         MWmBS63NuPUhU3p3Odf2FDnlOH7KIcDwDKaY4QNqNBiR9iqnlPVXpt1PjDY9wA6d8WzH
         fRTVhUWrbP+YT1D23WkVN0i6YMYvrCXsYTidkzrRXTYa9DPQYb+rCWLX6z2uz3j67LSm
         SQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+UppTrxLQdaijQbmLi2ygRNUTwZayeuPKsfWsxc+Zo=;
        b=q/OirpOB3ptVdx3m9vWvY4zfgV3Amf5ndAxFQ/Soz3dQIkurl9tfw+v3M7TkyN2THn
         H4yNfoaHHfxmmT4NdeDo/h7FDD8E7RBno+t2Psf8sZ7jeeefoG557R4Z2B4Si4UKo0Ar
         nCNiKsqLDczeNRso7SYdWTq3wPgHnEeFOXNR7D9dWqcPsyqEaGT544lAhBjds8zf5EJh
         dRyfsnWjDHZCziVjZDES5q5JD/q6Nk17sCvHfw34e4DCujDClg1P8AujQxzwJMUnjSq2
         wuPoNOpF8qSdAOIldh0UPGQrcfZDRHPUFAEPUVYL1SFmkLkzFQuh/Pdny3+oCRvpE3VG
         u+aw==
X-Gm-Message-State: AOAM530WIbUk7DpO4pb5lrI/xppEv2ygJ7n20GfjXXmaiWXn8JOKu7pr
        IbNG+Js0M4fzUVqYesh+BcjAuGtj1U6m17Eh18A=
X-Google-Smtp-Source: ABdhPJw2AO30JktpNowqISKLeErnm4X9BTwHN3YLfZlOFIVRTOk+leM/wRQcMWKtG1atVvaDsQmfkduj2H6qOl5JGso=
X-Received: by 2002:a05:6870:630c:b0:da:b3f:324d with SMTP id
 s12-20020a056870630c00b000da0b3f324dmr4883902oao.253.1648213628946; Fri, 25
 Mar 2022 06:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220325040515.4073706-1-tsung-hua.lin@amd.com>
In-Reply-To: <20220325040515.4073706-1-tsung-hua.lin@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Mar 2022 09:06:57 -0400
Message-ID: <CADnq5_MGrkDxGBfpg9XfJ-e=fSr9dx22VJTKz6BLQemTq7Ck8Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/25] drm/amdgpu: Disable ABM when AC mode
To:     Ryan Lin <tsung-hua.lin@amd.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        Mark Yacoub <markyacoub@google.com>,
        Victor Lu <victorchengchi.lu@amd.com>,
        ching-shih.li@amd.corp-partner.google.com,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        ddavenport@chromium.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, leon.li@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:27 AM Ryan Lin <tsung-hua.lin@amd.com> wrote:
>
> Disable ABM feature when the system is running on AC mode to get
> the more perfect contrast of the display.
>
> Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>  drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 58 ++++++++++++-------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
>  4 files changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index c560c1ab62ecb..bc8bb9aad2e36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -822,6 +822,10 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
>         struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, acpi_nb);
>         struct acpi_bus_event *entry = (struct acpi_bus_event *)data;
>
> +       if (strcmp(entry->device_class, "battery") == 0) {
> +               adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> +       }
> +

We already set adev->pm.ac_power in amdgpu_pm_acpi_event_handler()
which gets called a few lines below.

Alex


>         if (strcmp(entry->device_class, ACPI_AC_CLASS) == 0) {
>                 if (power_supply_is_system_supplied() > 0)
>                         DRM_DEBUG_DRIVER("pm: AC\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index abfcc1304ba0c..3a0afe7602727 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3454,6 +3454,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         adev->gfx.gfx_off_req_count = 1;
>         adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> +       adev->pm.old_ac_power = true;
>
>         atomic_set(&adev->throttling_logging_enabled, 1);
>         /*
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
> index 54a1408c8015c..478a734b66926 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
> @@ -23,6 +23,8 @@
>   *
>   */
>
> +#include <linux/power_supply.h>
> +#include "amdgpu.h"
>  #include "dmub_abm.h"
>  #include "dce_abm.h"
>  #include "dc.h"
> @@ -51,6 +53,7 @@
>  #define DISABLE_ABM_IMMEDIATELY 255
>
>
> +extern uint amdgpu_dm_abm_level;
>
>  static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
>  {
> @@ -117,28 +120,6 @@ static void dmub_abm_init(struct abm *abm, uint32_t backlight)
>         dmub_abm_enable_fractional_pwm(abm->ctx);
>  }
>
> -static unsigned int dmub_abm_get_current_backlight(struct abm *abm)
> -{
> -       struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
> -       unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
> -
> -       /* return backlight in hardware format which is unsigned 17 bits, with
> -        * 1 bit integer and 16 bit fractional
> -        */
> -       return backlight;
> -}
> -
> -static unsigned int dmub_abm_get_target_backlight(struct abm *abm)
> -{
> -       struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
> -       unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
> -
> -       /* return backlight in hardware format which is unsigned 17 bits, with
> -        * 1 bit integer and 16 bit fractional
> -        */
> -       return backlight;
> -}
> -
>  static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
>  {
>         union dmub_rb_cmd cmd;
> @@ -148,6 +129,9 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
>         int edp_num;
>         uint8_t panel_mask = 0;
>
> +       if (power_supply_is_system_supplied() > 0)
> +               level = 0;
> +
>         get_edp_links(dc->dc, edp_links, &edp_num);
>
>         for (i = 0; i < edp_num; i++) {
> @@ -170,6 +154,36 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
>         return true;
>  }
>
> +static unsigned int dmub_abm_get_current_backlight(struct abm *abm)
> +{
> +       struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
> +       unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
> +       struct dc_context *dc = abm->ctx;
> +       struct amdgpu_device *adev = dc->driver_context;
> +
> +       if (adev->pm.ac_power != adev->pm.old_ac_power) {
> +               dmub_abm_set_level(abm, amdgpu_dm_abm_level);
> +               adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> +               adev->pm.old_ac_power = adev->pm.ac_power;
> +       }
> +
> +       /* return backlight in hardware format which is unsigned 17 bits, with
> +        * 1 bit integer and 16 bit fractional
> +        */
> +       return backlight;
> +}
> +
> +static unsigned int dmub_abm_get_target_backlight(struct abm *abm)
> +{
> +       struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
> +       unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
> +
> +       /* return backlight in hardware format which is unsigned 17 bits, with
> +        * 1 bit integer and 16 bit fractional
> +        */
> +       return backlight;
> +}
> +
>  static bool dmub_abm_init_config(struct abm *abm,
>         const char *src,
>         unsigned int bytes,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index f6e0e7d8a0077..de459411a0e83 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -445,6 +445,7 @@ struct amdgpu_pm {
>         uint32_t                smu_prv_buffer_size;
>         struct amdgpu_bo        *smu_prv_buffer;
>         bool ac_power;
> +       bool old_ac_power;
>         /* powerplay feature */
>         uint32_t pp_feature;
>
> --
> 2.25.1
>
