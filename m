Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548E44C062B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiBWAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiBWAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:32:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187926563;
        Tue, 22 Feb 2022 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645576294; x=1677112294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9nLGmFa4SonpF2qf8NgANpNkiWR11udF8i0fGALAavU=;
  b=gfInyjZxWRp27tVE7gxbSkW3f9r+XAT+hhKnJ9C+sr3l8tB9eVWMjuNv
   fOgRWFcf6iTTvxcaLLmA7bPkgwsaK+TWQ6iOCZTB2zCXlIf8ehLhTtqtn
   lVUBCuNcf/TWJ3T9i+T3tvJhfPnL8KJ5G+irXMZzorl6p5ASJsnSbdlA8
   e09HIYuC6fdLPD47vNS0fV9jN0mY+GT86yKTGOXODBVPEPxWyhO5B9Jiu
   x/Eg46Obs7JoOVlifVdn5SmkUBuQV4BOoE0+vVPp/3MDtV6RCkKCdAnw8
   GoYXdeUOSyvNUS+d/ykrQhu8X9UNYxN4xMv7rT6cksUx+vk986mkIWhm5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315076994"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="315076994"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:31:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="639110296"
Received: from mjpatel-mobl.amr.corp.intel.com (HELO [10.212.37.223]) ([10.212.37.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:31:32 -0800
Message-ID: <49099bcb-35e9-0bea-9658-006caed3ab33@linux.intel.com>
Date:   Tue, 22 Feb 2022 18:31:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] soundwire: qcom: add wake up interrupt support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
 <5e050d4c-e3d2-35fb-ca49-7be53579bc31@linux.intel.com>
 <1cb4e02f-f040-23bd-44d0-0675429332bd@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1cb4e02f-f040-23bd-44d0-0675429332bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 16:52, Srinivas Kandagatla wrote:
> 
> 
> On 22/02/2022 19:26, Pierre-Louis Bossart wrote:
>>
>>
>>
>>> +static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>>> +{
>>> +    struct qcom_swrm_ctrl *swrm = dev_id;
>>> +    int ret = IRQ_HANDLED;
>>> +    struct sdw_slave *slave;
>>> +
>>> +    clk_prepare_enable(swrm->hclk);
>>> +
>>> +    if (swrm->wake_irq > 0) {
>>> +        if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
>>> +            disable_irq_nosync(swrm->wake_irq);
>>> +    }
>>> +
>>> +    /*
>>> +     * resume all the slaves which must have potentially generated this
>>> +     * interrupt, this should also wake the controller at the same
>>> time.
>>> +     * this is much safer than waking controller directly that will
>>> deadlock!
>>> +     */
>> There should be no difference if you first resume the controller and
>> then attached peripherals, or do a loop where you rely on the pm_runtime
>> framework.
>>
>> The notion that there might be a dead-lock is surprising, you would need
>> to elaborate here.Issue is, if wakeup interrupt resumes the controller
>> first which can 
> trigger an slave pending interrupt (ex: Button press event) in the
> middle of resume that will try to wake the slave device which in turn
> will try to wake parent in the middle of resume resulting in a dead lock.
> 
> This was the best way to avoid dead lock.

Not following, sorry. if you use pm_runtime functions and it so happens
that the resume already started, then those routines would wait for the
resume to complete.

In other words, there can be multiple requests to resume, but only the
*first* request will trigger a transition and others will just increase
a refcount.

In addition, the pm_runtime framework guarantees that the peripheral
device can only start resuming when the parent controller device is
fully resumed.

While I am at it, one thing that kept us busy as well is the
relationship between system suspend and pm_runtime suspend. In the
generic case a system suspend will cause a pm_runtime resume before you
can actually start the system suspend, but you might be able to skip
this step. In the Intel case when the controller and its parent device
were suspended we had to pm_runtime resume everything because some
registers were no longer accessible.


