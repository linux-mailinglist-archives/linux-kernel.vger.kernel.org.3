Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48E15113ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiD0I5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiD0I5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:57:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F95C3EAE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:54:07 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpCGL2FgtzhYhM;
        Wed, 27 Apr 2022 16:53:46 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 16:54:04 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 16:54:03 +0800
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <zengshun.wu@outlook.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
 <YmFXrBG5AmX3+4f8@lakrids> <20220421100639.03c0d123@gandalf.local.home>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <57b0c058-963b-fa9e-453c-b29165e13b45@huawei.com>
Date:   Wed, 27 Apr 2022 16:54:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20220421100639.03c0d123@gandalf.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/4/21 22:06, Steven Rostedt Ð´µÀ:
> On Thu, 21 Apr 2022 14:10:04 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
>
>> On Wed, Mar 16, 2022 at 06:01:31PM +0800, Wang ShaoBo wrote:
>>> From: Cheng Jian <cj.chengjian@huawei.com>
>>>
>>> When tracing multiple functions customly, a list function is called
>>> in ftrace_(regs)_caller, which makes all the other traced functions
>>> recheck the hash of the ftrace_ops when tracing happend, apparently
>>> it is inefficient.
>> ... and when does that actually matter? Who does this and why?
> I don't think it was explained properly. What dynamically allocated
> trampolines give you is this.
>
> Let's say you have 10 ftrace_ops registered (with bpf and kprobes this can
> be quite common). But each of these ftrace_ops traces a function (or
> functions) that are not being traced by the other ftrace_ops. That is, each
> ftrace_ops has its own unique function(s) that they are tracing. One could
> be tracing schedule, the other could be tracing ksoftirqd_should_run
> (whatever).
>
> Without this change, because the arch does not support dynamically
> allocated trampolines, it means that all these ftrace_ops will be
> registered to the same trampoline. That means, for every function that is
> traced, it will loop through all 10 of theses ftrace_ops and check their
> hashes to see if their callback should be called or not.
>
> With dynamically allocated trampolines, each ftrace_ops will have their own
> trampoline, and that trampoline will be called directly if the function
> is only being traced by the one ftrace_ops. This is much more efficient.
>
> If a function is traced by more than one ftrace_ops, then it falls back to
> the loop.
>
> -- Steve
> .

yes, this explanation is easier to understand, I will update commit 
description according to this.

-- Wang ShaoBo

