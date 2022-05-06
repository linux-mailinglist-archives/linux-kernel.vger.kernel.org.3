Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D0C51DF98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390793AbiEFTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390660AbiEFTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:18:58 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CE6D4E2;
        Fri,  6 May 2022 12:15:14 -0700 (PDT)
Received: from [192.168.1.30] (097-089-247-249.biz.spectrum.com [97.89.247.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A85273F616;
        Fri,  6 May 2022 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651864512;
        bh=AhY6XnbZGCaa4rZcAy/QJhv0KQphb6EX3UBpmJcYre4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IBsLG3MhrwhXcPHusLcHwEq1Qz0eU34L4OZe52BXOlw2nZXsjl456W8pvNW3AP6nA
         r5y9ej4AwjYpB7jgKCVKQ3GeALz9KeKvxdxmxXzBILE5AVekW++Xj1Zk4fOKZTMwtm
         9GK3100drIvlvEoS0qDLJosthdohnHwDg66yLFlWeN8lhZB8by9m2CrMGIrEoEcU++
         zQeRjnGbABdFyZUAqQT3nt0Of7RbBhUZZadHrjhGkCdei+Awjeo34uI41QsW0trray
         5tQY3xpOqFqs8B90+pxlJ9ncCU9IZBZCqzx/LUws2MsnNiByvonYRcnyoTWIvxf+RZ
         Kgbx3TdYi7teA==
Message-ID: <29829c01-f31e-2c4f-06e9-fc15c0261f93@canonical.com>
Date:   Fri, 6 May 2022 15:15:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Issue With real-time patches on 5.15.y
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-rt-users@vger.kernel.org
References: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
 <32803e0b-8ff6-ae8d-f9cb-ce2d3fd37229@intel.com>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
In-Reply-To: <32803e0b-8ff6-ae8d-f9cb-ce2d3fd37229@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 19:35, Dave Hansen wrote:
> On 5/5/22 16:18, Joseph Salisbury wrote:
>> The real-time kernel build failure can be resolved by reverting commit
>> b50854eca0e0.  The failure seems to be due to the removal of an include
>> of xstate.h from pkru.h and caused spinlock_t to not be defined.  The
>> commit would only be reverted for the real-time kernel and not any other
>> kernels.  I wanted to see if reverting the commit is the proper
>> approach, or if cherry-picking additional commits might be a better
>> solution in preparation for additional changes that might be coming in
>> the future?
>>
>> Any suggestions would be greatly appreciated.
> I thought you distro folks were the franenkernel experts. :)
>
> But, seriously...  This isn't rocket science.  Just look at the pkru.h
> in your tree and figure out what includes it needs.  If it needs FPU
> gunk, include the FPU header.  If you get a compile error for spinlock_t
> ...  well ...  find the code using spinlock_t and make sure it includes
> spinlock.h.
>
Thanks for the advice, Dave.

Your suggestion will probably be the easiest approach.  I was just 
trying to limit the amount of frankenkernel changes, since there are 
already so many  :-)  It's always best to stay as close to mainline as 
possible.
