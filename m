Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB38054FD42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiFQTIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbiFQTIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:08:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A5562D8;
        Fri, 17 Jun 2022 12:08:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f65so4782519pgc.7;
        Fri, 17 Jun 2022 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j41E/BYoRqjAFP436187RxcFJdtJLeDsuRyt74Icg5Y=;
        b=KAt/ZwIW6GKOk2RApSdAlLE9w/HUp3vrGRdYs6vuAfZyTRi008JVB0cQOEnfvn4GfV
         EfZaBz2oup74Sbuv+ci8AjajLNlStT4KI74+q8hh6GcNfH14P6EA4fqLQhNFErCnxcI4
         mnWMYhvPo63tmos4CoENDr/K+TJ8rvQiFdDtW81B9CQvWqJ4IUXP63QrblMccCHavw5D
         2G/gMYyKW0AvKJfWAWH26w286QKQPPfSbdJhtib2r3E5lZod7kFFiU4wAyTtBb6R8Mm1
         qehpuyTAF/AYJgwXTQF49T407noTHjRhS+ZSfUUk7lxVgVncOStzn4rh3uui/1Cm9ihK
         SPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j41E/BYoRqjAFP436187RxcFJdtJLeDsuRyt74Icg5Y=;
        b=N6RinlXpzus7smzOJTit1HO0+1IQh5fkpOcC0n6taEYLIwr611NwRJCPsLR37tFCo7
         Gg3u+4nVxvY2LZ2CejNbkvmFE2DHVZ1tHSRQch64QdXcaLb9D2A598OGX3MuymJbvEni
         qEzt6+jIWswe5aFHmClDgBophzJLP1FgpuyplpFOjfioI2hyanEADWYIRaX+v/iKH55J
         9Wr9fjCl2lukE/wUVuKImQqdf9LfKo3cieUEumKHOTqgb2P1GsYwOCdJ1daakhkzXOfp
         iCztGqkhjx4jEiCkmlRP8b+/+ju+bJDDcqYKU8AcKdnhUWbrOuLjL4LXSFjMpUHdii/C
         BLbA==
X-Gm-Message-State: AJIora8lnpDZc7oBCCjTwnkiQSO1YQFj+/KBE+ogOYIe8WoI4irBJpOC
        D6QrDx6xvgiQniV6bnY3TUovWyYDlrg=
X-Google-Smtp-Source: AGRyM1ttAZVg0K9w9XHm96HKWsCLC6j8iniymytPCQmXG79ZrpEgSUP/964Q9fbkjz0kHvDC/xMRZg==
X-Received: by 2002:aa7:92d2:0:b0:51b:4d60:6475 with SMTP id k18-20020aa792d2000000b0051b4d606475mr11560802pfa.73.1655492924171;
        Fri, 17 Jun 2022 12:08:44 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a67c400b001ec7ba41fe7sm1302753pjm.48.2022.06.17.12.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:08:43 -0700 (PDT)
Message-ID: <8ec38d8c-2ece-dfbb-8435-5963d7e80049@gmail.com>
Date:   Sat, 18 Jun 2022 04:08:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/4] PM / devfreq: Fix kernel warning with cpufreq
 passive register fail
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-3-ansuelsmth@gmail.com>
 <5848a10e-e5bf-108f-3e3e-15e16332922d@gmail.com>
 <62a9af8f.1c69fb81.56ead.2c48@mx.google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <62a9af8f.1c69fb81.56ead.2c48@mx.google.com>
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

On 22. 6. 15. 18:20, Ansuel Smith wrote:
> On Wed, Jun 15, 2022 at 04:11:13PM +0900, Chanwoo Choi wrote:
>> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
>>> When the cpufreq passive register path from the passive governor fails,
>>> the cpufreq_passive_unregister is called and a kernel WARNING is always
>>> reported.

>>> This is caused by the fact that the devfreq driver already call the
>>> governor unregister with the GOV_STOP, for this reason the second
>>> cpufreq_passive_unregister always return error and a WARN is printed
>>> from the WARN_ON function.

>>> Remove the unregister call from the error handling of the cpufreq register
>>> notifier as it's fundamentally wrong and already handled by the devfreq
>>> core code.

If possible, could you make the patch description more simply?

>>>
>>> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/devfreq/governor_passive.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 95de336f20d5..dcc9dd518197 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -331,7 +331,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>>>  err_put_policy:
>>>  	cpufreq_cpu_put(policy);
>>>  err:
>>> -	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
>>>  
>>>  	return ret;
>>>  }
>>
>> I think that it is necessary to free the resource when error happen.
> 
> Thing is that it should not be done in the register. Following the flow
> of the devfreq core code, if a gov fails to START, the gov STOP is
> called and we correctly free our resources. In the current
> implementation we call the free 2 times and the second time will always
> print error as the notifier is already unregistered.
> 
>> Also, after merging the your patch1, I think that cpufreq_passive_unregister_notifier(devfreq)
>> will not return error. Instead, just 0 for success.
> 
> With path1 we removed the error with the parent_cpu_data deletion but
> the unregister error is still there.
> 
>>
>> Instead, 'err_free_cpu_data' and 'err_put_policy' goto statement are wrong exception
>> handling. If fix the exception handling code in cpufreq_passive_register_notifier
>> as following and with your patch1, I'll handle the resource for free/un-registration
>> when error happen during cpufreq_passive_register_notifier.
>>
> 
> Don't know the main problem here is calling unregister 2 times.

Ah. I understood. To fix the error path handling with unregister function
is called twice, I think that need to to fix it as following:


diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index a35b39ac656c..8f38a63beefc 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -289,22 +289,25 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
                parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
                                                GFP_KERNEL);
                if (!parent_cpu_data) {
+                       cpufreq_cpu_put(policy);
                        ret = -ENOMEM;
-                       goto err_put_policy;
+                       goto err;
                }
 
                cpu_dev = get_cpu_device(cpu);
                if (!cpu_dev) {
                        dev_err(dev, "failed to get cpu device\n");
+                       cpufreq_cpu_put(policy);
                        ret = -ENODEV;
-                       goto err_free_cpu_data;
+                       goto err;
                }
 
                opp_table = dev_pm_opp_get_opp_table(cpu_dev);
                if (IS_ERR(opp_table)) {
                        dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);
+                       cpufreq_cpu_put(policy);
                        ret = PTR_ERR(opp_table);
-                       goto err_free_cpu_data;
+                       goto err;
                }
 
                parent_cpu_data->dev = cpu_dev;
@@ -324,15 +327,7 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
        if (ret)
                dev_err(dev, "failed to update the frequency\n");
 
-       return ret;
-
-err_free_cpu_data:
-       kfree(parent_cpu_data);
-err_put_policy:
-       cpufreq_cpu_put(policy);
 err:
-       WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
-
        return ret;
 }


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
