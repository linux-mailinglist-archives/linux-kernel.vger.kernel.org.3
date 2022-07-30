Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D9C585950
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiG3JGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiG3JGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:06:16 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF9933E27;
        Sat, 30 Jul 2022 02:06:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso4820603otv.3;
        Sat, 30 Jul 2022 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=4eVRrmQ+WXTUA655hJC7om/Fw3gm4iKU9b/x4bJL90A=;
        b=J+r/cTKaC7sX+nLput/6FyeuQ2jWiikEwrwsmUBWQSWAqoIH9ZS3G7DyyVXhbIRWN3
         t+a9Hfa9oBQfWBipeAqIiLzzpGQM307ARmC1mp5YtOuzbqMjDDrZk3Z7UGwdVGNlcf4Y
         4ipwWMSRKRvYfUghdmPEmTl1iKi3aWv+YCV41Gn1FRwl7HSZTS6lcsrOIbbBMN+piQny
         +IlU7zpmj/+iWY4bHv8Gq+1yBK4n1MsB0ryjip0UNWz/uiUCJazYDQhd1JlZt6+F4VBC
         N0KhOvzQtZcTqbn3oamQFhbqygpDCE5wz/+3rNUAzqCL0uK1H6yEORWhRlEi+OJCbz1r
         yRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=4eVRrmQ+WXTUA655hJC7om/Fw3gm4iKU9b/x4bJL90A=;
        b=ApW/PSOP8jfaEzrEWDGhVjAoXYhvupzf4qol2V845atCF515jq5LXe9BoDy5A7Qkn+
         RyxwlQlIGdlNhpPdolTLDL59Eq4YHiEPocfw+FXgz0JqQ7sJUmiR6tS9a8wN/j5UFZDT
         xMveAKeoHpLCuftZDVS32BypKXiBDSLsePBs5R4BZCuA6OO/A1HgypD2McJvSBdASZQC
         2R2uN7Vf7cddX7uDWSV4GDXgkFu5ybGQq84nP8w6QmguwUNLAYS0043G2WbX+sIQRDsK
         9eHQ0MPRBxfdLVlkcZGOdQEq94/4qGjFz77enKPRxCR8DUBybZzXbl8CfgRALovuadUq
         8ffg==
X-Gm-Message-State: AJIora+zT2JkBTok+5hJJ7VuIp8H6i1tkFEPEL8RLRB0m5V/nYNpbc1Y
        Bsynz06gpn3HzOyj6AeVhRDzXWfg7DcLUQ==
X-Google-Smtp-Source: AGRyM1tx2RCvf5THPT7g5vMumNDZwSgV7NHBp0eGgabTb6fToRvUbVhKrQcvmNq0qVoMOtPaq2NAeQ==
X-Received: by 2002:a05:6830:d81:b0:616:abfa:796f with SMTP id bv1-20020a0568300d8100b00616abfa796fmr2849828otb.18.1659171974604;
        Sat, 30 Jul 2022 02:06:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020a056830164400b0061c9c7813d4sm1658129otr.24.2022.07.30.02.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 02:06:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <80410e6e-838b-fa3d-1f87-710eb3c751c5@roeck-us.net>
Date:   Sat, 30 Jul 2022 02:06:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Stack-frame warnings in display_mode_vba_32.c
Content-Language: en-US
To:     paulmck@kernel.org,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     sfr@canb.auug.org.au, harry.wentland@amd.com, sunpeng.li@amd.com,
        arnd@arndb.de, alexander.deucher@amd.com,
        linux-next@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220730022532.GA1234397@paulmck-ThinkPad-P17-Gen-1>
 <85a49b72-8bb7-b3b3-8a69-2c90cda8079d@igalia.com>
 <20220730051238.GR2860372@paulmck-ThinkPad-P17-Gen-1>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220730051238.GR2860372@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 22:12, Paul E. McKenney wrote:
> On Fri, Jul 29, 2022 at 11:41:55PM -0300, André Almeida wrote:
>> Hi Paul,
>>
>> Às 23:25 de 29/07/22, Paul E. McKenney escreveu:
>>> Hello!
>>>
>>> I am seeing the following in allmodconfig builds of recent -next on x86:
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function ‘DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation’:
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1659:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>>>   1659 | }
>>>        | ^
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function ‘dml32_ModeSupportAndSystemConfigurationFull’:
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2480 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>>>   3799 | } // ModeSupportAndSystemConfigurationFull
>>>        | ^
>>
>> I think they are fixed at amd-staging-drm-next:
>>
>> git log --oneline amd/amd-staging-drm-next
>> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>> 953daa61981b drm/amd/display: Reduce stack size in the mode support function
>> 361e705e712d drm/amd/display: reduce stack for
>> dml32_CalculatePrefetchSchedule
>> f2dbf5a4dd1e drm/amd/display: reduce stack for
>> dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
>> a0a68cda2ef8 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
>> ca6730ca0f01 drm/amd/display: reduce stack for
>> dml32_CalculateSwathAndDETConfiguration
>> 593eef8c1a5e drm/amd/display: reduce stack size in dcn32 dml (v2)
>>
>> https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> 
> Very good, thank you!  I will test again on the next -next.
> 

Did you try next-20220728 ?

groeck@server:~/src/linux-next$ git describe
next-20220728
groeck@server:~/src/linux-next$ git log --oneline drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c
1b54a0121dba drm/amd/display: Reduce stack size in the mode support function
86e4863e67a9 drm/amd/display: reduce stack for dml32_CalculatePrefetchSchedule
3c3abac60117 drm/amd/display: reduce stack for dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
c3b3f9ba25e6 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
bac4b41d917a drm/amd/display: reduce stack for dml32_CalculateSwathAndDETConfiguration
7acc487ab57e drm/amd/display: reduce stack size in dcn32 dml (v2)

Guenter
