Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B010508EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiDTSCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381404AbiDTSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:02:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A64706C;
        Wed, 20 Apr 2022 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650477587; x=1682013587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N62cvOlKD0daSm/0St1yA0uiCTqXXL1RTNMqabzw2jQ=;
  b=k/40XO9tt96f7ahN59xMssjmm2KXnzw6wRsYQg9+v0JtamaBSOFYTrw3
   oXYhrEGp+4ePb4bvagRYOdZnr8UOer0Rc+4atKc3nMCoGJc9m1uvVyuFR
   fBQDB0c8tIHM/Gg3uCW7bLfQtiUAEzFHIp6dfOlqduTKEsRFLLLjdI+oE
   GfIbhUFzZsOQU1NfsRzjToASmUgWkFii36UFQ5E7FcNjEFPmSsLdnRxXQ
   eilRDHIWZPUSQWBiIbSLeNlwpJn+v0DxmvdR+8Sn94r6V55g2MPpppVel
   N5sagRZo706dJz3g+hDM4Jy8C2ZHqq6WA7rNNdkhPSGGP1+BRpJ+b5pKg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327013172"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="327013172"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:59:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576721817"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171]) ([10.209.100.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:59:45 -0700
Message-ID: <80503ba6-5a84-9481-11fc-6f0c4303331b@linux.intel.com>
Date:   Wed, 20 Apr 2022 12:53:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] soundwire: qcom: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
 <10eb3973-03c4-74cd-d28a-014fc280cdf8@linux.intel.com>
 <e8ac9fab-85af-8f3c-eb68-c2d4d2f7f046@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <e8ac9fab-85af-8f3c-eb68-c2d4d2f7f046@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> @@ -1197,12 +1224,23 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>>>   static int swrm_reg_show(struct seq_file *s_file, void *data)
>>>   {
>>>       struct qcom_swrm_ctrl *swrm = s_file->private;
>>> -    int reg, reg_val;
>>> +    int reg, reg_val, ret;
>>> +
>>> +    ret = pm_runtime_get_sync(swrm->dev);
>>> +    if (ret < 0 && ret != -EACCES) {
>>> +        dev_err_ratelimited(swrm->dev,
>>> +                    "pm_runtime_get_sync failed in %s, ret %d\n",
>>> +                    __func__, ret);
>>> +        pm_runtime_put_noidle(swrm->dev);
>> ... here it's missing?
>>
>> I have a fix ready but thought I would check first if this was intentional
> 
> Its not intentional.
> 
> 
>>
>> https://github.com/thesofproject/linux/pull/3602/commits/6353eec8dc971c5f0fda0166ae1777f71784ea32
> 
> Fix looks good.

Thanks Srini, I'll add Fixes tags and share on alsa-devel.

I guess we need to thank Mark Brown for his guidance to use pm_runtime_resume_and_get(), that's how I saw those two cases :-)
