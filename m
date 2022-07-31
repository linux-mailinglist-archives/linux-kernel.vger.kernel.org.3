Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBB585DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 09:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiGaHEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGaHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 03:04:19 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46113E0B1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 00:04:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3CDD742597;
        Sun, 31 Jul 2022 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1659251056; bh=IHRQqvX4twQwqPyyYOZbP4kt2K6mlg9BVwDRMLK7idE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kpGae5qKMQ8jQ836i4GFOEXv9321qF54Mdf1/hPPsey/gfZM0qNEpm8yK8MC+9mRU
         zcxNy3m+rphB28lj2uvZy2KQO9BA1T/lYXDPaBLQRUds+Sp0hI3XdPhVhpOlls4yep
         Q0471BuhlzjbFLjArw44RQuII7h08wwf3qxNh36MXYIn87pYYmaCrGzSrvtpzUMED7
         Fg6VZW4L3hewS+y8Wu8GmSA1x4DtbBh/+6FdMUJtIDUIcnEXMljmddR78fxdVUYJSf
         9JZJrEEmtDMTN/akJuDxkPCsdN4+LGNXND7+HzOlzvUMbAg90ETJcAYwHmPf0bN3A1
         7FAk8iFisIKxw==
Message-ID: <ae7dea84-b438-f67f-c18b-d67507eb4b2a@marcan.st>
Date:   Sun, 31 Jul 2022 16:04:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/5] iommu/io-pgtable-dart: Add DART PTE support for
 t6000
Content-Language: es-ES
To:     Robin Murphy <robin.murphy@arm.com>, Janne Grunau <j@jannau.net>,
        iommu@lists.linux-foundation.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220621071848.14834-1-j@jannau.net>
 <20220621071848.14834-5-j@jannau.net>
 <2df8c1d1-fb83-5b92-d32a-6b8ba988844c@arm.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <2df8c1d1-fb83-5b92-d32a-6b8ba988844c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 00.13, Robin Murphy wrote:
> On 2022-06-21 08:18, Janne Grunau wrote:
>> From: Sven Peter <sven@svenpeter.dev>
>>
>> The DARTs present in the M1 Pro/Max/Ultra SoC use a diffent PTE format.
>> They support a 42bit physical address space by shifting the paddr and
>> extending its mask inside the PTE.
>> They also come with mandatory sub-page protection now which we just
>> configure to always allow access to the entire page. This feature is
>> already present but optional on the previous DARTs which allows to
>> unconditionally configure it.
>>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> Co-developed-by: Janne Grunau <j@jannau.net>
>> Signed-off-by: Janne Grunau <j@jannau.net>
>>
>> ---
>>
>> Changes in v3:
>> - apply change to io-pgtable-dart.c
>> - handle pte <> paddr conversion based on the pte format instead of
>>    the output address size
>>
>> Changes in v2:
>> - add APPLE_DART2 PTE format
>>
>>   drivers/iommu/io-pgtable-dart.c | 51 +++++++++++++++++++++++++++------
>>   drivers/iommu/io-pgtable.c      |  1 +
>>   include/linux/io-pgtable.h      |  1 +
>>   3 files changed, 45 insertions(+), 8 deletions(-)
>>
> [...]
>> @@ -536,7 +571,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>>   	if (!cfg->coherent_walk)
>>   		return NULL;
>>   
>> -	if (cfg->oas > 36)
>> +	if (cfg->oas != 36 && cfg->oas != 42)
>>   		return NULL;
> 
> Wouldn't it make sense to tie this to the format? Maybe 36-bit OAS is 
> still valid with v2, but presumably 42-bit with v1 definitely isn't.

FWIW, 36-bit OAS with v2 is valid (this is the case on M2/t8112).

- Hector
