Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53F65026DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351451AbiDOInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351443AbiDOImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:42:38 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E82FFD7;
        Fri, 15 Apr 2022 01:39:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VA6gkh3_1650011989;
Received: from 192.168.193.180(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0VA6gkh3_1650011989)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 16:39:50 +0800
Message-ID: <145a1355-d961-9a67-0e08-a13619b3e827@linux.alibaba.com>
Date:   Fri, 15 Apr 2022 01:39:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220413213917.711770-1-keescook@chromium.org>
 <f7a5642f-bfcb-865d-7039-d0b9d62a3360@linux.alibaba.com>
 <202204141019.CD9152A7@keescook>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <202204141019.CD9152A7@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/22 10:22, Kees Cook wrote:
> On Thu, Apr 14, 2022 at 03:19:02AM -0700, Dan Li wrote:
>> Hi, Kees,
>> Thanks for the rewrite. I tested this patch, and it works fine for
>> me except for a few minor comments below :)
>> We may need to ignore the pac high bits of return address according
>> to TCR.T1SZ (or simply remove the high 16 bits before comparing).
> 
> Oh! Hah, yes, I totally forgot that. Thanks for testing -- getting PAC
> emulation working in QEMU has eluded me. I think untagged_addr() will
> work yes? i.e.:
> 
> 	if((untagged_addr(*ret_addr) == expected)
> 

untagged_addr might not clear enough bits, the following code works
fine for me:

+#define no_pac_addr(addr)      \
+       ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
        
-       if(*ret_addr == expected)
+       if(no_pac_addr(*ret_addr) == expected)
                 *ret_addr = (addr);

I re-checked the arm manual and found that the pac bits in an address is:
- Xn[54:bottom_PAC_bit]		 //When address tagging is used
- Xn[63:56, 54:bottom_PAC_bit]	 //When address tagging is not used

bottom_PAC_bit = 64-TCR_ELx.TnSZ //For kernel is VA_BITS

The pac bits could be at most [63:56, 54:VA_BITS], untagged_addr
clears [63:56] (and clearing the high 16 bits doesn't seem to be
enough either :) ).

For example, when CONFIG_ARM64_VA_BITS_39 enabled, i get a case:
- lr         : 0xffffffc0088d04f8
- lr with pac: 0x5681a740088d04f8
- PAGE_OFFSET: 0xffffff8000000000

"lr with pac|PAGE_OFFSET" seems to meet the need.

>>
>>> +	else
>>> +		/* Check architecture, stack layout, or compiler behavior... */
>>> +		pr_warn("Eek: return address mismatch! %px != %px\n",
>>> +			*ret_addr, addr);
>>
>> According to the context, it might be "expected" here?
>>
>> 		pr_warn("Eek: return address mismatch! %px != %px\n",
>> 			*ret_addr, expected);
>>
>> I simply ignored the upper 16 bits, and tested it separately
>> in gcc/llvm 12 with SCS/PAC and all the four cases worked fine for me.
> 
> Great! Do you have the PAC "Oops" text handy so I can include it in the
> commit log as an example of what should be expected?
> 

Yeah, in my test environment I get the following output:

/kselftest_install/lkdtm # ./CFI_BACKWARD.sh
[   58.333529] lkdtm: Performing direct entry CFI_BACKWARD
[   58.333927] lkdtm: Attempting unchecked stack return address redirection ...
[   58.334230] lkdtm: ok: redirected stack return address.
[   58.334870] lkdtm: Attempting checked stack return address redirection ...
[   58.336287] Unable to handle kernel paging request at virtual address bfffffc0088d0514
[   58.336633] Mem abort info:
[   58.336789]   ESR = 0x86000004
[   58.336992]   EC = 0x21: IABT (current EL), IL = 32 bits
[   58.337234]   SET = 0, FnV = 0
[   58.337429]   EA = 0, S1PTW = 0
[   58.337611]   FSC = 0x04: level 0 translation fault
[   58.337874] [bfffffc0088d0514] address between user and kernel address ranges
[   58.338304] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[   58.339209] Modules linked in:
[   58.340384] CPU: 1 PID: 131 Comm: cat Not tainted 5.18.0-rc2-29474-gb8dcca8f6a13-dirty #393
[   58.340842] Hardware name: linux,dummy-virt (DT)
[   58.341231] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   58.341593] pc : 0xbfffffc0088d0514
[   58.342255] lr : lkdtm_CFI_BACKWARD+0x108/0x130
[   58.342716] sp : ffffffc00a73bc60
[   58.342906] x29: ffffffc00a73bc60 x28: ffffff8003320000 x27: 0000000000000002
[   58.343462] x26: ffffffc00a204d00 x25: 0000000000000002 x24: ffffffc0092e72f0
[   58.343863] x23: 0000000000000006 x22: ffffffc00a204d10 x21: ffffff80188d2000
[   58.344264] x20: ffffffc00a73bde0 x19: ffffffc00a302000 x18: ffffffffffffffff
[   58.344732] x17: 663a72646461202c x16: 3866343064383830 x15: 0000000000000004
[   58.345112] x14: 0000000000000fff x13: ffffffc009f8a3e0 x12: 0000000000000003
[   58.345492] x11: 00000000ffffefff x10: c0000000ffffefff x9 : 90af2887c07d9500
[   58.345926] x8 : ffffffc0088d04f8 x7 : 205d323234353333 x6 : 332e38352020205b
[   58.346288] x5 : ffffffc00a2c313c x4 : 0000000000000001 x3 : 0000000000000000
[   58.346670] x2 : 0000000000000000 x1 : ffffffc00968626d x0 : 000000000000006d
[   58.347154] Call trace:
[   58.347419]  0xbfffffc0088d0514
[   58.347806]  lkdtm_do_action+0x1c/0x30
[   58.348085]  direct_entry+0x178/0x1b0
[   58.348291]  full_proxy_write+0x6c/0xe8
[   58.348523]  vfs_write+0x174/0x3b0
[   58.348721]  ksys_write+0x78/0xe4
[   58.348914]  __arm64_sys_write+0x1c/0x28
[   58.349125]  el0_svc_common+0xa4/0x134
[   58.349354]  do_el0_svc+0x24/0x7c
[   58.349551]  el0_svc+0x28/0xa4
[   58.349745]  el0t_64_sync_handler+0x84/0xe4
[   58.349995]  el0t_64_sync+0x170/0x174
[   58.350659] Code: bad PC value
[   58.351182] ---[ end trace 0000000000000000 ]---
CFI_BACKWARD: saw 'call trace:|ok: control flow unchanged': ok

Thanks,
Dan.
