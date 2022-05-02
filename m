Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4205173D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiEBQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiEBQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:13:00 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFDFDF52
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:09:31 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35878)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlYc6-00D9TG-5q; Mon, 02 May 2022 10:09:30 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36680 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlYc5-0030RY-2P; Mon, 02 May 2022 10:09:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
References: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
        <cover.1650631347.git.legion@kernel.org>
        <32a29b3eb5f560e30ef24cfb86e480684b49ac62.1650631347.git.legion@kernel.org>
Date:   Mon, 02 May 2022 11:09:22 -0500
In-Reply-To: <32a29b3eb5f560e30ef24cfb86e480684b49ac62.1650631347.git.legion@kernel.org>
        (Alexey Gladkov's message of "Fri, 22 Apr 2022 14:53:38 +0200")
Message-ID: <87sfprudal.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nlYc5-0030RY-2P;;;mid=<87sfprudal.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19y/q/FQzGs6F1Akdf/n30W2F0lmB7XTpg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 467 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.43
        (0.3%), extract_message_metadata: 17 (3.5%), get_uri_detail_list: 1.81
        (0.4%), tests_pri_-1000: 21 (4.5%), tests_pri_-950: 1.76 (0.4%),
        tests_pri_-900: 1.48 (0.3%), tests_pri_-90: 122 (26.2%), check_bayes:
        120 (25.8%), b_tokenize: 7 (1.5%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 101 (21.7%), b_finish: 1.00
        (0.2%), tests_pri_0: 276 (59.0%), check_dkim_signature: 0.94 (0.2%),
        check_dkim_adsp: 3.2 (0.7%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 2/4] ipc: Use proper ipc namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> As Eric Biederman pointed out, changing the namespace broke checkpoint
> restore. I have reverted my previous changes.

Can you remind me the bug that is being fixed here?

I am probably just going to fast to see it, but it would be good to have
it described in the commit comment.

Thanks,
Eric

>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  ipc/ipc_sysctl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index eb7ba8e0a355..ff99d0305a5b 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -72,7 +72,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>  static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
>  		int write, void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct ipc_namespace *ns = table->extra1;
> +	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
>  	struct ctl_table ipc_table;
>  
>  	if (write && !checkpoint_restore_ns_capable(ns->user_ns))
> @@ -244,15 +244,12 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id) {
>  				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
> -				tbl[i].extra1 = ns;
>  
>  			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id) {
>  				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
> -				tbl[i].extra1 = ns;
>  
>  			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id) {
>  				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
> -				tbl[i].extra1 = ns;
>  #endif
>  			} else {
>  				tbl[i].data = NULL;
