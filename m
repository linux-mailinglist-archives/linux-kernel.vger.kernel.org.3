Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF858027F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiGYQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:16:42 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52513FBB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:16:42 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38100)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG0l6-003w3H-H7; Mon, 25 Jul 2022 10:16:40 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:58050 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG0l5-006JxI-Hs; Mon, 25 Jul 2022 10:16:40 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
References: <54e6b6b1b430537748a7136e854923498443f78a.1657642613.git.legion@kernel.org>
Date:   Mon, 25 Jul 2022 11:16:07 -0500
In-Reply-To: <54e6b6b1b430537748a7136e854923498443f78a.1657642613.git.legion@kernel.org>
        (Alexey Gladkov's message of "Tue, 12 Jul 2022 18:17:38 +0200")
Message-ID: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oG0l5-006JxI-Hs;;;mid=<87wnc1i2wo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+7xsvv3hql2OPojijov5d5m6fwK6evo0A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.1%), parse: 1.54
        (0.3%), extract_message_metadata: 5 (1.2%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.90 (0.4%),
        tests_pri_-900: 1.55 (0.3%), tests_pri_-90: 116 (25.0%), check_bayes:
        114 (24.6%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 92 (19.8%), b_finish: 1.03
        (0.2%), tests_pri_0: 295 (63.3%), check_dkim_signature: 0.64 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 1.23 (0.3%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 12 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1] sysctl: Allow change system v ipc sysctls inside ipc
 namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Rootless containers are not allowed to modify kernel IPC parameters such
> as kernel.msgmnb.
>
> It seems to me that we can allow customization of these parameters if
> the user has CAP_SYS_RESOURCE in that ipc namespace.
>
> CAP_SYS_RESOURCE is already needed in order to overcome mqueue limits
> (msg_max and msgsize_max).


For changing the permissions on who can modify the SysV limits, I don't
think this change is safe.  I don't see anything that will prevent abuse
if anyone can modify these limits.  Replacing the ordinary unix DAC
permission check with ns_capable will allow anyone to modify the limits.


That said there is RLIMIT_MSGQUEUE that limits the posix messages queues
so those should be safe to allow anyone to modify their limits.

The code in mqueue_get_inode is where that limiting happens.

For the posix message queues all that should be needed is to change the
owner of the sysctl files from the global root to the user namespace
root.  There are also two capable calls in ipc/mqueue.c that can
probably be changed to ns_capable calls.


The only posix message queue limit that I don't immediately see
something that will prevent abuse of is /proc/sys/fs/mqueue/queus_max.
That probably still runs into RLIMIT_MSGQUEUE somewhere but it was
not immediately obvious at first glance.

Eric






>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  ipc/ipc_sysctl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index ef313ecfb53a..e79452867720 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -193,16 +193,19 @@ static int set_is_seen(struct ctl_table_set *set)
>  static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
>  {
>  	int mode = table->mode;
> -
> -#ifdef CONFIG_CHECKPOINT_RESTORE
>  	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
>  
> +#ifdef CONFIG_CHECKPOINT_RESTORE
>  	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
>  	    checkpoint_restore_ns_capable(ns->user_ns))
>  		mode = 0666;
> +	else
>  #endif
> +	if (ns_capable(ns->user_ns, CAP_SYS_RESOURCE))
> +		mode = 0666;
> +
>  	return mode;
>  }
