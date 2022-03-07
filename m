Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06C94D0C40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbiCGXtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbiCGXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E45192A4;
        Mon,  7 Mar 2022 15:48:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEA661267;
        Mon,  7 Mar 2022 23:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3C4C340E9;
        Mon,  7 Mar 2022 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646696919;
        bh=fHWO6maflMjyRFHNuByrtSCugopIWmyU6sb+v2UuxbI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YBwjydWfykhLRFG4dbT6Yt76164B3VgaHQawbf73WiXHSmSXxVWY3n6Q5liJGGgaB
         0j19wf83O8+ti7zRHiEY/bqXeBH+ygzxG+4zx3Bd08cXBzz3uriXRCJqTcAZdUW65o
         tlKw4PP2TLQcBoM5TJ5Y1cUjV/rFT4jU54y3sCIHreVhbAOKCaoyBREliaQin8y6S3
         l5zaHi0S2Lt+3BH5gNntHHU8xAMNL1ARdJQ4TgJ65pU0IUkBY/el7k/wIu+NpiMvEO
         jL0VZZSLxzyRg/1XCxyapHBsafOzSrq8Hk9ePfbarg1jPy15jo77OHES8XdhdWiB/Z
         s8a4zovDAoOHA==
Message-ID: <a2b941db-d0ed-68fe-a0dc-f328f9bc2105@kernel.org>
Date:   Tue, 8 Mar 2022 01:48:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Add interconnect path proxy vote
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220225033224.2238425-1-bjorn.andersson@linaro.org>
 <5a9210d9-c726-1ef9-4bf2-716f2ed1fb8b@kernel.org> <YiaKbbxJ/QE7yItC@ripper>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YiaKbbxJ/QE7yItC@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.03.22 0:42, Bjorn Andersson wrote:
> On Mon 07 Mar 10:35 PST 2022, Georgi Djakov wrote:
> 
>>
>> On 25.02.22 5:32, Bjorn Andersson wrote:
>>> Many remoteproc instances requires that Linux casts a proxy vote for an
>>> interconnect path during boot, until they can do it themselves. Add
>>> support for voting for a single path.
>>>
>>> As this is a shared problem between both PAS and MSS drivers, the path
>>> is acquired and votes casted from the common helper code.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>
>>> Sibi posted recently a patch to add interconnect votes from the modem driver,
>>> today I needed the same feature for one of the PAS remoteprocs. After
>>> essentially duplicating Sibi's patch I realized that it doesn't look too bad to
>>> put this in the common Q6V5 code.
>>>
>>> The main difference is that this would be messy if we need to support multiple
>>> paths, so we probably would have to push it out to the individual drivers at
>>> that point.
>>>
>>> Sibi's patch can be found here.
>>> https://lore.kernel.org/all/1644813252-12897-3-git-send-email-quic_sibis@quicinc.com/
>>>
>>>
>>> This makes the implementation pick up one path, relevant DT bindings would
>>> still need to be updated in order be allowed to this in the DeviceTree files.
>>>
>>>    drivers/remoteproc/qcom_q6v5.c | 21 ++++++++++++++++++++-
>>>    drivers/remoteproc/qcom_q6v5.h |  3 +++
>>>    2 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>>> index 442a388f8102..5280ec9b5449 100644
>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>> @@ -8,6 +8,7 @@
>>>     */
>>>    #include <linux/kernel.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/interconnect.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/module.h>
>>>    #include <linux/soc/qcom/qcom_aoss.h>
>>> @@ -51,9 +52,17 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5)
>>>    {
>>>    	int ret;
>>> +	ret = icc_set_bw(q6v5->path, 0, UINT_MAX);
>>> +	if (ret < 0) {
>>> +		dev_err(q6v5->dev, "failed to set bandwidth request\n");
>>> +		return ret;
>>> +	}
>>> +
>>>    	ret = q6v5_load_state_toggle(q6v5, true);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		icc_set_bw(q6v5->path, 0, 0);
>>>    		return ret;
>>> +	}
>>>    	reinit_completion(&q6v5->start_done);
>>>    	reinit_completion(&q6v5->stop_done);
>>> @@ -78,6 +87,9 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
>>>    	disable_irq(q6v5->handover_irq);
>>>    	q6v5_load_state_toggle(q6v5, false);
>>> +	/* Disable interconnect vote, in case handover never happened */
>>> +	icc_set_bw(q6v5->path, 0, 0);
>>> +
>>>    	return !q6v5->handover_issued;
>>>    }
>>>    EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
>>> @@ -160,6 +172,8 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>>>    	if (q6v5->handover)
>>>    		q6v5->handover(q6v5);
>>> +	icc_set_bw(q6v5->path, 0, 0);
>>> +
>>>    	q6v5->handover_issued = true;
>>>    	return IRQ_HANDLED;
>>> @@ -332,6 +346,11 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>>    		return load_state ? -ENOMEM : -EINVAL;
>>>    	}
>>> +	q6v5->path = devm_of_icc_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(q6v5->path))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>> +				     "failed to acquire interconnect path\n");
>>> +
>>>    	return 0;
>>>    }
>>>    EXPORT_SYMBOL_GPL(qcom_q6v5_init);
>>
>> Probably we should also call icc_put(q6v5->path) in qcom_q6v5_deinit().
>>
> 
> The use of devm_of_icc_get() should take care of that for us. Or am I
> missing something?

Right, it's fine then. Sorry for the noise.

BR,
Georgi

>> Reviewed-by: Georgi Djakov <djakov@kernel.org>
>>
> 
> Thanks,
> Bjorn

