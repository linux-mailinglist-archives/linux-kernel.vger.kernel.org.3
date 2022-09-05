Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B415ACAF2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiIEGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIEGay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:30:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17B2D1E7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:30:53 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLdpw1s9lzlWjm;
        Mon,  5 Sep 2022 14:27:20 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 14:30:51 +0800
Received: from [10.67.110.146] (10.67.110.146) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 14:30:51 +0800
Subject: Re: [PATCH] signal: fix deadlock caused by calling printk() under
 sighand->siglock
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <keescook@chromium.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
        <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>
References: <20220826092258.147322-1-yeweihua4@huawei.com>
 <87k06un1hi.fsf@email.froward.int.ebiederm.org>
From:   Ye Weihua <yeweihua4@huawei.com>
Message-ID: <1ecbbf35-2664-9132-fdd4-d835f792cb18@huawei.com>
Date:   Mon, 5 Sep 2022 14:30:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87k06un1hi.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.67.110.146]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/27 5:23, Eric W. Biederman wrote:
> While the patch below will in theory fix the reported deadlock, I don't
> think it is a good choice of fix.  As a rule we want to allow printk to
> be callable in as many places as possible, so that it can be used for
> debugging.  There are enough places that take siglock that outlawing
> printk under siglock will make the kernel unstable.
>
> I tried to read the current kernel and verify this deadlock to see if I
> could suggest a better location to change the code to fix the deadlock.
> Say modifying task_work_add to not take siglock.  The current
> task_work_add does not take siglock.  I encountered a few other
> significant function differences as well.  One significant difference is
> that io_poll_double_wake no longer exists.
>
> I think the amb-pl011.c driver might even be more different yet.
>
> Can you reproduce this on current kernels?
>
> Reading the code I think this is already fixed.
>
> Perhaps you want to read the code of the affected subsystems and pick
> some appropriate changes to backport to 5.10?
>
> Eric
>
> .

Thank you for your reply.


I tested it on the current version for a few days using the same case 
and the

problem didn't occur again. You're right, the problem has been fixed. 
I've read

some of the code and learned about some of the changes, and I'll try to 
backport

the relevant patches to the problem version later.

