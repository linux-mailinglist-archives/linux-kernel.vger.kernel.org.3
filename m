Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317DB567749
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGETGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiGETFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:05:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E921832;
        Tue,  5 Jul 2022 12:05:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 64so14230720ybt.12;
        Tue, 05 Jul 2022 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wk3DM317Ts86B0YftrStlYUZ4gz4TN2yIrO1HE5SXl4=;
        b=AJW8PNgt3MYe/AxNWntixYEyUSSq5JjLx/5UzSNlKMvoDQ08DKKJSIJMcV7hoU+zbW
         NYqzNsJK1J/CVBQZ7lhFDmv2CmJLT9IKOCdUSfQ8ccK1TdwiuKmq0muvLKoOvnjVVsXt
         4QnyHGecqlgD8g0RLbvnFQv9AiivRVRLanBKV2wgf5Fd0Kda4pX4OxN043PvSQ7FH3AU
         v5NIyDN8HP3D8wjR4LF72vIlw6rZ1s7ZXk64bahLHRC6IWQwguOY4E/xO0EpF1Qov6SO
         78likgj10byap+eWOWBDWQpjvl2oZJm2EqdXzRMb7VwpUnNh/eljY9IDsEbxj8gmByjJ
         DdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wk3DM317Ts86B0YftrStlYUZ4gz4TN2yIrO1HE5SXl4=;
        b=1ic05VKtBje9Rk6QI9B5iAdgqLtsrwo8Xnrh6i5vFCZ3oHds2CxrvrkGCcOZvvFA11
         pUQfjRhQRMtzDwEEWFyRm80nbRDafUW7MO2rGenyNefk4/4Lj9lN44sIVsmEYrfR6QI3
         hV7Pnr7LbRLj3nBwdX87isv22lrBuFcSNe0W6O3ivWC219mIXMo8WVktxCCP86RhEKAv
         GgN3ndgfc3sUDsj//V/f05V9CL5Tez/95CWWB9wQ76CiqPM4yJrCxtuGQFLjWW/FWjrz
         hOXqo7oq4elClyvYk7xG+3jm1njH3NAhte7bAkK8GF5l+hH0WeemqgRyl47Ek+cUa5zZ
         pBxA==
X-Gm-Message-State: AJIora8aCznVLbFYTDk4gZrhs3APThdglLkwzs8DQow4pIqYzNfkTSDT
        Nh/pBleLiOdclzgnkIwCfTURmvx6cAZV+t/85pu8BnYv2RDWiA==
X-Google-Smtp-Source: AGRyM1s2Sd4IFAjGDPznLJLfpZnMRgUbI3cKO3MrAuHWwKFMdU/ubcvbnJzWQUHHrKNFbCGEuuydrijbIkdEQkXxKm4=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr39416609ybs.93.1657047935999; Tue, 05
 Jul 2022 12:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220630150135.1799535-1-sbinding@opensource.cirrus.com> <20220630150135.1799535-2-sbinding@opensource.cirrus.com>
In-Reply-To: <20220630150135.1799535-2-sbinding@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 21:04:59 +0200
Message-ID: <CAHp75VfXwDAwwmzbcx4g1uEuzhzMJ31K1bsTrwYFZGbz3tLMBw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ACPI: utils: Add api to read _SUB from ACPI
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
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

On Thu, Jun 30, 2022 at 5:17 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Add a wrapper function to read the _SUB string from ACPI.

...

> +       if (obj->type == ACPI_TYPE_STRING) {
> +               if (strlen(obj->string.pointer) < ACPI_MAX_SUB_BUF_SIZE &&
> +                   strlen(obj->string.pointer) > 0) {
> +                       sub = kstrdup(obj->string.pointer, GFP_KERNEL);
> +                       if (!sub)
> +                               sub = ERR_PTR(-ENOMEM);
> +               } else {
> +                       acpi_handle_err(handle, "ACPI _SUB Length %zu is Invalid\n",
> +                                       strlen(obj->string.pointer));

Three times to evaluate strlen()... Can we do better, please?

> +                       sub = ERR_PTR(-EINVAL);
> +               }
> +       } else {
> +               acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
> +               sub = ERR_PTR(-EINVAL);
> +       }

-- 
With Best Regards,
Andy Shevchenko
