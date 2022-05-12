Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA35250F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351827AbiELPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355745AbiELPMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:12:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A250043
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:12:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so10825581ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjD85xNC7TaiLaFuFjU/KtoVZTm3HwGMYHqFcknbBsA=;
        b=qdr+XsGFHWjQwJZpbJ4udmcbD7KkTuYQpAzeKy9omY6zZQ7+9R9z8lwdquDoniMJpO
         3KkgL6Gdc8N/n7BfucdAaGK/9TJ7Umq7W3A6JXkc2VRU2fd0Bnx6C/4HpKi1D5ut7CMp
         /6IKI92jKfEGACjt3N5PdEfbIl0FQZ6BrNZ4AI3ebw599DPJ44Oxgj2aebqQo0FDwb74
         4LeweSegiA0iyTaBn5JU3IDj96IHErKsWdVvjSqfX8vWoAq/H6o8wZzmBT1P9yoh/8Fa
         87HCDsbZGPIqfPXjDg959UsDiOp4UpyHBD8VfM13/4TpBGgEgucPh1YGaLtFfLGWIGdJ
         Mzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjD85xNC7TaiLaFuFjU/KtoVZTm3HwGMYHqFcknbBsA=;
        b=oj80D33lvmheiDFW3a2djFlw6EJ3VVUC5LkUujLDovZ8MVGpr/ihG2+al3y+rNn2Mr
         1n8fqkoq5Bt06uRIyMm/Ya68xicHHiirlTV2najXDVrDo2JDj/fxy/8xKg1k3k25g5kd
         rBXqOfP6Pm8wLPnmXU8Ndglqd0BHyDmNaI/sNZRTrPHGGjoshIDpG1kJr5CutEqSD5AV
         thpp/PiGZctJmESCJ7Gezfxpt/rJSiyijdNxTG17zsIrnf2XzhHpKT7Tp5p1yFkapWST
         L4VvcrpQci8hLZQf7NJ845KCWEFW/jJiN2EZDUQdk8abFq5T6BVZiDxGZfhNMc9cswR3
         s+ug==
X-Gm-Message-State: AOAM53070Gb3+ZCGzDKxCTyNfQBwDcdExrkSDzWuR4TAUzD+v4AtMaP9
        +YV25k64ZH6MdAXoyJ5OxOAXVoZGXmv2yTuPLpd6lQ==
X-Google-Smtp-Source: ABdhPJyciJT1YGz02AIq1sYlG377PZjPDDut/szgn1Gtg8u03VxsR/ud7YebfmdVqB4rFxr+X5hmNiaauAh59Pfqzdw=
X-Received: by 2002:a17:906:58d4:b0:6f4:cebd:c4b with SMTP id
 e20-20020a17090658d400b006f4cebd0c4bmr352889ejs.492.1652368335432; Thu, 12
 May 2022 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220512083627.885338-1-tzungbi@kernel.org> <20220512083627.885338-5-tzungbi@kernel.org>
In-Reply-To: <20220512083627.885338-5-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 08:12:04 -0700
Message-ID: <CABXOdTdrYPVSFGq6zmepM4jGEy0OmFog36S4faQbeL6G=OgGvw@mail.gmail.com>
Subject: Re: [PATCH 4/6] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_get_host_event()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 1:36 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> It is overkill to crash the kernel if the `ec_dev` doesn't support MKBP
> event but gets called into cros_ec_get_host_event().
>
> Drop the BUG_ON() and return error (0 in the case) instead.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <goeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 9ce3374846ff..ff767dccdf0f 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -817,7 +817,8 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  {
>         u32 host_event;
>
> -       BUG_ON(!ec_dev->mkbp_event_supported);
> +       if (!ec_dev->mkbp_event_supported)
> +               return 0;
>
>         if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
>                 return 0;
> --
> 2.36.0.512.ge40c2bad7a-goog
>
