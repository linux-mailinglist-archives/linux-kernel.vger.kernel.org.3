Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412452C2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiERSyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiERSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:54:46 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651421F7E17;
        Wed, 18 May 2022 11:54:45 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ff1ed64f82so34864487b3.1;
        Wed, 18 May 2022 11:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDoI+Hz+DjmDMhGHIjtUwfCy9jNRufdBM5+r6T9y4EI=;
        b=Xi3OGE8xQmraAZsrkVKo7JtM5BCSD/hX0+5Hk7ErLz3+dJJHCvZfOJ+RzjIfDYDOv4
         58F0VrFvB7a67GNnNRaXz+3Ii/7IxDE3152cP1rzNVrwvt2bakR7AOSnRpduy33hIwry
         pRYo28IODMT+nbAo0AyB6ymRLCc9HKi5vTtk9Y/1qq2/EV4Dq1RYOBTdgeRZeY8gFRma
         TRAlwsp0FI5oGFOI066+8vvt3Iv9dOrM/CKOTtuVXj1E8ubZ5oJF/LmCM/2zkzF4QwvL
         dhIZNVQQJSfjbR4NLKeVBdCFxWCkkMRRsCMv1yi8Ymc7boj/quv4aVzP/Me2zfhPhEdq
         xFyA==
X-Gm-Message-State: AOAM532vUwUDBQCk0Eg0CU3tYHQNgBIfxNzmIKM9f2jEKTGY0AoO7UTt
        25oSoYPgy1w9DdCF4awvGSj4xu9hNQdGRNksDo0=
X-Google-Smtp-Source: ABdhPJxFrXLByqwcmqSEocnmy58ip2YxbYSqZGQH8Go8TzNcqICxzDBuL9fHa5mz7tClY1T8iZDvUocJo3ymmm0qF+Y=
X-Received: by 2002:a0d:c5c7:0:b0:2fe:e955:2c45 with SMTP id
 h190-20020a0dc5c7000000b002fee9552c45mr863340ywd.19.1652900084507; Wed, 18
 May 2022 11:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <1652751061-23045-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1652751061-23045-1-git-send-email-baihaowen@meizu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 20:54:33 +0200
Message-ID: <CAJZ5v0jgLd2qZw5s6e8S6i3D+RU8cvy1iGCMcadG0SHVKKpEoA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: hfi: remove null check after call container_of()
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Tue, May 17, 2022 at 3:31 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> container_of() will never return NULL, so remove useless code.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 730fd121df6e..a0640f762dc5 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -243,8 +243,6 @@ static void hfi_update_work_fn(struct work_struct *work)
>
>         hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
>                                     update_work);
> -       if (!hfi_instance)
> -               return;
>
>         update_capabilities(hfi_instance);
>  }
> --

Applied with adjusted subject as 5.19 material, thanks!
