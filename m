Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23BD4C5849
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiBZV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBZV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:27:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309C271474;
        Sat, 26 Feb 2022 13:26:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so3802518wme.0;
        Sat, 26 Feb 2022 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TyrNgSDfo+1HFIj3kDakMkkgmqGllazNd2qDuPTwQZo=;
        b=JHkgen1brpV4/9y45tcSWvczIjOgQ2zM3BreLzjdq75kuvLq7cY7aLWtCf1vMmYLtO
         is/K7zoVzAXdWmdj1n5M3WZn93zhKAuCpOiCMqFfVNwqPWs7sAB8lmGVUgKyAxGoIJqt
         GfLi4+hbI3MvATKfj1i/q3cmD2ryj0qWkfEYpMFfbDA3KKSm1Yhstl7/w/HMW132NP+e
         MQzmvqD05GtpUlaO13b2u5tSWIz+W5utTnZn3+jYFSbtZHssFy4JiMPdtEdaETpbY77O
         ys4EJ7XM3yl/ncKP89Yz5/+V5ZX+c1syo42Udj5/e4g0Xn3FDKXpaeXqoEdWNLmtKDZ8
         8fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TyrNgSDfo+1HFIj3kDakMkkgmqGllazNd2qDuPTwQZo=;
        b=CcuvV/hZ4ZEov+pF4dQ8IAFQrm2WjCQXH6ZvECA4uMGSdffAjxkr7nQm1NF2xlJV7v
         0c04fQ7NtacHjoEnprnjFrc2OlWMqAfHOXPrm4ZlTfhmvscyCPRAGwV4gRkjtQRdNaNy
         PFuJNzyajNUneApktNFJMaVyjv/5yE39Fr4XSTT0KIQ7L0a0nMh19yPmlpAp4RNPj4Yv
         tWYJ1wdfrdtdMhPScrVVUsodNwDXXs3O/1kPfvPKncCVoa0IiiofmlfF2G4pPTEIc9cG
         32rKYYNiivAnlLJz1VdlJrG65goWHJbRe+Tx4XaiUx12jFmy9tMjA+tSNX686R3e3Ebr
         ZZQA==
X-Gm-Message-State: AOAM531dPni9DrsYAc2qNA/wz+uhbM057PRPghOw5kIxlMFLtZT0PDlq
        U4EoFN9oCqwUPlSLu9WrZUh0nylL70XwXdxh
X-Google-Smtp-Source: ABdhPJwy3XONgbZN4q8BHplRawf8sSEJs3LQ347lcI5tm9T3b21rmk9OimmOVRdkhypkRB4nblntdw==
X-Received: by 2002:a05:600c:2146:b0:380:d7df:137c with SMTP id v6-20020a05600c214600b00380d7df137cmr7974476wml.140.1645910811793;
        Sat, 26 Feb 2022 13:26:51 -0800 (PST)
Received: from [192.168.0.149] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id ay23-20020a5d6f17000000b001ea79f73fbcsm5740733wrb.25.2022.02.26.13.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 13:26:51 -0800 (PST)
Message-ID: <ae52c028-05c7-c22e-fc47-d97ee4a2f6c7@gmail.com>
Date:   Sat, 26 Feb 2022 22:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/7] landlock: Fix landlock_add_rule(2) signature
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
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
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <20220221155311.166278-3-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mickaël,

On 21/2/22 16:53, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Replace the enum landlock_rule_type with an int in the syscall signature
> of landlock_add_rule to avoid an implementation-defined size.  In
> practice an enum type is like an int (at least with GCC and clang), but
> compilers may accept options (e.g. -fshort-enums) that would have an
> impact on that [1].  This change is mostly a cosmetic fix according to
> the current kernel compilers and used options.

There are two proposals for C2x that might bring C++ syntax to C for 
enums, i.e., being able to specify the underlying type of an enum.

See:
<http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2904.htm>
<http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2908.htm>

Since the current kernel is safe from that enum problem, it may be 
better to wait and see what the standard decides to do with enum.  I 
guess they'll add this feature sooner or later.

Regards,
Alex

> 
> Link: https://lore.kernel.org/r/8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com/ [1]
> Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221155311.166278-3-mic@digikod.net
> ---
>   include/linux/syscalls.h     | 3 +--
>   security/landlock/syscalls.c | 7 ++++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 819c0cb00b6d..a5956f91caf2 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -71,7 +71,6 @@ struct clone_args;
>   struct open_how;
>   struct mount_attr;
>   struct landlock_ruleset_attr;
> -enum landlock_rule_type;
>   
>   #include <linux/types.h>
>   #include <linux/aio_abi.h>
> @@ -1053,7 +1052,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
>   asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
>   asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr __user *attr,
>   		size_t size, __u32 flags);
> -asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
> +asmlinkage long sys_landlock_add_rule(int ruleset_fd, int rule_type,
>   		const void __user *rule_attr, __u32 flags);
>   asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
>   asmlinkage long sys_memfd_secret(unsigned int flags);
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index fd4b24022a06..3b40fc5d0216 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -277,8 +277,9 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
>    *
>    * @ruleset_fd: File descriptor tied to the ruleset that should be extended
>    *		with the new rule.
> - * @rule_type: Identify the structure type pointed to by @rule_attr (only
> - *             LANDLOCK_RULE_PATH_BENEATH for now).
> + * @rule_type: Identify the structure type pointed to by @rule_attr as defined
> + *             by enum landlock_rule_type (only LANDLOCK_RULE_PATH_BENEATH for
> + *             now).
>    * @rule_attr: Pointer to a rule (only of type &struct
>    *             landlock_path_beneath_attr for now).
>    * @flags: Must be 0.
> @@ -301,7 +302,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
>    * - EFAULT: @rule_attr inconsistency.
>    */
>   SYSCALL_DEFINE4(landlock_add_rule,
> -		const int, ruleset_fd, const enum landlock_rule_type, rule_type,
> +		const int, ruleset_fd, const int, rule_type,
>   		const void __user *const, rule_attr, const __u32, flags)
>   {
>   	struct landlock_path_beneath_attr path_beneath_attr;

