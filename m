Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F814CA225
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiCBK2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiCBK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:28:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2C91FD1A;
        Wed,  2 Mar 2022 02:27:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC850139F;
        Wed,  2 Mar 2022 02:27:31 -0800 (PST)
Received: from [10.57.21.40] (unknown [10.57.21.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B488C3F70D;
        Wed,  2 Mar 2022 02:27:29 -0800 (PST)
Message-ID: <5529d0f7-e81f-4def-0d34-eb3f1801cc45@arm.com>
Date:   Wed, 2 Mar 2022 10:27:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] coresight: core: Fix coresight device probe failure issue
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220302080132.20946-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220302080132.20946-1-quic_jinlmao@quicinc.com>
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

On 02/03/2022 08:01, Mao Jinlong wrote:
> It is possibe that probe failure issue happens when the device
> and its child_device's probe happens at the same time.
> In coresight_make_links, has_conns_grp is true for parent, but
> has_conns_grp is false for child device as has_conns_grp is set
> to true in coresight_create_conns_sysfs_group. The probe of parent
> device will fail at this condition. Add has_conns_grp check for
> child device before make the links and make the process from
> device_register to connection_create be atomic to avoid this
> probe failure issue.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 88653d1c06a4..7ce78dddfe31 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1382,7 +1382,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
>   			continue;
>   		conn->child_dev =
>   			coresight_find_csdev_by_fwnode(conn->child_fwnode);
> -		if (conn->child_dev) {
> +		if (conn->child_dev && conn->child_dev->has_conns_grp) {
>   			ret = coresight_make_links(csdev, conn,
>   						   conn->child_dev);
>   			if (ret)
> @@ -1619,6 +1619,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>   	dev_set_name(&csdev->dev, "%s", desc->name);
>   
> +	mutex_lock(&coresight_mutex);
>   	ret = device_register(&csdev->dev);
>   	if (ret) {
>   		put_device(&csdev->dev);
> @@ -1645,8 +1646,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   		}
>   	}
>   
> -	mutex_lock(&coresight_mutex);
> -
>   	ret = coresight_create_conns_sysfs_group(csdev);
>   	if (!ret)
>   		ret = coresight_fixup_device_conns(csdev);
> @@ -1666,6 +1665,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   err_free_csdev:
>   	kfree(csdev);
>   err_out:
> +	mutex_unlock(&coresight_mutex);

This appears to be wrong. We may do an unlock when we didn't lock it in
the first place.
Please could you double check. Also, I think it may be neater to move
the kfree(csdev) to the only user and return straight away from there.

Cheers
Suzuki




>   	/* Cleanup the connection information */
>   	coresight_release_platform_data(NULL, desc->pdata);
>   	return ERR_PTR(ret);

