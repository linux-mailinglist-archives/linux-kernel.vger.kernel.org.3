Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE251DD88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443753AbiEFQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443746AbiEFQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:27:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A676B097
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:23:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e189so7981029oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKR1p2XpapTkYTRRGdf56YSSJBMEPrgZBznxidBKLms=;
        b=FifVGujk5CYZw9INUWSaYsjuguzlc6FVqyvGQxK+CXMFIAj34CHTH4MURITWp/780b
         hpvkAYUtMaF6Y+GzmxmlMQgIa1gomt5iALx1LC0Z1BlYpyETqLgXJ3PoIz6nVH7f2OlB
         f3NTsF3hqDCdqtrJbaeOGeV+xAb4SKTXTKGG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKR1p2XpapTkYTRRGdf56YSSJBMEPrgZBznxidBKLms=;
        b=c+lpQrL92e9APLi5/Ql79j6Y8TpXqIAaf5tuiQ80dL1uDVlH4AubGQzkROv9R7x8xL
         1xy2Z/1yJME1UYk7cGg4GDFov6KTiQorlcoj9FPTxWR6r45/Vniu56QTzJ96Y1m3F2wi
         BJqAuAWiNceSUXzeMmr3P8h2jW3LKLC+uTUvWCZpIvtwfZbyWHoMC5iAJh26OXj6RWhW
         kEBZvFnaXg8nr/+xoskObyA4Izuv1HsbJ2dFEzVd9xbueAjcnSgFhYLpKmT52BnSWCBj
         jhGqYVtU6BqIXj241lKti6ejR/7NE8oq9pI6K6o37ZFFiSJXLhEnanHNxCTmAJIwgwA8
         5V7A==
X-Gm-Message-State: AOAM533Wh3oqTyRzzFGi3dUBWp4uiEgkrdQRmhgd+/K+Jhif42VMGK9q
        bdqZYgb88MssYdYBiY0HLdyCPg==
X-Google-Smtp-Source: ABdhPJzqYzGLNGpOMnI0vx6E0reoKjwmACMdIM1kV7RuedYut8iUJNPgJ5XCkhsQQDKfxu4zrzrGQg==
X-Received: by 2002:a05:6808:180f:b0:326:60a9:501b with SMTP id bh15-20020a056808180f00b0032660a9501bmr5147973oib.91.1651854224289;
        Fri, 06 May 2022 09:23:44 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p11-20020a4ab38b000000b0035eb4e5a6c2sm1981364ooo.24.2022.05.06.09.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:23:43 -0700 (PDT)
Subject: Re: [Ksummit-discuss] uninitialized variables bugs
To:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, kbuild@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220506091338.GE4031@kadam>
 <CAK8P3a0DY2b15yyzpwsjOCqOALfTbsmYf1kTnQZF5wPW8mtFbQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dc58c60e-a92c-92b8-ae5e-d7cf2ef5f051@linuxfoundation.org>
Date:   Fri, 6 May 2022 10:23:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0DY2b15yyzpwsjOCqOALfTbsmYf1kTnQZF5wPW8mtFbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 5:56 AM, Arnd Bergmann wrote:
> On Fri, May 6, 2022 at 11:13 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
>>
>> It's frustrating.  Sometimes the false positives are hard to analyse
>> because I have to read through multiple functions.  A lot of times
>> when I write a patch and a commit message Nathan has already fixed it
>> so it's just a waste of time.
> 
> Agreed. I'm not actually checking for those warnings on gcc any more,
> but just the clang warnings point to a bigger problem.
> 
>> It's risky as well.  The Smatch check for uninitialized variables was
>> broken for most of 2021.  Nathan sometimes goes on vacation.
>>
>> I guess I would hope that one day we can turn on the GCC uninitialized
>> variable warnings again.  That would mean silencing false positives
>> which a lot of people don't want to do...  Maybe Clang has fewer false
>> positives than GCC?
> 

I would like to throw resource leak bugs in the mix. I am finding cppcheck
has been effective in finding them.

I am seeing a lot of file pointer leaks  in error legs in kselftest code error
paths. I have a few fixes in the works to send out.

We could discuss this topic at the LPC Kernel Testing and Dependability mini-conf
as well.

thanks,
-- Shuah



