Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37CD4C9E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiCBHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiCBHCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:02:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCB58B459D;
        Tue,  1 Mar 2022 23:01:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5A01424;
        Tue,  1 Mar 2022 23:01:39 -0800 (PST)
Received: from [10.57.21.27] (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605C33F73D;
        Tue,  1 Mar 2022 23:01:37 -0800 (PST)
Message-ID: <fd9b6b6e-9258-b7e3-fbbe-404cd49b26dd@arm.com>
Date:   Wed, 2 Mar 2022 07:01:35 +0000
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
 <20220302045301.fq6nolscdfd5wvyo@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220302045301.fq6nolscdfd5wvyo@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/22 04:53, Viresh Kumar wrote:
> On 01-03-22, 09:35, Lukasz Luba wrote:
>> The Energy Model (EM) can be created based on DT entry:
>> 'dynamic-power-coefficient'. It's a 'simple' EM which is limited to the
>> dynamic power. It has to fit into the math formula which requires also
>> information about voltage. Some of the platforms don't expose voltage
>> information, thus it's not possible to use EM registration using DT.
>>
>> This patch aims to fix it. It introduces new implementation of the EM
>> registration callback. The new mechanism relies on the new OPP feature
>> allowing to get power (which is coming from "opp-microwatt" DT property)
>> expressed in micro-Watts.
>>
>> The patch also opens new opportunity to better support platforms, which
>> have a decent static power. It allows to register 'advanced' EM (based
>> on real power measurements) which models total power (static + dynamic),
>> so better reflects real HW.
> 
> Advanced :(
> 

You're right, here these words sneak in. I'm going to resent this patch
because it has this reported build issue for !EM. I'll update the words
there as well.

BTW, for the build fix, I'm going for the v3 approach:

------------8<--------------
         if (_of_has_opp_microwatt_property(dev)) {
                 struct em_data_callback em_cb_dt = 
EM_DATA_CB(_get_dt_power);

                 return em_dev_register_perf_domain(dev, nr_opp, &em_cb_dt,
                                                    cpus, true);
         }

----------->8---------------

I don't want to introduce another dual-macro mechanism, since
the type em_data_callback is not defined in !EM.

I hope you are OK with this approach, if not please let me know.

