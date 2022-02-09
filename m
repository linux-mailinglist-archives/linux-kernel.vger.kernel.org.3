Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2812A4AE989
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiBIFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:49:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiBIFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:47:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4242E015279
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:47:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E5F5ED1;
        Tue,  8 Feb 2022 21:47:28 -0800 (PST)
Received: from [10.57.88.245] (unknown [10.57.88.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3133F718;
        Tue,  8 Feb 2022 21:47:26 -0800 (PST)
Message-ID: <6b91293a-1149-2c77-04a4-421a45d4e1e0@arm.com>
Date:   Wed, 9 Feb 2022 05:47:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 RESEND 1/4] coresight: etm4x: Add lock for reading
 virtual context ID comparator
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220204152403.71775-1-leo.yan@linaro.org>
 <20220204152403.71775-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220204152403.71775-2-leo.yan@linaro.org>
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

Hi Leo

On 04/02/2022 15:24, Leo Yan wrote:
> Updates to the values and the index are protected via the spinlock.
> Ensure we use the same lock to read the value safely.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 10ef2a29006e..2f3b4eef8261 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2111,7 +2111,9 @@ static ssize_t vmid_val_show(struct device *dev,
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etmv4_config *config = &drvdata->config;
>   
> +	spin_lock(&drvdata->spinlock);
>   	val = (unsigned long)config->vmid_val[config->vmid_idx];
> +	spin_unlock(&drvdata->spinlock);
>   	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>   }
>   


I have queued this patch. For the rest, we would need to wait
until the helper lands in the rc.

Suzuki
