Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB9D4ADD5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381832AbiBHPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiBHPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:47:48 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FB65C061578;
        Tue,  8 Feb 2022 07:47:47 -0800 (PST)
Received: from [192.168.254.13] (unknown [72.85.44.115])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3DB4E20B90C6;
        Tue,  8 Feb 2022 07:47:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DB4E20B90C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644335267;
        bh=KmL07M010/ylefc6zNElZjQYbSBmTpd/e1SNOQwetTM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PJMmBh8HudgS0Eyy3CtKlIqOzn5Pav8NmMnir/hQca15xoFu+ZCXljT+Qd5p/gQsg
         lLQqq0eq4lL6zH6U75lA+xrszXmWz9NcLfRErWB8pbDLJQBhiRZN/4P8Oj8OFWK0Dy
         tAsi618Vp/hGxc8RkNyk9WTWmDUR1PVWipWf9V5U=
Message-ID: <4be3fef6-63ca-af97-7fc6-d93d85a9b706@linux.microsoft.com>
Date:   Tue, 8 Feb 2022 10:47:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
Content-Language: en-US
To:     William Roberts <bill.c.roberts@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Cc:     Paul Moore <paul@paul-moore.com>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
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
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2022 09:17, William Roberts wrote:
> <snip>
> 
> This is getting too long for me.
> 
>>>
>>> I don't have a strong opinion either way.  If one were to allow this
>>> using a policy rule, it would result in a major policy breakage.  The
>>> rule would turn on extended perm checks across the entire system,
>>> which the SELinux Reference Policy isn't written for.  I can't speak
>>> to the Android policy, but I would imagine it would be the similar
>>> problem there too.
>>
>> Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
>> xperm checks across the entire system.
> 
> It doesn't as you state below its target + class.
> 
>>
>> If i am not mistaken it will turn on xperm checks only for the
>> operations that have the same source and target/target class.
> 
> That's correct.

Just to clarify (Demi Marie also mentioned this earlier in the thread), 
what I originally meant was how to emulate this patch by using policy 
rules means you need a rule that allows the two ioctls on all domains 
for all objects.  That results in xperms checks enabled everywhere.


>> This is also why i don't (with the exception TIOSCTI for termdev
>> chr_file) use xperms by default.
>>
>> 1. it is really easy to selectively filter ioctls by adding xperm rules
>> for end users (and since ioctls are often device/driver specific they
>> know best what is needed and what not)
> 
>>>>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
>>
>> 2. if you filter ioctls in upstream policy for example like i do with
>> TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
>> (0xXXXX)))) then you cannot easily exclude additional ioctls later where source is
>> foo and target/tclass is bar/chr_file because there is already a rule in
>> place allowing the ioctl (and you cannot add rules)
> 
> Currently, fcntl flag F_SETFD is never checked, it's silently allowed, but
> the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote policy
> to block the FIO*CLEX flags, it would be bypassable through F_SETFD and
> FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
> F_SETFD. Which means upstream policy users could drop this allow, which
> could then remove the target/class rule and allow all icotls. Which is easy
> to prevent and fix you could be a rule in to allowx 0 as documented in the
> wiki: https://selinuxproject.org/page/XpermRules
> 
> The questions I think we have here are:
> 1. Do we agree that the behavior between SETFD and the FIO flags are equivalent?
>    I think they are.
> 2. Do we want the interfaces to behave the same?
>    I think they should.

If you can bypass FIONCLEX and FIOCLEX checks by F_SETFD and FD_CLOEXEC, 
then I agree that the two FIO checks don't have value and can be skipped 
as F_SETFD is.

> 3. Do upstream users of the policy construct care?
>    The patch is backwards compat, but I don't want their to be cruft
> floating around with extra allowxperm rules.

Reference policy does not have any xperm rules at this time.  I looked 
at the Fedora policy, and that doesn't have any.



-- 
Chris PeBenito
