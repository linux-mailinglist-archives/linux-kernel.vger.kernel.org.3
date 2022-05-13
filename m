Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD6D526043
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379572AbiEMKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355554AbiEMKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:42:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF39B66CA7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:42:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38320143D;
        Fri, 13 May 2022 03:42:13 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD6253F5A1;
        Fri, 13 May 2022 03:42:11 -0700 (PDT)
Message-ID: <afafbb0c-5279-bee8-1ef4-434733e2a552@arm.com>
Date:   Fri, 13 May 2022 12:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] arch_topology: Use llc_id instead of package_id
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
References: <20220513083400.343706-1-dietmar.eggemann@arm.com>
 <20220513090330.z25fwthekn4rjkwq@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220513090330.z25fwthekn4rjkwq@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 11:03, Sudeep Holla wrote:
> On Fri, May 13, 2022 at 10:34:00AM +0200, Dietmar Eggemann wrote:

[...]

>> @@ -527,7 +528,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>>  			return -EINVAL;
>>  		}
>>  
>> -		cpu_topology[cpu].package_id = package_id;
>> +		cpu_topology[cpu].package_id = 0;
> 
> While the above looks good and matches with what I am attempting to do
> as well ...
> 
>> +		cpu_topology[cpu].llc_id = llc_id;
> 
> This looks wrong for simple reason that this is derived incorrectly from
> the cpu-map while there is no guarantee that it matches the last level
> cache ID on the system as we didn't parse the cache topology for this.
> So I disagree with this change as it might conflict with the actual and
> correct llc_id.

It might not match the LLC, that's true. Something we have already today
in Android for DynamIQ clusters with big/Little. People using 1. level
clusters to group CPUs according to uArch.

My point is we manage to get:

SMT - cpu_smt_mask()
CLS - cpu_clustergroup_mask()
MC  - cpu_coregroup_mask()
DIE - cpu_cpu_mask()

covered in ACPI with the cpu_topology[] structure and if we want CLS on
DT we have to save cluster_id for the 2. level (DT) cluster.

And that's why I proposed to (ab)use llc_id to form the MC mask.

I'm not currently aware of another solution to get CLS somehow elegantly
into a DT system.
