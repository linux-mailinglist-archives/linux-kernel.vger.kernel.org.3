Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8D50B5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbiDVLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446686AbiDVLNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:13:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E44EB53A77
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:10:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9CAE1576;
        Fri, 22 Apr 2022 04:10:40 -0700 (PDT)
Received: from [10.57.44.4] (unknown [10.57.44.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB0D13F73B;
        Fri, 22 Apr 2022 04:10:38 -0700 (PDT)
Message-ID: <5033835b-195f-2712-d621-c3c06cc61a08@arm.com>
Date:   Fri, 22 Apr 2022 12:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
References: <20220412134220.1588482-1-vincent.donnefort@arm.com>
 <20220412134220.1588482-2-vincent.donnefort@arm.com>
 <Yl6uKPBfOoj8ABfI@geo.homenetwork>
From:   Vincent Donnefort <vincent.donnefort@arm.com>
In-Reply-To: <Yl6uKPBfOoj8ABfI@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>> +#ifdef CONFIG_64BIT
>> +# define u64_u32_load_copy(var, copy)       var
>> +# define u64_u32_store_copy(var, copy, val) (var = val)
>> +#else
>> +# define u64_u32_load_copy(var, copy)					\
>> +({									\
>> +	u64 __val, __val_copy;						\
>> +	do {								\
>> +		__val_copy = copy;					\
>> +		/*							\
>> +		 * paired with u64_u32_store, ordering access		\
>> +		 * to var and copy.					\
>> +		 */							\
>> +		smp_rmb();						\
>> +		__val = var;						\
>> +	} while (__val != __val_copy);					\
>> +	__val;								\
>> +})
>> +# define u64_u32_store_copy(var, copy, val)				\
>> +do {									\
>> +	typeof(val) __val = (val);					\
>> +	var = __val;							\
>> +	/*								\
>> +	 * paired with u64_u32_load, ordering access to var and		\
>> +	 * copy.							\
>> +	 */								\
>> +	smp_wmb();							\
>> +	copy = __val;							\
> 
> `copy = __val;` should be `copy = var`.
> 
> If var equal to val we do not need to do store. Check this condition
> in the above macro to avoid a redundant store.
> 
>   if (var != __val)
>     var = __val;

Judging by the users of this macro, var = val is very much unlikely to
happen. Also, I don't think we want to waste a if here.

[...]
