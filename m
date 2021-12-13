Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392BE4730E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbhLMPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:50:55 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37034 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhLMPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:50:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38854)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwnbI-007JDw-RW; Mon, 13 Dec 2021 08:50:52 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41060 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwnbH-00BKrr-EJ; Mon, 13 Dec 2021 08:50:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1638218242.git.legion@kernel.org>
        <24c87e225c7950bf2ea1ff4b4a8f237348808241.1638218242.git.legion@kernel.org>
Date:   Mon, 13 Dec 2021 09:50:45 -0600
In-Reply-To: <24c87e225c7950bf2ea1ff4b4a8f237348808241.1638218242.git.legion@kernel.org>
        (Alexey Gladkov's message of "Mon, 29 Nov 2021 21:37:26 +0100")
Message-ID: <87tufc1p2i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mwnbH-00BKrr-EJ;;;mid=<87tufc1p2i.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YbcX3pVFz6SwYbXeGqi+WvZYayKg9XWc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4840]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 833 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.3%), b_tie_ro: 10 (1.1%), parse: 1.01
        (0.1%), extract_message_metadata: 14 (1.6%), get_uri_detail_list: 3.3
        (0.4%), tests_pri_-1000: 7 (0.8%), tests_pri_-950: 1.18 (0.1%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 85 (10.2%), check_bayes:
        83 (10.0%), b_tokenize: 16 (1.9%), b_tok_get_all: 9 (1.1%),
        b_comp_prob: 2.4 (0.3%), b_tok_touch_all: 52 (6.2%), b_finish: 0.93
        (0.1%), tests_pri_0: 701 (84.2%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 5 (0.7%), poll_dns_idle: 0.42 (0.0%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/2] ucounts: Move rlimit max values from ucounts max
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Since the semantics of maximum rlimit values are different, they need to
> be separated from ucount_max. This will prevent the error of using
> inc_count/dec_ucount for rlimit parameters.
>
> This patch also renames the functions to emphasize the lack of
> connection between rlimit_max and ucount_max.
>
> v2:
> - Fix the array-index-out-of-bounds that was found by the lkp project.

Just looking at this I wonder if it things would come out cleaner if we
had a separate "enum ucount_rlimit_type" and a separate array in "struct
ucount" for the rlimits.

Just so that people don't accidentally mix the two.

>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  include/linux/user_namespace.h | 17 ++++++++++++-----
>  kernel/fork.c                  | 10 +++++-----
>  kernel/ucount.c                | 10 +++-------
>  kernel/user_namespace.c        | 10 +++++-----
>  4 files changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 33a4240e6a6f..812b6935f4a3 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -58,10 +58,11 @@ enum ucount_type {
>  	UCOUNT_RLIMIT_MSGQUEUE,
>  	UCOUNT_RLIMIT_SIGPENDING,
>  	UCOUNT_RLIMIT_MEMLOCK,
> -	UCOUNT_COUNTS,
> +	UCOUNT_ALL_COUNTS,
>  };
>  
> -#define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
> +#define UCOUNT_COUNTS UCOUNT_RLIMIT_NPROC
> +#define RLIMIT_COUNTS UCOUNT_ALL_COUNTS - UCOUNT_COUNTS + 1
>  
>  struct user_namespace {
>  	struct uid_gid_map	uid_map;
> @@ -99,6 +100,7 @@ struct user_namespace {
>  #endif
>  	struct ucounts		*ucounts;
>  	long ucount_max[UCOUNT_COUNTS];
> +	long rlimit_max[RLIMIT_COUNTS];
>  } __randomize_layout;
>  
>  struct ucounts {
> @@ -106,7 +108,7 @@ struct ucounts {
>  	struct user_namespace *ns;
>  	kuid_t uid;
>  	atomic_t count;
> -	atomic_long_t ucount[UCOUNT_COUNTS];
> +	atomic_long_t ucount[UCOUNT_ALL_COUNTS];
>  };
>  
>  extern struct user_namespace init_user_ns;
> @@ -131,10 +133,15 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
>  void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
>  bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
>  
> -static inline void set_rlimit_ucount_max(struct user_namespace *ns,
> +static inline long get_userns_rlimit_max(struct user_namespace *ns, enum ucount_type type)
> +{
> +	return READ_ONCE(ns->rlimit_max[type - UCOUNT_COUNTS]);
> +}
> +
> +static inline void set_userns_rlimit_max(struct user_namespace *ns,
>  		enum ucount_type type, unsigned long max)
>  {
> -	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
> +	ns->rlimit_max[type - UCOUNT_COUNTS] = max <= LONG_MAX ? max : LONG_MAX;
>  }
>  
>  #ifdef CONFIG_USER_NS
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3244cc56b697..365819458030 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -836,13 +836,13 @@ void __init fork_init(void)
>  	init_task.signal->rlim[RLIMIT_SIGPENDING] =
>  		init_task.signal->rlim[RLIMIT_NPROC];
>  
> -	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
> +	for (i = 0; i < UCOUNT_COUNTS; i++)
>  		init_user_ns.ucount_max[i] = max_threads/2;
>  
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
>  
>  #ifdef CONFIG_VMAP_STACK
>  	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 7b32c356ebc5..ffffcfae8474 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -87,10 +87,6 @@ static struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_fanotify_groups"),
>  	UCOUNT_ENTRY("max_fanotify_marks"),
>  #endif
> -	{ },
> -	{ },
> -	{ },
> -	{ },
>  	{ }
>  };
>  #endif /* CONFIG_SYSCTL */
> @@ -273,7 +269,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
>  			ret = LONG_MAX;
>  		else if (iter == ucounts)
>  			ret = new;
> -		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		max = get_userns_rlimit_max(iter->ns, type);
>  	}
>  	return ret;
>  }
> @@ -322,7 +318,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
>  			goto unwind;
>  		if (iter == ucounts)
>  			ret = new;
> -		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		max = get_userns_rlimit_max(iter->ns, type);
>  		/*
>  		 * Grab an extra ucount reference for the caller when
>  		 * the rlimit count was previously 0.
> @@ -350,7 +346,7 @@ bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsign
>  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>  		if (get_ucounts_value(iter, type) > max)
>  			return true;
> -		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		max = get_userns_rlimit_max(iter->ns, type);
>  	}
>  	return false;
>  }
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 6b2e3ca7ee99..b9f6729b4e5f 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -119,13 +119,13 @@ int create_user_ns(struct cred *new)
>  	ns->owner = owner;
>  	ns->group = group;
>  	INIT_WORK(&ns->work, free_user_ns);
> -	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
> +	for (i = 0; i < UCOUNT_COUNTS; i++) {
>  		ns->ucount_max[i] = INT_MAX;
>  	}
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
>  	ns->ucounts = ucounts;
>  
>  	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
