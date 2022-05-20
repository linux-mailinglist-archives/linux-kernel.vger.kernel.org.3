Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1F52E6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbiETHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbiETHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:55:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CB15D328
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F217B82955
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5629C34100
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653033324;
        bh=5PjNxWrAkE2aE9x3dsIS9yQLnElttOOmKVN4caatM7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbyzrSprqnbq46tDefPpYzM+NTVrUW5rIvgTJbph3SfpSXhg9Aj6ycFMp+2vpEWCr
         tb3GemDub8Jx164H0J118szakPOJHgnNMYzvZbuCqh9OqGvKtufjt4TsxBOUHqC+z9
         YZTXZ/5noMEGYCSgprz9YPg/mrBwZZWFpyn6JYL9PwEm28bIUwNJqSM8GH18tfwWb3
         EpPtccTi3TGdjcJ8+iPJ6sNhlN7K6amHyX2h0iX+5c3rA965fhrlrBqCp7Djr/+JBA
         GpuQvVouHZuJVIhklN7VTqvq3Hp9BhFgMeUfb3mvHKVAegfWsXpFm3H9mPqe6rqIGy
         oJGEYDgHAGzvg==
Received: by mail-vs1-f52.google.com with SMTP id i186so7601335vsc.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:55:24 -0700 (PDT)
X-Gm-Message-State: AOAM532etIQdLaDCvZMO4+Mi1v2OYBMjIa7yWHVFMtVMm4TgFWEdrhSN
        Cg24lQWldXZS5ERuOv6pWutaT+2GGK9xOtJJAyU=
X-Google-Smtp-Source: ABdhPJzoQJmEcg1f5gdVVGcKBbnvI29hx3yOXCHhpEX2KNC80TO+z8VUoQ3xCchExuHGPIQmGQV0Zg0tadzLdBEIJW0=
X-Received: by 2002:a05:6102:390b:b0:32d:5fc3:bd2c with SMTP id
 e11-20020a056102390b00b0032d5fc3bd2cmr3709471vsu.51.1653033323855; Fri, 20
 May 2022 00:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170254.3178923-1-heiko@sntech.de> <20220518170254.3178923-5-heiko@sntech.de>
In-Reply-To: <20220518170254.3178923-5-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 20 May 2022 15:55:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0Ory_eXBfHAE7g+hdwPcC-h_41g_m=_v=e-HraOXPBQ@mail.gmail.com>
Message-ID: <CAJF2gTQ0Ory_eXBfHAE7g+hdwPcC-h_41g_m=_v=e-HraOXPBQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: fix dependency for t-head errata
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, May 19, 2022 at 1:03 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> alternatives only work correctly on non-xip-kernels and while the
> selected alternative-symbol has the correct dependency the symbol
> selecting it also needs that dependency.
>
> So add the missing dependency to the T-Head errata Kconfig symbol.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index ebfcd5cc6eaf..457ac72c9b36 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -35,6 +35,7 @@ config ERRATA_SIFIVE_CIP_1200
>
>  config ERRATA_THEAD
>         bool "T-HEAD errata"
> +       depends on !XIP_KERNEL
>         select RISCV_ALTERNATIVE
>         help
>           All T-HEAD errata Kconfig depend on this Kconfig. Disabling
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
