Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F77500229
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiDMW5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiDMW5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:57:20 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD303B299;
        Wed, 13 Apr 2022 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649890497; x=1681426497;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m9Tzk5iuVsfm3l6Vm0LArjqnKY1ATrD/yP8P02JitlM=;
  b=A6FORCrhBrIgM9aJORJW1uv6Y+ortK+7QD1mFjJflG4/uhD7TCTfrzzc
   BoZvTnX074nhR7/m+sfplKUbyNv1AU7GJPwLjvUm6/qbBshtoUZ+dMmVc
   oSfb6boKA79Sh2/3NoPmt/TegE4YLB2jFZNwzoxe/bYaYOlkaTanAkLTI
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Apr 2022 15:54:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 15:54:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 15:54:56 -0700
Received: from [10.110.74.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 15:54:55 -0700
Message-ID: <d6ae3572-58db-5264-c26a-9f75de6292a7@quicinc.com>
Date:   Wed, 13 Apr 2022 15:54:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bus: mhi: host: Add soc_reset sysfs
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <jhugo@codeaurora.org>
References: <1649883619-17609-1-git-send-email-quic_jhugo@quicinc.com>
From:   Bhaumik Vasav Bhatt <quic_bbhatt@quicinc.com>
In-Reply-To: <1649883619-17609-1-git-send-email-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/2022 2:00 PM, Jeffrey Hugo wrote:
> From: Jeffrey Hugo <jhugo@codeaurora.org>
>
> The MHI bus supports a standardized hardware reset, which is known as the
> "SoC Reset".  This reset is similar to the reset sysfs for PCI devices -
> a hardware mechanism to reset the state back to square one.
>
> The MHI SoC Reset is described in the spec as a reset of last resort.  If
> some unrecoverable error has occurred where other resets have failed, SoC
> Reset is the "big hammer" that ungracefully resets the device.  This is
> effectivly the same as yanking the power on the device, and reapplying it.
> However, depending on the nature of the particular issue, the underlying
> transport link may remain active and configured.  If the link remains up,
> the device will flag a MHI system error early in the boot process after
> the reset is executed, which allows the MHI bus to process a fatal error
> event, and clean up appropiately.
>
> While the SoC Reset is generally intended as a means of recovery when all
> else has failed, it can be useful in non-error scenarios.  For example,
> if the device loads firmware from the host filesystem, the device may need
> to be fully rebooted inorder to pick up the new firmware.  In this
> scenario, the system administrator may use the soc_reset sysfs to cause
> the device to pick up the new firmware that the admin placed on the
> filesystem.
>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
Reviewed-by: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
> v2:
> Rebase
>
>   Documentation/ABI/stable/sysfs-bus-mhi | 11 +++++++++++
>   drivers/bus/mhi/host/init.c            | 14 ++++++++++++++
>   2 files changed, 25 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> index ecfe766..306f63e 100644
> --- a/Documentation/ABI/stable/sysfs-bus-mhi
> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> @@ -19,3 +19,14 @@ Description:	The file holds the OEM PK Hash value of the endpoint device
>   		read without having the device power on at least once, the file
>   		will read all 0's.
>   Users:		Any userspace application or clients interested in device info.
> +
> +What:           /sys/bus/mhi/devices/.../soc_reset
> +Date:           April 2022
> +KernelVersion:  5.19
> +Contact:        mhi@lists.linux.dev
> +Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
> +                a reset of last resort, and will require a complete re-init.
> +                This can be useful as a method of recovery if the device is
> +                non-responsive, or as a means of loading new firmware as a
> +                system administration task.
> +
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 04c409b..e12b210 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -108,9 +108,23 @@ static ssize_t oem_pk_hash_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(oem_pk_hash);
>   
> +static ssize_t soc_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf,
> +			       size_t count)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +
> +	mhi_soc_reset(mhi_cntrl);
> +	return count;
> +}
> +static DEVICE_ATTR_WO(soc_reset);
> +
>   static struct attribute *mhi_dev_attrs[] = {
>   	&dev_attr_serial_number.attr,
>   	&dev_attr_oem_pk_hash.attr,
> +	&dev_attr_soc_reset.attr,
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(mhi_dev);
