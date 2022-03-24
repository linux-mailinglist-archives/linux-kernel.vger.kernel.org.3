Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70004E6A67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiCXVvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXVvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:51:03 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C490CDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:49:29 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:42026)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nXVKf-004CrQ-Le; Thu, 24 Mar 2022 15:49:25 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35370 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nXVKe-009mjU-6j; Thu, 24 Mar 2022 15:49:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
References: <cover.1644862280.git.legion@kernel.org>
        <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
Date:   Thu, 24 Mar 2022 16:48:59 -0500
In-Reply-To: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 24 Mar 2022 11:12:21 -0700")
Message-ID: <87czib9g38.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nXVKe-009mjU-6j;;;mid=<87czib9g38.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/CzAR3xs870q902q+h8NSA1paBvYeu4wE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 769 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.54
        (0.2%), extract_message_metadata: 20 (2.6%), get_uri_detail_list: 6
        (0.7%), tests_pri_-1000: 26 (3.3%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 92 (12.0%), check_bayes:
        91 (11.8%), b_tokenize: 17 (2.2%), b_tok_get_all: 13 (1.7%),
        b_comp_prob: 3.8 (0.5%), b_tok_touch_all: 53 (6.9%), b_finish: 0.89
        (0.1%), tests_pri_0: 597 (77.6%), check_dkim_signature: 1.25 (0.2%),
        check_dkim_adsp: 4.1 (0.5%), poll_dns_idle: 1.26 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 13 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] ipc: Bind to the ipc namespace at open time.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Mar 23, 2022 at 1:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Please pull the per-namespace-ipc-sysctls-for-v5.18 tag from the git tree:
>
> Ugh.
>
> I pulled this. Then I stared at it for a long time.
>
> And then I decided that this is too ugly to live.
>
> I'm sorry. I think Alexey has probably spent a fair amount of time on
> it, but I really think the sysctl code needs to be cleaned up way more
> than this.
>
> The old code was horribly hacky too, but that setup_ipc_sysctls() (and
> setup_mq_sysctls()) thing that copies the whole sysctls table, and
> then walks it entry by entry to modify it, is just too ugly for words.

I am not convinced when it comes to the .data pointers it is too
ugly to live.  The only realistic alternative is doing something
with the offset to adjust the pointers to the per namespace values.

Fundamentally the copy is needed because in the general case (which is
present in the networking stack) we only show a subset of the sysctls in
anything other than the initial namespace.  That is necessary as some
sysctls have not been shown to be safe for unprivileged users to write.

So there does need to be a separate array of ctl_table entries per
namespace, and the data pointers in those entries need to be adjusted to
the per namespace values.

> And then it hides things in .extra1, and because it does that it can't
> use the normal "extra1 and extra2 contains the limits" so then at
> write() time it copies it into a local one AGAIN only to set the
> limits back so that it can call the normal routines again.
>
> Not ok.

I agree.  That is a bit ugly, and I missed it when I was looking
at the code.

The mq_sysctl.c changes look reasonable to me.  There are no strange
games being played with .extra1 or .extra2.  All I see happening
in mq_sysctl.c is boiler plate to make things work.

Looking at ipc_sysctl.c I agree playing games with .extra1 and .extra2
is ugly and error prone.  Worse I noticed when reading it through that
proc_ipc_sem_dointvec passes sem_check_semmni current->nsproxy->ipc_ns
instead of passing the computed ns value.  A bug but not a regression.

I went through the code and we don't need to play games with .extra1
to get the namespace value all we need to call container_of with
the .data member.  That takes a little extra boiler plate especially
for the checkpoint_restore case.

The checkpoint_restore sysctls arguably need to be done differently so
that the permissions can be checked at open time instead of at write
time.  That would eliminate the need to play games with foobar.

>
> Anyway, I really think we must not make that sysctl code even uglier
> than it is today, and I think we need to move towards a model that
> actually makes sense. And that "pass in the right cred" is the only
> sensible model I can see.

