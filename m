Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5953DB32
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiFEKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiFEKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:06:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E3443EB;
        Sun,  5 Jun 2022 03:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DCCDB80C94;
        Sun,  5 Jun 2022 10:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF7AC385A5;
        Sun,  5 Jun 2022 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654423562;
        bh=UkhK0iXmipOKdrh664jQXMz5mV/hcSj5hRpVu1jSBfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k4Mfn/8QAnGV2O6X6jv2u4l1y+rYDmyzCwa1D/UI0PNyWd2UCZMaDCrehF9YZIv/O
         OWsvUw6kTYR6zB1CoS9JgKqzox2KMf3r7jVf/VTZ6XWtwOCMdENBzK4jmsOtvmxjzS
         CDyWCPNdt8mT7etbrkSQVZ66U+SE1C46ntkO7E2B5kd/R5i9AeL1EdKcva4qhtvJeH
         CVWQomn4DbnO1gA5iWP2fVwX7axawIXOpPkR4Akzva2F9qXHpdtBj/DD4Fotxhfwh2
         83z8tKgsvzdLNG+AXJR2dJJ7/QsVhfXe1qQefbcGHkWvANEEPVY/4IiMIyjkUp3OUj
         /Qa6Wskn3bJTw==
Received: by mail-yb1-f170.google.com with SMTP id a30so2265888ybj.3;
        Sun, 05 Jun 2022 03:06:01 -0700 (PDT)
X-Gm-Message-State: AOAM533sIpkutbhKsPHh+HUfQ2GWYaEWVIxYX0A9owlvp5Wh/Isy6mvK
        D/doEVq6mRn5OfH6e38SoBO7nKj3Z4hW5D4VxMU=
X-Google-Smtp-Source: ABdhPJw3j6eaxny1petObshdCU3O7C4LdZnpOgx/3q928/0gteNHzH6VQv4VdRzBF2oStDnzp8/BKitGQSxu3iaGd7s=
X-Received: by 2002:a05:6902:514:b0:65c:b28c:f9f8 with SMTP id
 x20-20020a056902051400b0065cb28cf9f8mr18935548ybs.403.1654423561012; Sun, 05
 Jun 2022 03:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <Yo4gIobpIlRmxqtH@kili>
In-Reply-To: <Yo4gIobpIlRmxqtH@kili>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 5 Jun 2022 13:05:33 +0300
X-Gmail-Original-Message-ID: <CAFCwf12QOxB4HJJAjJLknsEBiSAbaDgbna5L3JFhCcr36Rqc9w@mail.gmail.com>
Message-ID: <CAFCwf12QOxB4HJJAjJLknsEBiSAbaDgbna5L3JFhCcr36Rqc9w@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix double unlock on error in map_device_va()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ohad Sharabi <osharabi@habana.ai>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuri Nudelman <ynudelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 3:25 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If hl_mmu_prefetch_cache_range() fails then this code calls
> mutex_unlock(&ctx->mmu_lock) when it's no longer holding the mutex.
>
> Fixes: 9e495e24003e ("habanalabs: do MMU prefetch as deferred work")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/habanalabs/common/memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> index 663dd7e589d4..d5e6500f8a1f 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -1245,16 +1245,16 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
>         rc = map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
>         if (rc) {
>                 dev_err(hdev->dev, "mapping page pack failed for handle %u\n", handle);
> +               mutex_unlock(&ctx->mmu_lock);
>                 goto map_err;
>         }
>
>         rc = hl_mmu_invalidate_cache_range(hdev, false, *vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
>                                 ctx->asid, ret_vaddr, phys_pg_pack->total_size);
> +       mutex_unlock(&ctx->mmu_lock);
>         if (rc)
>                 goto map_err;
>
> -       mutex_unlock(&ctx->mmu_lock);
> -
>         /*
>          * prefetch is done upon user's request. it is performed in WQ as and so can
>          * be outside the MMU lock. the operation itself is already protected by the mmu lock
> @@ -1283,8 +1283,6 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
>         return rc;
>
>  map_err:
> -       mutex_unlock(&ctx->mmu_lock);
> -
>         if (add_va_block(hdev, va_range, ret_vaddr,
>                                 ret_vaddr + phys_pg_pack->total_size - 1))
>                 dev_warn(hdev->dev,
> --
> 2.35.1
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
