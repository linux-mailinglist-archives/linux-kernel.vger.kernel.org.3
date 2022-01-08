Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58357487FEA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiAHAYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:24:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:38527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbiAHAYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641601439;
        bh=3w7Jpez3pMI3sD4qPNGM59cmZ74L2llDzLaJwuSVl2M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=imPCOId6PsLyz/dUws/KBLAtBWDDjmOv+PIieNxtSex5eOzqIejPcjOPAcuCTrV4u
         btAs69EkwY8xljbp3zDj6+Rv8unJrjWx/p3uroIT6f7dwFaftGQ6pszVbvsY1F2EQq
         iBGu5bv/bzBv7e+wpyxluP82HRS5qgdu3qsvMISg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.182.203]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1mLt5i0zjF-012IOy; Sat, 08
 Jan 2022 01:23:59 +0100
Message-ID: <a399670d-1fd8-c948-b4db-b2396290c22a@gmx.de>
Date:   Sat, 8 Jan 2022 01:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] usercopy: Do not fail on memory from former init sections
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
References: <YdeHDDAP+TY5wNeT@ls3530>
 <20220107155112.30671fe4bb53ea71029f5a6d@linux-foundation.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220107155112.30671fe4bb53ea71029f5a6d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p9W0atH/9OENtS723Msl+FwALapLVtbR8QqmChB6+1FPj8xuHuX
 4vo7K820dGr2yodd4i+xZFEC+wPIpRCDqhkyjupIJCv1myn6z8XyHjc+n53sfOPDy5oQR4f
 2lO2mYzcxr83ii1nP5rruRxPJJiD8pm+l7dm2N5VotjEpl0EZPdrCH3hsqLfmOp7HGNy35G
 5MDAhWG8MsBNzX28y+GeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEIf025NlPc=:5MFAnmuxKJxcwPOwLnjxIw
 Vm0sjNirkEJXSE/g0IfV+66MJbzlHjEqgakKsv+cjOxrBszojTnq+KdNkkhiU/UmaRmIPSwlK
 YeOfRoBNMtSlmGKmWwlpkFAOvvb+YKjvxTmkLrmOhlauloMDvPMpt2VP6oTzqvmw59AvcD/Hn
 naccQlmMNEp74hnay7OcF9EMmjXyAUP1bAx7yXNBk9KnaMoeI8GpSoA9bSR542GTMOk8TSkKR
 mF7ZYoKI7TnWRHKj7Z4KRqCNVLryeKj5ofT6Jj/Q4B2GWG5smS+lvokJOU6S0+DBRh6I6S6jz
 p0c+tr+6EIY5NRgYHhKIxsra7Wc0scmcz9CvP8M7IsRY4eKaq05q3eec3Ki/f9Gr2JgHm8iO2
 2k43Ug2PgYxWkDhlHdxb2kupvY2uiF8IJ0wFaHA2PcXWErlAY5x56ij+0fVae4i2NvgodJeqi
 fjRUFjB8jQvGZObK7L2geUtkj8npFRSbIkB2GDFUKEnpBIEIyE01+fqJKwrxu2vQwAMBsPt3u
 yJe11spK65Dh/jrP+WzrZ7FC9zc7L3EoYDdzh+XV0PkG1TP+8KRNtUrgWGIJ7COKtF1jiPk5x
 Me+BvF57ufpD9bic4I7c4LD7AoMJ09i1nF9TPLw4b6jiCAPqT9/mOapSJwzvWVzdX6+4epe0z
 xJXaoJoZ5omnBk4kfyHhZK5Hffexxm4q1YqhWJOCfhmhTRRaeF0fEU4KZJjhZkhKQruMIflxH
 xVOvKrfd5Z9O/SiheH/8X3dWKcQNtcaDK7SyeF0Meo/GjkEQI2oSVBxvLKwYxBHZNlELUhrzI
 baqinSJUjiBTPVk4D6lw0qYICRTzDyP8RpdvwREsvTha+/hmCfv0eEQ2FlexumprJqcDVXbXp
 6dQ20Ru6MTmBsgstMU1K4hf1hzop7SqE9nup5hpH7pvY/z0i79Sj76iLkdMaGEHrnOxHPspUL
 FgikYHXmHRYOr6eN/OubpXB6yW0B5zRxMTY4BLhL7R7lXwM0G5mu9N3+zej0nNgrKb0e6Awrn
 tBGerDZYy+jNQT5Jyh5hetn9bJFHc+mT1EjT2pb6w25PW9HI77I1B5KZf7TWh6zLOdrdyXOg4
 YXul23IfzdGNYM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 1/8/22 00:51, Andrew Morton wrote:
> On Fri, 7 Jan 2022 01:19:24 +0100 Helge Deller <deller@gmx.de> wrote:
>
>> On some platforms the memory area between the _stext and the _etext
>> symbols includes the init sections (parisc and csky). If the init
>> sections are freed after bootup, the kernel may reuse this memory.
>>
>> In one test the usercopy checks if the given address is inside the .tex=
t
>> section (from _stext to _etext), and it wrongly fails on the mentioned
>> platforms if the memory is from the former init section.
>>
>> Fix this failure by first checking against the init sections before
>> checking against the _stext/_etext section.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Fixes: 98400ad75e95 ("parisc: Fix backtrace to always include init funt=
ion names")

You asked:
> This sounds like it might have very serious runtime effects?

Yes, the patch fixes very negative effects in the sense that the kernel fa=
ils to boot
on parisc if the following patch is included (and if userchecks are enable=
d):
279917e27edc - parisc: Fix backtrace to always include init funtion names

That patch (279917e27edc) was once in v5.16, but because of the failure
I *reverted* it again with:
98400ad75e95 - Revert "parisc: Fix backtrace to always include init funtio=
n names"

Both patches were originally tagged for stable.
So, all current trees are fine as they are right now as they are.

> And 98400ad75e95 has cc:stable so we'll want cc:stable on this patch
> also, yes?

We could push it to stable if we think it's worth it.
But I'm fine if we simply start fresh with kernel 5.17.
So: no.

> So is this a must-have for 5.16?

No. Current trees are fine.

> And I really wouldn't want to jam a patch into mm/usercopy.c at this
> point in the life of 5.16 anyway.

Right.
I sent the patch for review and for v5.17 (it didn't had a stable tag).

It would be nice if you could queue it up for v5.17.

Helge
