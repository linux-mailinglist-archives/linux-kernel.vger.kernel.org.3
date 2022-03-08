Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CF4D232E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbiCHVUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCHVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:20:36 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C8E4739F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:19:38 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o12so118908ilg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QLkteIHRhUSwMXJUDME8Lv3LFalvJ1bqMQRnTxAe590=;
        b=HPHLxDYxsD2+TZ97by9ltALMf5ZHAJRHroJziBzdFwPuSJCKFZe4Yg027YVsTH6yCw
         i3KnR6zXLuQMsYM4TizAFnN6ywf0cp6as6NL0rWeD34y0dg06ufDv99CZ6frUbi4E0uE
         ISz7vzV+iA8emrmC8AR103T/jvoipxfWillrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLkteIHRhUSwMXJUDME8Lv3LFalvJ1bqMQRnTxAe590=;
        b=ifuqRamJ8vVgvTZeOSyx84pnJq28yLzEEEvBcgFz50ImmKNBDg9VdIsbU/MqbmVOr3
         YyznFpCrjjo5KP/qsIaFOrTGFZwFdt5ZC4EFWF6GCmFRDZGEs84wvcT7UZQbSRfjrocq
         VUtoEr63H6SFV/ln9MtBZfBl9e4z+8cBe9ARn5ApKSTqBleqIO9qpHajeJrjxs2GNmOD
         2Qc+d0mB36abu1PDuRCUaiIpzjBTzu5yhUrys8Dkd/EAs3EGrGTh6SQpIoiqA/IplyHn
         lJZfvwk00yElGMZT2+zI1QzmmW0UQ7bBy+4pyJuqfZd2puSjkPMrUB1D26UmUUEsOEwx
         hIqQ==
X-Gm-Message-State: AOAM531GJPI22DcuFixVCILShcMle9N80yL/jvbF2hWsDxRSXEoXWiPf
        YzAtMFndTY63aA6M/yzlHEhrog==
X-Google-Smtp-Source: ABdhPJyv+OH6SuRIzmqviaFC/odZEMdUR/TmLwGhSf+amvFfnigvBORf3Lp73Pst8YT7Bsp/7ZB+pA==
X-Received: by 2002:a05:6e02:5b1:b0:2c6:218d:fb38 with SMTP id k17-20020a056e0205b100b002c6218dfb38mr17562252ils.266.1646774377886;
        Tue, 08 Mar 2022 13:19:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d9647000000b00638d53cd21esm11212583ios.26.2022.03.08.13.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 13:19:37 -0800 (PST)
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel@collabora.com, kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
 <6e954470-f593-e27a-d15c-ecd5c28f4dca@linuxfoundation.org>
 <2ac8cecb-5e14-a8b2-7629-a9ab9d474585@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <65c11aba-bcab-28f4-a016-8cad128809ad@linuxfoundation.org>
Date:   Tue, 8 Mar 2022 14:19:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2ac8cecb-5e14-a8b2-7629-a9ab9d474585@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 1:11 AM, Muhammad Usama Anjum wrote:
> On 3/4/22 2:32 AM, Shuah Khan wrote:
>> On 2/23/22 12:10 PM, Muhammad Usama Anjum wrote:
>>> Build of kselftests fail if kernel's top most Makefile is used for
>>> running or building kselftests with separate output directory. The
>>> absolute path is needed to reference other files during this kind of
>>> build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
>>> fixes the following different types of errors:
>>>
>>> make kselftest-all O=/linux_mainline/build
>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>
>>> make kselftest-all O=build
>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> I've tested this patch on top of next-20220217. The latest next-20220222
>>> have missing patches.
>>
>> Can you give more details on the use-cases you tested? Did you test all
>> the ways kselftest are built?
>>
> Yeah, I've tried to test all the ways. Here are the different ways I've
> used to test it:
> 1) Same directory build of kselftest (this is already working)
> make kselftest
> make kselftest-all
> make kselftest-install
> make kselftest-clean
> make kselftest-gen_tar
> 
> 2) These were failing when separate output directory is specified either
> as relative or absolute path. After adding this patch, these are also
> working. kselfetst.rst mentions separate output directory build in this way.
> make kselftest O=build
> make kselftest-all O=build
> make kselftest-install O=build
> make kselftest-clean O=build
> make kselftest-gen_tar O=build
> 
> make kselftest O=/build
> make kselftest-all O=/build
> make kselftest-install O=/build
> make kselftest-clean O=/build
> make kselftest-gen_tar O=/build
> 
> Tested on top of next-20220307 after applying this patch.
> 

Thank you for testing all these use-cases. This is a good comprehensive
list. Do you mind sending a doc patch for

Documentation/dev-tools/kselftest.rst

The text here could almost as is as a new section after

Contributing new tests (details) with a new section that outlines
the tests to run when adding a new test to selftests/Makefile
and making changes to kselftest common frameowork: selftests/Makefile,
selftests/lib.mk

Let me know if you are unable to, I will send a patch in.

thanks,
-- Shuah
