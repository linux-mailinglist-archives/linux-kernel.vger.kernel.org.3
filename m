Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36DE565974
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGDPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiGDPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:09:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4413CD8;
        Mon,  4 Jul 2022 08:07:48 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264BGm2N020004;
        Mon, 4 Jul 2022 17:07:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+zRfghuFRHUHo1b772Ta7sUSNim87Ohn59ycNpVDF3Y=;
 b=OJE2Hcx1Yf1MGdGbxDHtEj46lWjiwbZNDcF4O8WpWThvF2YLLptM9kAXbccpga/oN1ue
 qbAj1LCPYWior9IjrAnvDXnff/IshyBVka4ZuwdY9Ap4+uKJ4xbtk+tiHnGJLW7d+6ot
 Ku+6q6yZDkSb+dJ+f/WEHTiWypWgAKh6fyksml32JxTG8f2sIlWH81Vm/pWC+VDrg/bh
 TuF+YczgGA9nmg0bakkdEmM2OxPYwIbnUy688OmkQSslEmQR1tJIAGCX0VaUS+bNaIyQ
 ayNF75goPekUokqWJXmbrrBsN7jz/TfUXwfae0m0jUxBb72fD+EWJYToblFW+a4D6zzE Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h2cwhu4xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 17:07:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C44010002A;
        Mon,  4 Jul 2022 17:06:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 86927227895;
        Mon,  4 Jul 2022 17:06:57 +0200 (CEST)
Received: from [10.252.4.55] (10.75.127.44) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 4 Jul
 2022 17:06:56 +0200
Message-ID: <290a2840-a282-1e45-360f-348b827c60bf@foss.st.com>
Date:   Mon, 4 Jul 2022 17:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 2/2] remoteproc: support attach recovery after rproc
 crash
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20220701093702.265249-1-peng.fan@oss.nxp.com>
 <20220701093702.265249-3-peng.fan@oss.nxp.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220701093702.265249-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/22 11:37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do attach recovery after crash and trigger watchdog
> reboot. It does not need main processor to load image, or stop/start M4
> core.

I would suppress "M4 core" to be generic.

> 
> Introduce two functions: rproc_attach_recovery, rproc_firmware_recovery

rproc_boot_recovery

> for the two cases. Firmware recovery is as before, let main processor to

s/Firmware/Boot/ 

> help recovery, while attach recovery is recover itself withou help.

without

> To attach recovery, we only do detach and attach.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 62 +++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ed374c8bf14a..ef5b9310bc83 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_attach_recovery(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	ret = __rproc_detach(rproc);
> +	if (ret)
> +		return ret;
> +
> +	return __rproc_attach(rproc);
> +}
> +
> +static int rproc_boot_recovery(struct rproc *rproc)
> +{
> +	const struct firmware *firmware_p;
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	ret = rproc_stop(rproc, true);
> +	if (ret)
> +		return ret;
> +
> +	/* generate coredump */
> +	rproc->ops->coredump(rproc);
> +
> +	/* load firmware */
> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* boot the remote processor up again */
> +	ret = rproc_start(rproc, firmware_p);
> +
> +	release_firmware(firmware_p);
> +
> +	return ret;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  
>  	dev_err(dev, "recovering %s\n", rproc->name);
>  
> -	ret = rproc_stop(rproc, true);
> -	if (ret)
> -		goto unlock_mutex;
> -
> -	/* generate coredump */
> -	rproc->ops->coredump(rproc);
> -
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> -	}
> -
> -	/* boot the remote processor up again */
> -	ret = rproc_start(rproc, firmware_p);
> -
> -	release_firmware(firmware_p);
> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
> +		ret = rproc_attach_recovery(rproc);
> +	else
> +		ret = rproc_boot_recovery(rproc);

I tested the series on stm32mp1 with success.

With typo fixes:
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud

>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
