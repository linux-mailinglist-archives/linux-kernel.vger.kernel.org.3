Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A1527D77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbiEPGPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiEPGPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:15:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C820F72
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:15:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FF2768B05; Mon, 16 May 2022 08:15:42 +0200 (CEST)
Date:   Mon, 16 May 2022 08:15:41 +0200
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
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH 11/12] riscv: don't use global static vars to store
 alternative data
Message-ID: <20220516061541.GA12877@lst.de>
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-12-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511192921.2223629-12-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:29:20PM +0200, Heiko Stuebner wrote:
> Right now the code uses a global struct to store vendor-ids
> and another global variable to store the vendor-patch-function.
> 
> There exist specific cases where we'll need to patch the kernel
> at an even earlier stage, where trying to write to a static
> variable might actually result in hangs.
> 
> Also collecting the vendor-information consists of 3 sbi-ecalls
> (or csr-reads) which is pretty negligible in the context of
> booting a kernel.
> 
> So rework the code to not rely on static variables and instead
> collect the vendor-information when a round of alternatives is
> to be applied.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/kernel/alternative.c | 51 ++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index e6c9de9f9ba6..27f722ae452b 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -16,41 +16,35 @@
>  #include <asm/sbi.h>
>  #include <asm/csr.h>
>  
> -static struct cpu_manufacturer_info_t {
> +struct cpu_manufacturer_info_t {
>  	unsigned long vendor_id;
>  	unsigned long arch_id;
>  	unsigned long imp_id;
> -} cpu_mfr_info;
> +	void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
> +				  unsigned long archid, unsigned long impid,
> +				  unsigned int stage);

Please drop the confusing vendor_ prefix for the function pointer
while you're at it.  The vendor id is just one of three inputs for
the patching.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
