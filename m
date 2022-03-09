Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B84D3375
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiCIQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiCIQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:08:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AB18CC77;
        Wed,  9 Mar 2022 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qzB5SkChcUpXXTILPYEoiZsWblCS3kRjEhEA4tvWFBA=; b=JjBfU4RcbAJyJTf1dScNeR/9Ho
        AlZkTmpj9SsK1oDq6UTB/AcWUopsbiSLBGR6rZ2kBCw7j4vNo2VJRBUq8/KFhsm1GawDk4dDcSTB0
        CAcF6dfoPaEs0Gfz8X8csw4+TvxgiPIlR30lPYJvaOwQCM8VvYdi8Wsr4XICpNu/Qaygh0PysniQO
        SyyGMm6lUhw5iTcltD/IOCdeqX++6/j+K96Pdx2bmwdewbe3c6YDhA7DoYvB3PWynCjiFTZ95BR6a
        cfwFLvgkagvPcfT8tRBkxAXjKWBSrNNRFeT2Lc3lff5pJIccLtnRTXiKaaapODICmEkZ+Gvc9/379
        brxt0HAQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRyoJ-00HGIW-9U; Wed, 09 Mar 2022 16:05:11 +0000
Message-ID: <faadb494-2ed9-f894-257d-9a70398a02b6@infradead.org>
Date:   Wed, 9 Mar 2022 08:05:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] docs/kernel-parameters: update description of mem=
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220309122446.1118738-1-rppt@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220309122446.1118738-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 3/9/22 04:24, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The existing description of mem= does not cover all the cases and
> differences between how architectures treat it.
> 
> Extend the description to match the code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> This is in a way a followup for the discussion of mem= usage on MIPS:
> 
> https://lore.kernel.org/all/1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn
> 
>  .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..f3597841a031 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2834,6 +2834,15 @@
>  			2 when the kernel is not able to see the whole system memory;
>  			3 memory that lies after 'mem=' boundary is excluded from
>  			 the hypervisor, then assigned to KVM guests.
> +			4 to limit the memory available for kdump kernel.
> +
> +			[ARC,MICROBLAZE] - the limit applies only to low memory,
> +			high memory is not affected.
> +
> +			[ARM64] - only limits memory covered by the linear
> +			mapping. The NOMAP regions are not affected.
> +
> +			[HEXAGON] - must be use to set the memory size, there is

Above line seems to be missing something?

Otherwise looks good AFAIK.

>  
>  			[X86] Work as limiting max address. Use together
>  			with memmap= to avoid physical address space collisions.
> @@ -2844,6 +2853,17 @@
>  			in above case 3, memory may need be hot added after boot
>  			if system memory of hypervisor is not sufficient.
>  
> +	mem=nn[KMG]@ss[KMG]
> +			[ARM,MIPS] - override the memory layout reported by
> +			firmware.
> +			Define a memory region of size nn[KMG] starting at
> +			ss[KMG].
> +			Multiple different regions can be specified with
> +			multiple mem= parameters on the command line.
> +
> +	mem=nn[KMG]	[HEXAGON] Set the memory size.
> +			Must be specified, otherwise memory size will be 0.
> +
>  	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
>  			memory.
>  

-- 
~Randy
