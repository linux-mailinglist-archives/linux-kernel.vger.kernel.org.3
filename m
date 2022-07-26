Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16061581A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiGZTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiGZTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:04:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AD326D0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AE7BB819C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF59C433D7;
        Tue, 26 Jul 2022 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658862293;
        bh=3IRGUYh3u9rTFLy437yI96MUoBiwVyifVYbC4EAueFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=knxiO1d/K2XnWqfeKTHFKkacRcOuCmkuRkwsLFnYoF+tp6nj7Vf/boYC0msdDI20G
         8JJWc8HJwzDB6RQoIOnDUsorcof7J7zu5sJmMg73ZYHfZNGuk5cvGYFZrE/NNsuovo
         o+4/spQmSkHnx3MQw4I1AtmwUsJeTNnT6/n9n/GLFCI34TqOqNDWLRIJnEMmPD3hmr
         +z8wLgkhhSJv92jWM9II1VF9ZZugf3YUajsDIh4IwfcvjgViosyT8vu7Z4Xl8fseR6
         zjX38CEN0iFT2yT9yhz5hmJ2R52tZa0/XNCdMWR7S1kEWj3MHs33tewVYQ4oIv0o5Y
         WUi5wf7CjZL7Q==
Date:   Tue, 26 Jul 2022 14:04:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH -next] x86/cyrix: include header linux/isa-dma.h
Message-ID: <20220726190450.GA81971@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725202224.29269-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:22:24PM -0700, Randy Dunlap wrote:
> x86/kernel/cpu/cyrix.c now needs to include <linux/isa-dma.h>
> since the 'isa_dma_bridge_buggy' variable was moved to it.
> 
> Fixes this build error:
> 
> ../arch/x86/kernel/cpu/cyrix.c: In function ‘init_cyrix’:
> ../arch/x86/kernel/cpu/cyrix.c:277:17: error: ‘isa_dma_bridge_buggy’ undeclared (first use in this function)
>   277 |                 isa_dma_bridge_buggy = 2;
> 
> Fixes: abb4970ac335 ("PCI: Move isa_dma_bridge_buggy out of asm/dma.h")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I appended this to my pci/header-cleanup-immutable branch for v5.20,
thanks!

> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/kernel/cpu/cyrix.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/x86/kernel/cpu/cyrix.c
> +++ b/arch/x86/kernel/cpu/cyrix.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/isa-dma.h>
>  #include <linux/pci.h>
>  #include <asm/dma.h>
>  #include <linux/io.h>
