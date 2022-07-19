Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0957A9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiGSWVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGSWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:21:16 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDC35407E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:21:15 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:45240)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oDvab-009vV1-TK; Tue, 19 Jul 2022 16:21:13 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34048 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oDvaa-0069CZ-DW; Tue, 19 Jul 2022 16:21:13 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        longman@redhat.com, roman.gushchin@linux.dev, legion@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220715062301.19311-1-hbh25y@gmail.com> (Hangyu Hua's message
        of "Fri, 15 Jul 2022 14:23:01 +0800")
References: <20220715062301.19311-1-hbh25y@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 19 Jul 2022 17:21:02 -0500
Message-ID: <87lesosq0h.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oDvaa-0069CZ-DW;;;mid=<87lesosq0h.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18rTReGCVKTGPlhUXT061i0UO41VfUIWDs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Hangyu Hua <hbh25y@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 854 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.3%), b_tie_ro: 9 (1.1%), parse: 1.07 (0.1%),
         extract_message_metadata: 3.3 (0.4%), get_uri_detail_list: 0.86
        (0.1%), tests_pri_-1000: 4.0 (0.5%), tests_pri_-950: 1.60 (0.2%),
        tests_pri_-900: 1.17 (0.1%), tests_pri_-90: 150 (17.6%), check_bayes:
        148 (17.4%), b_tokenize: 6 (0.6%), b_tok_get_all: 6 (0.7%),
        b_comp_prob: 1.96 (0.2%), b_tok_touch_all: 131 (15.4%), b_finish: 1.16
        (0.1%), tests_pri_0: 661 (77.4%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.0 (0.3%), poll_dns_idle: 0.62 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 9 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ipc: mqueue: fix possible memory leak in init_mqueue_fs()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

Applied.  Thank you.

>
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
