Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8544D4F58
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiCJQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbiCJQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:33:49 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D9B4587;
        Thu, 10 Mar 2022 08:32:46 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AGEo0P026874;
        Thu, 10 Mar 2022 17:32:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=QOUPb/MXDpAhDlvBmQeOiY48BmrgZ+iOxXTy3hwTuKk=;
 b=ilAVPNarl8JUDS3F88iBufFFGv6LPPSul+Vi43t7WQcYIXix1rg45qJRoXE4qICCXi40
 ZZSirC+lq0LMRs0Ec9qo+NssxoY2EzBHsAeRWpmNd+hy+51tY+M4ZekemncpPWCFlpWx
 htvLVr4a3v8pzN6sj5knrn18NK8fJ0sDjcxWfh6eDam2lmQOvQIVZlWs9YaPM880zY5r
 1Up3uxzjzn/t4i9PIWvXi/afI1cgu4oxSdRn/7Pdq4bEbruTB0u9Dh1G+g13njGdRWb3
 epRrfUKUL5+tO78xNUO5cyZpHpiLsmlYuG9tNCuHy94kLGSnV89vOWl6FRt2/qfhB761 UQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3embmh7mun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 17:32:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 98C2E100038;
        Thu, 10 Mar 2022 17:32:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91A8C232FEF;
        Thu, 10 Mar 2022 17:32:33 +0100 (CET)
Received: from [10.201.23.19] (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Mar
 2022 17:32:32 +0100
Subject: Re: [PATCH v3] media: st-delta: Fix PM disable depth imbalance in
 delta_probe
To:     Miaoqian Lin <linmq006@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <2a3b4095-7b63-4da5-d0fa-43ba86715504@xs4all.nl>
 <20220307080859.14475-1-linmq006@gmail.com>
From:   Hugues FRUCHET - FOSS <hugues.fruchet@foss.st.com>
Message-ID: <9d543059-2a3b-e5b2-59f2-30819d49b74b@foss.st.com>
Date:   Thu, 10 Mar 2022 17:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220307080859.14475-1-linmq006@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian Lin,

Thanks for the patch !

Acked-by: Hugues Fruchet <hugues.fruchet@foss.st.com>

BR,
Hugues.

On 3/7/22 9:08 AM, Miaoqian Lin wrote:
> The pm_runtime_enable will decrease power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> 
> Fixes: f386509 ("[media] st-delta: STiH4xx multi-format video decoder v4l2 driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - remove unused label.
> changes in v3:
> - add err_pm_disable label and update related 'goto err'.
> - update commit message
> ---
>   drivers/media/platform/sti/delta/delta-v4l2.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
> index c887a31ebb54..420ad4d8df5d 100644
> --- a/drivers/media/platform/sti/delta/delta-v4l2.c
> +++ b/drivers/media/platform/sti/delta/delta-v4l2.c
> @@ -1859,7 +1859,7 @@ static int delta_probe(struct platform_device *pdev)
>   	if (ret) {
>   		dev_err(delta->dev, "%s failed to initialize firmware ipc channel\n",
>   			DELTA_PREFIX);
> -		goto err;
> +		goto err_pm_disable;
>   	}
>   
>   	/* register all available decoders */
> @@ -1873,7 +1873,7 @@ static int delta_probe(struct platform_device *pdev)
>   	if (ret) {
>   		dev_err(delta->dev, "%s failed to register V4L2 device\n",
>   			DELTA_PREFIX);
> -		goto err;
> +		goto err_pm_disable;
>   	}
>   
>   	delta->work_queue = create_workqueue(DELTA_NAME);
> @@ -1898,6 +1898,8 @@ static int delta_probe(struct platform_device *pdev)
>   	destroy_workqueue(delta->work_queue);
>   err_v4l2:
>   	v4l2_device_unregister(&delta->v4l2_dev);
> +err_pm_disable:
> +	pm_runtime_disable(dev);
>   err:
>   	return ret;
>   }
> 
