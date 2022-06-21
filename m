Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34CF5539F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352591AbiFUTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiFUTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:01:01 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C216310;
        Tue, 21 Jun 2022 12:01:00 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id x38so26080393ybd.9;
        Tue, 21 Jun 2022 12:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+zEfTPl62ZsQ+t9lMlcWTCl0qIebIY9l0QPCPq49r0=;
        b=JdXHa2jrfBN45+6Iub7qTRXjgdaDRMw7DU7OuBbNSoIOQBqrgakOp/G8g5IdyheFO0
         ASF09DTG6P7wByBzF9s8JOKrI7gi+jOjWgTkVhluwX2WoFPQbPfuUJn5Yhl2oLCaCXXL
         xtI14GzNjRgZ998zcGUFUhHKCp2+lmBCHHUPsnffg76qIWLzN+/3QU2mNEFK66g+1IQD
         hYVr5y82N6QusAl2mIJzqKRlusiLXXOR3TkH/52+zb7umd0/Yxr8Q2EY0UUIY5rCmua/
         AeDYZa/gkhDP7JfCBhL+Op8Pp3xg/37KGTLpgmEiSwTujrTms2YmCwUxc23cRV2WaSIJ
         5Sig==
X-Gm-Message-State: AJIora/sm5ngf7u7PgJEfEJknbwCDWNcwUS2Stge8Q8uQEIfwPjNqmmF
        IpUppAmGKDr9c0eWsJbeLjwd2vg5wRvqH1ncuRqy18Vd
X-Google-Smtp-Source: AGRyM1vHY55MahEyWeg4N+yr0dbBZvb66hCxrIii1Y0e4pT8SAg3KKAFkEl6bUit0p6mohG2X8nrYo3pN/RnCIwnq+4=
X-Received: by 2002:a25:cad5:0:b0:668:b012:88c0 with SMTP id
 a204-20020a25cad5000000b00668b01288c0mr25821880ybg.633.1655838059428; Tue, 21
 Jun 2022 12:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220617122402.151782-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220617122402.151782-1-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Jun 2022 21:00:48 +0200
Message-ID: <CAJZ5v0h9-BRp2k5Vc+9qyf6RV5dq98LBUKm+xTcNJYDnMxJ98g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: hibernate: Use kernel_can_power_off()
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ken Moffat <zarniwhoop@ntlworld.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 2:24 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Use new kernel_can_power_off() API instead of legacy pm_power_off global
> variable to fix regressed hibernation to disk where machine no longer
> powers off when it should because ACPI power driver transitioned to the
> new sys-off based API and it doesn't use pm_power_off anymore.
>
> Fixes: 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
> Tested-by: Ken Moffat <zarniwhoop@ntlworld.com>
> Reported-by: Ken Moffat <zarniwhhop@ntlworld.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 20a66bf9f465..89c71fce225d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -665,7 +665,7 @@ static void power_down(void)
>                 hibernation_platform_enter();
>                 fallthrough;
>         case HIBERNATION_SHUTDOWN:
> -               if (pm_power_off)
> +               if (kernel_can_power_off())
>                         kernel_power_off();
>                 break;
>         }
> --

Applied as 5.19-rc material, thanks!
