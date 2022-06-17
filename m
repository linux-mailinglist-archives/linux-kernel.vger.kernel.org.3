Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DB54FCFD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiFQSfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiFQSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:35:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701733A1D;
        Fri, 17 Jun 2022 11:35:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so4871858pjz.1;
        Fri, 17 Jun 2022 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XpK58kUCWVuuY39qtRdH+2/18OjpPpfLZS8p0EA/aIk=;
        b=X+e9+KlVx2TPF+4Oc2c0yO5W7xvG2og5jID+LA0LjVRRaYHc16BualhI6w/eVmsGyn
         rF3fuwZUttecgWTSkfkbo8G4zUSfBKgyY1pm2n3m5HbbueDnD6DFLZbF+MEXesrBCgx5
         MfZtttijG7eRMROjF5GmS+uIGmHmajl01CAq4wC7EIRen7IfsWIUF6+tsocZ8ay7S/Uf
         1EaZdI7jWc98dckm3kRWIDyEGjgjHy0cA3fps67SuXywNJLwUhtOQvQVBCd4pDfBFm+x
         Cb7I3PiwFiLXgr80LGVYIj/9ptXLQ7Bz9wEV1jPEHkDNXhM8HnmDeignpALbcGSPYBsT
         98pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XpK58kUCWVuuY39qtRdH+2/18OjpPpfLZS8p0EA/aIk=;
        b=3e5ZVtYFmaFwrDlioZARt/VUeCQU7av1ew2NtOVl6NwF4nptKQu9kwITVZl+I12EfF
         Y/u0/LP1mehNO4crdBmWggtflNoQ5cITzbj7l9vQnhgSmlA9vUewlllBtPCaQLf3f5eq
         af5xndlq5NV4zGSGA781gHuRfLmgBQA54HfFnYABhRIjYEPw62XlkPdjgmRgNDHxfgYp
         D1OVq9tml8NJfNotkD5NnTI7uatmpAHye3RSdg6/e0kchZ405iqivtS1LvHBrBHklDJj
         xuuuSUqpcYjNNkfMc5uFVRHi+TabMO/I7Rw9pnmZ02e6CPNhHH/9AIq1WR10+X0QJ+eF
         rNug==
X-Gm-Message-State: AJIora+6ChBt0Z+B8gAnMMMPYP7lh7SK/GgazUMLgt/I5reEEvJlCJbi
        XzzKKznobGoWRzNNtWAzHlw=
X-Google-Smtp-Source: AGRyM1sJOeWnCiVtPgZVWGmdodTkBHtUIJZwZjSCZXvUstfmaP15s7/NSBYCvqeigaHd2wztYcG73g==
X-Received: by 2002:a17:902:dacd:b0:164:17ef:54c6 with SMTP id q13-20020a170902dacd00b0016417ef54c6mr11198030plx.11.1655490910763;
        Fri, 17 Jun 2022 11:35:10 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id h190-20020a6283c7000000b0051cb8b91474sm3981731pfe.136.2022.06.17.11.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 11:35:10 -0700 (PDT)
Message-ID: <6502dfdc-3e35-db24-2be5-15eca026d193@gmail.com>
Date:   Sat, 18 Jun 2022 03:35:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/4] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-2-ansuelsmth@gmail.com>
 <17cb21c6-317a-3f70-8c4d-4d8fe20604d4@gmail.com>
 <62a9ade8.1c69fb81.76bfd.ae0b@mx.google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <62a9ade8.1c69fb81.76bfd.ae0b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 15. 18:13, Ansuel Smith wrote:
> On Wed, Jun 15, 2022 at 03:48:03PM +0900, Chanwoo Choi wrote:
>> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
>>> With the passive governor, the cpu based scaling can PROBE_DEFER due to
>>> the fact that CPU policy are not ready.


>>> The cpufreq passive unregister notifier is called both from the
>>> GOV_START errors and for the GOV_STOP and assume the notifier is
>>> successfully registred every time. With GOV_START failing it's wrong to
>>> loop over each possible CPU since the register path has failed for
>>> some CPU policy not ready. Change the logic and unregister the notifer
>>> based on the current allocated parent_cpu_data list to correctly handle
>>> errors and the governor unregister path.>>>
>>> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/devfreq/governor_passive.c | 39 +++++++++++++-----------------
>>>  1 file changed, 17 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 72c67979ebe1..95de336f20d5 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -34,6 +34,20 @@ get_parent_cpu_data(struct devfreq_passive_data *p_data,
>>>  	return NULL;
>>>  }
>>>  
>>> +static void delete_parent_cpu_data(struct devfreq_passive_data *p_data)
>>> +{
>>> +	struct devfreq_cpu_data *parent_cpu_data, *tmp;
>>> +
>>
>> Need to add the validation checking of argument as following:
>>
>> 	if (!p_data)
>> 		return;
>>
> 
> Considering this is called only by cpufreq_passive_unregister_notifier
> and cpufreq_passive_unregister_notifier is called only by devfreq_passive_event_handler
> where the check is already done, isn't that redundant.
> We should never reach delete_parent_cpu_data with no p_data.
> (Unless you want to use that function somewhere else)

Actually, right as you mentioned. I'd like to check the parameter validation
on each function. But, I agree to keep this path without checking p_data.
If needed on later, I'll do that.

Applied it. Thanks.

> 
>>> +	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
>>> +		list_del(&parent_cpu_data->node);
>>> +
>>> +		if (parent_cpu_data->opp_table)
>>> +			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
>>> +
>>> +		kfree(parent_cpu_data);
>>> +	}
>>> +}
>>> +
>>>  static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
>>>  						struct opp_table *p_opp_table,
>>>  						struct opp_table *opp_table,
>>> @@ -222,8 +236,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>>>  {
>>>  	struct devfreq_passive_data *p_data
>>>  			= (struct devfreq_passive_data *)devfreq->data;
>>> -	struct devfreq_cpu_data *parent_cpu_data;
>>> -	int cpu, ret = 0;
>>> +	int ret;
>>>  
>>>  	if (p_data->nb.notifier_call) {
>>>  		ret = cpufreq_unregister_notifier(&p_data->nb,
>>> @@ -232,27 +245,9 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
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
>>> -		list_del(&parent_cpu_data->node);
>>> -		if (parent_cpu_data->opp_table)
>>> -			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
>>> -		kfree(parent_cpu_data);
>>> -		cpufreq_cpu_put(policy);
>>> -	}
>>> +	delete_parent_cpu_data(p_data);
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
