Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573D54BE33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbiFNXMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiFNXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:12:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD952B0D;
        Tue, 14 Jun 2022 16:12:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so2148905pjb.1;
        Tue, 14 Jun 2022 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CHFPGXOKSd9PvMLjziQ2+rTIn+JaqVqTkdHD91+8Kdk=;
        b=M77rdH/BcMSljgFX28xbEWaO8AFiQIs74jfc8mKvmsCx6I7Ihc/6StvNUByNRBdV0y
         ud/jGMz2/cWQaoklDn6Zte9LB++BJnw7Mx9FTO3mRBLBuzEWo3bYRKbUJOmlwO9Q1pCT
         pQArlkaQX0P0cnC5oDS+094GbgyxnB7B2XtgbqMPbVuZfMlC/x+Pd07mhMp9Y/yUMfVT
         65ocJy4HKYNoCupKDOdy2buDEl7aMEhqAIgv7L3Qk50MdP/6Cx6g+d6Yk8PYfC+6CEIy
         4c/mUWz0EZRDN8LK3rixhGLSyrVtOr1vi4hIHwQ6WgHXfUpt7C/bcyP+iYxaGwyRKnQO
         wH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CHFPGXOKSd9PvMLjziQ2+rTIn+JaqVqTkdHD91+8Kdk=;
        b=14jrQuT7rBekLKaAF3+yecuBrJezB0qfnOtQ2MUYNu8Br6h7ugPpGIQYVB4L6LprJw
         ALybPnyt6ySqsBQ5ZxDEJiv1jaOX6aldsD5paywNmSx5Yl2V7K6WvosYzxODtMcIC5uT
         n8vyUENHA2zmIi2i5WPIwv64xu/tiGuhIfNCKTcl4QU1dxGsOgR9BnEXJC7n0Ec8kAcL
         PbZ9oHFz5gwhMOBLJwPsCZivR1xzUXquDJEZabsDPA4gEeNIvhsusACVoLhYExofuwZY
         oJHbA35RzC/4WYJcroMUdE6bCb/WkUd8LgbACQHwgHh4Wvdp50JSOvYynPqFf/GJTATy
         90kQ==
X-Gm-Message-State: AJIora8V6RVZJdY8d3njG7aOS6fNdyl7/sPTstRFwqadOrbla6WtzT7C
        od68p3vKnfQ25FCGavCwpsY=
X-Google-Smtp-Source: AGRyM1siYZIs6z+o0eBAk3uIwSuXqRX9lCtP+WZ8Q+cr2OQt24RyChMHOnVpKfL1KPL8Q4EqZeoADA==
X-Received: by 2002:a17:903:187:b0:166:4360:a4fa with SMTP id z7-20020a170903018700b001664360a4famr6301008plg.87.1655248329956;
        Tue, 14 Jun 2022 16:12:09 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170902efd500b0016632179ecfsm7723972plb.264.2022.06.14.16.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:12:09 -0700 (PDT)
Message-ID: <6a5a8354-c294-9797-2232-3fbd81aa181e@gmail.com>
Date:   Wed, 15 Jun 2022 08:12:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/5] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
 <20220614110701.31240-2-ansuelsmth@gmail.com>
 <7f00333d-40f9-34d5-fd84-54c10d7a243d@gmail.com>
 <62a91320.1c69fb81.7fba4.8c25@mx.google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <62a91320.1c69fb81.7fba4.8c25@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 15. 07:07, Ansuel Smith wrote:
> On Wed, Jun 15, 2022 at 07:58:16AM +0900, Chanwoo Choi wrote:
>> On 22. 6. 14. 20:06, Christian 'Ansuel' Marangi wrote:
>>> With the passive governor, the cpu based scaling can PROBE_DEFER due to
>>> the fact that CPU policy are not ready.
>>> The cpufreq passive unregister notifier is called both from the
>>> GOV_START errors and for the GOV_STOP and assume the notifier is
>>> successfully registred every time. With GOV_START failing it's wrong to
>>> loop over each possible CPU since the register path has failed for
>>> some CPU policy not ready. Change the logic and unregister the notifer
>>> based on the current allocated parent_cpu_data list to correctly handle
>>> errors and the governor unregister path.
>>>
>>> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/devfreq/governor_passive.c | 23 ++++++-----------------
>>>  1 file changed, 6 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 72c67979ebe1..0188c32f5198 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -222,8 +222,8 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>>>  {
>>>  	struct devfreq_passive_data *p_data
>>>  			= (struct devfreq_passive_data *)devfreq->data;
>>> -	struct devfreq_cpu_data *parent_cpu_data;
>>> -	int cpu, ret = 0;
>>> +	struct devfreq_cpu_data *parent_cpu_data, *tmp;
>>> +	int ret;
>>>  
>>>  	if (p_data->nb.notifier_call) {
>>>  		ret = cpufreq_unregister_notifier(&p_data->nb,
>>> @@ -232,27 +232,16 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>>>  			return ret;
>>>  	}
>>>  
>>> -	for_each_possible_cpu(cpu) {
>>> -		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>> -		if (!policy) {
>>> -			ret = -EINVAL;
>>> -			continue;
>>> -		}
>>> -
>>> -		parent_cpu_data = get_parent_cpu_data(p_data, policy);
>>> -		if (!parent_cpu_data) {
>>> -			cpufreq_cpu_put(policy);
>>> -			continue;
>>> -		}
>>> -
>>> +	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
>>>  		list_del(&parent_cpu_data->node);
>>> +
>>>  		if (parent_cpu_data->opp_table)
>>>  			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
>>> +
>>>  		kfree(parent_cpu_data);
>>> -		cpufreq_cpu_put(policy);
>>>  	}
>>
>> I agree this patch. Just, I'd like to make the separate function
>> to handle the removing of parent_cpu_data.
>>
>> Please add new delete_parent_cpu_data() function under get_parent_cpu_data()
>> implementation and then call delete_parent_cpu_data()
>> in cpufreq_passive_unregister_notifier().
>>
> 
> Ok just to make sure I understand this correctly.
> A dedicated function with just the list_for_each_entry_safe function
> correct?

Yes to remove the parent_cpu_data with list_for_each_entry_safe.

> 
>>>  
>>> -	return ret;
>>> +	return 0;
>>>  }
>>>  
>>>  static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>>
>>
>> -- 
>> Best Regards,
>> Samsung Electronics
>> Chanwoo Choi
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
