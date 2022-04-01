Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC44EEA5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbiDAJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiDAJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:27:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DFEEAC87
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:25:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y6so2010810plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpps/7SgFquxKCOj7M8NgIo6De4u6whEjneyMo4UPFs=;
        b=Q6PGD1JOHNbZ64V72kkcK/KPtpC2zWKuQycsjZo5rWtV1MiuQ97AuWj1IPyn197/OR
         Buxc58Q0yQO+JBpQeztseOPQOQr+2TgzFKGW3VzNAR7c6eKjJJXlgIYzCof8QFeoQdFE
         qbrNgotWTxY/DbY89IYxpbpR/k1NzhsVRpCnpulnaYCTPwNLRwJYGQYzBU6RSJMyGw/p
         T03kfCYjjr4kzdBsuVJKdBlRyDZAFcSSx9jw/RNGtuNyCQTZKi8nNImONmbNLxIav80a
         UBzxUJwKxAuRjTrS8p7UlMz3uiyGcdlzZtWBPqTzCWAzO39OBzV7rdUBJVPGBmONkcz2
         6/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpps/7SgFquxKCOj7M8NgIo6De4u6whEjneyMo4UPFs=;
        b=lN5e+YAKRWewW8vIluaoDYDqWC7gII/u9ZCLfRyQvgofMm4d6ZU2UL/MY23KH5zzzS
         Q8ndmVYF/op6My2VTV5XNiRiIwldPdl2wPWI0hoGUDcTrzqnHHY+uIUdM2F0X/OzedDR
         jkiR0PRPQ0f1ZYYA5Tm3iH042kWo6dfnlc3k1phGI9uSlXjPQKAcsavUO3QwJJXFnrZN
         AaBNvcnSQqqTCOPTnW14MpPFZj7YJnE9kLqq6vJoe4UHvWnwdqZ2gejVoIIKFY6NKZjz
         VW3zLZKbn90DsHwnkapZhQ6KvzrDnyKpQXn1zquPyI74pFgxq/WUXPxWAr4RPrix5o0l
         Mbdw==
X-Gm-Message-State: AOAM530mAGDVjUfQwTX5ocyhYuwtlIgm/q3cEa3Rk7NbZubxEu+cd0u/
        H2KANLZKUCbX5DVdBM6UybUfAdcb6GvahL2YjXPVk4pXmYc=
X-Google-Smtp-Source: ABdhPJxezlGSi8KeogGlaccw9MFltaFsZMFMDGs0jf8o6lgPej2KNJmC1QA3IjMgku2i6lCVeXsdV26QsfufovSNWMU=
X-Received: by 2002:a17:902:7e0d:b0:156:47a4:a7c4 with SMTP id
 b13-20020a1709027e0d00b0015647a4a7c4mr9473951plm.141.1648805123539; Fri, 01
 Apr 2022 02:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com> <20220330120246.25580-2-xiam0nd.tong@gmail.com>
In-Reply-To: <20220330120246.25580-2-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 1 Apr 2022 11:25:12 +0200
Message-ID: <CAMeQTsaL45HwKjVoh2k0m1gq7j5ui43LBLXsq0_-RJnFko40mA@mail.gmail.com>
Subject: Re: [PATCH 1/5] gma500: fix a missing break in oaktrail_crtc_mode_set
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Clark, Rob" <rob@ti.com>, Zhao Yakui <yakui.zhao@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 2:03 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete. It
> will certainly lead to a invalid reference to list itereator variable
> 'connector' after the loop pointing an bogus address at an offset
> from the list head, and could lead to multiple 'is_*' flags being set
> with true mistakely too.
>
> The invalid reference to list itereator is here:
>         drm_object_property_get_value(&connector->base,
>
> To fix this, when found the entry, add a break after the switch
> statement.

Hi, this is already fixed in:
commit b1a7d0ddb169774c3db5afe9e64124daea7fdd9f
Author: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue Mar 22 14:17:38 2022 +0100

    drm/gma500: Make use of the drm connector iterator

>
> Fixes: a69ac9ea85d87 ("drm/gma500: drm_connector_property -> drm_object_property")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> index 36c7c2686c90..eb2d79872bd5 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -409,6 +409,8 @@ static int oaktrail_crtc_mode_set(struct drm_crtc *crtc,
>                         is_mipi = true;
>                         break;
>                 }
> +
> +               break;
>         }
>
>         /* Disable the VGA plane that we never use */
> --
> 2.17.1
>
