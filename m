Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3261597B31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiHRBus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiHRBuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:50:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FFA9AFD6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:50:45 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7SRB5YLjzXdrZ;
        Thu, 18 Aug 2022 09:46:30 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:50:41 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:50:40 +0800
Subject: Re: [PATCH] ftrace: Fix NULL pointer dereference in
 is_ftrace_trampoline when ftrace is dead
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20220804021610.209791-1-yangjihong1@huawei.com>
 <20220817104115.0ec6b90b@gandalf.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <dcbc9c43-486d-e045-1e35-4226233981ea@huawei.com>
Date:   Thu, 18 Aug 2022 09:50:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220817104115.0ec6b90b@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/8/17 22:41, Steven Rostedt wrote:
> On Thu, 4 Aug 2022 10:16:10 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> @@ -2922,24 +2922,36 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
>>   	ops->flags |= FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_ADDING;
>>   
>>   	ret = ftrace_hash_ipmodify_enable(ops);
>> -	if (ret < 0) {
>> -		/* Rollback registration process */
>> -		__unregister_ftrace_function(ops);
>> -		ftrace_start_up--;
>> -		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
>> -		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
>> -			ftrace_trampoline_free(ops);
>> -		return ret;
> 
> This should stay as is.
> 
>> -	}
>> +	if (ret < 0)
>> +		goto out_rollback_registration;
>>   
>>   	if (ftrace_hash_rec_enable(ops, 1))
>>   		command |= FTRACE_UPDATE_CALLS;
>>   
>>   	ftrace_startup_enable(command);
>>   
>> +	/*
>> +	 * If ftrace_startup_enable fails,
>> +	 * we need to rollback registration process.
>> +	 */
>> +	if (unlikely(ftrace_disabled)) {
>> +		ret = -ENODEV;
>> +		goto out_rollback_registration;
> 
> The only thing to do here is the _unregister_ftrace_function(ops);
> And that may not even be safe.
> 
> 
>> +	}
>> +
>>   	ops->flags &= ~FTRACE_OPS_FL_ADDING;
>>   
>>   	return 0;
>> +
>> +out_rollback_registration:
>> +	/* Rollback registration process */
>> +	__unregister_ftrace_function(ops);
>> +	ftrace_start_up--;
>> +	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
>> +	if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
>> +		ftrace_trampoline_free(ops);
>> +
> 
> When ftrace_disabled is set, ftrace is in an undefined state, and a reboot
> should be done ASAP. Because we have no idea what went wrong. It means
> something happened that ftrace was not designed for.
> 
> That means, we do not know if the trampoline can still be called or not.
> Maybe it enabled some of the functions, but not all. And maybe those
> functions call the dynamic trampoline directly.
> 
> Thus, on ftrace_disable being set, only do the bare minimum, as ftrace has
> now "shutdown" and will not do any more work.
> 
> Basically, this patch is trying to mitigate a kernel that broke and needs
> a reboot immediately.
> 
> -- Steve
Thanks for the detailed explanation.
If panic_on_warn is not set, FTRACE_WARN_ON{_ONCE} only sets 
ftrace_disabled, but will not reboot.
I think this is to limit the problem to ftrace itself and not spread to 
other subsystems(I don't know if that's right. If it's not right, please 
correct it).
Because is_ftrace_trampoline is a common and public interface  (This 
interface is called in many places in the kernel).
If is_ftrace_trampoline interface is not restricted (for example, just 
return true if ftrace_disabled is set), the preceding Syzkaller scenario 
may be triggered when this interface is called.

Therefore, my idea is to restrict the is_ftrace_trampoline or roll back 
  _unregister_ftrace_function when ftrace_disabled is set, so that the 
interface can be invoked normally. Or keep the current code and do not 
modify.

Please give me some suggestions that you think are better.

Thanks,
Yang

> 
> 
>> +	return ret;
>>   }
>>   
>>   int ftrace_shutdown(struct ftrace_ops *ops, int command)
>> -- 
> .
> 
