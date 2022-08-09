Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAEA58D1E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiHICKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiHICJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:09:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67811A393
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:09:21 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1xKJ4SlrzmVZL;
        Tue,  9 Aug 2022 10:07:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 10:09:18 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 10:09:18 +0800
Subject: Re: [PATCH] ARM: Remove the special printing format of pc and lr in
 __show_regs()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
References: <20220801032016.1524-1-thunder.leizhen@huawei.com>
 <YvDaYakZnP5Z+2ia@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9f630d80-68c7-8816-f2f6-7e39c890c4d1@huawei.com>
Date:   Tue, 9 Aug 2022 10:09:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YvDaYakZnP5Z+2ia@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/8 17:41, Russell King (Oracle) wrote:
> On Mon, Aug 01, 2022 at 11:20:16AM +0800, Zhen Lei wrote:
>> Currently, instruction pointers are printed in [<%08lx>] format to make
>> them more visible. However, it is not necessary in __show_regs() because
>> they have the prefix 'pc :' or 'lr :', and it is also inconsistent with
>> that of other registers, which causes misalignment.
> 
> The formatting is not "to make them more visible" - it was to mark the
> addresses that we wanted the ksymoops utility to translate to kernel
> symbols before we had kallsyms in the kernel. If one disables kallsyms,
> then we still need a way to translate kernel addresses to symbols.

I searched the git log and found that the ksymoops utility is discarded.

See:
073a9ecb3a73401662430bb955aedeac1de643d1
However, a commit in the pre-git era [1] had added the statement,
"ksymoops is useless on 2.6.  Please use the Oops in its original format".

That statement existed until commit 4eb9241127a0 ("Documentation:
admin-guide: update bug-hunting.rst") finally removed the stale
ksymoops information.

4eb9241127a0b5ac3aaaf1b246728009527ebc86
- delete all references to ksymoops since it is no longer applicable;

> 
> I notice there is a script which helps with this that is part of the
> kernel source - scripts/decode_stacktrace.sh. I haven't tried this on
> arm32 since I always use kallsyms - and I suspect that is rather
> universally true as it avoids needing System.map files etc to decode
> the oops. That said, if you're building a kernel for small systems,
> you probably don't want the overhead of kallsyms.

Yes, I read scripts/decode_stacktrace.sh, it requires the format "[<...>]".
But if that's the only concern, maybe we can do the conversion from
"pc: addr" and "lr: addr" to "[<addr>]" first in scripts/decode_stacktrace.sh

I'm usually "objdump -d vmlinux > asm_file", then search "addr:" in asm_file.

Honestly, I think format "[<...>]" is dump_backtrace()'s requirement, not __show_regs()'s.


> 
> So, there's an argument for keeping it - it's an API in that it
> provides hints to scripting to identify which values need to be
> converted to symbols. There's also the argument for getting rid of it,
> which is that hardly anyone does that anymore.
> 
> The question is, which is the more important argument, and I don't
> think there's a definite answer. So I'm inclined to leave this
> as-is.

OK

> 

-- 
Regards,
  Zhen Lei
