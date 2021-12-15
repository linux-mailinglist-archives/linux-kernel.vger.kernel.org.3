Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB84753B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhLOHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbhLOHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DDDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:30:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F74FB81DF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBE7C3460C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639553448;
        bh=CuBnUB9rlCFrNEiiE2APPssU9pAmsRUNYSSlDtU6g5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ci28ztUggGhZihYQDjexU4RsH8ZiOLnkyIpYDqk2UDdLfZFQsZAe/i9O4TDkMHXKE
         3o7eWk7yfWC1geJX40BA9UZBOKu6iE2Sy0BaRt5DQsvutpCaoKdZBOybL0VqZVXug6
         eJQBR1BISNFj8pfrvhrWUoPekCqLbcpSZ2BW0idycfaC/Zt+eD6dYU+hFNDKjuW7RP
         vCWWGxzyruyTzX876r4kx0FIjRr0QMEbo8cTCYxWmYNLJ+wOfeAjM8vCRhQp5Js1IP
         wF7B6HHjwEtzj5l7mRWVwP7hq3Q1YRtO8FCj5XV7MI4/5t1hMG2IobIAqqYTM8rTXU
         GSHw3nbXkmf4Q==
Received: by mail-wr1-f53.google.com with SMTP id c4so36499396wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:30:48 -0800 (PST)
X-Gm-Message-State: AOAM532DKUejYpHxNDTSE1mZJ92RNi7OKYro7fPAPxuGM+/4HfFxsXgK
        J4h964KzByzPngX9roP47v0ZyAICadMsMsj6t1k=
X-Google-Smtp-Source: ABdhPJwQ8ypaYPjUD2rIVZ2mwyirgnnIlAtJtpdrdgQzG4QXJYsrxWJzBoiHkJUDY8+vF28Ze5t8RPOYkQ+vPWflkvw=
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr3130676wrc.417.1639553446963;
 Tue, 14 Dec 2021 23:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
In-Reply-To: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Dec 2021 08:30:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFWKk+sH8F6vH0ZDTiFO-bQURYQWPFOEFCvbE6oPTHosQ@mail.gmail.com>
Message-ID: <CAMj1kXFWKk+sH8F6vH0ZDTiFO-bQURYQWPFOEFCvbE6oPTHosQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: mm: apply __ro_after_init to memory_limit
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 07:55, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> This variable is only set during initialization, so mark with
> __ro_after_init.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8834434af99..db63cc885771 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -172,7 +172,7 @@ int pfn_is_map_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_is_map_memory);
>
> -static phys_addr_t memory_limit = PHYS_ADDR_MAX;
> +static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
>
>  /*
>   * Limit the memory size that was specified via FDT.
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
