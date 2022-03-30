Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE84EC9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348905AbiC3QpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348899AbiC3QpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:45:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0744B61
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:43:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD16F23A;
        Wed, 30 Mar 2022 09:43:31 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DACDC3F73B;
        Wed, 30 Mar 2022 09:43:28 -0700 (PDT)
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-8-james.morse@arm.com>
 <40eae910-29fb-4875-c26c-ee901bb49a83@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <309a7d32-ea0d-7eb8-2c66-ea4c8efca9dc@arm.com>
Date:   Wed, 30 Mar 2022 17:43:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <40eae910-29fb-4875-c26c-ee901bb49a83@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 05/03/2022 00:26, Reinette Chatre wrote:
> On 2/17/2022 10:20 AM, James Morse wrote:
>> To support resctrl's MBA software controller, the architecture must provide
>> a second configuration array to hold the mbps_val[] from user-space.
>>
>> This complicates the interface between the architecture specific code and
>> the filesystem portions of resctrl that will move to /fs/, to allow
>> multiple architectures to support resctrl.
>>
>> Make the filesystem parts of resctrl create an array for the mba_sc
>> values when is_mba_sc() is set to true. The software controller
>> can be changed to use this, allowing the architecture code to only
>> consider the values configured in hardware.

...

>> @@ -3263,6 +3295,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  		cancel_delayed_work(&d->cqm_limbo);
>>  	}
>>  
>> +	if (is_mba_sc(r))
>> +		mba_sc_domain_destroy(r, d);
>> +
>>  	domain_destroy_mon_state(d);
>>  }
>>  
>> @@ -3309,6 +3344,12 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  	if (err)
>>  		return err;
>>  
>> +	err = mba_sc_domain_allocate(r, d);
>> +	if (err) {
>> +		domain_destroy_mon_state(d);
>> +		return err;
>> +	}
>> +

> Thank you for making this all symmetrical. It seems as though the new
> array is always created but only destroyed when is_mba_sc() is true.
> Is this correct?

That looks broken. Oops.

I'll fix it to always allocate the array, as that is what domain_setup_ctrlval() does
today, and it saves the hotplug headache.


Thanks,

James
