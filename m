Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5F4B5A16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiBNSmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:42:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBNSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:42:13 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5576734E;
        Mon, 14 Feb 2022 10:41:58 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EFbae7002001;
        Mon, 14 Feb 2022 19:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=KGz2678pGQbIbcVEydZQMC3hC9P2ytNR+Hdz3Z+2McY=;
 b=s+2QXTxsdXXVHNmJusjAWCUcRA5/Pf/8M48NOyWKLzUEpKst0u80bF8101lORhKqbOb2
 afRQjXGiQBdLsYQmYc+zRrUwvQN2X+QgecGTB0TVGFzzs/CwqzQ+h7sanAAvHgXQz8bR
 A+mJLRvHSeJmBGdYdvDptL6b0k6SjfGuNpymlYgMK8pi2OKD/kDxXoVo2BQG0p0GFmM6
 +M+TGM5CfSS8dcef5knA8kfaQXlrsJ99gRv9QTfgJOEt5iTKy4v6imaqvxzLJFD8LD7v
 A4NxJapkr0JstTLptPflFtG7685ac3LSwQ0gvjSL42qQEYMle8F42+hpId/kblPx1MZ2 sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e7pj7j9yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 19:41:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B92D310002A;
        Mon, 14 Feb 2022 19:41:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC008231DE5;
        Mon, 14 Feb 2022 19:41:41 +0100 (CET)
Received: from [10.211.3.63] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 14 Feb
 2022 19:41:40 +0100
Message-ID: <67ddf940-6f87-d8cc-8dc6-29a39a022265@foss.st.com>
Date:   Mon, 14 Feb 2022 19:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] remoteproc: support self recovery after rproc crash
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Peng Fan <peng.fan@nxp.com>
References: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 1/26/22 09:51, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do self recovery after crash and trigger watchdog
> reboot. It does not need main processor to load image, stop/start M4
> core.


On stm32mp1 platform the remote processor watchdog generates an early interrupt
that could be used to detach and reattach before the reset of the remote processor.
I need to test race condition,but I suppose that this should works if the resource
table is not reinitialized by the remote processor firmware.

Another option for the stm32mp1 is that remoteproc manages the reset of the 
remote processor.
For instance this allows to save a core-dump before manually resetting the remote
processor.
But looks like this use case can be handled later, as mentioned below. 

> 
> This patch add a new flag to indicate whether the SoC has self recovery
> capability. And introduce two functions: rproc_self_recovery,
> rproc_assisted_recovery for the two cases. Assisted recovery is as
> before, let main processor to help recovery, while self recovery is
> recover itself withou help. To self recovery, we only do detach and
> attach.


> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Nothing change in V2.
>  Only move this patch out from
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
> 
>  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++++++--------
>  include/linux/remoteproc.h           |  2 +
>  2 files changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..4bd5544dab8f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_self_recovery(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	mutex_unlock(&rproc->lock);
> +	ret = rproc_detach(rproc);
> +	mutex_lock(&rproc->lock);
> +	if (ret)
> +		return ret;

Here we would want to perform a core dump and manually reset the
co-processor.
I suppose that a new rproc ops could be called here in a next step.

> +
> +	if (atomic_inc_return(&rproc->power) > 1)
> +		return 0;

Do you identify a use case that needs to test rproc->power to
skip the attach?
If yes could you add a comment to describe it?

> +	return rproc_attach(rproc);
> +}
> +
> +static int rproc_assisted_recovery(struct rproc *rproc)
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
> @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
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
> +	if (rproc->self_recovery)
> +		ret = rproc_self_recovery(rproc);

If some platforms have to manually reset the remote processor (without
reloading the firmware) the name could not be relevant...

Following comments are only suggestions that needs to be commented by maintainers

What about rproc_attach_recovery ?

> +	else
> +		ret = rproc_assisted_recovery(rproc);

and rproc_firmware_recovery ?


>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..b32ef46f8aa4 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -529,6 +529,7 @@ struct rproc_dump_segment {
>   * @elf_machine: firmware ELF machine
>   * @cdev: character device of the rproc
>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
> + * @self_recovery: flag to indicate if remoteproc support self recovery
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -568,6 +569,7 @@ struct rproc {
>  	u16 elf_machine;
>  	struct cdev cdev;
>  	bool cdev_put_on_release;
> +	bool self_recovery;

This bool seems needed because we have lost the previous state before crash. 
I wonder if a new rproc->state such as RPROC_REBOOT could avoid this boolean.


I will try to test you patch on stm32mp1 next week

Regards,
Arnaud

>  };
>  
>  /**
