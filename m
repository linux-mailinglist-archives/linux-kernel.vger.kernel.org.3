Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB55527D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiEPGLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiEPGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:11:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB7F20F67
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:11:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9219A68B05; Mon, 16 May 2022 08:10:57 +0200 (CEST)
Date:   Mon, 16 May 2022 08:10:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Wei Wu <lazyparser@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Bill Huffman <huffman@cadence.com>
Subject: Re: [PATCH 09/12] riscv: add RISC-V Svpbmt extension support
Message-ID: <20220516061057.GL12339@lst.de>
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-10-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511192921.2223629-10-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config RISCV_ISA_SVPBMT
> +	bool "SVPBMT extension support"

I don't think this prompt is very useful as it doesn't describe
what it does.  But do we even want people to disable it as it is
really essentially for a fully functioning kernel and a pity that
it took RISC-V so long to get there?

> +	depends on 64BIT && MMU
> +	select RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the SVPBMT extension

overly long line here.

> index 5f1046e82d9f..dbfcd9b72bd8 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -14,6 +14,9 @@
>  #define	ERRATA_SIFIVE_NUMBER 2
>  #endif
>  
> +#define	CPUFEATURE_SVPBMT 0
> +#define	CPUFEATURE_NUMBER 1

is errata_list.h really the right place for architectural features?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
