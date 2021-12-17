Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1008D4791F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbhLQQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:53:58 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59954 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbhLQQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:53:57 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:43922)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myGUW-0031FY-IN; Fri, 17 Dec 2021 09:53:56 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:39432 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myGUV-003tH4-BT; Fri, 17 Dec 2021 09:53:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211217183425.5ace9d3c@canb.auug.org.au>
Date:   Fri, 17 Dec 2021 10:53:49 -0600
In-Reply-To: <20211217183425.5ace9d3c@canb.auug.org.au> (Stephen Rothwell's
        message of "Fri, 17 Dec 2021 18:34:25 +1100")
Message-ID: <87ilvnfa02.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1myGUV-003tH4-BT;;;mid=<87ilvnfa02.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18lR3N1Wl6cWSXZGnQwJAwk7CfvhljKO4E=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 360 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (3.7%), b_tie_ro: 11 (3.1%), parse: 1.06
        (0.3%), extract_message_metadata: 13 (3.7%), get_uri_detail_list: 1.77
        (0.5%), tests_pri_-1000: 12 (3.2%), tests_pri_-950: 1.38 (0.4%),
        tests_pri_-900: 1.23 (0.3%), tests_pri_-90: 98 (27.4%), check_bayes:
        96 (26.7%), b_tokenize: 7 (1.8%), b_tok_get_all: 8 (2.3%),
        b_comp_prob: 2.4 (0.7%), b_tok_touch_all: 74 (20.4%), b_finish: 1.49
        (0.4%), tests_pri_0: 206 (57.3%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.6 (1.0%), poll_dns_idle: 1.64 (0.5%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux-next: build failure after merge of the userns tree
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the userns tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> ERROR: modpost: ".do_exit" [drivers/vhost/vhost.ko] undefined!
>
> Caused by commit
>
>   eb55e716ac1a ("exit: Stop exporting do_exit")
>
> interacting with commit
>
>   bbf761db7dbb ("vhost: use user_worker to check RLIMITs")
>
> from the vhost tree.
>
> I have added the following merge fix patch.

Thanks.

I will dig in a little more but this is not the correct fix.

make_task_dead is for the guts of oops, when the process is borked.

I need to track down and see what is going on with the new
user_work_create/start thing.

This looks like we need a user_work_exit helper that does what these
new user work kernel threads need.

I will follow up because yikes!  At first glance user_helpers look
like what kthreads were added to avoid.  Getting userspace and kernel
space state confused.

Eric

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 17 Dec 2021 18:24:30 +1100
> Subject: [PATCH] fix up for "vhost: use user_worker to check RLIMITs"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8cf259d798c0..b605a79533bb 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -374,7 +374,7 @@ static int vhost_worker(void *data)
>  	}
>  
>  	complete(worker->exit_done);
> -	do_exit(0);
> +	make_task_dead(0);
>  }
>  
>  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
>
> This lead to:
>
> ERROR: modpost: ".make_task_dead" [drivers/vhost/vhost.ko] undefined!
>
> so I added the following as well.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 17 Dec 2021 18:30:09 +1100
> Subject: [PATCH] fix 2 for "vhost: use user_worker to check RLIMITs"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  kernel/exit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 6c4b04531f17..dfa3e8f6ffeb 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -890,6 +890,7 @@ void __noreturn make_task_dead(int signr)
>  
>  	do_exit(signr);
>  }
> +EXPORT_SYMBOL_GPL(make_task_dead);
>  
>  SYSCALL_DEFINE1(exit, int, error_code)
>  {
