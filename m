Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520A4DDFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiCRRLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiCRRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:11:46 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFF304AE8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:10:26 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:34208)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVG7N-00HajF-2r; Fri, 18 Mar 2022 11:10:25 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38554 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVG7M-007Ebz-5k; Fri, 18 Mar 2022 11:10:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220317072612.163143-2-imran.f.khan@oracle.com> (Imran Khan's
        message of "Thu, 17 Mar 2022 18:26:05 +1100")
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
        <20220317072612.163143-2-imran.f.khan@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 18 Mar 2022 12:10:14 -0500
Message-ID: <87r16z191l.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nVG7M-007Ebz-5k;;;mid=<87r16z191l.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wjzlL/GPqEcbAXTkQu2rdooPY6b912Cc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Imran Khan <imran.f.khan@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 301 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (3.3%), b_tie_ro: 9 (2.9%), parse: 0.69 (0.2%),
         extract_message_metadata: 2.6 (0.9%), get_uri_detail_list: 1.01
        (0.3%), tests_pri_-1000: 3.0 (1.0%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.80 (0.3%), tests_pri_-90: 87 (28.9%), check_bayes:
        86 (28.5%), b_tokenize: 4.8 (1.6%), b_tok_get_all: 5 (1.8%),
        b_comp_prob: 1.56 (0.5%), b_tok_touch_all: 72 (23.8%), b_finish: 0.68
        (0.2%), tests_pri_0: 173 (57.5%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 1.22 (0.4%), tests_pri_10:
        3.9 (1.3%), tests_pri_500: 13 (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imran Khan <imran.f.khan@oracle.com> writes:

> This allows to change underlying mutex locking, without needing to change
> the users of the lock. For example next patch modifies this interface to
> use hashed mutexes in place of a single global kernfs_open_file_mutex.
>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
>  fs/kernfs/file.c            | 26 +++++++++++++++-----------
>  fs/kernfs/kernfs-internal.h | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 7aefaca876a0..99793c32abc3 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -30,7 +30,7 @@
>   * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
>   */
>  static DEFINE_SPINLOCK(kernfs_open_node_lock);
> -static DEFINE_MUTEX(kernfs_open_file_mutex);
> +DEFINE_MUTEX(kernfs_open_file_mutex);
^^^^^????

Why when you want things more localized are you making a lock more
global?
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index eeaa779b929c..df00a5f5a367 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -164,4 +164,22 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
>   */
>  extern const struct inode_operations kernfs_symlink_iops;
>  
> +extern struct mutex kernfs_open_file_mutex;
> +
> +static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
> +{
> +	return &kernfs_open_file_mutex;
> +}
> +
> +static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
> +{
> +	struct mutex *lock;
> +
> +	lock = kernfs_open_file_mutex_ptr(kn);
> +
> +	mutex_lock(lock);
> +
> +	return lock;
> +}

Why don't these functions live in fs/kern/fs/file.c

Eric

