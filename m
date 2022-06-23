Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC75571C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiFWEmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbiFWDsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:48:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58213D11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1593FB8204D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5122DC3411B;
        Thu, 23 Jun 2022 03:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655956081;
        bh=Wp4Jyu7Evu+xPN4gK+sTGNzC8Vqe46xBT6i45WSKSaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uv7/hRpz7LO+UHEy7KiMB1C3GNb3nXMx4+TY+EGpuKptgxA+XN2NtjJRfsdHoJni6
         Fi2wriVnTP2XOnUW+cumELFPRzJh6l+pwxH/W0zAm1tFTaW4GojzNoxKP4veQrwbBZ
         QSnPadCr6kYObITPuVp42vgkVHcvEP2ssCw/JBDdOrUzdizoSmi/IhinEueqYTEb7k
         rTEaakIfjT9+yMMuI9lo9x4dUY/Ju6GOozjRve08CHSHH0gTtKTl3FmViGmbgVLnrB
         cUHmAPzZAr0KxPQp2U4tmbBPQBApcQRhqJj+4LK5hXPSNSP+i+zjZdeeHlGPVNUS2n
         2pic+YiLEwieA==
Date:   Wed, 22 Jun 2022 22:47:55 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 1/4] memblock tests: add user-provided arguments to
 Makefile
Message-ID: <YrPia6frNDEyN41S@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
 <b7e8e89dbbd7acdf41d62f1528f02d1dc2283e4b.1655889641.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e8e89dbbd7acdf41d62f1528f02d1dc2283e4b.1655889641.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rebecca,

On Wed, Jun 22, 2022 at 04:29:06AM -0500, Rebecca Mckeever wrote:
>
> Subject: memblock tests: add user-provided arguments to Makefile

Please be more specific here, e.g. 

memblock tests: Makefile: add arguments to control verbosity

> Add VERBOSE and MEMBLOCK_DEBUG user-provided arguments. VERBOSE will
> enable verbose output from Memblock simulator. MEMBLOCK_DEBUG will enable
> memblock_dbg() messages.
> 
> Update the help message to include VERBOSE and MEMBLOCK_DEBUG. Update
> the README to include VERBOSE. The README does not include all available
> options and refers to the help message for the remaining options.
> Therefore, omit MEMBLOCK_DEBUG from README.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/Makefile                 |  4 ++++
>  tools/testing/memblock/README                   | 10 +++++++++-
>  tools/testing/memblock/scripts/Makefile.include | 10 ++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
> index a698e24b35e7..9fde49ad73bd 100644
> --- a/tools/testing/memblock/Makefile
> +++ b/tools/testing/memblock/Makefile
> @@ -45,6 +45,10 @@ help:
>  	@echo  '  clean		  - Remove generated files and symlinks in the directory'
>  	@echo  ''
>  	@echo  'Configuration:'
> +	@echo  '  make VERBOSE=1            - enable verbose output, which includes the'
> +	@echo  '                              names of functions being tested and the'
> +	@echo  '                              number of test cases passing'
> +	@echo  '  make MEMBLOCK_DEBUG=1     - enable memblock_dbg() messages'
>  	@echo  '  make NUMA=1               - simulate enabled NUMA'
>  	@echo  '  make MOVABLE_NODE=1       - override `movable_node_is_enabled`'
>  	@echo  '                              definition to simulate movable NUMA nodes'
> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> index ca6afcff013a..058146b528a5 100644
> --- a/tools/testing/memblock/README
> +++ b/tools/testing/memblock/README
> @@ -34,7 +34,15 @@ To run the tests, build the main target and run it:
>  $ make && ./main
>  
>  A successful run produces no output. It is also possible to override different
> -configuration parameters. For example, to simulate enabled NUMA, use:
> +configuration parameters. For example, to include verbose output, specify the
> +VERBOSE flag when building the main target:
> +
> +$ make VERBOSE=1
> +
> +This will print information about which functions are being tested and the
> +number of test cases that passed.
> +
> +To simulate enabled NUMA, use:
>  
>  $ make NUMA=1
>  
> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> index 641569ccb7b0..4401f79bed4c 100644
> --- a/tools/testing/memblock/scripts/Makefile.include
> +++ b/tools/testing/memblock/scripts/Makefile.include
> @@ -17,3 +17,13 @@ ifeq ($(32BIT_PHYS_ADDR_T), 1)
>  	CFLAGS += -m32 -U CONFIG_PHYS_ADDR_T_64BIT
>  	LDFLAGS += -m32
>  endif
> +
> +# Enable verbose testing output
> +ifeq ($(VERBOSE), 1)
> +	CFLAGS += -D VERBOSE
> +endif
> +
> +# Enable memblock_dbg() messages
> +ifeq ($(MEMBLOCK_DEBUG), 1)
> +	CFLAGS += -D MEMBLOCK_DEBUG
> +endif
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
