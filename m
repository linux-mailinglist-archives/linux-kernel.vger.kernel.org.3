Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866594C7795
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiB1SYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbiB1SYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:24:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23F79C4D;
        Mon, 28 Feb 2022 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646071480; x=1677607480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PhTJdotKJ2wTOUcIThvtagW0Hjoxa9a1PK57pi8jxnU=;
  b=S+J5RBTdpwt3DsUiX/Rxysm2t6/Ha/sDhHIlv6H7T9/op/W6CgUz/E9J
   UV0Dw0LwrSIZd0NjF0FEz0XSJbS76DG+4/7MnP62opSRg8k2r8P8Jqtlk
   HLJq0EwMK2OgzlyjcrKRhcmjqqHRGiCI2JXinksRn9ZrfsdeZDxAGQLJV
   MbWo2uwN0ENowBxDo7u+59wUER+L7+o9GmV2czCvsO92934yeDWsfulWD
   5GRI3+N3U+hj5gTlyQM1fSi6pXaw1/tQb38mAUoCoyM1gPq9UdTj0rbi8
   CKLRgGt7TKRwwezR1qTAuaBB0iB8kdCqUcA3tx4fXD/fCTDa4DNeXa4XQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232919519"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="232919519"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:04:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="510184837"
Received: from ensymall-mobl.amr.corp.intel.com (HELO [10.212.116.28]) ([10.212.116.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:04:35 -0800
Message-ID: <28a7aa9b-8322-54df-1cfa-275805e2b044@linux.intel.com>
Date:   Mon, 28 Feb 2022 12:01:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] soundwire: qcom: add in-band wake up interrupt
 support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220228172528.3489-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -1424,6 +1464,11 @@ static int swrm_runtime_resume(struct device *dev)
>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (ctrl->wake_irq > 0) {
> +		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
> +			disable_irq_nosync(ctrl->wake_irq);
> +	}
> +
>  	clk_prepare_enable(ctrl->hclk);

This one is quite interesting. If you disable the IRQ mechanism but
haven't yet resumed the clock, that leaves a time window where the
peripheral could attempt to drive the line high. what happens in that case?

>  
>  	if (ctrl->clock_stop_not_supported) {
> @@ -1491,6 +1536,11 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>  
>  	usleep_range(300, 305);
>  
> +	if (ctrl->wake_irq > 0) {
> +		if (irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
> +			enable_irq(ctrl->wake_irq);
> +	}
> +

and this one is similar, you could have a case where the peripheral
signals a wake immediately after the ClockStopNow frame, but you may not
yet have enabled the wake detection interrupt.

Would that imply that the wake is missed?



>  	return 0;
>  }
>  
