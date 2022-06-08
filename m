Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9D5424BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiFHFSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiFHFSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31D27E46E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3EF6617A0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F97CC34114
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654655321;
        bh=FrteEuZTwseBpaOH5Z0G0HTM9+1Of+/l5CBo2sRiR5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y+dDRfYUdyvv3sl1DfVOEShaUuGxX8ZHPT3lROQDoKQZFCaoqqMtZzTCv2BcIXl49
         DaXBg8/1m4552ddyycjiGtwcdiLYmBrfog4XhfYspS6r3wnEKQn/qg4NkRvnlzDWOV
         bvVrCQczBm7lgkQjo6HfT7gCcsWo0zQdHNon3CD4LeXx+PHqaL1NEX7/K+y2lmujGB
         wyLIj0hVgvkHi+slSFFg0Wor82LTfFDoCpwmfT42nEDbXUxOTxA8sjxTqGLin8vZ0N
         M0UFjFzhq6atSlI6VBqduGpw1wcHFn4dOhWNbcUEqGmzze9V72bpPjuy/agE2hw1ws
         GodXajwXfdoJA==
Received: by mail-vs1-f49.google.com with SMTP id r12so15756381vsg.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:28:41 -0700 (PDT)
X-Gm-Message-State: AOAM530+olYIyST3awaiqj+ZnqWL6kPWKZXonoii30mrkzDAbFYJVD78
        eRjTYLGxOTxDru4PxX2hBBaYQm0apusyidKVn3o=
X-Google-Smtp-Source: ABdhPJwLnvXf7DWVcfNLpW3GLoBUN9fMmsH11OmVM3fqAzjKjQUvBzbGNFbhbe5DV3Bbqcd3aVAxVQPSekYGu7L2vQE=
X-Received: by 2002:a05:6102:3562:b0:34b:9e99:1bfa with SMTP id
 bh2-20020a056102356200b0034b9e991bfamr10191231vsb.51.1654655320384; Tue, 07
 Jun 2022 19:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220607143059.1054074-1-heiko@sntech.de>
In-Reply-To: <20220607143059.1054074-1-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 8 Jun 2022 10:28:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTMFPf63_PGUrCLZt3xT3MDG=DZ8dwE8530f5N57yAq=w@mail.gmail.com>
Message-ID: <CAJF2gTTMFPf63_PGUrCLZt3xT3MDG=DZ8dwE8530f5N57yAq=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: Add macro for multiple nop instructions
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>
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

Just a safe good coding convention point.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Tue, Jun 7, 2022 at 10:31 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Some cases need multiple nop instructions and arm64 already has a
> nice helper for not needing to write all of them out but instead
> use a helper to add n nops.
>
> So add a similar thing to riscv and convert the T-Head PMA
> alternative to use it.
>
>
> Heiko Stuebner (2):
>   riscv: introduce nops and __nops macros for NOP sequences
>   riscv: convert the t-head pbmt errata to use the __nops macro
>
>  arch/riscv/include/asm/asm.h         | 15 +++++++++++++++
>  arch/riscv/include/asm/barrier.h     |  2 ++
>  arch/riscv/include/asm/errata_list.h |  8 +-------
>  3 files changed, 18 insertions(+), 7 deletions(-)
>
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
