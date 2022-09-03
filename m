Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2E75AC07E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiICSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiICSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:05:55 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08146D87;
        Sat,  3 Sep 2022 11:05:54 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 193so7420573ybc.10;
        Sat, 03 Sep 2022 11:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VZspdJAb/ju//+Bhc5iNyCD8XcmOd3SFg+vf3tdYitk=;
        b=iXBucZgU2aEr53vHlmLGeKhl5tu41XQQvteVtm6c0Ig6Nyo/mXglI5QRdW9o1RoGWM
         2YEEW/TSE2el/fdJvVGq7OL6r2G5VgTg+89KwpXUrS5G3pmCxBegll4NDVQWQ/kkeHNB
         8Gj67QIpmHuNOQ/TBEexoK5qk1km6Nre3ChA747AhMMjSVHLWZJQwVSh68/yl6gFLGeb
         goSlK4VF2nX6qGDZ3Df55GXDepq2MCWuKt4QQZWgG9oYk0Z0MKdXtIV7sKXkNXPcaSlI
         75KysQVKHbQMhcA8QLl+QkLimKIThwR8xw5Oqd6llDOXEbjYRJ9m8/yV6p8gbyzBmW2N
         Y4Xw==
X-Gm-Message-State: ACgBeo2AUC2MK/SU+jCkY6Kw2YnLW8AwTVGsyGO8X+HDsauc4JTcFqU3
        OTW7yitGjaK6wKr+rHlBHF/zTrueMpE2CX1Pmnk=
X-Google-Smtp-Source: AA6agR5NNHHq6rGLcfeG4BrTFM5UI/K8XJrdCnLCQ5XP3PW+FXN6QNyYiiQfu53azMXBYQSxO0ECTm6kSB15PmloIFk=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr28803814ybm.137.1662228354205; Sat, 03
 Sep 2022 11:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220825013630.16311-1-mario.limonciello@amd.com>
In-Reply-To: <20220825013630.16311-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:05:43 +0200
Message-ID: <CAJZ5v0jc_MNm6-s=p1Kaymk72h4QEH12J33dadyiKB76muqLtQ@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: Add extra debugging statement for multiple
 active IRQs
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
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

On Thu, Aug 25, 2022 at 3:36 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Since commit cb1f65c1e1424 ("PM: s2idle: ACPI: Fix wakeup interrupts
> handling") was introduced the kernel can now handle multiple
> simultaneous interrupts during wakeup.  Ths uncovered some existing
> subtle firmware bugs where multiple IRQs are unintentionally active.
>
> To help with fixing those bugs add an extra message when PM debugging
> is enabled that can show the individual IRQs triggered as if a variety
> are fired they'll potentially be lost as /sys/power/pm_wakeup_irq only
> contains the first one that triggered the wakeup after resume is
> complete but all may be needed to demonstrate the whole picture.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215770
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/base/power/wakeup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index e3befa2c1b661..dcd06eac30afd 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -943,6 +943,7 @@ void pm_system_irq_wakeup(unsigned int irq_number)
>                 wakeup_irq[1] = irq_number;
>         else
>                 irq_number = 0;
> +       pm_pr_dbg("Triggering wakeup from IRQ %d\n", irq_number);
>
>         raw_spin_unlock_irqrestore(&wakeup_irq_lock, flags);
>
> --

Applied as 6.1 material, thanks!
