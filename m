Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0CE4EEA38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbiDAJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiDAJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:18:10 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002181CABC0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:16:20 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220401091618epoutp049e1b6c54d03631f4da8e6022e55cca6d~huwczhbnV2454024540epoutp04e
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:16:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220401091618epoutp049e1b6c54d03631f4da8e6022e55cca6d~huwczhbnV2454024540epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648804578;
        bh=cGJepxz4cnstkBJIo6/P4jwwK3qA32Md6z1NYGJE1YA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=fJ8oHR5X6p7ctSPK6cYpdWKADZkdkCCc1yNH3tBCUxc0miPJ69aAMKGCZLV3lh4z1
         N54mrjrlruLQWlDtdqVGbASDGPaNLKntLkjOLl0+i4Wso7BJE9xYjXzVylxgREbWDv
         Nhzp3zGRVG+VxaY9MIB//XTKYPDkA5vZtDTVu8Gw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220401091617epcas2p20f5f28caf4027e56df85ca212a0e681c~huwcWwKeY0444904449epcas2p2-;
        Fri,  1 Apr 2022 09:16:17 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KVF0G6Fp0z4x9Q7; Fri,  1 Apr
        2022 09:16:14 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.28.33036.ED2C6426; Fri,  1 Apr 2022 18:16:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220401091614epcas2p16a5e0585aa821d448dd8f2609c51bffd~huwZbp9_R2667326673epcas2p1x;
        Fri,  1 Apr 2022 09:16:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220401091614epsmtrp2a4d0c38cdba198365f5154ec19817213~huwZamjXn2251322513epsmtrp2a;
        Fri,  1 Apr 2022 09:16:14 +0000 (GMT)
X-AuditID: b6c32a48-511ff7000000810c-15-6246c2de0062
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.CD.03370.ED2C6426; Fri,  1 Apr 2022 18:16:14 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220401091614epsmtip21f4171f3b2d644951d46ed35cc5e2952~huwZQzi1C1759617596epsmtip2U;
        Fri,  1 Apr 2022 09:16:14 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220401085050.119323-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] scsi: ufs: ufshcd-pltfrm: simplify usages of pdev->dev
