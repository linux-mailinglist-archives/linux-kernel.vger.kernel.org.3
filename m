Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649714FBB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242499AbiDKLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiDKLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:47:56 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3AF43481
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:45:40 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5ae91f.dynamic.kabel-deutschland.de [95.90.233.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B154861EA1923;
        Mon, 11 Apr 2022 13:45:37 +0200 (CEST)
Message-ID: <ba56a9db-b34f-b2ce-baef-f8861476b3fc@molgen.mpg.de>
Date:   Mon, 11 Apr 2022 13:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv2] drm/amdgpu: disable ASPM on Intel AlderLake based
 systems
Content-Language: en-US
To:     Richard Gong <richard.gong@amd.com>
Cc:     airlied@linux.ie, xinhui.pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, alexander.deucher@amd.com,
        Dell.Client.Kernel@dell.com, christian.koenig@amd.com,
        mario.limonciello@amd.com
References: <20220408190502.4103670-1-richard.gong@amd.com>
 <44354d78-b340-fbc4-fd6c-060d7ad3404e@molgen.mpg.de>
 <45ea5705-71d6-4008-f094-1aa902e5cc41@amd.com>
 <0d0a3f0f-f021-ccc2-a80a-f789cb53a47b@molgen.mpg.de>
 <192375d0-85ac-ced0-43d6-e5ea4e3c0fae@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <192375d0-85ac-ced0-43d6-e5ea4e3c0fae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,


Am 11.04.22 um 13:38 schrieb Gong, Richard:

> On 4/11/2022 2:41 AM, Paul Menzel wrote:
>> [Cc: +<Dell.Client.Kernel@dell.com>]

>> Am 11.04.22 um 02:27 schrieb Gong, Richard:
>>
>>> On 4/8/2022 7:19 PM, Paul Menzel wrote:
>>
>>>> Am 08.04.22 um 21:05 schrieb Richard Gong:
>>>>> Active State Power Management (ASPM) feature is enabled since 
>>>>> kernel 5.14.
>>>>> There are some AMD GFX cards (such as WX3200 and RX640) that cannot be
>>>>> used with Intel AlderLake based systems to enable ASPM. Using these 
>>>>> GFX
>>>>
>>>> Alder Lake
>>> will correct in the next version.
>>>>
>>>>> cards as video/display output, Intel Alder Lake based systems will hang
>>>>> during suspend/resume.
>>>>
>>>> Please reflow for 75 characters per line.
>>>>
>>>> Also please mention the exact system you had problems with (also 
>>>> firmware versions).
>>>>
>>>>>
>>>>> Add extra check to disable ASPM on Intel AlderLake based systems.
>>>>
>>>> Is that a problem with Intel Alder Lake or the Dell system? 
>>>> Shouldn’t ASPM just be disabled for the problematic cards for the 
>>>> Dell system. You write newer cards worked fine.
>>>
>>> There is a problem with Dell system (Dell Precision DT workstation), 
>>> which is based on Intel Alder Lake.
>>>
>>> ASPM works just fine on these GPU's. It's more of an issue with 
>>> whether the underlying platform supports ASPM or not.
>>
>> At least you didn’t document what the real issue is,
> 
> You can refer to bug tag from the comment messages.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885

No, the commit message should be self-contained, and reviewers and 
readers of the commit message not required to read comments of bug 
reports. Please add the necessary information to the commit message.


Kind regards,

Paul


>> that ASPM does not work. With current information (some GPU graphics 
>> card with the the Dell system and others don’t), it could be the GPU, 
>> the Dell system (firmware, …), a problem with Alder Lake SOC, or 
>> another bug. I hope you are in contact with Dell to analyze it, so 
>> ASPM can be enabled again.
>>
>> […]
>>
>>
>> Kind regards,
>>
>> Paul
