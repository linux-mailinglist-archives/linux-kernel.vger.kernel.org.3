Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5842E518FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiECVGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiECVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E904403CE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651611739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDZbWK0BLixqlWjUz2JHDFzdOBqstmI1FplFwCeha7M=;
        b=AqXNBOtiIsfje/Z4Lnv/hMjsiEbxuwDX7CVSCadB0wXRnDtiet3u7t+LWTrEkLz5Oo/4wp
        PzVf91MX8CJn24sHYhHD5XcgPmCH8pOAp+jQfhj1ekX91ik3sspM5u4qnkJdim9itdA0Nt
        AqoYqfw4tqUi0i6qA4pkBba2YqJnDVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-1we9oypZPXSScbZYReIlOA-1; Tue, 03 May 2022 17:02:17 -0400
X-MC-Unique: 1we9oypZPXSScbZYReIlOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 205188F3FCE;
        Tue,  3 May 2022 21:02:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4F5D40D2820;
        Tue,  3 May 2022 21:02:15 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BD6154112778; Tue,  3 May 2022 16:12:21 -0300 (-03)
Date:   Tue, 3 May 2022 16:12:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 13/13] task isolation: only TIF_TASK_ISOL if task
 isolation is enabled
Message-ID: <YnF+lbxJXiQMbS/a@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.333646565@fedora.localdomain>
 <87zgk7x93h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgk7x93h.ffs@tglx>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:45:54AM +0200, Thomas Gleixner wrote:
> On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> 
> $Subject does not qualify as a parseable sentence.
> 
> > This avoids processing of TIF_TASK_ISOL, when returning to userspace,
> > for tasks which do not have task isolation configured.
> 
> That's how kernel development works, right:
> 
>    1) Add half baken stuff
>    2) Apply duct tape on top
> 
> You know exactly, that this is _not_ the way it works.
> 
> This whole thing is half thought out tinkerware with [ill|un]defined
> semantics.

It seems to be inline with the remaining TIF_ bits:

                if (ti_work & _TIF_NOTIFY_RESUME)
                        tracehook_notify_resume(regs);

+               if (ti_work & _TIF_TASK_ISOL)
+                       task_isol_exit_to_user_mode();
+


And there is even:

--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED       3       /* rescheduling necessary */
 #define TIF_SINGLESTEP         4       /* reenable singlestep on user return*/
 #define TIF_SSBD               5       /* Speculative store bypass disable */
+#define TIF_TASK_ISOL          6       /* task isolation work pending */
 #define TIF_SPEC_IB            9       /* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH     10      /* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY 11      /* notify kernel of userspace return */

So the purpose of TIF_TASK_ISOL is to condense in a single bit the 
question: "is there task isolation work pending?"

By looking at the code, we see the sites where this bit is set are:

1) Task isolation configuration.

@@ -251,6 +257,11 @@ static int cfg_feat_quiesce_set(unsigned
        info->quiesce_mask = i_qctrl->quiesce_mask;
        info->oneshot_mask = i_qctrl->quiesce_oneshot_mask;
        info->conf_mask |= ISOL_F_QUIESCE;
+
+       if ((info->active_mask & ISOL_F_QUIESCE) &&
+           (info->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
+               set_thread_flag(TIF_TASK_ISOL);
+
        ret = 0;

2) copy_process (clone / fork):

@@ -303,6 +314,7 @@ int __copy_task_isol(struct task_struct
                new_info->active_mask = info->active_mask;

        tsk->task_isol_info = new_info;
+       set_ti_thread_flag(task_thread_info(tsk), TIF_TASK_ISOL);

        return 0;
 }

3) task isolation activation:

@@ -330,6 +342,10 @@ int prctl_task_isol_activate_set(unsigne
        info->active_mask = active_mask;
        ret = 0;

+       if ((info->active_mask & ISOL_F_QUIESCE) &&
+           (info->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
+               set_thread_flag(TIF_TASK_ISOL);
+
 out:
        return ret;

Would you prefer an explanation, in words, when these bits are set, when
they are cleared? 

So the meaning is:

+#define TIF_TASK_ISOL          6       /* task isolation work pending */

And the definition is "task isolation work" depends on what task
isolation features are implemented.

(honestly, seem pretty clear to me, but willing to improve...).

