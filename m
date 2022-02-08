Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB444ADEB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383599AbiBHQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383579AbiBHQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:54:49 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 08:54:45 PST
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE2C061576;
        Tue,  8 Feb 2022 08:54:45 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id F3200FC07E3;
        Tue,  8 Feb 2022 17:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1644338827;
        bh=eRv74+XI594hq5dL4OGUblyk1lqPGFnb0U0Ww0ZWEfg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hzs3WgiC2LieAJ+kSe703/DKF1H9tljccbLnmkZ6Uh37e9nMp/3uEvz1r3sFtORQQ
         6+M/k4iKUqWP+z5HHEWOcHpTzKfg9L/QwylHxC3Uz5fetMqiOLBE8hWuQM+zOENabp
         Dx73EyMBADClv8GDiZs25lvdx7Qu1FtiRIG/GqhA=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
        <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
        <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
        <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
        <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
        <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
        <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
        <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
        <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
        <875ypt5zmz.fsf@defensec.nl>
        <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
        <4be3fef6-63ca-af97-7fc6-d93d85a9b706@linux.microsoft.com>
Date:   Tue, 08 Feb 2022 17:47:05 +0100
In-Reply-To: <4be3fef6-63ca-af97-7fc6-d93d85a9b706@linux.microsoft.com> (Chris
        PeBenito's message of "Tue, 8 Feb 2022 10:47:44 -0500")
Message-ID: <87ee4dnw52.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris PeBenito <chpebeni@linux.microsoft.com> writes:

> On 2/8/2022 09:17, William Roberts wrote:
>> <snip>
>> This is getting too long for me.
>> 
>>>>
>>>> I don't have a strong opinion either way.  If one were to allow this
>>>> using a policy rule, it would result in a major policy breakage.  The
>>>> rule would turn on extended perm checks across the entire system,
>>>> which the SELinux Reference Policy isn't written for.  I can't speak
>>>> to the Android policy, but I would imagine it would be the similar
>>>> problem there too.
>>>
>>> Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
>>> xperm checks across the entire system.
>> It doesn't as you state below its target + class.
>> 
>>>
>>> If i am not mistaken it will turn on xperm checks only for the
>>> operations that have the same source and target/target class.
>> That's correct.
>
> Just to clarify (Demi Marie also mentioned this earlier in the
> thread), what I originally meant was how to emulate this patch by
> using policy rules means you need a rule that allows the two ioctls on
> all domains for all objects.  That results in xperms checks enabled
> everywhere.

Thanks. That is clear now. I also learned that is pretty much what
Android's sepolicy is doing. That is probably not something I would do
(enable xperms globally). I would probably leverage it only for "devnode"
chr and maybe blk files and only where they actually are accessed.

I would not mind removing these two checks, but i am not a big user of
xperms (i only filter TIOSCTI on terminal chr files and only for the
entities that write or append them).

>
>
>>> This is also why i don't (with the exception TIOSCTI for termdev
>>> chr_file) use xperms by default.
>>>
>>> 1. it is really easy to selectively filter ioctls by adding xperm rules
>>> for end users (and since ioctls are often device/driver specific they
>>> know best what is needed and what not)
>> 
>>>>>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
>>>
>>> 2. if you filter ioctls in upstream policy for example like i do with
>>> TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
>>> (0xXXXX)))) then you cannot easily exclude additional ioctls later where source is
>>> foo and target/tclass is bar/chr_file because there is already a rule in
>>> place allowing the ioctl (and you cannot add rules)
>> Currently, fcntl flag F_SETFD is never checked, it's silently
>> allowed, but
>> the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote policy
>> to block the FIO*CLEX flags, it would be bypassable through F_SETFD and
>> FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
>> F_SETFD. Which means upstream policy users could drop this allow, which
>> could then remove the target/class rule and allow all icotls. Which is easy
>> to prevent and fix you could be a rule in to allowx 0 as documented in the
>> wiki: https://selinuxproject.org/page/XpermRules
>> The questions I think we have here are:
>> 1. Do we agree that the behavior between SETFD and the FIO flags are equivalent?
>>    I think they are.
>> 2. Do we want the interfaces to behave the same?
>>    I think they should.
>
> If you can bypass FIONCLEX and FIOCLEX checks by F_SETFD and
> FD_CLOEXEC, then I agree that the two FIO checks don't have value and
> can be skipped as F_SETFD is.
>
>> 3. Do upstream users of the policy construct care?
>>    The patch is backwards compat, but I don't want their to be cruft
>> floating around with extra allowxperm rules.
>
> Reference policy does not have any xperm rules at this time.  I looked
> at the Fedora policy, and that doesn't have any.

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
