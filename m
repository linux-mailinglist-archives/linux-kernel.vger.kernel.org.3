Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2C4C7010
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiB1OwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiB1OwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:52:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C278C8092A;
        Mon, 28 Feb 2022 06:51:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBBFD6E;
        Mon, 28 Feb 2022 06:51:28 -0800 (PST)
Received: from [10.57.20.141] (unknown [10.57.20.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DEBF3F73D;
        Mon, 28 Feb 2022 06:51:26 -0800 (PST)
Message-ID: <861dd6e1-30dc-626e-3449-72d3b6822e7b@arm.com>
Date:   Mon, 28 Feb 2022 14:51:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] coresight: Defer probe when the child dev is not probed
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mao Jinlong <jinlmao@qti.qualcomm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220228133112.3987-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220228133112.3987-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinlong

On 28/02/2022 13:31, Mao Jinlong wrote:
> From: Mao Jinlong <jinlmao@qti.qualcomm.com>
> 
> It is possible that when device probe, its child device is not
> probed. Then it will fail when add sysfs connection for the device.
> Make device defer probe when the child device is not probed.

Please could you a bit a more specific on the exact issue ?
I don't see a problem with probe deferral right now, with
coresight/next.

For e.g.,

root@juno-server:~# lsmod
Module                  Size  Used by
coresight              73728  0
root@juno-server:~# ls /sys/bus/coresight/devices/
root@juno-server:~# modprobe coresight-etm4x
root@juno-server:~# lsmod
Module                  Size  Used by
coresight_etm4x        81920  0
coresight              73728  1 coresight_etm4x
root@juno-server:~# ls /sys/bus/coresight/devices/
etm0  etm1

-- Note etm2-etm5 doesn't appear --

root@juno-server:~# modprobe coresight-funnel
root@juno-server:~# lsmod
Module                  Size  Used by
coresight_funnel       20480  0
coresight_etm4x        81920  0
coresight              73728  2 coresight_etm4x,coresight_funnel
root@juno-server:~# ls /sys/bus/coresight/devices/
etm0  etm1

-- Still don't appear ---

root@juno-server:~# modprobe coresight-replicator
root@juno-server:~# ls /sys/bus/coresight/devices/
etm0  etm1
root@juno-server:~# modprobe coresight-tmc

-- At this stage, the devices automatically get probed and appear --
root@juno-server:~# ls /sys/bus/coresight/devices/
etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  tmc_etf0 
  tmc_etr0


root@juno-server:~# lsmod
Module                  Size  Used by
coresight_tmc          40960  0
coresight_replicator    20480  0
coresight_funnel       20480  0
coresight_etm4x        81920  0
coresight              73728  4 
coresight_tmc,coresight_etm4x,coresight_replicator,coresight_funnel

So, my question is, what is this patch trying to solve ?


Cheers
Suzuki

> 
> Signed-off-by: Mao Jinlong <jinlmao@qti.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-sysfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 34d2a2d31d00..7df9eb59bf2c 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -73,8 +73,10 @@ int coresight_add_sysfs_link(struct coresight_sysfs_link *info)
>   	if (!info->orig || !info->target ||
>   	    !info->orig_name || !info->target_name)
>   		return -EINVAL;
> -	if (!info->orig->has_conns_grp || !info->target->has_conns_grp)
> +	if (!info->orig->has_conns_grp)
>   		return -EINVAL;
> +	if (!info->target->has_conns_grp)
> +		return -EPROBE_DEFER;
>   
>   	/* first link orig->target */
>   	ret = sysfs_add_link_to_group(&info->orig->dev.kobj,

