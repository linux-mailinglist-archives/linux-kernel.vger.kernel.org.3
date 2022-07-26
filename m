Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE135808D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiGZA4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZA4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:56:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A570255BA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:56:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsJPh01Psz4x1T;
        Tue, 26 Jul 2022 10:56:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658796968;
        bh=XM/sSLZCdmxU7N0ibsdjeo384f6+QLdmjSl5hrtE3HY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kWgG78BPwfOqjitCUhFJ1j7aQuatzG1Kzsf+7936A1WLUoNMph3bVIxIlABiTDJEJ
         hIIcGB/y8AFSlwe/+vhMtJcBEakfJHeQb/EPEh1G7QM8Fj1g7kmD4E4rDvBAscAEEQ
         Y9m7YoapBqwumAnrkXpPVFp4iTJcszdtuCXUjKZ3zAyIkxhYTxrIpZQ+9viWvCIJZN
         Lo+0ODKIoi8+wOoWZGyX2w81RnbtPvoDX+kaetTWOCl8t08KBgIfEZU4r9ji6GmqBD
         XC9xzCTHZvgPJML2QJUKrzkpJdrABgL2gtRQwE/S/p+qpY1A+EQDJrveHxPMK7Qwkp
         zoGf02DW07bSw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, alexdeucher@gmail.com,
        amd-gfx@lists.freedesktop.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, dan@danny.cz,
        tpearson@raptorengineering.com
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
In-Reply-To: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
 <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Date:   Tue, 26 Jul 2022 10:56:07 +1000
Message-ID: <87k080bsk8.fsf@mpe.ellerman.id.au>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Jul 25, 2022 at 5:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Further digging shows that the build failures only occur with compilers
>> that default to 64-bit long double.
>
> Where the heck do we have 'long double' things anywhere in the kernel?

There's one or two uses, but not in any code that's relevant to this
issue AFAICS.

> I tried to grep for it, and failed miserably. I found some constants
> that would qualify, but they were in the v4l colorspaces-details.rst
> doc file.
>
> Strange.

It doesn't seem to matter if you use long double or not. It's just that
if the long double size is 64-bits the linker refuses to link a mixture
of soft/hard-float objects.

The 64-bit ABI says long double is 128-bits, so the compilers that are
using 64-bit long double are either not built correctly, or we are not
passing the correct flags to them.

There's an -mlong-double-128 flag which we can pass at build time which
seems to do the right thing, I will probably add that to the kernel
CFLAGS, but I want that to get a bit more testing.

cheers
