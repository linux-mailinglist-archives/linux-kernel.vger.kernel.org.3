Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981144FEE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiDMFnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiDMFnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C6205F9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C619A61BFE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C1C385AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649828490;
        bh=6fyXgGmnncP9RnqtMEVqhcHnnTV4ib2I9cy9gPtxqnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UP8035ibOxc8zEcw0pPcAIIY+p1XKSIkPB4Y336Y0Dz0pFAikXra/CRVL2hha5Qbn
         AFSrPEZOT4kxqEcpkKwBH1tQ7WnJ8eADILuwh4QBtUNPDyk/+Kx3ok+ijop4kf8Ibp
         uJA19ExlQLMFwt/oYsQoo2G4QW2CtpYpmScKu/CIXyKjEOkWRyRc+2BC5f13i8FfBZ
         WN7OYLgBi1Kch2JJ8OIbE0Ax+LXB8XBb5ZG3nCWHKmhHx+JvtHKrD4vKIzexsKet7D
         DtgLXCr2AUY1aJsk3nlAIcI3mZgu4HCzw5vyk7z1RyJQky+XiqOoTohhrudI0V0adE
         SEBrlkUGlTV6g==
Received: by mail-vs1-f53.google.com with SMTP id f32so635206vsv.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:41:30 -0700 (PDT)
X-Gm-Message-State: AOAM532NxTbZYwxKekmvhkhFccjRMv2aWJN7v95jx958/1K+ALu120GD
        3NLIPNUpvQTULKEiJtO2wv0FR9EcnSTv9hHwQNc=
X-Google-Smtp-Source: ABdhPJzpwykgp0eknHlnFcTmKfeIedOUwl0K6MIZjruWMpZxjRLZgyIMm3a18FZ2AyDQBAOoFJrUtGGyWiQ3aXs8A/8=
X-Received: by 2002:a05:6102:1241:b0:325:6bfb:ab75 with SMTP id
 p1-20020a056102124100b003256bfbab75mr13574254vsg.2.1649828489116; Tue, 12 Apr
 2022 22:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-11-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-11-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Apr 2022 13:41:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQOEQ3ukNT8+3uL_wM82xobLedJHrNk4DGTRzB3d_Ui8g@mail.gmail.com>
Message-ID: <CAJF2gTQOEQ3ukNT8+3uL_wM82xobLedJHrNk4DGTRzB3d_Ui8g@mail.gmail.com>
Subject: Re: [PATCH v9 10/12] riscv: remove FIXMAP_PAGE_IO and fall back to
 its default value
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, liush <liush@allwinnertech.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Apr 13, 2022 at 11:05 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> If not defined in the arch, FIXMAP_PAGE_IO defaults to PAGE_KERNEL_IO,
> which we defined when adding the svpbmt implementation.
>
> So drop the FIXMAP_PAGE_IO riscv define.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/fixmap.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 3cfece8b6568..5c3e7b97fcc6 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -45,8 +45,6 @@ enum fixed_addresses {
>         __end_of_fixed_addresses
>  };
>
> -#define FIXMAP_PAGE_IO         PAGE_KERNEL
> -
>  #define __early_set_fixmap     __set_fixmap
>
>  #define __late_set_fixmap      __set_fixmap
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
