Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9E57390C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiGMOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiGMOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9810232ECE;
        Wed, 13 Jul 2022 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=68ViflEzlXDx+7TKBapr6Ak8Jvjo25dHgw/5Ff89KiA=; b=HaOk0QSze3GgDOQtZ2NA1ChzrB
        usRgqoTT6zsaUHt8WwxG5NjIR/C3QKzIvOK8QiwZV49eD3cKcM7pshfOyxDFZNMJeyx+1uiE1u1BA
        igLOsmbFzYzVF5usNyifn9hftgG908/stYIT7ZbwHLL0GeHjXupvFUkBk7ICROmWcAw8zjYp1tXhA
        uDcu1qQYoaf0rleXhptUIFl8LKxfKeSPSritkl1naMbWV5AjZ6UwrMCaZe4ju+8EIJ97aUanDeFrN
        SqiNIZhfvbl7jBpBlurF8NVlxua+/AcW0sGs2XFfR0dk5APgiJSXgRHedNwzikoyi1xuiwgU5zat5
        6Hm6vLOw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBdZQ-004coL-AJ; Wed, 13 Jul 2022 14:42:32 +0000
Message-ID: <c2e80ab1-2c28-2963-9c5a-c7cff6b3450c@infradead.org>
Date:   Wed, 13 Jul 2022 07:42:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/4] pseries/mobility: set NMI watchdog factor during
 LPM
Content-Language: en-US
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        wim@linux-watchdog.org, linux@roeck-us.net, nathanl@linux.ibm.com
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220712143202.23144-1-ldufour@linux.ibm.com>
 <20220712143202.23144-5-ldufour@linux.ibm.com>
 <a646b2e9-e7a7-3d52-413e-4e2b8c48e383@infradead.org>
 <d78f65a7-67bb-b5f3-007b-fca5a9f98a69@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d78f65a7-67bb-b5f3-007b-fca5a9f98a69@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/22 03:56, Laurent Dufour wrote:
> Le 12/07/2022 à 18:25, Randy Dunlap a écrit :
>> Hi--
>>
>> On 7/12/22 07:32, Laurent Dufour wrote:

>>>
>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>>> ---
>>>  Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++
>>>  arch/powerpc/platforms/pseries/mobility.c   | 43 +++++++++++++++++++++
>>>  2 files changed, 55 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>>> index ddccd1077462..0bb0b7f27e96 100644
>>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>>> @@ -592,6 +592,18 @@ to the guest kernel command line (see
>>>  Documentation/admin-guide/kernel-parameters.rst).
>>>  
>>
>> This entire block should be in kernel-parameters.txt, not .rst,
>> and it should be formatted like everything else in the .txt file.

My apologies. I misread the file name.
I don't see a problem with this part of the patch or its location.

> Thanks for reviewing this patch.
> 
> I'll apply your requests in the next version.
> 
> However, regarding the change in kernel-parameters.txt, I'm confused. The
> newly introduced parameter is only exposed through sysctl. Not as a kernel
> boot option. In that case, should it be mentioned in kernel-parameters.txt?
> 
> Documentation/process/4.Coding.rst says:
> The file :ref:`Documentation/admin-guide/kernel-parameters.rst
> <kernelparameters>` describes all of the kernel's boot-time parameters.
> Any patch which adds new parameters should add the appropriate entries to
> this file.
> 
> And Documentation/process/submit-checklist.rst says:
> 16) All new kernel boot parameters are documented in
>     ``Documentation/admin-guide/kernel-parameters.rst``.
> 
> What are the rules about editing .txt or .rst files?

Yeah, that's a little confusing.
kernel-parameters.txt in included in kernel-parameters.rst when
'make htmldocs' is run, so the produced output looks like it is from
the .rst file.

Kernel boot parameters should be added to the .txt file.
The .rst file is just intro material.

Thanks.

-- 
~Randy
