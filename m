Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D572352EACB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348527AbiETL3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbiETL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:29:45 -0400
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A22215AB01
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:29:40 -0700 (PDT)
Received: from [77.23.249.31] (helo=srivatsab-a02.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1ns0p7-0005LB-Jg; Fri, 20 May 2022 07:29:37 -0400
To:     Borislav Petkov <bp@alien8.de>,
        Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     amakhalov@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
References: <20220520072857.592746-1-sshedi@vmware.com>
 <Yode3m6iia9ZBHsl@zn.tnic>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] x86/vmware: use unsigned integer for shifting
Message-ID: <c3219731-5f7e-80ea-b193-f8c93d7c1bdc@csail.mit.edu>
Date:   Fri, 20 May 2022 13:29:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yode3m6iia9ZBHsl@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreenidhi,

Thank you for the patch!

On 5/20/22 2:26 AM, Borislav Petkov wrote:
> On Fri, May 20, 2022 at 12:58:57PM +0530, Shreenidhi Shedi wrote:
>> Shifting signed 32-bit value by 31 bits is implementation-defined
>> behaviour. Using unsigned is better option for this.
>>

Can you also add a "Fixes:" tag with the commit that introduced the
issue? I believe it is 4cca6ea04d31 ("x86/apic: Allow x2apic without
IR on VMware platform").

>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>> ---
>>  arch/x86/kernel/cpu/vmware.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>> index c04b933f48d3..b28f789d3c56 100644
>> --- a/arch/x86/kernel/cpu/vmware.c
>> +++ b/arch/x86/kernel/cpu/vmware.c
>> @@ -476,7 +476,7 @@ static bool __init vmware_legacy_x2apic_available(void)
>>  {
>>  	uint32_t eax, ebx, ecx, edx;
>>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
>> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>> +	return (eax & (1U << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>>  	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> 
> Or you can use the BIT() macro and simplify this expression even more:
> 
>        return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
>                (eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
> 
> 

That's better indeed.

Regards,
Srivatsa
