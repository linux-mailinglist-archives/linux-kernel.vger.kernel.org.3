Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA7481AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhL3IfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:35:02 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:38798 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhL3IfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:35:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211230083459epoutp02ff351ac40116014747b08566299afd4c~Fe2Hn60Tm3130031300epoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 08:34:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211230083459epoutp02ff351ac40116014747b08566299afd4c~Fe2Hn60Tm3130031300epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640853299;
        bh=LnnbCn1ikfbcquXeoSQU5csy8RCFh3bknsY3HDm1HxQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PFapUeP6UjKXjmlF6AMzhBpSfw3137yDDEsEjXPuIAccppsULHLarnhRaDzV+RRzR
         U8JqBy3KkCaYUXHrThIRD+2pwlG5wxkcOVdYilI0gkw5p06O9l35Eg/gGR7d0s1kEL
         B6rbZ49J7vqfK8q3DCc8v34uiaqQYifI2gQXMODc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211230083459epcas1p1040e12a2ad28ed493b025415f9c55f3d~Fe2HVILdL0853208532epcas1p1H;
        Thu, 30 Dec 2021 08:34:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.235]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JPhR22SgDz4x9Pq; Thu, 30 Dec
        2021 08:34:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.4B.08277.82F6DC16; Thu, 30 Dec 2021 17:34:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211230083447epcas1p329fef5fa40608c616910c9e57a11785f~Fe18mNXhm1066210662epcas1p3X;
        Thu, 30 Dec 2021 08:34:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211230083447epsmtrp18ad6729217873b68b2311c7215292299~Fe18lWzNw2434724347epsmtrp1P;
        Thu, 30 Dec 2021 08:34:47 +0000 (GMT)
X-AuditID: b6c32a36-1edff70000002055-a8-61cd6f288921
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.03.29871.72F6DC16; Thu, 30 Dec 2021 17:34:47 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211230083447epsmtip2e5dc1fb27105b70d2c093108d6e89f45~Fe18aGYep0113401134epsmtip26;
        Thu, 30 Dec 2021 08:34:47 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
