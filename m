Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D9508EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381183AbiDTRoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376358AbiDTRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:44:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435E47043;
        Wed, 20 Apr 2022 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650476482; x=1682012482;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3CtKJu86H4ZmVWLsuoKje6DsnJeg0MUXUxRcD9E3dzM=;
  b=LV6eacejHcsZoFfOPPzLEeJOerWabESxuKwrxN/y/5wKhgSBiwliK8u+
   Uv08E64fP0XBPUVAJ40xmrle3gikQM86LIrcnobp2acU9mfqSK3SZTCcE
   lvrcJXdH7dlDE0E5m6a8tPwDkeLnv2eQa20M2BkieQY27WrFM8RKl6VeA
   M/dawHG2YQbLSChOKN660Jy6xD6meN0R2od7OEy1g5dMpsVa9CmsVuOdP
   R6eLDaLrn9Z1eXmOW70NzYe5JVuMTeeGA+ioIlt+/FDaMqtshJXicZ9zq
   Sl4Yas6SfWk3z+OO8iEIxBPgcXUjSZVNI0HNNtyVL1tycG47TJiG5aBMd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251416879"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="251416879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:40:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576712409"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171]) ([10.209.100.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:40:58 -0700
Message-ID: <217a59f8-86fb-5508-bdd9-25c553052a48@linux.intel.com>
Date:   Wed, 20 Apr 2022 12:40:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] soundwire: qcom: add in-band wake up interrupt
 support
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-4-srinivas.kandagatla@linaro.org>
 <a3240a03-2e14-35e6-4915-41f994e365fc@linux.intel.com>
In-Reply-To: <a3240a03-2e14-35e6-4915-41f994e365fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct qcom_swrm_ctrl *swrm = dev_id;
>> +	int ret;
>> +
>> +	ret = pm_runtime_get_sync(swrm->dev);
>> +	if (ret < 0 && ret != -EACCES) {
>> +		dev_err_ratelimited(swrm->dev,
>> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
>> +				    __func__, ret);
>> +		pm_runtime_put_noidle(swrm->dev);

missing 'return ret' here as well, is this intentional?

Fix at https://github.com/thesofproject/linux/pull/3602/commits/6353eec8dc971c5f0fda0166ae1777f71784ea32 ready to go, but not sure what the intent was.

>> +	}
>> +
>> +	if (swrm->wake_irq > 0) {
>> +		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
>> +			disable_irq_nosync(swrm->wake_irq);
>> +	}
>> +
>> +	pm_runtime_mark_last_busy(swrm->dev);
>> +	pm_runtime_put_autosuspend(swrm->dev);
>> +
>> +	return IRQ_HANDLED;
>> +}
