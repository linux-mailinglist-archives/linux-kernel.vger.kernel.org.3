Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA58563610
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiGAOqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiGAOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:45:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031315A23;
        Fri,  1 Jul 2022 07:45:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 128so2640698pfv.12;
        Fri, 01 Jul 2022 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=AegXoaT67U049NkEtzNZb6ehTXo7Zibz7gdRn9ypXjk=;
        b=GSwVOoN3SkUdkhIZ5Q25toefGWglJKYzSe5LZNh/SBVILEfTqW5emW45IqUeEEI7uv
         eXsXFnLRv7KkBVsIQTJagAHcV5t5bSW2gJguEfgnT6/JkmASkm+prnfgfCvuTU0d1+ya
         pt6oN5EgvzEm9Cm9uerafA3MXiVVFQwzGeBx2msYxUd+EDlOD1lT6l5re5nLjkOee0Sd
         S7h9MsHrbaN7iLKodv/iu4QLLg+f0tbl0tLDh23BLMaUCcfPaL2piBCPsxT5GLzDLJaF
         vJANAyfDCwdLwbi8IIfuZ93airWMM+3Ua+xeKOaFkz7i5YixPCfgV3UHIpbG2BaJUa+Q
         a8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=AegXoaT67U049NkEtzNZb6ehTXo7Zibz7gdRn9ypXjk=;
        b=ZsD/3ooPRUBCdwrbqfwBRf0xDzsmdaKp8wtDx+/SBLAq9ju7RhE2av+nMIHl6iE1OB
         LsoG1TbQNAdQFvKnrFTd5ib+Z1dBa50VMmZqOIyyXfaSbuezlkjYkua3iZX/LODoRf79
         rorOT5Eg0gSSumdL3JONbsnRxZ1VqxKBzuXmBRaFzRIPJjx6z29c9xcbG0VJ3vUsDkNr
         P8u81G0XmbDgov1aWerkEl/eDYvuHxNqUIJ3NvGzE8Xcd+CtZrEjyLmn197xcnoR8gu4
         dW1IOx/h479o4nc4Q1yLUHi65WJQzxaLA33sAynZm1IekZ0rj9HBEmpg7Zic2ZnQfJOG
         0UQg==
X-Gm-Message-State: AJIora9foULiR0TX8x2qHV0OAmSnSBKArMraZXWnvRciYFEdPS/0a7rY
        SS8BSgdueTYMHKhiEMjiPkc=
X-Google-Smtp-Source: AGRyM1uL1H83FMZzdz//ZsV4zqI8yIugN7N8q0z+T397kmwzGp6LFlFWyz9eFDL+vvMEij+jcUENRA==
X-Received: by 2002:a63:7248:0:b0:40c:762e:c866 with SMTP id c8-20020a637248000000b0040c762ec866mr12706580pgn.558.1656686754649;
        Fri, 01 Jul 2022 07:45:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a66c200b001ece55b938asm4196258pjl.32.2022.07.01.07.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:45:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56166be5-e30f-8f2a-e85a-09b993c7a8f0@roeck-us.net>
Date:   Fri, 1 Jul 2022 07:45:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Gabriele Paoloni <gpaoloni@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
 <168af019-70d1-3237-dc9c-56a82beb5990@roeck-us.net>
 <04ca385b-47dc-5535-419e-1b814a383d1a@kernel.org>
 <CA+wEVJbvcMZbCroO2_rdVxLvYkUo-ePxCwsp5vbDpoqys4HGWQ@mail.gmail.com>
 <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
 <20220628153256.65dc84dd@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
In-Reply-To: <20220628153256.65dc84dd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 12:32, Steven Rostedt wrote:
[ ... ]
>> I am open to suggestions from others, but at this point I have serious doubts
>> that this code is maintainable in the kernel.
>>
> 
> Let me give some background on this. Various safety critical users
> (automotive, power plants, etc) are looking at using Linux in the field.
> Obviously, Linux itself is too big to verify properly. In fact, even small
> OSs that say they are verifiable seldom are. Part of the solution is to add
> a way to check that Linux is running as expected, and be able to detect
> when it is not. When that happens, you fall into a "fail-safe" mode (for
> example, if you have an autonomous driving vehicle, it could sound an alarm
> and inform the driver to go into manual mode, or it is going to simply
> "pull over". Note, this is just a hypothetical example, not something I've
> seen in reality).
> 
> But to implement this, you need to verify the verifier. In this case, the
> watchdog timer is what verifies that Linux is running properly. It is
> possible to verify parts of the kernel when you limit the inputs of the
> kernel. This means we are not trying to verify all use cases of the
> watchdog timer. That would be pretty much impossible, or take decades to
> complete. We only need to verify the use cases used in safety critical
> systems.
> 

I understand the context. However, ...

> Do not confuse this with static analyzers or other general purpose tooling
> to find bugs. This is not the purpose of the run time verify. It is just to
> prove that certain use cases will perform as expected, given a limited
> input.
> 

... this is, unfortunately, not explained in the patch. I would have much less
of a problem with the series if those details were included.

Not that I would mind such a verifier, if it was possible to define one,
but it would have to be tested with a large number of watchdog drivers
to ensure that it addresses all use cases, or at least with a substantial
percentage of use cases. It would also require that the state machine is
readable to give people a chance to fix it if turns out to be broken.
It would also have to be robust, meaning it would have to reject invalid
(unsupported) settings from the start and not only during runtime.

Thanks,
Guenter