Date:   Fri, 1 Apr 2022 18:16:14 +0900
Message-ID: <01e401d845a9$22e481e0$68ad85a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIQxNM3mfj57f4Z1qObDZeWls2QCQI208enrFgRaYA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhe69Q25JBl8bDS0ezNvGZvHy51U2
        i0U3tjFZ7H29ld3i8q45bBbd13ewWSw//o/Jgd3jzrU9bB4TFh1g9Pj49BaLR9+WVYwenzfJ
        ebQf6GYKYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVo
        YGBkClSYkJ0x491H1oKJghUrW5ewNTA28XUxcnJICJhIXOicytbFyMUhJLCDUWLa39msEM4n
        RonddyZBOZ8ZJb7/XcMC0/J8zT92iMQuRomr7z4zQTgvGCU+T7nFCFLFJqAv8bJjG1i7iMAO
        JolJ3+cAJTg4OAVcJebvdASpERbwlth8uhNsKouAisTadauYQGxeAUuJza/3skPYghInZz4B
        q2EWkJfY/nYOM8QVChI/ny5jBbFFBKwkpry7xwpRIyIxu7ONGWSvhMBMDolT87YwgeyVEHCR
        eDBLBKJXWOLV8S3sELaUxOd3e9kg7GKJpbM+MUH0NjBKXN72CyphLDHrWTvY/cwCmhLrd+lD
        jFSWOHIL6jQ+iY7Df9khwrwSHW1CEI3qEge2T4eGm6xE95zPrBC2h8T3I/dYJzAqzkLy5Cwk
        T85C8swshL0LGFlWMYqlFhTnpqcWGxWYwCM7OT93EyM4mWp57GCc/faD3iFGJg7GQ4wSHMxK
        IrxXY12ThHhTEiurUovy44tKc1KLDzGaAoN9IrOUaHI+MJ3nlcQbmlgamJiZGZobmRqYK4nz
        eqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgqmI+YjAjqHTRww0vKoXeerr8P+p4g3GFQdWMWcIv
        PArclykmZcXw+D9L4H3F+nihmtTRaYuzTNqj9adsdr3Ektb1YEHX63+XOvPaqqf/0JV/u23/
        0/qcIvfObyfPT3oR/8opLs2xkScxtGDa3BbvT0w6pybphip+rtg4+3jEVOXFJ1dOOHjcWPbr
        wjWHJVP4zZozcxjXJsXJP9CZ5mygp7Vsz/OU1t/ioeppK+u5eu+e7nrpKjojxMyo4VPmupSY
        umkHd/Evu3vd0OLRtLU2XZ5+V/9dEmiZP+PnbIeo3VfyJ+vvMY2R+5jhL5W8oPilRNXvH9WV
        Nb8yPaW4r/rOZP/Goaer8P72wY9KBYUHlViKMxINtZiLihMBRG3XTy8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvO69Q25JBt+a5CwezNvGZvHy51U2
        i0U3tjFZ7H29ld3i8q45bBbd13ewWSw//o/Jgd3jzrU9bB4TFh1g9Pj49BaLR9+WVYwenzfJ
        ebQf6GYKYIvisklJzcksSy3St0vgypjx7iNrwUTBipWtS9gaGJv4uhg5OSQETCSer/nH3sXI
        xSEksINRYsbZHlaIhKzEs3c72CFsYYn7LUfA4kICzxglZr8vA7HZBPQlXnZsYwVpFhHYwyTR
        fOU/I8SkaYwSh37sAXI4ODgFXCXm73QEaRAW8JbYfLqTBcRmEVCRWLtuFROIzStgKbH59V52
        CFtQ4uTMJywgrcwCehJtGxlBwswC8hLb385hhrhHQeLn02Vg94gIWElMeXePFaJGRGJ2Zxvz
        BEahWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOHi2t
        HYx7Vn3QO8TIxMF4iFGCg1lJhPdqrGuSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTS
        E0tSs1NTC1KLYLJMHJxSDUxe2TPcJQJfchxxfMBYWqWW8mCFmGu/9elD9hJPqydrp62YzSB5
        1mjaJP2qy4dPbH33dp9fibRyXILiIlm7+Lu//0nMiUw4kV+u32n545vXKtWp2kout3mPn3RL
        /OtmY+x6hvtI/0uZjVYXk7gWP1iXn7tKKoL/Mt8k3bbMeYw3n5rV/zhdozyP5cXlFEuZa5oR
        M3P+Kay2UN1wffLOBfNML1ud4IoKWXr+29yzJlGLfKZmvejsvJTWs7tDJe6cs9uqjA7rTzvv
        rH1QUrxALNCI787c79m7Jly8WrrMoHvGvyMJdV8OdbNoVys81ZqfdW96X7CP7eXHrV+ajz7v
        CLlYdyY+5fHGXSufT7DR489QYinOSDTUYi4qTgQAj1EPWQ0DAAA=
X-CMS-MailID: 20220401091614epcas2p16a5e0585aa821d448dd8f2609c51bffd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220401085104epcas2p4a13c6ec6b67da7cf7a165b92e811a545
References: <CGME20220401085104epcas2p4a13c6ec6b67da7cf7a165b92e811a545@epcas2p4.samsung.com>
        <20220401085050.119323-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, April 1, 2022 5:51 PM
> To: Alim Akhtar <alim.akhtar@samsung.com>; Avri Altman
> <avri.altman@wdc.com>; James E.J. Bottomley <jejb@linux.ibm.com>; Martin
K.
> Petersen <martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] scsi: ufs: ufshcd-pltfrm: simplify usages of pdev->dev
> 
> The 'struct device' pointer is already cached as local variable in
> ufshcd_pltfrm_init(), so use it.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/scsi/ufs/ufshcd-pltfrm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-
> pltfrm.c
> index 87975d1a21c8..cca4b2181a81 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -341,7 +341,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
> 
>  	err = ufshcd_alloc_host(dev, &hba);
>  	if (err) {
> -		dev_err(&pdev->dev, "Allocation failed\n");
> +		dev_err(dev, "Allocation failed\n");
>  		goto out;
>  	}
> 
> @@ -349,13 +349,13 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
> 
>  	err = ufshcd_parse_clock_info(hba);
>  	if (err) {
> -		dev_err(&pdev->dev, "%s: clock parse failed %d\n",
> +		dev_err(dev, "%s: clock parse failed %d\n",
>  				__func__, err);
>  		goto dealloc_host;
>  	}
>  	err = ufshcd_parse_regulator_info(hba);
>  	if (err) {
> -		dev_err(&pdev->dev, "%s: regulator init failed %d\n",
> +		dev_err(dev, "%s: regulator init failed %d\n",
>  				__func__, err);
>  		goto dealloc_host;
>  	}
> @@ -368,8 +368,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>  		goto dealloc_host;
>  	}
> 
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> 
>  	return 0;
> 
> --
> 2.32.0


