Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD91E4C9FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbiCBIuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCBIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:50:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDD435C34E;
        Wed,  2 Mar 2022 00:50:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82E551396;
        Wed,  2 Mar 2022 00:50:10 -0800 (PST)
Received: from [10.57.21.27] (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858FA3F66F;
        Wed,  2 Mar 2022 00:50:08 -0800 (PST)
Message-ID: <e02d9113-d1ae-c029-750f-aece1cefab2d@arm.com>
Date:   Wed, 2 Mar 2022 08:50:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220301093524.8870-1-lukasz.luba@arm.com>
 <20220301093524.8870-4-lukasz.luba@arm.com>
 <20220302074515.dqzoutfiobildiph@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220302074515.dqzoutfiobildiph@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/22 07:45, Viresh Kumar wrote:
> On 01-03-22, 09:35, Lukasz Luba wrote:
>>   /**
>>    * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
>>    * @dev		: Device for which an Energy Model has to be registered
>> @@ -1517,6 +1567,12 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>>   		goto failed;
>>   	}
>>   
>> +	/* First, try to find more precised Energy Model in DT */
>> +	if (_of_has_opp_microwatt_property(dev)) {
>> +		em_cb.active_power = _get_dt_power;
> 
> You can also do (to fix the warning) this instead:
> 
> em_cb = EM_DATA_CB(_get_dt_power);
> 
> Similar for the else part.
> 

Unfortunately, not for this case. When we declare that em_cb
it can handle the brackets '{ }', but not later in the code no.
In both configs it won't fly:

EM:
drivers/opp/of.c: In function ‘dev_pm_opp_of_register_em’:
./include/linux/energy_model.h:118:38: error: expected expression before 
‘{’ token
  #define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
                                       ^
drivers/opp/of.c:1573:11: note: in expansion of macro ‘EM_DATA_CB’
    em_cb = EM_DATA_CB(_get_dt_power);
            ^~~~~~~~~~
./include/linux/energy_model.h:118:38: error: expected expression before 
‘{’ token
  #define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
                                       ^
drivers/opp/of.c:1600:10: note: in expansion of macro ‘EM_DATA_CB’
   em_cb = EM_DATA_CB(_get_power);
           ^~~~~~~~~~

!EM:
drivers/opp/of.c: In function ‘dev_pm_opp_of_register_em’:
./include/linux/energy_model.h:266:38: error: expected expression before 
‘{’ token
  #define EM_DATA_CB(_active_power_cb) { }
                                       ^
drivers/opp/of.c:1573:11: note: in expansion of macro ‘EM_DATA_CB’
    em_cb = EM_DATA_CB(_get_dt_power);
            ^~~~~~~~~~
./include/linux/energy_model.h:266:38: error: expected expression before 
‘{’ token
  #define EM_DATA_CB(_active_power_cb) { }
                                       ^
drivers/opp/of.c:1600:10: note: in expansion of macro ‘EM_DATA_CB’
   em_cb = EM_DATA_CB(_get_power);
           ^~~~~~~~~~


If you like, I can introduce new dual-macro implementation
in energy_modle.h which would sole this issue:

ifdef EM:
#define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)

ifndef EM:
#define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)


Then we would keep the single call to the registration EM and
we would have:

         if (_of_has_opp_microwatt_property(dev)) {
                 EM_SET_ACTIVE_POWER_CB(em_cb, _get_dt_power);
                 goto register_em;
         }


	
         EM_SET_ACTIVE_POWER_CB(em_cb, _get_power);

register_em:
         ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);


I can do that, please let me know.
