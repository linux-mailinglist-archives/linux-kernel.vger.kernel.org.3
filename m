Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49452C46E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiERUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiERUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:30:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A371E319;
        Wed, 18 May 2022 13:30:50 -0700 (PDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2B88B20ECB86;
        Wed, 18 May 2022 13:30:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B88B20ECB86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652905850;
        bh=8k/Z9Q7iTR6kKI9udfgvXsP0KxNS8bW1JB5O3rM+Sto=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=byjirW5nho09sxKL6P88ax1uBV0kNKXenC+osQyUvxXod4gmeMaAOnELHP4IoLd8W
         EHCAwMQ4wUxitdy5dulrOiKQszIGSUXPdr7reU82Py1L/IQQ2Lst6+il/D9d/3ND6A
         NMTXUyzqq9i+3lYWTHanpB/CSgawN7xlG5ydCYOo=
Message-ID: <83e757fe-5269-693b-ee8c-c5186ea5fcdd@linux.microsoft.com>
Date:   Wed, 18 May 2022 13:30:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] powerpc: check previous kernel's ima-kexec-buffer against
 memory bounds
Content-Language: en-US
To:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, nramas@linux.microsoft.com
References: <20220518200547.655788-1-vaibhav@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <20220518200547.655788-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaibhav,

On 5/18/2022 1:05 PM, Vaibhav Jain wrote:
> Presently ima_get_kexec_buffer() doesn't check if the previous kernel's
> ima-kexec-buffer lies outside the addressable memory range. This can result
> in a kernel panic if the new kernel is booted with 'mem=X' arg and the
> ima-kexec-buffer was allocated beyond that range by the previous kernel.

Thanks for providing this patch.

> Fix this issue by checking returned address/size of previous kernel's
> ima-kexec-buffer against memblock's memory bounds.
> 
> Fixes: fee3ff99bc67("powerpc: Move arch independent ima kexec functions to
> drivers/of/kexec.c")
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>   drivers/of/kexec.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index b9bd1cff1793..c73007eda52d 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -140,6 +140,13 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
>   	if (ret)
>   		return ret;
>   
> +	/* if the ima-kexec-buffer goes beyond the addressable memory */
> +	if (!memblock_is_region_memory(tmp_addr, tmp_size)) {
> +		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
> +			tmp_addr, tmp_size);
> +		return -EINVAL;
> +	}
> +
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

>   	*addr = __va(tmp_addr);
>   	*size = tmp_size;
>   
