Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518F5807B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiGYWn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbiGYWnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:43:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E5C29CA5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:41:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w10so137606plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=+gsloq9DrRj40wgtL1Bj5I/zKXAptLmoCHjL2BnUObw=;
        b=qUtmtma6HAQJVGOAzv8j1zpuhY/PD+n2lLtrvXqfLjDEbW/92oJFBSdQSqvu0vrBl1
         6wA5y5aBh4XKOitO+OtYvo6eIpaT54/UGk0fdpdZZrk5dWPezSTLL1T1dX5bNd6Fejmy
         wLZQ58Uh9DVm4Q9Vwasenaz16K7iKmeICk5jmwSYudByNWr4HffVTxdC0gZv5NSfXM7d
         h38haZ1YMo7ToVhCDJr7KtgZ+MhXyr2vZFb8eeHqZk9oqtrUHMJN2887ZizkRpG4a9Xq
         a/V6LSSiy7mRYJSLoWW67r75jEdfwxX8h22LSYiYxrZqvGTo1UdtTggGJHe6S4fqi1gM
         pIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=+gsloq9DrRj40wgtL1Bj5I/zKXAptLmoCHjL2BnUObw=;
        b=5j4fq4+vXt9+4T8PaZaCDSC0aqmeE0Z7IOhSm/+z/w2b7s4wlsutGXkwvh0ey8VE4B
         E6K/Jn5K1RBnNUQRYtBf975qsjqKmhEW9A+xRM0RuXaOTRnZJl+K68rJIRBRgpbtFx6W
         oBt06Paa6HMSmi0c3XGXx+s2lcZ4cBzp0aoGUY7Na+/n4m7ZTmcdShjng25/mq+/yCGe
         vm9lIYJrLh09u1ztbSpUN0NdGQupcewMbt568oum+S+rbm+1Q7GOQP0tG6ONqUnRWvJK
         Vczsaq4f6qjlFf0kRaVY5qKlOTRV9BYdOcTIFBNrWU1o4Uu0ct/nWihZqn2TJsvkhwcm
         +VOQ==
X-Gm-Message-State: AJIora93iHGiKOqrxmZ4bPDq/JFvLMj+/IzgCnehmnMgXlDbu2TgtWDe
        M1dmDi0inTFiUvBJ+8mUB8E=
X-Google-Smtp-Source: AGRyM1sY6xs2vLFIRjWV2bnzc91l1WGwCvv+DJXVUNptBy7iZlV1vdS9ruecuC6uACy/vvyxKuwSiQ==
X-Received: by 2002:a17:902:ba91:b0:16c:6b8e:cd06 with SMTP id k17-20020a170902ba9100b0016c6b8ecd06mr13859080pls.33.1658788842670;
        Mon, 25 Jul 2022 15:40:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7958e000000b0052a75004c51sm10440383pfj.146.2022.07.25.15.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 15:40:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ef016a9-c1bb-91dd-454d-504d26074477@roeck-us.net>
Date:   Mon, 25 Jul 2022 15:40:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
 <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
 <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
 <20220725204217.GU25951@gate.crashing.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
In-Reply-To: <20220725204217.GU25951@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/25/22 13:42, Segher Boessenkool wrote:
> On Mon, Jul 25, 2022 at 02:34:08PM -0500, Timothy Pearson wrote:
>>>> Further digging shows that the build failures only occur with compilers
>>>> that default to 64-bit long double.
>>>
>>> Where the heck do we have 'long double' things anywhere in the kernel?
>>>
>>> I tried to grep for it, and failed miserably. I found some constants
>>> that would qualify, but they were in the v4l colorspaces-details.rst
>>> doc file.
>>>
>>> Strange.
>>
>> We don't, at least not that I can see.  The affected code uses standard doubles.
>>
>> What I'm wondering is if the compiler is getting confused between standard and long doubles when they are both the same bit length...
> 
> The compiler emits the same code (DFmode things, double precision float)
> in both cases, and it itself does not see any difference anymore fairly
> early in the pipeline.  Compare to int and long on most 32-bit targets,
> both are SImode, the compiler will not see different types anymore:
> there *are* no types, except in the compiler frontend.
> 
> It only happens for powerpc64le things, and not for powerpc64 builds.
> 
> It is probably a GCC problem.  I don't see what forces the GCC build
> here to use 64-bit long double either btw?  Compilers build via buildall
> have all kinds of unnecessary things disabled, but not that, not
> directly at least.
> 

 From what little documentation I can find, there appears to be
"--with-long-double-128" and "--with-long-double-format=ieee".
That looks like something that would need to be enabled, not disabled.

FWIW, depending on compiler build options such as the above for kernel
builds seems to be a little odd to me, and I am not sure I'd want to
blame gcc if the kernel wants to be built with 128-bit floating point
as default. At the very least, that should be documented somewhere,
and if possible the kernel should refuse to build if the compiler build
options don't meet the requirements.

Guenter
