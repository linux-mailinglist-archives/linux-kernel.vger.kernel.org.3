Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731944B877B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiBPMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:22:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiBPMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:22:53 -0500
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE3E0ACD;
        Wed, 16 Feb 2022 04:22:41 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id y6so5472316ybc.5;
        Wed, 16 Feb 2022 04:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyLKMy9mx/11boOTHLHDZ1fvODjQEjXMH8nu+p70vJs=;
        b=fu7P9kBBg/MMvjWN/lY+KqPqg5ZeeTgIhKde0G5jS4IReQm1ayXYZDJIXQDu7eYx5W
         UDzC6byGHhB+AD3r9ZJoqVe7O6CbkRwqAKncma2EVVgZxlVs14zHjsxraT6+UUcYggFF
         JFonXefseGKRWL5X9FAaucy6a85Z4N9QkvGI1uVpC3TNWBYtCQBNK+xOEPbGEPjQow2c
         kRw1wTu+1pukSE9JYFmy5EVxrRAzZueZmXnoJwNFkkBl3XIliQ2l/VSj6aVCTKuMKjNQ
         PA7i2rlCMN5ZEihsll8X604d+1/3bCi/jrHcEh4OkM51ZfX2qJ3mFhVB+lHP5Tn42IMx
         tCmw==
X-Gm-Message-State: AOAM532OsAeIAILBZEos0gr54EgTTkJYNXDN7/ujBaq2yATtJ4qbEI72
        B10MyvVHdZS5eNSJPtuxLXi1AZYnRJYk/13Z+xg=
X-Google-Smtp-Source: ABdhPJyJxNNVakBSB/WLvTRdrGZ9BXqx/DQIqoqFOGeLTAEwWDJchTaLwydj6Vd4o58xgwmHfILAH+X1f5I0myuczl4=
X-Received: by 2002:a0d:d5d6:0:b0:2d1:51e2:5a09 with SMTP id
 x205-20020a0dd5d6000000b002d151e25a09mr2027246ywd.149.1645014161118; Wed, 16
 Feb 2022 04:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20220216062615.779778-1-ztong0001@gmail.com>
In-Reply-To: <20220216062615.779778-1-ztong0001@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 13:22:27 +0100
Message-ID: <CAJZ5v0hsDVqZM=iP=4CYhGT99ScQ1xQNYHKcdJHHCscEhXOoCA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: proactively check null ptr to avoid API misuse
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Wed, Feb 16, 2022 at 7:26 AM Tong Zhang <ztong0001@gmail.com> wrote:
>
> There are some cases that user use acpi_ns_walk_namespace() without
> checking acpi_disable flag. When acpi=off is provided in boot cmdline,
> acpi_gbl_root_node is NULL and calling acpi_ns_walk_namespace() will
> crash kernel. In order to avoid such misuse, we proactively check null ptr
> and return an error when we know ACPI is disabled.

The issue should be fixed by this commit in the upstream ACPICA code
base: https://github.com/acpica/acpica/commit/b1c3656ef4950098e530be68d4b589584f06cddc

>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/acpi/acpica/nswalk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
> index 915c2433463d..9ae45db16d86 100644
> --- a/drivers/acpi/acpica/nswalk.c
> +++ b/drivers/acpi/acpica/nswalk.c
> @@ -171,6 +171,13 @@ acpi_ns_walk_namespace(acpi_object_type type,
>                 start_node = acpi_gbl_root_node;
>         }
>
> +       /* acpi_gbl_root_node is NULL when acpi=off is provided.
> +        * We proactively check nulliness here and return an error if user call
> +        * this function without checking acpi_disabled
> +        */
> +       if (start_node == NULL)
> +               return_ACPI_STATUS(AE_ERROR);
> +
>         /* Null child means "get first node" */
>
>         parent_node = start_node;
> --
> 2.25.1
>
