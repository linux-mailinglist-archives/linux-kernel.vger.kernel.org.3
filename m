Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8157154C72F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244829AbiFOLKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiFOLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:10:36 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5688540A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:10:35 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 68so8409873qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9ehyMccErLvnswsUCaTIrl34oqySPKiX0jSZU6Bb2M=;
        b=XhFBEfnUAAAiNoeaPp8jwbXdQl0UO7gQ42vHajwiCKngRuo0+EtuAWphzpblMChMsD
         RkVTK5S2gXSlD7AUPLShgjdcsQpzhv4aGO6gh1nd+2JkywFSNLBEPv16HhRjL8H3Ncxm
         hLIbTd1JEz1g7iebq0wd6y8bcz6Wfj7MI32+7T1UB6Li37w9mX0LC6KfSb3/nsCq/Vv8
         dVTiD15brD1+tiKNQl4ioh/q2esWTbJKztXqhYfD1EIokoBM6/kRzycSaWQeCyCFFT37
         AyjRcvyQYCsh8qWMkluLCajMWb4IyOR/Us9TFaGLP02GGWmj8HYcpqudasPGy/jF88OS
         cKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9ehyMccErLvnswsUCaTIrl34oqySPKiX0jSZU6Bb2M=;
        b=FWQlA1UWIu/y5zi7MldcVv6tfx0QAHrxjlM+x3PcJj8QTYaJNaNKOIMPe8J4qP1X9y
         E9qIMlQsaFn+HeuRuUZbLCZngfoa1XRzLq60alfw30ibA40EP25U2uNWT8JccTdVeX2a
         j7eV+N4bOUfWXcX/LFnv5vKW8qKvWRKRa9GPV9dD7IlYepjQWGrX/IvW1KYiqkxDTvWm
         0L5QP28NDyxA6Lv04p/MjGMQbOV4LiW0z+s99yj9J1xW3V7ENwDM/HXhptI+4xqaHsZm
         sA2MrmAwuNgxuQqr6z5mwNnSOlvCL7wZc2ekESxhPFDiQQLQUgfLnguyLzd/NBJ4wky5
         ZnZw==
X-Gm-Message-State: AOAM533+y9jEMwlcAlopCuBjPUBgxHM8tcwpdoWifRhewe//3Wj7+fyx
        iIapiuCJ8VRR7r9C0CqvsLyVJiQUlzkerwUtY6gmyw==
X-Google-Smtp-Source: ABdhPJwAFCuKWsMd/fvYsI+fi7dfEHmvREDN3bjZ7ZeI6PNzbJOFtpJB3OdCaG6L5u7bW4MhfRba3zINUWabfKcuTsQ=
X-Received: by 2002:a05:620a:2a0e:b0:6a7:8346:1601 with SMTP id
 o14-20020a05620a2a0e00b006a783461601mr7451127qkp.593.1655291434425; Wed, 15
 Jun 2022 04:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220614215418.910948-1-dianders@chromium.org> <20220614145327.v4.3.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
In-Reply-To: <20220614145327.v4.3.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Jun 2022 14:10:22 +0300
Message-ID: <CAA8EJpqrEb-48ma61D5enaTR5V27q3Uyts4keAnMgCdvAjc7vQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/panel: atna33xc20: Take advantage of
 wait_hpd_asserted() in struct drm_dp_aux
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
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

On Wed, 15 Jun 2022 at 00:54, Douglas Anderson <dianders@chromium.org> wrote:
>
> Let's add support for being able to read the HPD pin even if it's
> hooked directly to the controller. This will let us take away the
> waiting in the AUX transfer functions of the eDP controller drivers.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
> Changes in v4:
> - Reorganized logic as per Dmitry's suggestion.
>
> Changes in v3:
> - Don't check "hpd_asserted" boolean when unset.
> - Handle errors from gpiod_get_value_cansleep() properly.
>
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
>
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 51 ++++++++++++++-----
>  1 file changed, 38 insertions(+), 13 deletions(-)
>

-- 
With best wishes
Dmitry