I don't see how passing in struct cred does anything helpful.  The
namespace can not be found in struct cred.

Now this set of changes is a setup to allow implementing .set_ownership
and .permission methods so that we can allow the namespace root to write
to sysctls it is safe for the namespace root to be able to write to.
Even there I don't see how passing in a struct cred would help.

Given that there are no regressions I don't see it even being helpful
to not merge this code.

I did look and there are some cleanup pretty significant cleanup
opportunities, by using container_of on .data, which avoids the need
to stuff a namespace parameter in .extra1.

There are also significant cleanup opportunities in implementing a
.permission method that will allow the checkpoint_restart sysctls
to perform all of their permission checks at open time, and not
need any other special code.

But all of these cleanups I see are moving forward from the current
point so I don't see why we would not want to merge the code as is
and then get the tested versions of my cleanups below.



ipc/ipc_sysctl.c | 81 +++++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 15210ac47e9e..e2209d48db04 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -19,16 +19,11 @@
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ipc_namespace *ns = table->extra1;
-	struct ctl_table ipc_table;
+	struct ipc_namespace *ns =
+		container_of(table->data, struct ipc_namespace, shm_rmid_forced);
 	int err;
 
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-
-	ipc_table.extra1 = SYSCTL_ZERO;
-	ipc_table.extra2 = SYSCTL_ONE;
-
-	err = proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (err < 0)
 		return err;
@@ -55,20 +50,15 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ipc_namespace *ns = table->extra1;
-	struct ctl_table ipc_table;
+	struct ipc_namespace *ns =
+		container_of(table->data, struct ipc_namespace, sem_ctls);
 	int ret, semmni;
 
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-
-	ipc_table.extra1 = NULL;
-	ipc_table.extra2 = NULL;
-
 	semmni = ns->sem_ctls[3];
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
 	if (!ret)
-		ret = sem_check_semmni(current->nsproxy->ipc_ns);
+		ret = sem_check_semmni(ns);
 
 	/*
 	 * Reset the semmni value if an error happens.
@@ -78,24 +68,6 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	return ret;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
-static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ipc_namespace *ns = table->extra1;
-	struct ctl_table ipc_table;
-
-	if (write && !checkpoint_restore_ns_capable(ns->user_ns))
-		return -EPERM;
-
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-
-	ipc_table.extra1 = SYSCTL_ZERO;
-	ipc_table.extra2 = SYSCTL_INT_MAX;
-
-	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
-}
-#endif
 
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
@@ -131,6 +103,8 @@ static struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "msgmax",
@@ -180,22 +154,28 @@ static struct ctl_table ipc_sysctls[] = {
 		.procname	= "sem_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
-		.mode		= 0666,
-		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "msg_next_id",
 		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
-		.mode		= 0666,
-		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "shm_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
-		.mode		= 0666,
-		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
 	{}
@@ -211,8 +191,24 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
+static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
+{
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	int mode = table->mode;
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
+	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
+	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
+	    checkpoint_restore_ns_capable(ns->user_ns))
+		mode = 0666;
+#endif
+	return mode;
+}
+
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
+	.permissions = ipc_permissions,
 };
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
@@ -237,7 +233,6 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 			} else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced) {
 				tbl[i].data = &ns->shm_rmid_forced;
-				tbl[i].extra1 = ns;
 
 			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmax) {
 				tbl[i].data = &ns->msg_ctlmax;
@@ -250,19 +245,15 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 			} else if (tbl[i].data == &init_ipc_ns.sem_ctls) {
 				tbl[i].data = &ns->sem_ctls;
-				tbl[i].extra1 = ns;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
-				tbl[i].extra1 = ns;
 
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
-				tbl[i].extra1 = ns;
 
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
-				tbl[i].extra1 = ns;
 #endif
 			} else {
 				tbl[i].data = NULL;



Eric
