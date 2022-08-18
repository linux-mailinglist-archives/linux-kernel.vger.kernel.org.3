Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53739597B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiHRCcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHRCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:32:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A880516
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:32:20 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7TPV00KfzmVqL;
        Thu, 18 Aug 2022 10:30:05 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 10:32:18 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 10:32:17 +0800
Subject: Re: [PATCH] ftrace: Fix NULL pointer dereference in
 is_ftrace_trampoline when ftrace is dead
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20220804021610.209791-1-yangjihong1@huawei.com>
 <20220817104115.0ec6b90b@gandalf.local.home>
 <dcbc9c43-486d-e045-1e35-4226233981ea@huawei.com>
 <20220817221422.295db316@gandalf.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <472bdcc7-c35c-0306-5642-3eaf9061909d@huawei.com>
Date:   Thu, 18 Aug 2022 10:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220817221422.295db316@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/8/18 10:14, Steven Rostedt wrote:
> On Thu, 18 Aug 2022 09:50:40 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> Thanks for the detailed explanation.
>> If panic_on_warn is not set, FTRACE_WARN_ON{_ONCE} only sets
>> ftrace_disabled, but will not reboot.
> 
> Correct. But whenever there's a WARN_ON() the administrator of the machine
> should think about rebooting it ASAP. That's because all WARN_ON()s are
> suppose to only happen when the system does something that was not
> expected, putting it into an inconsistent state. And could be a dangerous
> one. This is why all WARN_ON()s that are triggered are considered bugs and
> must be fixed.
> 
> 
>> I think this is to limit the problem to ftrace itself and not spread to
>> other subsystems(I don't know if that's right. If it's not right, please
>> correct it).
> 
> Yes, the ftrace_disable means that ftrace just found itself in a situation
> that it does not understand, and nothing can be trusted. As ftrace modifies
> kernel code, it basically stops everything and WARNs about it. Because
> anything else it does can make things worse.
> 
>> Because is_ftrace_trampoline is a common and public interface  (This
>> interface is called in many places in the kernel).
>> If is_ftrace_trampoline interface is not restricted (for example, just
>> return true if ftrace_disabled is set), the preceding Syzkaller scenario
>> may be triggered when this interface is called.
> 
> If ftrace_disabled is set, then any operations should fail, and any tests
> should fail with it.
> 
>>
>> Therefore, my idea is to restrict the is_ftrace_trampoline or roll back
>>    _unregister_ftrace_function when ftrace_disabled is set, so that the
>> interface can be invoked normally. Or keep the current code and do not
>> modify.
> 
> Once ftrace_disabled is set, none of its interfaces should perform
> normally.
> 
> But you reported that you could hit a NULL pointer from the
> is_ftrace_trampoline() which was caused by the failure adding the dynamic
> trampoline, and then the ops is on the list but later freed.
> 
> My suggestion above is to just call _unregister_ftrace_function(ops) to
> take it off the list and prevent the NULL pointer.
> 
> Doesn't that fix the bug?
> 
> I don't want to totally roll it back and free the trampoline, because those
> actions could cause further damage, depending on the failed state ftrace is
> in.
OK, I understand, and will be modified in this way in next version.

Thanks,
Yang
