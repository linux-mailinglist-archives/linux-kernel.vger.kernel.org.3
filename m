Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C51574558
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiGNGyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiGNGyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:54:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E22AC4F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE710B8222A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA84C34115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657781672;
        bh=pY6Oh1xI3elnYIaAyKOGZ+znYcxLjnl8Uh5Nt/yrIoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jMpFH48cdb7uQwOo4R5JaygLrQlIKxKWQLFRoOu9DjNe9oR2oA+AjIbS8Hi0cMseN
         oy2BsRFu0PP+KKL1ZUTrXFNSax0CBbE5exY69vNEA0OTzkjRsw1sBFHh3Oyx65IOJk
         ZIeCtJhcEhX6seNXpGO4yTXM8lA/+YMteNw2gy7pK3OoPKI1hoq1nVIox3OcTfJnZE
         PVnw5k5cc4ByMt5Jy/HtAgGzvhokjB2NyjQyD0HxWtyvJ9lD3c+teNbYD6gtn43xvY
         i00bqM6vxhxBLROnjsgHLfdP/xtj8rEzu6qlzZCMZLZe0jE2j1crIT/czVmIIWUDq1
         EKTWYO88tGt8Q==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31c9b70c382so7837147b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:54:32 -0700 (PDT)
X-Gm-Message-State: AJIora/9/liH3FriQqNt7MU34c2M/TmtIutBIH8VOv6HD5PbUBs4hejQ
        ePg/5EC1XIyKzJ3gnDBczRyUniE6pTYItxydac4=
X-Google-Smtp-Source: AGRyM1vvphUH1o0RqtC3ZmwDKrSwcj2aM46AYWxZb67L7oriGa4izPonw02pIMzohRrw5ur3ZFDh9WoDMYBoL1DERWc=
X-Received: by 2002:a0d:fec3:0:b0:31b:c2d6:34ea with SMTP id
 o186-20020a0dfec3000000b0031bc2d634eamr8103089ywf.62.1657781671284; Wed, 13
 Jul 2022 23:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220714012908.4948-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220714012908.4948-1-yang.lee@linux.alibaba.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 14 Jul 2022 09:54:04 +0300
X-Gmail-Original-Message-ID: <CAFCwf12DeOFdwKk-bunOhO=NK6y6emFpEFY0J96Y5bmYE0bYSA@mail.gmail.com>
Message-ID: <CAFCwf12DeOFdwKk-bunOhO=NK6y6emFpEFY0J96Y5bmYE0bYSA@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 4:29 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/misc/habanalabs/gaudi2/gaudi2.c:9727:48-53: WARNING:
> conversion to bool not needed here
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/misc/habanalabs/gaudi2/gaudi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> index 98336a1a84b0..344b4dedef41 100644
> --- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
> +++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> @@ -9724,7 +9724,7 @@ static int gaudi2_get_mmu_base(struct hl_device *hdev, u64 mmu_id, u32 *mmu_base
>
>  static void gaudi2_ack_mmu_error(struct hl_device *hdev, u64 mmu_id)
>  {
> -       bool is_pmmu = (mmu_id == HW_CAP_PMMU ? true : false);
> +       bool is_pmmu = (mmu_id == HW_CAP_PMMU);
>         struct gaudi2_device *gaudi2 = hdev->asic_specific;
>         u32 mmu_base;
>
> --
> 2.20.1.7.g153144c
>
This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next.
Thanks,
Oded
