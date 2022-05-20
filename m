Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBF52EF72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiETPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiETPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:41:30 -0400
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94DA7163285
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:41:27 -0700 (PDT)
Received: from [77.23.249.31] (helo=srivatsab-a02.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1ns4kk-000Jtb-1u; Fri, 20 May 2022 11:41:22 -0400
To:     Shreenidhi Shedi <yesshedi@gmail.com>, amakhalov@vmware.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
References: <20220520140954.597725-1-sshedi@vmware.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] x86/vmware: use unsigned integer for shifting
Message-ID: <a38ef828-dbfa-59c0-475d-e16c44267e6b@csail.mit.edu>
Date:   Fri, 20 May 2022 17:41:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220520140954.597725-1-sshedi@vmware.com>
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

On 5/20/22 7:09 AM, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> From: Shreenidhi Shedi <sshedi@vmware.com>
> 
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.
> 
> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..cd809c5b17f0 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpu.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
> +#include <linux/bits.h>
>  #include <asm/div64.h>
>  #include <asm/x86_init.h>
>  #include <asm/hypervisor.h>
> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> +		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC))


This patch has clearly not been tested, and not even compiled! (It is
missing a semicolon at the end of the return statement).

Please take your time to revise and test your patch based on the
review feedback; there is no hurry! :)

(Also, while at it, the double From: at the beginning of the patch
needs to be fixed too).

Regards,
Srivatsa
