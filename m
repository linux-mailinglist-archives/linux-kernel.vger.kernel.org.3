Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F25258CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359690AbiELX5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359688AbiELX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED25A59C;
        Thu, 12 May 2022 16:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35B46209D;
        Thu, 12 May 2022 23:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF4EC385B8;
        Thu, 12 May 2022 23:57:46 +0000 (UTC)
Message-ID: <b128ed0f-08f8-2742-e22c-20cc5870a61c@linux-m68k.org>
Date:   Fri, 13 May 2022 09:57:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] m68knommu: allow elf_fdpic loader to be selected
Content-Language: en-US
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org
References: <20220512230602.1408871-1-gerg@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20220512230602.1408871-1-gerg@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/5/22 09:06, Greg Ungerer wrote:
> The m68k architecture code is capable of supporting the binfmt_elf_fdpic
> loader, so allow it to be configured. It is restricted to nommu
> configurations at this time due to the MMU context structures/code not
> supporting everything elf_fdpic needs when MMU is enabled.
> 
> Link: https://lore.kernel.org/linux-m68k/20220428033319.239341-1-gerg@linux-m68k.org/
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>   fs/Kconfig.binfmt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> v2: remove superfluous surrounding "(" ")"

If no one has any objections I can carry this in the m68knommu
git tree with the rest of the series.

Regards
Greg


> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 21c6332fa785..fb325b3aa4b0 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>   config BINFMT_ELF_FDPIC
>   	bool "Kernel support for FDPIC ELF binaries"
>   	default y if !BINFMT_ELF
> -	depends on (ARM || (SUPERH && !MMU))
> +	depends on ARM || ((M68K || SUPERH) && !MMU)
>   	select ELFCORE
>   	help
>   	  ELF FDPIC binaries are based on ELF, but allow the individual load
