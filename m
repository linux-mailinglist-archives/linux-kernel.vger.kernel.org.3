Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6354663B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbhLBMfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347054AbhLBMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:35:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C393C06174A;
        Thu,  2 Dec 2021 04:31:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i5so59310293wrb.2;
        Thu, 02 Dec 2021 04:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VL6H7ooUU5Oyl/vWveaQgsetp1c69O3kXNkklKAHmRU=;
        b=pMXR7XprybFGI0px8pCXcMmj+31bssCnMkTKMJO+G973hQdgt80HrjaRUubIqdByKw
         yj8EL4n7hC0nX8EYbsr7drdSMLBLeDUT+5DMEiZFuRDW3biTDqPWuOEmr96DkMo3zhLm
         XLKEzeXZ5MK90MJvT3JvcYGPUhSsZYCVR2ILZKuLCjCjOlHwUaAa19aTebpJmfEiwaGC
         xn/vPa5Jjf2ioIqpKid0z8ygwxdniiM04V0jItIPE2tLdoXH0rIY4t/PUziP8gUdw2oA
         qcSa30cODTdJktgY5Pcb+Ypldfyzt0vBxfAKXZVkuRfMhPy6ctg8tKBsZDTlDc4eTTJq
         gdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VL6H7ooUU5Oyl/vWveaQgsetp1c69O3kXNkklKAHmRU=;
        b=Kw5nRxgcYMimavpHk8ea5iTkyAdHHRQn9FkIlyvgkbaDx+JEyzGv7AeFR1jj1vVsRJ
         g9cn3Ru/AX08+ybGu9ZcVcTosbruvnkihWqB7fft7DR5k2ZSq5E8SzyLg4WAL3URe5no
         pet7ILUHTjThYMxPZe0Bs7ek14hzDeI1OIVoIocFqTT6zgpNBldj2ZxaJqor9CvCXwoF
         mWXAR1QsFAh1QnqmOPr6P0PzLcZ98TU/ndHUthG3k2MZ+FtuPIqOmYNWTRn4dx+5p9bq
         q/uv0ADC5oglGacQj0txkUetUMypoIMK97Pkw/hxiNAL7wkM6s1SmD2TvGfhIiaV+V85
         nAKg==
X-Gm-Message-State: AOAM530flaWpaW448JIVBJgyGJSjQW0jOlM/tZ4z430PwUO/kG/2e7by
        FtBCswUt1eDjO6be6jVDinscEgC0/XA=
X-Google-Smtp-Source: ABdhPJwLq2JDcu+FAQrpdmSuQqbNC2tKCWaqMxxbqPLrku9xkSLDMM9JbB7kr7w1O1RZ4YrRoPR+ug==
X-Received: by 2002:a05:6000:186e:: with SMTP id d14mr14440324wri.376.1638448308942;
        Thu, 02 Dec 2021 04:31:48 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id m1sm2041498wme.39.2021.12.02.04.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 04:31:48 -0800 (PST)
Subject: Re: [PATCH] media: ipu3: don't use recursion at the Kernel
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cf020b6a04b3a9d7f08750927b1d100f63ff4689.1638445455.git.mchehab+huawei@kernel.org>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <1a1437f7-89e9-73f5-a197-c2b7c9536846@gmail.com>
Date:   Thu, 2 Dec 2021 12:31:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cf020b6a04b3a9d7f08750927b1d100f63ff4689.1638445455.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro

On 02/12/2021 11:44, Mauro Carvalho Chehab wrote:
> The Kernel stack is too small. Doing recursions there is a very
> bad idea, as, if something gets wrong, it could lead to data
> corruption.


TIL - I'll bear that in mind in the future, thanks.

> So, re-implement cio2_check_fwnode_graph() to avoid
> recursion.
>
> Compile-tested only.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


FWIW:

Reviewed-by: Daniel Scally <djrscally@gmail.com>

Tested-by: Daniel Scally <djrscally@gmail.com>

> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
> index 356ea966cf8d..8e4f250a8b56 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
> @@ -1691,16 +1691,15 @@ static int cio2_check_fwnode_graph(struct fwnode_handle *fwnode)
>  {
>  	struct fwnode_handle *endpoint;
>  
> -	if (IS_ERR_OR_NULL(fwnode))
> -		return -EINVAL;
> -
> -	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
> -	if (endpoint) {
> -		fwnode_handle_put(endpoint);
> -		return 0;
> +	while (!IS_ERR_OR_NULL(fwnode)) {
> +		endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
> +		if (endpoint) {
> +			fwnode_handle_put(endpoint);
> +			return 0;
> +		}
> +		fwnode = fwnode->secondary;
>  	}
> -
> -	return cio2_check_fwnode_graph(fwnode->secondary);
> +	return -EINVAL;
>  }
>  
>  /**************** PCI interface ****************/
