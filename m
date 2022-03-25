Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D464E7436
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbiCYNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiCYNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:31:52 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE252B02
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:30:18 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:49962)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nXk1A-002XcK-Rr; Fri, 25 Mar 2022 07:30:16 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35450 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nXk19-0036C5-SP; Fri, 25 Mar 2022 07:30:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220325112127.18026-1-pvorel@suse.cz>
Date:   Fri, 25 Mar 2022 08:29:25 -0500
In-Reply-To: <20220325112127.18026-1-pvorel@suse.cz> (Petr Vorel's message of
        "Fri, 25 Mar 2022 12:21:27 +0100")
Message-ID: <87o81u88ju.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nXk19-0036C5-SP;;;mid=<87o81u88ju.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19QVxhJidXPA7KZs1oAQPDdsHbodYjthcs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Petr Vorel <pvorel@suse.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 325 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.3 (1.0%), b_tie_ro: 2.3 (0.7%), parse: 0.67
        (0.2%), extract_message_metadata: 8 (2.5%), get_uri_detail_list: 1.05
        (0.3%), tests_pri_-1000: 3.8 (1.2%), tests_pri_-950: 1.00 (0.3%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 72 (22.1%), check_bayes:
        71 (21.7%), b_tokenize: 5 (1.6%), b_tok_get_all: 4.3 (1.3%),
        b_comp_prob: 1.43 (0.4%), b_tok_touch_all: 57 (17.6%), b_finish: 0.73
        (0.2%), tests_pri_0: 225 (69.3%), check_dkim_signature: 0.60 (0.2%),
        check_dkim_adsp: 2.2 (0.7%), poll_dns_idle: 0.68 (0.2%), tests_pri_10:
        1.78 (0.5%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] ns: Move MAX_PID_NS_LEVEL to ns_common.h, reuse it
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vorel <pvorel@suse.cz> writes:

> Move MAX_PID_NS_LEVEL to ns_common.h and reuse it in check in
> user_namespace.c.

What is the motivation for this change?

Is it just that there is a bare number in create_user_ns and that is a
little ugly?  Or is there something more motivating this?

Eric

>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Christian, all,
>
> I don't see putting MAX_PID_NS_LEVEL into ns_common.h as an elegant
> solution but IMHO better than use a hardwired number or redefinition in
> user_namespace.h.
>
> Kind regards,
> Petr
>
>  include/linux/ns_common.h     | 3 +++
>  include/linux/pid_namespace.h | 3 ---
>  kernel/user_namespace.c       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 0f1d024bd958..173fab9dadf7 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -4,6 +4,9 @@
>  
>  #include <linux/refcount.h>
>  
> +/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> +#define MAX_PID_NS_LEVEL 32
> +
>  struct proc_ns_operations;
>  
>  struct ns_common {
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 07481bb87d4e..f814068012d0 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -11,9 +11,6 @@
>  #include <linux/ns_common.h>
>  #include <linux/idr.h>
>  
> -/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> -#define MAX_PID_NS_LEVEL 32
> -
>  struct fs_pin;
>  
>  struct pid_namespace {
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 5481ba44a8d6..6ea6e263403d 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -87,7 +87,7 @@ int create_user_ns(struct cred *new)
>  	int ret, i;
>  
>  	ret = -ENOSPC;
> -	if (parent_ns->level > 32)
> +	if (parent_ns->level > MAX_PID_NS_LEVEL)
>  		goto fail;
>  
>  	ucounts = inc_user_namespaces(parent_ns, owner);
