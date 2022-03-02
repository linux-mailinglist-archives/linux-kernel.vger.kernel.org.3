Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E64CB01A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbiCBUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiCBUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:42:26 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD5BFD64CC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:41:42 -0800 (PST)
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id D826220B7178;
        Wed,  2 Mar 2022 12:41:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D826220B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646253702;
        bh=nGnrN6wZvEIMXigwO2qniJwHemfc6PMUGGJtDX7QpyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dAFrxi7X3t+esiOuFgK3Tzk+rFkAf/KzrW80FE0S6od4CLcVjt8fIFLXrWsqVIvoD
         1FwuoMUnCbXzzT5sFHrS8IJ06B3+EjMmsyLwJHJ+b4Lnqq+Bqmuti1kv7BnSdbpmY2
         nSpmnX/8MenODANPuc4P/GUOSnd/IBCfHGjKLm/g=
Message-ID: <cd7dbd13-724f-0783-51dc-bbd246fa7a13@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 12:41:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] arm64: Do not defer reserve_crashkernel() for
 platforms with no DMA memory zones
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1646242689-20744-1-git-send-email-vijayb@linux.microsoft.com>
 <CA+CK2bDbbx=8R=UthkMesWOST8eJMtOGJdfMRTFSwVmo0Vn0EA@mail.gmail.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <CA+CK2bDbbx=8R=UthkMesWOST8eJMtOGJdfMRTFSwVmo0Vn0EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pasha.

Catalin, Will,

I can generate a new version with suggested change from Pasha.  I'm fine 
if you modify.

Thanks,
Vijay


On 3/2/2022 10:15 AM, Pasha Tatashin wrote:
> Hi Vijay,
> 
> The patch looks good to me, just one nit below.
> 
>> -phys_addr_t arm64_dma_phys_limit __ro_after_init;
>> +#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
>> +phys_addr_t __ro_after_init arm64_dma_phys_limit;
>> +#else
>> +phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> 
> Since in this case arm64_dma_phys_limit is initialized during
> declaration, it would make sense to use const instead of
> __ro_after_init. Consider changing the above to this:
> const phys_addr_t arm64_dma_phys_limit = PHYS_MASK + 1;
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Thank you,
> Pasha
