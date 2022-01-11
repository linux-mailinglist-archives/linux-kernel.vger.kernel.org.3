Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39848AD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiAKMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiAKMGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:06:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:06:32 -0800 (PST)
Received: from [IPv6:2a00:c281:14a3:8100:a909:23ff:b834:d3b1] (unknown [IPv6:2a00:c281:14a3:8100:a909:23ff:b834:d3b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D50C51F44341;
        Tue, 11 Jan 2022 12:06:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641902791;
        bh=kRoLZoDn7anbUJOPv8KDNgu67NtycySGqdoUYDHej6w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SD27BulwCwAOuSZwhDZ7Wh19ADlUE6jLQVXKC8eRr3ElJx74/Q7WH6uJD2Nf+AAKl
         d4SK9fccjRpn0CUJpn9x30q2qxN3lbrnDm6qh8uAB9HZnSoJVTVLBUBt6JD5nzNLjO
         NIPKXPZWxcWFcIEgvqiztoo7G5OkETpRb7hRada2fL5kvE7AaOykuylhO1XT9fjttK
         CzOyp1hImlRoM/ul+OK00cdrpJH/6h9zCGIXZOLsB+KLaGdTPbyqfA8Z8QT8Kd73E5
         IBG+0izeqjZt6sv8mNMQA4G0vvy02/WGXYyNXmsZD8yRfbvSCYYGbQq1wRtiKQZ0nk
         dYx6HPf2OehWA==
Subject: Re: [PATCH] checkpatch: warn for p0 patch only if prefix is not b
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
References: <20220110200529.18601-1-dafna.hirschfeld@collabora.com>
 <CAKXUXMyepnLO=jLPciG5mWvTxbQGR+1PaeYs1_c+-t3hFAEhNg@mail.gmail.com>
 <ff6e3942-24e4-25ec-946c-cc6301ebf260@collabora.com>
 <CAKXUXMzkibUyMOZnUv2A7Ksv=E_qYPqjfaio3at-pqG9RYukig@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <9ea178f0-aa8e-5311-17fc-d13511838655@collabora.com>
Date:   Tue, 11 Jan 2022 14:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzkibUyMOZnUv2A7Ksv=E_qYPqjfaio3at-pqG9RYukig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.22 13:27, Lukas Bulwahn wrote:
> On Tue, Jan 11, 2022 at 11:47 AM Dafna Hirschfeld
> <dafna.hirschfeld@collabora.com> wrote:
>>
>>
>>
>> On 11.01.22 12:18, Lukas Bulwahn wrote:
>>> Dafna,
>>>
>>> On Mon, Jan 10, 2022 at 9:06 PM Dafna Hirschfeld
>>> <dafna.hirschfeld@collabora.com> wrote:
>>>>
>>>> It might be that file 'b' happens to exit. In that
>>>> case, if the prefix is also 'b' (which is the
>>>> common case) we get the falsely warning:
>>>>
>>>> patch prefix 'b' exists, appears to be a -p0 patch
>>>>
>>>> So warn only if prefix is not 'b'
>>>>
>>>
>>> The checkpatch script that is maintained here is really only intended
>>> for its use in the kernel development. You may use checkpatch anywhere
>>> else, but any changes that increase complexity for those other use
>>> cases is really difficult to argue for inclusion in the kernel
>>> repository. The checkpatch script currently is already large and
>>> complex enough and all rules need to be understood as rough
>>> heuristics, not as strict rules.
>>>
>>> So, can you point to a kernel repository where there is actually a
>>> file 'b' included? On a quick scan, I could not find a file 'b' in the
>>> current trees of the repositories on my machine.
>>>
>>> I am just letting you know about what I have observed; I do not decide
>>> on the inclusion of this patch, though.
>>
>> Hi, a 'b' file might make it to the source folder as an untracked file.
>> This actually happened to me since I was too lazy to give it a meaningful name.
>> Then I got this warning and it took me some time to figure out what is the problem.
>>
> 
> Well, but you run checkpatch.pl on a patch, right? So, you need to add
> the file explicitly with git (where you notice adding a file called b,
> which probably is really not a good name), you create a git commit
> (where that is pointed out again), then create a patch from that
> (which you may manually look at again) and then run checkpatch.pl
> before you submit it (again, submitting a patch with a file 'b' is
> probably a good reason to rethink your submission).

Hi , no, the 'b' file is left untracked.
It is easily reproducible, inside a kernel source repo do:

touch b

# These two commands will both trigger the warning.
./scripts/checkpatch.pl --strict -g HEAD
./scripts/checkpatch.pl --strict 0001-some-random-patch.patch

> 
> If it helps, you can add some documentation on the PATCH_PREFIX rule
> in the checkpatch documentation at
> ./Documentation/dev-tools/checkpatch.rst. Especially, you can note the
> situation you encountered there, e.g., that adding files with explicit
> name 'a' or 'b' may make this rule trigger. If that documentation of
> the rule is helpful, I will ack that documentation patch and request
> inclusion of it.

I can do that as well if you think it is better.

Thanks,
Dafna

> 
> Lukas
> 
>> Thanks,
>> Dafna
>>
>>>
>>> Lukas
>>>
>>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>>> ---
>>>>    scripts/checkpatch.pl | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> index 1784921c645d..72263b142e39 100755
>>>> --- a/scripts/checkpatch.pl
>>>> +++ b/scripts/checkpatch.pl
>>>> @@ -2821,7 +2821,7 @@ sub process {
>>>>                           $in_commit_log = 0;
>>>>
>>>>                           $p1_prefix = $1;
>>>> -                       if (!$file && $tree && $p1_prefix ne '' &&
>>>> +                       if (!$file && $tree && $p1_prefix ne '' && $p1_prefix ne 'b' &&
>>>>                               -e "$root/$p1_prefix") {
>>>>                                   WARN("PATCH_PREFIX",
>>>>                                        "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
>>>
>>>> --
>>>> 2.17.1
>>>>
