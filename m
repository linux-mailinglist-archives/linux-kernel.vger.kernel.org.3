Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B00559E51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiFXQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:11:47 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D1A5002A;
        Fri, 24 Jun 2022 09:11:47 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 23so5265242ybe.8;
        Fri, 24 Jun 2022 09:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8SvbPl2HkMoNoh8fjmvh+1figA9UteGT0qWY1AbfLY=;
        b=RMjNk5JByIm6Siaoj3ZI3+oC0mwISSOzrRqYsoRydTn67E2i9sjqeVNzaEsXaBh+Nr
         zA4YqDxR5sT2+R0H/hcSpNZyldLGJG6kEfxOC9T0j0Rqoo6Oflx54ZIinJ2xb6CXCwIT
         TtgxCzvClBogRzENp9BCUK9DDLZN6P7+ARa6keda37FbVWYFWLvdJ/OiUP5jAuXmdKqy
         N2fwHwW9t4FMo7FagCHfBh5T3Z0ZMmQc+2u0+EOWkthT60e8eHux0Wr69p7xdIugArjX
         aetybKFxaHBw9Lfa6eoaeLTe8/zTIr4jpSG1XkLgfX9010ddQvySVycjvh+LZX4Od1Ju
         JStg==
X-Gm-Message-State: AJIora+VCGQO3sx9XSXBnqBpFrFWO6FONvvgPdKQwY8MHE3i3+gzRSqd
        BeOgP7oVGUaBBJ797YMxKsGDpThh7p0CitJy8oSvT6Fptio=
X-Google-Smtp-Source: AGRyM1ve/F8rHyeHqtGTuIOFtCx/e8wcxtrG1D/rxohZ3L6KH/fsrwGwrnZTegGICZobudV3v/pi9LuKqHafZ9OCdnc=
X-Received: by 2002:a05:6902:1141:b0:669:3f2a:c6bb with SMTP id
 p1-20020a056902114100b006693f2ac6bbmr15571250ybu.365.1656087106298; Fri, 24
 Jun 2022 09:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220624115940.272422-1-Perry.Yuan@amd.com>
In-Reply-To: <20220624115940.272422-1-Perry.Yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Jun 2022 18:11:35 +0200
Message-ID: <CAJZ5v0igFJgTH9yVCVyuGHmkbonBYh18KKi4X+TYDVaZRwNzxg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Fix osc_sb_cppc_not_supported check
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     Huang Rui <Ray.Huang@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, Xinmei.Huang@amd.com,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
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

On Fri, Jun 24, 2022 at 2:00 PM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> The patch fixs the osc_sb_cppc_not_supported variable checking
> Otherwise the cppc acpi driver will be failed to register causing AMD
> pstate driver failed to load when calling acpi_cpc_valid()
>
> Fixes: c42fa24b447("ACPI: bus: Avoid using CPPC if not supported by firmware")
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4d7c51a33b01..9731e4a1e338 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -359,7 +359,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>         }
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> -       osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
> +       osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &&
>                         (OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));

This certainly is not a correct fix, because it causes
osc_sb_cppc_not_supported to always be true if
capbuf_ret[OSC_SUPPORT_DWORD] is not zero.

>  #endif
>
> --
> 2.25.1
>
