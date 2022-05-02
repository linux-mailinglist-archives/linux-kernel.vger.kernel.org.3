Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9A5173CC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiEBQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbiEBQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:11:34 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DACDF94
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:07:59 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39356)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlYaW-00G66k-43; Mon, 02 May 2022 10:07:52 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36676 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlYaV-002zy7-2q; Mon, 02 May 2022 10:07:51 -0600
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
        <e2c8df40672ca854b754cc3a412be2d6f684ac8b.1650631347.git.legion@kernel.org>
Date:   Mon, 02 May 2022 11:07:24 -0500
In-Reply-To: <e2c8df40672ca854b754cc3a412be2d6f684ac8b.1650631347.git.legion@kernel.org>
        (Alexey Gladkov's message of "Fri, 22 Apr 2022 14:53:37 +0200")
Message-ID: <875ymnvryb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nlYaV-002zy7-2q;;;mid=<875ymnvryb.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+wXehoCMqRnCn8sog7V37uBF8NwpGbygA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 389 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.01
        (0.3%), extract_message_metadata: 12 (3.1%), get_uri_detail_list: 1.43
        (0.4%), tests_pri_-1000: 15 (3.8%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 54 (13.8%), check_bayes:
        52 (13.3%), b_tokenize: 7 (1.8%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 31 (8.0%), b_finish: 0.86
        (0.2%), tests_pri_0: 282 (72.4%), check_dkim_signature: 0.86 (0.2%),
        check_dkim_adsp: 3.3 (0.8%), poll_dns_idle: 0.75 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 1/4] ipc: Remove extra1 field abuse to pass ipc
 namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Eric Biederman pointed out that using .extra1 to pass ipc namespace
> looks like an ugly hack and there is a better solution.
>
> Link: https://lore.kernel.org/lkml/87czib9g38.fsf@email.froward.int.ebiederm.org/
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  ipc/ipc_sysctl.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 15210ac47e9e..eb7ba8e0a355 100644
> @@ -55,20 +50,15 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>  	void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct ipc_namespace *ns = table->extra1;
> -	struct ctl_table ipc_table;
> +	struct ipc_namespace *ns =
> +		container_of(table->data, struct ipc_namespace, sem_ctls);
>  	int ret, semmni;
>  
> -	memcpy(&ipc_table, table, sizeof(ipc_table));
> -
> -	ipc_table.extra1 = NULL;
> -	ipc_table.extra2 = NULL;
> -
>  	semmni = ns->sem_ctls[3];
>  	ret = proc_dointvec(table, write, buffer, lenp, ppos);
>  
>  	if (!ret)
> -		ret = sem_check_semmni(current->nsproxy->ipc_ns);
> +		ret = sem_check_semmni(ns);
		^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can you break this one line change into a separate patch?

It is a bug fix so that the entire function uses the same
ns value.  I expect the change would read easier if the
change was separate.

>  
>  	/*
>  	 * Reset the semmni value if an error happens.

Eric
