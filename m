Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15821520371
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiEIRWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiEIRWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:22:10 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC5124DC62;
        Mon,  9 May 2022 10:18:12 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1B270683; Mon,  9 May 2022 12:12:39 -0500 (CDT)
Date:   Mon, 9 May 2022 12:12:39 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] capability: add capable_or to test for multiple
 caps with exactly one audit message
Message-ID: <20220509171239.GA28406@mail.hallyn.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
 <20220502160030.131168-1-cgzones@googlemail.com>
 <20220502160030.131168-8-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502160030.131168-8-cgzones@googlemail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 06:00:30PM +0200, Christian Göttsche wrote:
> Add the interface `capable_or()` as an alternative to or multiple

How about 'capable_contains_oneof(x, y)' or 'capable_of_one(a, b)'?

> `capable()` calls, like `capable_or(CAP_SYS_NICE, CAP_SYS_ADMIN)`
> instead of `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> `capable_or()` will in particular generate exactly one audit message,
> either for the left most capability in effect or, if the task has none,
> the first one.
> This is especially helpful with regard to SELinux, where each audit
> message about a not allowed capability will create an avc denial.
> Using this function with the least invasive capability as left most
> argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
> to only allow the least invasive one and SELinux domains pass this check
> with only capability:sys_nice or capability:sys_admin allowed without
> any avc denial message.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> 
> ---
> v2:
>    avoid varargs and fix to two capabilities; capable_or3() can be added
>    later if needed
> ---
>  include/linux/capability.h |  5 +++++
>  kernel/capability.c        | 29 +++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..a16d1edea9b3 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -207,6 +207,7 @@ extern bool has_ns_capability(struct task_struct *t,
>  extern bool has_capability_noaudit(struct task_struct *t, int cap);
>  extern bool has_ns_capability_noaudit(struct task_struct *t,
>  				      struct user_namespace *ns, int cap);
> +extern bool capable_or(int cap1, int cap2);
>  extern bool capable(int cap);
>  extern bool ns_capable(struct user_namespace *ns, int cap);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
> @@ -230,6 +231,10 @@ static inline bool has_ns_capability_noaudit(struct task_struct *t,
>  {
>  	return true;
>  }
> +static inline bool capable_or(int cap1, int cap2)
> +{
> +	return true;
> +}
>  static inline bool capable(int cap)
>  {
>  	return true;
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 765194f5d678..cd8f3efe6d08 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -435,6 +435,35 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
>  
> +/**
> + * capable_or - Determine if the current task has one of two superior capabilities in effect
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at one of the two given superior

s/has at one/has at least one/ ?

> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one audit
> + * message, either for @cap1, if it is granted or both are not permitted,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on the
> + * assumption that it's about to be used.
> + */
> +bool capable_or(int cap1, int cap2)
> +{
> +	if (ns_capable_noaudit(&init_user_ns, cap1))
> +		return ns_capable(&init_user_ns, cap1);
> +
> +	if (ns_capable_noaudit(&init_user_ns, cap2))
> +		return ns_capable(&init_user_ns, cap2);
> +
> +	return ns_capable(&init_user_ns, cap1);

Hm, too bad about the repetition of work, but I guess it has to be
this way right now.

> +}
> +EXPORT_SYMBOL(capable_or);
> +
>  /**
>   * capable - Determine if the current task has a superior capability in effect
>   * @cap: The capability to be tested for
> -- 
> 2.36.0
