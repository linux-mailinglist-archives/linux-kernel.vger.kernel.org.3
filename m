Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460675808C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiGZArZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGZArX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:47:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DC2654C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:47:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsJCQ717gz4x1d;
        Tue, 26 Jul 2022 10:47:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658796436;
        bh=J9yu53lhhX0ehyV3JzkSGwZjLJLxwxnpts7lB9FNFWg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nOi+DKO6pAKNMiIRsSnbhfQJ5RTa3S6GisPurroblZlwbhsziob6fnXSwN5ohtR6t
         wJZfBYD9/53mrGcnAtN3ay2qtf1KzTsCLxvUVL61kfTkvujBOShLcO2JUsfm2zOjB3
         Hdlyg327quF/vSNVeYh+AYEHSmbPmgDen+3qxEh3P+qIfs7WEqYqI2tzPfwajeLlK7
         NN4RduDY7xfBSLbjXPcieslPd4B2MUClNgV4siQeo37WDP7bwlqLwoWG1WizQ8IqAv
         t/YZNyr4lBXXP9Fw/E+Dgc/7/Z/JseW8+2+fTsdq4+9flkDRHeaNy7VVPdw17UelqH
         LJeZq6eJGcQBg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Cc:     Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
In-Reply-To: <5ef016a9-c1bb-91dd-454d-504d26074477@roeck-us.net>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
 <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
 <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
 <20220725204217.GU25951@gate.crashing.org>
 <5ef016a9-c1bb-91dd-454d-504d26074477@roeck-us.net>
Date:   Tue, 26 Jul 2022 10:47:12 +1000
Message-ID: <87mtcwbsz3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On 7/25/22 13:42, Segher Boessenkool wrote:
>> On Mon, Jul 25, 2022 at 02:34:08PM -0500, Timothy Pearson wrote:
>>>>> Further digging shows that the build failures only occur with compilers
>>>>> that default to 64-bit long double.
>>>>
>>>> Where the heck do we have 'long double' things anywhere in the kernel?
>>>>
>>>> I tried to grep for it, and failed miserably. I found some constants
>>>> that would qualify, but they were in the v4l colorspaces-details.rst
>>>> doc file.
>>>>
>>>> Strange.
>>>
>>> We don't, at least not that I can see.  The affected code uses standard doubles.
>>>
>>> What I'm wondering is if the compiler is getting confused between standard and long doubles when they are both the same bit length...
>> 
>> The compiler emits the same code (DFmode things, double precision float)
>> in both cases, and it itself does not see any difference anymore fairly
>> early in the pipeline.  Compare to int and long on most 32-bit targets,
>> both are SImode, the compiler will not see different types anymore:
>> there *are* no types, except in the compiler frontend.
>> 
>> It only happens for powerpc64le things, and not for powerpc64 builds.
>> 
>> It is probably a GCC problem.  I don't see what forces the GCC build
>> here to use 64-bit long double either btw?  Compilers build via buildall
>> have all kinds of unnecessary things disabled, but not that, not
>> directly at least.
>> 
>
>  From what little documentation I can find, there appears to be
> "--with-long-double-128" and "--with-long-double-format=ieee".
> That looks like something that would need to be enabled, not disabled.
>
> FWIW, depending on compiler build options such as the above for kernel
> builds seems to be a little odd to me, and I am not sure I'd want to
> blame gcc if the kernel wants to be built with 128-bit floating point
> as default.

The kernel doesn't care what the size is, but ld refuses to link objects
built with soft/hard float if the long double size is 64-bits.

> At the very least, that should be documented somewhere,
> and if possible the kernel should refuse to build if the compiler build
> options don't meet the requirements.

The ABI says long double is 128-bits. So it's documented there :)

The kernel expects that passing `-m64 -mlittle-endian -mabi=elfv2` will
produce code that conforms to the 64-bit Little Endian ELFv2 ABI :D

But it seems those flags are not sufficient.

There is an -mlong-double-128 flag, which appears to do the right thing
regardless of how the compiler was built. I will probably add that to
the kernel CFLAGS, but that's not a change I want to do just before the
v5.19 release.

cheers
