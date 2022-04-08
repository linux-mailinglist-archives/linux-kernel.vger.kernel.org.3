Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19FA4F9200
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiDHJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiDHJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:28:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30208CD84
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:26:15 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZXrW3HKMzgYNK;
        Fri,  8 Apr 2022 17:24:27 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 17:26:04 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 17:26:12 +0800
Message-ID: <c6f69fc4-0d8f-baa8-2d13-6ac765bbc2c3@huawei.com>
Date:   Fri, 8 Apr 2022 17:25:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Chen Zhongjin <chenzhongjin@huawei.com>
Subject: Re: [RFC PATCH v3 13/13] objtool: arm64: Enable stack validation for
 arm64
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jthierry@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <ardb@kernel.org>, <masahiroy@kernel.org>,
        <jpoimboe@redhat.com>, <ycote@redhat.com>
References: <20220407120141.43801-1-chenzhongjin@huawei.com>
 <20220407120141.43801-14-chenzhongjin@huawei.com>
 <20220407121919.GK2731@worktop.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20220407121919.GK2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

You are right that Julien had tried to use gcc plugin to fix this but 
refused by Ard.

With jump tables objtool will give some sibling call errors because we 
can't detect
jump table correctly on arm64. Then in the v2 patch they gave a 
conclusion that
it is acceptable to close jump table.

Now we still have some problems on arm64. The todo list includes:

- BRK insns are decoded as INSN_BUG and then marked as dead_end, which 
makes objtool
stop checking and cause unreachable error.

- Some functions need to be annotated by UNWIND micro or marked as noreturn.

- arm64 and x86 share the code for check.c and it can make some problem.
Now I found some errors about __ex_table which is related to alternative 
entry
search code for x86 in special.c.

- Some *.S file still contain data inside text section which cannot be 
excluded or
decoded such as head.S. Also, we have a assembly file kuser32.S which 
reporting
undecodable error.

Now I'm trying to fix these problems with minimum change on arm64 
architecture
and objtool code. To be honest, objtool check grows to a huge x86 wool 
ball now and
make migration a bit difficult. Josh mentions there will be a 
refectoring for objtool
features and maybe we can separatedly support features on different 
arches which will
make things easier.

Also, Madhaven has commited a new patch for stack validation. It's seems 
an available
approch that using DWARF to make stack validation so that we don't need 
to adapt to
different architectures. I'm checking the code and planning to help to 
test it.

Anyway, besides stack validation I think it's still valuable to migrate 
objtool on arm64.
So let things going on and if you have any advise or help I'll be vary 
appriciate for that.

Thanks for your time!


On 2022/4/7 20:19, Peter Zijlstra wrote:
> IIRC this is a sore spot for the whole endeavour..

