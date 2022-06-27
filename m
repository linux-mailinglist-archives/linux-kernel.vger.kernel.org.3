Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE755D646
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiF0PNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiF0PNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:13:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A65C5175A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:13:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E8461758;
        Mon, 27 Jun 2022 08:13:26 -0700 (PDT)
Received: from [10.57.84.159] (unknown [10.57.84.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132823F5A1;
        Mon, 27 Jun 2022 08:13:23 -0700 (PDT)
Message-ID: <2df8c1d1-fb83-5b92-d32a-6b8ba988844c@arm.com>
Date:   Mon, 27 Jun 2022 16:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/5] iommu/io-pgtable-dart: Add DART PTE support for
 t6000
Content-Language: en-GB
To:     Janne Grunau <j@jannau.net>, iommu@lists.linux-foundation.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Hector Martin <marcan@marcan.st>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220621071848.14834-1-j@jannau.net>
 <20220621071848.14834-5-j@jannau.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220621071848.14834-5-j@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-21 08:18, Janne Grunau wrote:
> From: Sven Peter <sven@svenpeter.dev>
> 
> The DARTs present in the M1 Pro/Max/Ultra SoC use a diffent PTE format.
> They support a 42bit physical address space by shifting the paddr and
> extending its mask inside the PTE.
> They also come with mandatory sub-page protection now which we just
> configure to always allow access to the entire page. This feature is
> already present but optional on the previous DARTs which allows to
> unconditionally configure it.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> 
> Changes in v3:
> - apply change to io-pgtable-dart.c
> - handle pte <> paddr conversion based on the pte format instead of
>    the output address size
> 
> Changes in v2:
> - add APPLE_DART2 PTE format
> 
>   drivers/iommu/io-pgtable-dart.c | 51 +++++++++++++++++++++++++++------
>   drivers/iommu/io-pgtable.c      |  1 +
>   include/linux/io-pgtable.h      |  1 +
>   3 files changed, 45 insertions(+), 8 deletions(-)
> 
[...]
> @@ -536,7 +571,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   	if (!cfg->coherent_walk)
>   		return NULL;
>   
> -	if (cfg->oas > 36)
> +	if (cfg->oas != 36 && cfg->oas != 42)
>   		return NULL;

Wouldn't it make sense to tie this to the format? Maybe 36-bit OAS is 
still valid with v2, but presumably 42-bit with v1 definitely isn't.

Robin.
