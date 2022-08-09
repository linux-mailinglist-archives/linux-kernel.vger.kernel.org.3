Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE258D224
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiHICwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHICwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:52:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27991EEE5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28BF9B8113A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8080FC433D7;
        Tue,  9 Aug 2022 02:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660013509;
        bh=jDoqOf+FwIP4llPVmdQzA4TXzcoAUMvW9jcFaNiXkRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VERjjnxoG/CZs1PQaMUQYe5LIuB7UAPCG3Nu8caUJRniPUUkWRBhXXP7x6vwZRdGD
         qbApqDyFyyedH/ZELQ+/ja6BLRP3Kcln+UoDoteDmQrWOpM5zilFQH3jP9BEwUXD7w
         R/YpCL9uruHF5sEqSaMRFIBXHRD6a3E8w/eKee68DG7FzWPm7VD2Z/L1WziC5s4Jnn
         WrgSpcGOLkDl8+Cy4yLAWtenXths1Baddokh+pHnRG7Or4QyV9ciCJRvwV1l9OQTAS
         BrFMbOyOS+faFrFK+ZOGUrhuEgdAI6scD6s3H7QbOYADxjppFqQk5Oba2aK2XsO+4b
         MOGoySsjC6xcw==
Date:   Mon, 8 Aug 2022 21:51:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     bhelgaas@google.com, horms@verge.net.au, pablo@netfilter.org,
        davem@davemloft.net, nathan@kernel.org, apw@canonical.com,
        joe@perches.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig: eliminate abnormal characters displayed under
 menuconfig
Message-ID: <20220809025147.GA1264335@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1659435153-119538-1-git-send-email-liusong@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:12:33PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Use "find ./linux/* | grep Kconfig | xargs file | grep UTF", can find
> files with utf-8 encoded characters, these files will display garbled
> characters in menuconfig, except for characters with special meanings
> that cannot be modified, modify the characters with obvious errors to
> eliminate the wrong display under meunconfig.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>

I did suggest fixing everything at once.  But I think there are
actually two problems here.  The first is that some are just wrong,
e.g., drivers/pci/Kconfig using CYRILLIC SMALL LETTER DZE instead of
"s", or net/netfilter/ipvs/Kconfig using NO-BREAK SPACE for no good
reason.

arch/Kconfig looks like it's using RIGHT SINGLE QUOTATION MARK instead
of the basic APOSTROPHE.  That one is debatable; I think it's fair to
argue that RIGHT SINGLE QUOTATION MARK would be preferred if rendered
correctly.

The second problem is that I think menuconfig doesn't handle UTF-8
correctly.  For example, in a gnome terminal with the default
LC_ALL=en_US.UTF-8, these look fine:

  $ grep -A10 MTD_SPI_NOR_USE_4K_SECTORS drivers/mtd/spi-nor/Kconfig
  ...
  64 KiB block instead of 16 × 4 KiB sectors.

  $ grep -A1 MTD_NAND_CAFE drivers/mtd/nand/raw/Kconfig
  config MTD_NAND_CAFE
	tristate "OLPC CAFÉ NAND controller"

But when menuconfig in the same terminal displays that same text, it
looks like "16  ~W 4 KiB sectors" and "OLPC CAF ~I NAND".

On the other hand, gconfig and xconfig do render these correctly.  So
I think there's something wrong with UTF-8 in menuconfig, and we
should fix that as well.

Anyway, I'm fine with this patch as far as it goes:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  arch/Kconfig               | 2 +-
>  drivers/pci/Kconfig        | 2 +-
>  net/netfilter/ipvs/Kconfig | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 5ea3e38..2462337 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -745,7 +745,7 @@ config CFI_CLANG
>  	depends on CLANG_VERSION >= 140000
>  	select KALLSYMS
>  	help
> -	  This option enables Clang’s forward-edge Control Flow Integrity
> +	  This option enables Clang's forward-edge Control Flow Integrity
>  	  (CFI) checking, where the compiler injects a runtime check to each
>  	  indirect function call to ensure the target is a valid function with
>  	  the correct static type. This restricts possible call targets and
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c732..8102b78 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -166,7 +166,7 @@ config PCI_P2PDMA
>  	depends on ZONE_DEVICE
>  	select GENERIC_ALLOCATOR
>  	help
> -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> +	  Enables drivers to do PCI peer-to-peer transactions to and from
>  	  BARs that are exposed in other devices that are the part of
>  	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
>  	  specification to work (ie. anything below a single PCI bridge).
> diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
> index 271da84..06b9066 100644
> --- a/net/netfilter/ipvs/Kconfig
> +++ b/net/netfilter/ipvs/Kconfig
> @@ -308,10 +308,10 @@ config IP_VS_MH_TAB_INDEX
>  	  stored in a hash table. This table is assigned by a preference
>  	  list of the positions to each destination until all slots in
>  	  the table are filled. The index determines the prime for size of
> -	  the table as 251, 509, 1021, 2039, 4093, 8191, 16381, 32749,
> -	  65521 or 131071. When using weights to allow destinations to
> -	  receive more connections, the table is assigned an amount
> -	  proportional to the weights specified. The table needs to be large
> +	  the table as 251, 509, 1021, 2039, 4093, 8191, 16381, 32749,
> +	  65521 or 131071. When using weights to allow destinations to
> +	  receive more connections, the table is assigned an amount
> +	  proportional to the weights specified. The table needs to be large
>  	  enough to effectively fit all the destinations multiplied by their
>  	  respective weights.
>  
> -- 
> 1.8.3.1
> 
