Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC74D2890
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiCIFt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiCIFtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:49:51 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A035140C8;
        Tue,  8 Mar 2022 21:48:53 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id i66so693109wma.5;
        Tue, 08 Mar 2022 21:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L/2hLME7wbG3iYnMiEc+NU9UJToaXXdZRluS6g6KT3U=;
        b=s4pJMRiD/XjJ6QgGW9miRxfJw6S9FL9smGmxh8vqjh5BqZspsG3BVZN2Sse9uMeCVV
         joYsmUKXFNKNJB7YpCXYEw1fb07CooBKlW4kTP/qTsaesjfHzgF6FJENUbW3HR1NeebT
         88QS61oRmyAlUYY04+c4V8bPgCrq7dNgQ3od1BPgV4om9G8E6leS9LB1psW3AMQ+npUa
         DXZ05AiCyvG7+W3jtgrG3hfUaJJOlxdpPB+yX4HqaMEA1e77zkKTvMbHrH7N0os0QsC2
         73hXte98Vj0xV4UGwwFO7VtpNUF5dG4/TPsL1EIyhKKvLdI1AJOAPA36iV63Xwe949+Y
         McUQ==
X-Gm-Message-State: AOAM531vqdv8ou+4foDV2k5jnEU7KXQ4/l4NpyHWKl8SBWJdatb0XWjW
        sSRFQd3iyAa9ZT2gnFy2Qjm+VcAOH78=
X-Google-Smtp-Source: ABdhPJyr+zRDrqPwGQ9WMZPFvipbWpPfP0XxBgmuP68pwUNHCELlQIQESYkX7Pxrx0w2KNGD8YojUg==
X-Received: by 2002:a1c:4404:0:b0:382:a672:987b with SMTP id r4-20020a1c4404000000b00382a672987bmr6233389wma.115.1646804931467;
        Tue, 08 Mar 2022 21:48:51 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm678289wml.29.2022.03.08.21.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 21:48:50 -0800 (PST)
Message-ID: <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
Date:   Wed, 9 Mar 2022 06:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08. 03. 22, 15:51, Helge Deller wrote:
> Hi Jiri,
> 
> Thanks for testing on parisc!
> 
> On 3/8/22 12:06, Jiri Slaby wrote:
>> since the "parisc: Add vDSO support" commit, I can no longer cross-build a hppa kernel. I see two issues:
>>
>> 1) CROSS32_COMPILE detection doesn't work here, as openSUSE provides hppa-suse-linux-* binaries. It's easy to overcome by "CROSS32_COMPILE=hppa-suse-linux-"
> 
> How is it handled for other platforms like s390x?

s390 simply uses CC for vdso32:
cmd_vdso32cc = $(CC) $(c_flags) -c -o $@ $<

> Would it make sense to add the detection for SUSE too?

Maybe.

>> 2) openSUSE doesn't provide any libc for hppa. So gcc doesn't provide libgcc.a and the build of vDSO fails.
> 
> libgcc.a comes with the compiler, I don't think you need libc for that.

I was told glibc is needed to build libgcc.a.

> I'm currently installing opensuse to try myself though...
> 
>> So could vDSO be optional on hppa via KConfig?
> The vDSO is one of the first things which is built during kernel build process.
> This is why you fail.
> Making it optional doesn't make sense, because then the kernel wouldn't be able
> to start the user space processes.
> 
>> I used to use the cross compiler to at least compile-check the following  tty drivers:
>> arch/parisc/kernel/pdc_cons.o
>> drivers/tty/serial/mux.o
>> drivers/tty/serial/8250/8250_gsc.o
> 
> I assume you never built a full kernel, but stopped when building those modules?
> Without libgcc.a the kernel itself wouldn't have linked before either.

Correct, I am only build-testing parisc-only drivers when doing global 
tty changes.

thanks,
-- 
js
suse labs
