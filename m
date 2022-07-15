Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795105766A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGOSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGOSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:20:53 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7746050A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:20:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41140)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCPvm-001XGR-Ov; Fri, 15 Jul 2022 12:20:50 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47566 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCPvl-006d1V-Qv; Fri, 15 Jul 2022 12:20:50 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        longman@redhat.com, roman.gushchin@linux.dev, legion@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220715062301.19311-1-hbh25y@gmail.com>
Date:   Fri, 15 Jul 2022 13:20:23 -0500
In-Reply-To: <20220715062301.19311-1-hbh25y@gmail.com> (Hangyu Hua's message
        of "Fri, 15 Jul 2022 14:23:01 +0800")
Message-ID: <87v8ryz194.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oCPvl-006d1V-Qv;;;mid=<87v8ryz194.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19CcuBbg2Xt2eAPCP9wCMd7QXP6AefhaWQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Hangyu Hua <hbh25y@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 383 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 14 (3.7%), b_tie_ro: 12 (3.1%), parse: 1.64
        (0.4%), extract_message_metadata: 5 (1.4%), get_uri_detail_list: 1.44
        (0.4%), tests_pri_-1000: 8 (2.0%), tests_pri_-950: 2.2 (0.6%),
        tests_pri_-900: 1.92 (0.5%), tests_pri_-90: 95 (24.7%), check_bayes:
        93 (24.2%), b_tokenize: 7 (1.9%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 71 (18.7%), b_finish: 1.28
        (0.3%), tests_pri_0: 223 (58.3%), check_dkim_signature: 1.09 (0.3%),
        check_dkim_adsp: 4.0 (1.0%), poll_dns_idle: 0.95 (0.2%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 14 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ipc: mqueue: fix possible memory leak in init_mqueue_fs()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hangyu Hua <hbh25y@gmail.com> writes:

> commit db7cfc380900 ("ipc: Free mq_sysctls if ipc namespace creation
> failed")
>
> Here's a similar memory leak to the one fixed by the patch above.
> retire_mq_sysctls need to be called when init_mqueue_fs fails after
> setup_mq_sysctls.

Alex can you review this change?

> Fixes: dc55e35f9e81 ("ipc: Store mqueue sysctls in the ipc namespace")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  ipc/mqueue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 12ad7860bb88..83370fef8879 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -1746,6 +1746,7 @@ static int __init init_mqueue_fs(void)
>  	unregister_filesystem(&mqueue_fs_type);
>  out_sysctl:
>  	kmem_cache_destroy(mqueue_inode_cachep);
> +	retire_mq_sysctls(&init_ipc_ns);
>  	return error;
>  }

Thanks,
Eric
