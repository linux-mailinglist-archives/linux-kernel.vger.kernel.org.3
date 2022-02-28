Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7E4C6440
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiB1IAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiB1IAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:00:07 -0500
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00024FC66
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:59:28 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K6XpN2CGLzMq0qN;
        Mon, 28 Feb 2022 08:59:24 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K6XpL1ZyHzljTgK;
        Mon, 28 Feb 2022 08:59:22 +0100 (CET)
Message-ID: <274f63e6-ed9a-e49f-8779-6e4980f51b33@digikod.net>
Date:   Mon, 28 Feb 2022 08:59:39 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220221155311.166278-1-mic@digikod.net>
 <20220221155311.166278-3-mic@digikod.net>
 <ae52c028-05c7-c22e-fc47-d97ee4a2f6c7@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 2/7] landlock: Fix landlock_add_rule(2) signature
In-Reply-To: <ae52c028-05c7-c22e-fc47-d97ee4a2f6c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/02/2022 22:26, Alejandro Colomar (man-pages) wrote:
> Hi Mickaël,
> 
> On 21/2/22 16:53, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Replace the enum landlock_rule_type with an int in the syscall signature
>> of landlock_add_rule to avoid an implementation-defined size.  In
>> practice an enum type is like an int (at least with GCC and clang), but
>> compilers may accept options (e.g. -fshort-enums) that would have an
>> impact on that [1].  This change is mostly a cosmetic fix according to
>> the current kernel compilers and used options.
> 
> There are two proposals for C2x that might bring C++ syntax to C for 
> enums, i.e., being able to specify the underlying type of an enum.
> 
> See:
> <http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2904.htm>
> <http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2908.htm>
> 
> Since the current kernel is safe from that enum problem, it may be 
> better to wait and see what the standard decides to do with enum.  I 
> guess they'll add this feature sooner or later.

Ok, interesting, I'll remove this patch then. I'd be curious to know 
when this will impact Linux though.

Thanks!

> 
> Regards,
> Alex
> 
>>
>> Link: 
>> https://lore.kernel.org/r/8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com/ 
>> [1]
>> Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220221155311.166278-3-mic@digikod.net
>> ---
>>   include/linux/syscalls.h     | 3 +--
>>   security/landlock/syscalls.c | 7 ++++---
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 819c0cb00b6d..a5956f91caf2 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -71,7 +71,6 @@ struct clone_args;
>>   struct open_how;
>>   struct mount_attr;
>>   struct landlock_ruleset_attr;
>> -enum landlock_rule_type;
>>   #include <linux/types.h>
>>   #include <linux/aio_abi.h>
>> @@ -1053,7 +1052,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, 
>> int sig,
>>   asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
>>   asmlinkage long sys_landlock_create_ruleset(const struct 
>> landlock_ruleset_attr __user *attr,
>>           size_t size, __u32 flags);
>> -asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum 
>> landlock_rule_type rule_type,
>> +asmlinkage long sys_landlock_add_rule(int ruleset_fd, int rule_type,
>>           const void __user *rule_attr, __u32 flags);
>>   asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 
>> flags);
>>   asmlinkage long sys_memfd_secret(unsigned int flags);
>> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>> index fd4b24022a06..3b40fc5d0216 100644
>> --- a/security/landlock/syscalls.c
>> +++ b/security/landlock/syscalls.c
>> @@ -277,8 +277,9 @@ static int get_path_from_fd(const s32 fd, struct 
>> path *const path)
>>    *
>>    * @ruleset_fd: File descriptor tied to the ruleset that should be 
>> extended
>>    *        with the new rule.
>> - * @rule_type: Identify the structure type pointed to by @rule_attr 
>> (only
>> - *             LANDLOCK_RULE_PATH_BENEATH for now).
>> + * @rule_type: Identify the structure type pointed to by @rule_attr 
>> as defined
>> + *             by enum landlock_rule_type (only 
>> LANDLOCK_RULE_PATH_BENEATH for
>> + *             now).
>>    * @rule_attr: Pointer to a rule (only of type &struct
>>    *             landlock_path_beneath_attr for now).
>>    * @flags: Must be 0.
>> @@ -301,7 +302,7 @@ static int get_path_from_fd(const s32 fd, struct 
>> path *const path)
>>    * - EFAULT: @rule_attr inconsistency.
>>    */
>>   SYSCALL_DEFINE4(landlock_add_rule,
>> -        const int, ruleset_fd, const enum landlock_rule_type, rule_type,
>> +        const int, ruleset_fd, const int, rule_type,
>>           const void __user *const, rule_attr, const __u32, flags)
>>   {
>>       struct landlock_path_beneath_attr path_beneath_attr;
> 
