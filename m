Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963E34E457D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiCVRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiCVRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:52:21 -0400
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A996D3BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:50:52 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 5F3FEFA1325
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:50:52 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id Wieinnl7Yb6UBWiein3c7H; Tue, 22 Mar 2022 12:50:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EMkcbT+z9hMOzCQkn6zBneEne+tFD8pPsSScVB5S/8c=; b=tKSGP7T3pSSclCVTZcl0BF07xK
        V2cH7CWm9DyHmYD5pdewLguU80f+3UlP08AEGWnkqKBQOC3a5r9nr7fdo3G5rKOiefZGfYny2trfA
        lKKpNmqO+iogtwwWnV+IpBCmM3KsWEN2LfWPGE8zcdCedivQDCBhpvhVWwh13h9kiLn9y9zBDQ+xj
        xidJLOUIconUNrEB47IP5XNfPochoTLkbxCuaMKJB1amoiLyzuOVq3Gdmq1Ku3ntR7qCGF9dd+cSN
        l+VsSt9hM3xoNzUH2UF8AFzJ4gDWnmWDTDt3iuhX4g+9WY2BhayVAm3FOMa+FJH9pRlGTK4skmOKm
        85BuCSSQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54400)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWieh-002Tku-QZ; Tue, 22 Mar 2022 17:50:51 +0000
Message-ID: <11063f42-6d3c-64d2-f3ed-9593be469fa5@roeck-us.net>
Date:   Tue, 22 Mar 2022 10:50:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org> <YjjJNb0D/b+ZXBVZ@ls3530>
 <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
 <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
 <20220322130516.GA724287@roeck-us.net>
 <ccc25312-890a-a534-1681-5ecde56328d0@gmx.de>
 <78abe69b-7914-1b38-c94e-7143f61f4909@roeck-us.net>
 <4d52b78d-ed39-102f-ba64-3ba9c17f58f9@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <4d52b78d-ed39-102f-ba64-3ba9c17f58f9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWieh-002Tku-QZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54400
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 09:16, Helge Deller wrote:
> On 3/22/22 16:19, Guenter Roeck wrote:
>> On 3/22/22 07:25, Helge Deller wrote:
>>> On 3/22/22 14:05, Guenter Roeck wrote:
>>>> Does that also fix the build problems now seen in mainline ?
>>>
>>> No.
>>>
>>>> Building parisc64:generic-64bit_defconfig ... failed
>>>> --------------
>>>> Error log:
>>>> arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>>>> arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>>>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
>>>> ...
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc without corresponding .cfi_startproc
>>>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
>>>> make[2]: *** Waiting for unfinished jobs....
>>>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
>>>> make[1]: *** [arch/parisc/Makefile:177: vdso_prepare] Error 2
>>>> make: *** [Makefile:219: __sub-make] Error 2
>>>>
>>>> This is with hppa64-linux-gcc (GCC) 11.2.0.
>>>
>>> Can you check if you have the 32-bit compiler (hppa-linux-gcc) installed too?
>>> The errors above happen when building the 32-bit vDSO, for which you need the 32-bit compiler.
>>>
>>
>> Yes, I do, but that doesn't help much if I want to build a 64-bit target such
>> as generic-64bit_defconfig. Am I missing something ?
> 
> The 64-bit PA-RISC kernel now includes a built-in a 32-bit and a 64-bit vDSO for userspace.
> To build the 32-bit vDSO (vdso32) you need the 32-bit hppa compiler installed.
> That's what's being done above - see the path: arch/parisc/kernel/vdso32/
> Can you try "make V=1" to see the command line?
> 


I am currently bisecting another problem. I'll try that afterwards.
Either case, how does one specify two cross compilers with two different
prefixes on the command line ?

Guenter
