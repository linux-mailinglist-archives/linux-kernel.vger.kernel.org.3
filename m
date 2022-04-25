Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECEF50ECA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiDYXfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDYXfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:35:34 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0956E54A;
        Mon, 25 Apr 2022 16:32:27 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 121203F62C;
        Mon, 25 Apr 2022 23:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650929543;
        bh=qD+GwLEOSjJsCQNYOwpuepe8fR7kDYamfQFbaSPARgg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZgGQfYoMCemwVUUNYJHKrweJJfKNGdI0uC75t+sRdwMwsh94O7Sa2yFXO2spz4la9
         x0q44Mkw5Qgs0GDhMopBdMLvJEVvIDgExbAzPFBfVfpqnNVP9xajXlZi7e2RrT4/Aj
         gY+wecxSxNG9kKUaimutDuyFr4kyTCRzjbpj+fEhsf5olvBRe6aEY+d1mKRp7dZpHA
         E4a7aFJR/RUIzdez34ap0Z9U6jPkmL0m2u3QmDrOuWGxZFdShhT1DG8qs7D3UEtByj
         QxD3xVAkAGLnKTNTQEf+zhF+TLv5zDiwQKbbMfFSaQkE0wSTIQLWSVbhZBcHfAUdwA
         cda40nqnF3MHQ==
Message-ID: <9ad920b4-f079-e367-4e0f-20078ea56d0d@canonical.com>
Date:   Mon, 25 Apr 2022 16:32:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 21/29] LSM: Extend security_secid_to_secctx to include
 module selection
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-22-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-22-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 07:59, Casey Schaufler wrote:
> Add a parameter to security_secid_to_secctx() to identify
> which of the security modules that may be active should
> provide the security context. If the parameter is greater
> than or equal to zero, the security module associated with
> that LSM "slot" is used. If the value is LSMBLOB_DISPLAY
> the "interface lsm" is used. If the value is LSMBLOB_FIRST
> the first security module providing a hook is used.
> 

So the patch does change behavior from previously doing
effectively LSMBLOB_DISPLAY everywhere to using LSMBLOB_FIRST
in certain cases. I think the reason for the change needs
to called out. I think a note in the patch description
would do.


> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c                |  2 +-
>  include/linux/security.h                |  7 +++++--
>  include/net/scm.h                       |  2 +-
>  kernel/audit.c                          |  4 ++--
>  kernel/auditsc.c                        |  7 ++++---
>  net/ipv4/ip_sockglue.c                  |  2 +-
>  net/netfilter/nf_conntrack_netlink.c    |  4 ++--
>  net/netfilter/nf_conntrack_standalone.c |  2 +-
>  net/netfilter/nfnetlink_queue.c         |  2 +-
>  net/netlabel/netlabel_unlabeled.c       | 11 +++++++----
>  net/netlabel/netlabel_user.c            |  2 +-
>  security/security.c                     | 20 ++++++++++++++++++--
>  12 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 259f5e38e6ba..d59c4ebf7e22 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2983,7 +2983,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		size_t added_size;
>  
>  		security_cred_getsecid(proc->cred, &blob);
> -		ret = security_secid_to_secctx(&blob, &lsmctx);
> +		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
>  			return_error_param = ret;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dc66f3f48456..2150016492be 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -184,6 +184,8 @@ struct lsmblob {
>  #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
>  #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>  #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +#define LSMBLOB_DISPLAY		-4	/* Use the "interface_lsm" slot */
> +#define LSMBLOB_FIRST		-5	/* Use the first slot */
>  
>  /**
>   * lsmblob_init - initialize a lsmblob structure
> @@ -615,7 +617,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
> +			     int ilsm);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob);
>  void security_release_secctx(struct lsmcontext *cp);
> @@ -1470,7 +1473,7 @@ static inline int security_ismaclabel(const char *name)
>  }
>  
>  static inline int security_secid_to_secctx(struct lsmblob *blob,
> -					   struct lsmcontext *cp)
> +					   struct lsmcontext *cp, int ilsm)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index b77a52f93389..f4d567d4885e 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -101,7 +101,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>  		 * and the infrastructure will know which it is.
>  		 */
>  		lsmblob_init(&lb, scm->secid);
> -		err = security_secid_to_secctx(&lb, &context);
> +		err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
>  
>  		if (!err) {
>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, context.len,
> diff --git a/kernel/audit.c b/kernel/audit.c
> index a885ebdbb91e..28ff7a5f90bd 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1464,7 +1464,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  
>  		if (lsmblob_is_set(&audit_sig_lsm)) {
>  			err = security_secid_to_secctx(&audit_sig_lsm,
> -						       &context);
> +						       &context, LSMBLOB_FIRST);
>  			if (err)
>  				return err;
>  		}
> @@ -2176,7 +2176,7 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	if (!lsmblob_is_set(&blob))
>  		return 0;
>  
> -	error = security_secid_to_secctx(&blob, &context);
> +	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
>  
>  	if (error) {
>  		if (error != -EINVAL)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 802de65259d8..231631f61550 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1132,7 +1132,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &lsmctx)) {
> +		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> @@ -1425,7 +1425,8 @@ static void show_special(struct audit_context *context, int *call_panic)
>  			struct lsmblob blob;
>  
>  			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt)) {
> +			if (security_secid_to_secctx(&blob, &lsmcxt,
> +						     LSMBLOB_FIRST)) {
>  				audit_log_format(ab, " osid=%u", osid);
>  				*call_panic = 1;
>  			} else {
> @@ -1593,7 +1594,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  		struct lsmcontext lsmctx;
>  
>  		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx)) {
> +		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
>  			audit_log_format(ab, " osid=%u", n->osid);
>  			if (call_panic)
>  				*call_panic = 2;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index ad5be7707bca..9b5c44dec1e9 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -140,7 +140,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  		return;
>  
>  	lsmblob_init(&lb, secid);
> -	err = security_secid_to_secctx(&lb, &context);
> +	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
>  	if (err)
>  		return;
>  
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 07660c7dd342..5d72d2f41562 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -353,7 +353,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	 * security_secid_to_secctx() will know which security module
>  	 * to use to create the secctx.  */
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>  	if (ret)
>  		return 0;
>  
> @@ -663,7 +663,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>  	int len;
>  	struct lsmblob blob;
>  
> -	len = security_secid_to_secctx(&blob, NULL);
> +	len = security_secid_to_secctx(&blob, NULL, LSMBLOB_DISPLAY);
>  	if (len <= 0)
>  		return 0;
>  
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 36338660df3c..cb4b8b636f6a 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -180,7 +180,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>  	if (ret)
>  		return;
>  
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index f60a0b6240ff..844955b2e163 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -316,7 +316,7 @@ static void nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
>  		 * blob. security_secid_to_secctx() will know which security
>  		 * module to use to create the secctx.  */
>  		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, context);
> +		security_secid_to_secctx(&blob, context, LSMBLOB_DISPLAY);
>  	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 910a03f15b0d..8deee7e176a9 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -437,7 +437,8 @@ int netlbl_unlhsh_add(struct net *net,
>  unlhsh_add_return:
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(lsmblob, &context) == 0) {
> +		if (security_secid_to_secctx(lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -491,7 +492,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  					  addr->s_addr, mask->s_addr);
>  		dev_put(dev);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -550,7 +552,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  					  addr, mask);
>  		dev_put(dev);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -1120,7 +1123,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		lsmb = (struct lsmblob *)&addr6->lsmblob;
>  	}
>  
> -	ret_val = security_secid_to_secctx(lsmb, &context);
> +	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 951ba0639d20..1941877fd16f 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  
>  	lsmblob_init(&blob, audit_info->secid);
>  	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(&blob, &context) == 0) {
> +	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
>  		audit_log_format(audit_buf, " subj=%s", context.context);
>  		security_release_secctx(&context);
>  	}
> diff --git a/security/security.c b/security/security.c
> index 64073d807240..be6682768760 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2347,20 +2347,36 @@ EXPORT_SYMBOL(security_ismaclabel);
>   * security_secid_to_secctx - convert secid to secctx
>   * @blob: set of secids
>   * @cp: lsm context into which result is put
> + * @ilsm: which security module to report
>   *
>   * Translate secid information into a secctx string.
>   * Return a negative value on error.
>   * If cp is NULL return the length of the string.
>   * Otherwise, return 0.
>   */
> -int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
> +			     int ilsm)
>  {
>  	struct security_hook_list *hp;
> -	int ilsm = lsm_task_ilsm(current);
>  
>  	if (cp)
>  		memset(cp, 0, sizeof(*cp));
>  
> +	/*
> +	 * ilsm either is the slot number use for formatting
> +	 * or an instruction on which relative slot to use.
> +	 */
> +	if (ilsm == LSMBLOB_DISPLAY)
> +		ilsm = lsm_task_ilsm(current);
> +	else if (ilsm == LSMBLOB_FIRST)
> +		ilsm = LSMBLOB_INVALID;
> +	else if (ilsm < 0) {
> +		WARN_ONCE(true, "LSM: %s unknown interface LSM\n", __func__);
> +		ilsm = LSMBLOB_INVALID;
> +	} else if (ilsm >= lsm_slot) {
> +		WARN_ONCE(true, "LSM: %s invalid interface LSM\n", __func__);
> +		ilsm = LSMBLOB_INVALID;
> +	}
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;