To:     Wen Zhiwei <wenzhiwei@kylinos.cn>, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <beeb83e9-415c-cf36-9cec-f9bc277442ed@samsung.com>
Date:   Thu, 30 Dec 2021 17:35:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211229023814.53372-1-wenzhiwei@kylinos.cn>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTQFcj/2yiwYJV7BaXd81hszjyv5/R
        4u69EywWx9eGW+y/fInZgdVjS+s/Zo871/awefT/NfD4vEkugCUq2yYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj9tf/zAV72Su2Lupja2Cc
        ydbFyMkhIWAi0bnoLTOILSSwg1Hi+OToLkYuIPsTo8TensmsEM43Rok/r1ayw3T0vDzDCJHY
        yyix58luKOc9o8TiCQtZQaqEBRwlvvyeD9YhIhAu8W75TbA4s4C1xM8frWA2m4COxPZvx5m6
        GDk4eAXsJPb1V4GEWQRUJR5cXgTWKioQKXH/x3Iwm1dAUOLkzCcsIDangJXEzF8PmCBGikvc
        ejIfypaX2P52DjPIPRICX9klzi45wghxtYvE1g/TWCFsYYlXx7dAfSMl8bK/jR2iYRmjxJ3b
        f9kgnPWMEge2L4GGkrHE/qWTwS5lFtCUWL9LHyKsKLHz91xGiM18Eu++9rCClEgI8Ep0tAlB
        lKhIXHr9kglm190n/6Fu8JC4N2knywRGxVlIfpuF5J9ZSP6ZhbB4ASPLKkax1ILi3PTUYsMC
        I3hsJ+fnbmIEp0gtsx2Mk95+0DvEyMTBeIhRgoNZSYR33bQziUK8KYmVValF+fFFpTmpxYcY
        TYGhPZFZSjQ5H5ik80riDU0sDUzMjIxNLAzNDJXEeVdNO50oJJCeWJKanZpakFoE08fEwSnV
        wGT+f8fBIlehvbPlf9a53/urUZYfdE5vUfyEF53nnTZUln/WqXZlibBguzb7mtgDm6TOg5cr
        pi2Lqtgiff/44VTBI9vKv8ZF/sucO+Vf1ZrOV9wrbiXFFrSs1tY8EbAyoShpTu0PC8bFgjId
        e5vEeu00ztc2etv9PuYeu3UZq1nv1tnt39e9tZxmfjlyysk889Aa+dKrz7v4OR9IrVI345I8
        Gv1zqvQn2dfM+bfVnBvqzr43+//k8J8lZ2Xuz18UovK86USb/s2/yy6u3n3gTOfzXBd/Z43m
        RUt3eu5eUHVnXsCd78InUs9UOUXvX1f7v1Wxu+6cbX7W4geZBw2zVUKlhHdJ/Crpvh4Ty5w/
        rVeJpTgj0VCLuag4EQC33hv4GgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvK56/tlEg8V9uhaXd81hszjyv5/R
        4u69EywWx9eGW+y/fInZgdVjS+s/Zo871/awefT/NfD4vEkugCWKyyYlNSezLLVI3y6BK2P2
        1//MBXvZK7Yu6mNrYJzJ1sXIySEhYCLR8/IMYxcjF4eQwG5GiWnflrNCJKQkPj+dClTEAWQL
        Sxw+XAxR85ZRYvfzE+wgNcICjhJffs8Hs0UEwiV27vwN1sssYC3x80crK0RDL6PE/l/HGUES
        bAI6Etu/HWcCGcorYCexr78KJMwioCrx4PIisDmiApES644vA7N5BQQlTs58wgJicwpYScz8
        9YAJYr66xJ95l5ghbHGJW0/mQ8XlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC4tz0
        3GLDAsO81HK94sTc4tK8dL3k/NxNjOCY0NLcwbh91Qe9Q4xMHIyHGCU4mJVEeNdNO5MoxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5Pme4Xr2nPkD/MI
        rJXg1pioMG2X971XzF8LODZ+P5NVoD7DT+++uNP8TTX6B7f7/sqykde9tkH3up1UwxFd0xUH
        zzxmfazvvVSusOK+ocHaLZusmVe2Mr8M+fvTs3vBVK1FGzJ1c43XP3b+mlXd3eOe7Z9/1W2m
        X1B/rsjTZsknjg65rYKSMRfP5OaI7tmyX++icZzXt/Vs0/2yf7ZpHxVzbkrcabS+V2lCXIBz
        +RPhe4cqWtb/UFmbxjz5wJGdvAkh5o/7tvx6tZpNa++/dfznW5d2p72fLpK6eOafLeuLbHdq
        HYn1Zgvtc047EHamuW9Pm//X4Cylvbp2j+tLN/53DTu+65vEHYuIK9eEHiixFGckGmoxFxUn
        AgBnxjz6+AIAAA==
X-CMS-MailID: 20211230083447epcas1p329fef5fa40608c616910c9e57a11785f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211229023827epcas1p1c62596be323776d0abad266224c299e0
References: <CGME20211229023827epcas1p1c62596be323776d0abad266224c299e0@epcas1p1.samsung.com>
        <20211229023814.53372-1-wenzhiwei@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 11:38 AM, Wen Zhiwei wrote:
> we previously assumed 'host->slot' could be null,
> null pointer judgment should be added
> 
> Signed-off-by: Wen Zhiwei <wenzhiwei@kylinos.cn>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Beset Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d977f34f6b55..c9dc8c168efb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3518,7 +3518,7 @@ int dw_mci_runtime_resume(struct device *dev)
>  	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>  
>  
> -	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> +	if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>  		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
>  
>  	/* Force setup bus to guarantee available clock output */
> 

