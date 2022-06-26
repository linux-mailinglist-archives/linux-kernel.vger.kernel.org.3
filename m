Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD055B466
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiFZWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:34:44 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DED2DDE;
        Sun, 26 Jun 2022 15:34:42 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 2E4BF186C; Sun, 26 Jun 2022 17:34:41 -0500 (CDT)
Date:   Sun, 26 Jun 2022 17:34:41 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] capability: add any wrapper to test for multiple
 caps with exactly one audit message
Message-ID: <20220626223441.GA30137@mail.hallyn.com>
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
 <20220615152623.311223-8-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615152623.311223-8-cgzones@googlemail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:26:23PM +0200, Christian Göttsche wrote:
> Add the interfaces `capable_any()` and `ns_capable_any()` as an
> alternative to multiple `capable()`/`ns_capable()` calls, like
> `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> 
> `capable_any()`/`ns_capable_any()` will in particular generate exactly
> one audit message, either for the left most capability in effect or, if
> the task has none, the first one.
> 
> This is especially helpful with regard to SELinux, where each audit
> message about a not allowed capability will create an AVC denial.
> Using this function with the least invasive capability as left most
> argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
> to only allow the least invasive one and SELinux domains pass this check
> with only capability:sys_nice or capability:sys_admin allowed without
> any AVC denial message.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> 
> ---
> v3:
>    - rename to capable_any()
>    - fix typo in function documentation
>    - add ns_capable_any()
> v2:
>    avoid varargs and fix to two capabilities; capable_or3() can be added
>    later if needed
> ---
>  include/linux/capability.h | 10 +++++++
>  kernel/capability.c        | 53 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..7316d5339a6e 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -208,7 +208,9 @@ extern bool has_capability_noaudit(struct task_struct *t, int cap);
>  extern bool has_ns_capability_noaudit(struct task_struct *t,
>  				      struct user_namespace *ns, int cap);
>  extern bool capable(int cap);
> +extern bool capable_any(int cap1, int cap2);
>  extern bool ns_capable(struct user_namespace *ns, int cap);
> +extern bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
>  extern bool ns_capable_setid(struct user_namespace *ns, int cap);
>  #else
> @@ -234,10 +236,18 @@ static inline bool capable(int cap)
>  {
>  	return true;
>  }
> +static inline bool capable_any(int cap1, int cap2)
> +{
> +	return true;
> +}
>  static inline bool ns_capable(struct user_namespace *ns, int cap)
>  {
>  	return true;
>  }
> +static inline bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +	return true;
> +}
>  static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  {
>  	return true;
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 765194f5d678..ab9b889c3f4d 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -435,6 +435,59 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
>  
> +/**
> + * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
> + * @ns:  The usernamespace we want the capability in
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given superior
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
> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +	if (ns_capable_noaudit(ns, cap1))
> +		return ns_capable(ns, cap1);
> +
> +	if (ns_capable_noaudit(ns, cap2))
> +		return ns_capable(ns, cap2);
> +
> +	return ns_capable(ns, cap1);
> +}
> +EXPORT_SYMBOL(ns_capable_any);
> +
> +/**
> + * capable_any - Determine if the current task has one of two superior capabilities in effect
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given superior
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
> +bool capable_any(int cap1, int cap2)
> +{
> +	return ns_capable_any(&init_user_ns, cap1, cap2);
> +}
> +EXPORT_SYMBOL(capable_any);
> +
>  /**
>   * capable - Determine if the current task has a superior capability in effect
>   * @cap: The capability to be tested for
> -- 
> 2.36.1
