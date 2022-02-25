Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20474C496C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbiBYPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbiBYPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:44:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581191FCC9;
        Fri, 25 Feb 2022 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645803829; x=1677339829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f47cn1Kplw8bEVPU/7scXhOv3urE9BWf0pa3OAk5r0s=;
  b=D9mZwrfeNpaNF5jqxJeF9sLMoIC+MkR45WWzbaH1WSNDxLZyDCB+Gqfj
   xs8QvXrGC4im+VfgbO/IIkvg07WwuwoaAgjjVGBSDVu3qcwZE+zYrJ9PO
   OSjyKbSS+iB+vGUutDh0uLle/zjSNG9jCmn3vUNDPdPLXXAveKnv3C9OV
   Vk9LpihGwaG3yRAhI20PeT0onPnYEilfhP8gC+8UQSLc3i4iVkYgvNdwA
   aSPFinvnZvdwxW97t7DfejnTU41t9N51z4RBeyzfs/6WOPGirQHz1qbK+
   0CxY53X8DPpvAUA5er0T1f3LDWNT/hV7FmZQUtVeN2PhIe05lSDfwoy3r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338954833"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="338954833"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 07:43:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="777438751"
Received: from nnwogbe-mobl1.amr.corp.intel.com (HELO [10.212.101.231]) ([10.212.101.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 07:43:47 -0800
Message-ID: <06650d56-eed3-73ad-d6b4-6b56a5a70669@linux.intel.com>
Date:   Fri, 25 Feb 2022 09:43:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] soundwire: qcom: remove redundant wait for completion
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1645800257-27025-1-git-send-email-quic_srivasam@quicinc.com>
 <a99a59eb-cd59-f566-b98d-486c94f32eec@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <a99a59eb-cd59-f566-b98d-486c94f32eec@linaro.org>
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



On 2/25/22 08:45, Srinivas Kandagatla wrote:
> 
> 
> On 25/02/2022 14:44, Srinivasa Rao Mandadapu wrote:
>> Remove wait_for_completion_timeout from soundwire probe as it seems
>> unnecessary and device enumeration is anyway not happening here,
>> hence this api is blocking till it completes max wait time.
>> Also, as device enumeration event is dependent on wcd938x probe to be
>> completed, its of no use waiting here.
>> Waiting here increasing the boot time almost 4 seconds and impacting
>> other modules like touch screen.
>>
>> Fixes: 06dd96738d618 ("soundwire: qcom: wait for enumeration to be
>> complete in probe")
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> 
> LGTM,
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

I don't get the idea, sorry.

If you look at the code, these are the cases where this 'struct
completion' is used

	struct completion enumeration;
	complete(&ctrl->enumeration);
	/* Enable Auto enumeration */
	init_completion(&ctrl->enumeration);
	wait_for_completion_timeout(&ctrl->enumeration,


so if you remove the wait_for_completeion, then you might just as well
remove the whole thing and revert 06dd96738d618

what am I missing?


>> ---
>>   drivers/soundwire/qcom.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 5481341..9a32a24 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -1309,8 +1309,6 @@ static int qcom_swrm_probe(struct
>> platform_device *pdev)
>>       }
>>         qcom_swrm_init(ctrl);
>> -    wait_for_completion_timeout(&ctrl->enumeration,
>> -                    msecs_to_jiffies(TIMEOUT_MS));
>>       ret = qcom_swrm_register_dais(ctrl);
>>       if (ret)
>>           goto err_master_add;
