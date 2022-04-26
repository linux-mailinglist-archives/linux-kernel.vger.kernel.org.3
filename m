Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4AB50EF52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiDZDle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiDZDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:41:25 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF2ECCCC;
        Mon, 25 Apr 2022 20:38:15 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A47813F9E0;
        Tue, 26 Apr 2022 03:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650944288;
        bh=t5BVhVwPX2LjN7byClOmBAVBS2+Tcozj35sCWydq8Ho=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=i8K/sAv2iKqpr2Llk8lXY5ReC7zxrdiIPVH4k/OPhEQFyowGURO+EMMZHFayqn/Se
         d9LmP4ihOxZrswc1YSXuTlISvfA4pW8zIAzebHfRbDCj879IVFJFPmckPWbvMqd26H
         7YkOfdcKWk/K0QxRB3P4H/8VpgsrFZStu66iIRhXgt4tcsqAGHJle1p9naSDIew1cy
         tCMxJYIV4G8FZkwLoqyBnwmxDC0V2e8A5itDWxW+IpvsT/ZcyDBuahzx9fNiwlaYsf
         +mUGKFILEvpGV74wFvOIEDwNqAOF7fIW5RpsK+lrUnIOucSiGHF5a1Q/MNUdnyyWjG
         RVPhWtyDHNjpA==
Message-ID: <f2186f22-5bcd-d962-7e49-c816fc5fbd07@canonical.com>
Date:   Mon, 25 Apr 2022 20:37:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 27/29] Audit: Add record for multiple object contexts
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-28-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-28-casey@schaufler-ca.com>
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
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1421) record is:
> 
>     type=MAC_OBJ_CONTEXTS[1421]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  5 +++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 47 +++++++++++++++++++++++
>  kernel/auditsc.c           | 79 ++++++++++++--------------------------
>  4 files changed, 77 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 14849d5f84b4..1b05eb2dbe77 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -191,6 +191,8 @@ extern void		    audit_log_path_denied(int type,
>  						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
> +extern void audit_log_object_context(struct audit_buffer *ab,
> +				     struct lsmblob *blob);
>  extern int audit_log_task_context(struct audit_buffer *ab);
>  extern void audit_log_task_info(struct audit_buffer *ab);
>  
> @@ -251,6 +253,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
>  { }
>  static inline void audit_log_path_denied(int type, const char *operation)
>  { }
> +static inline  void audit_log_object_context(struct audit_buffer *ab,
> +					     struct lsmblob *blob)
> +{ }
>  static inline int audit_log_task_context(struct audit_buffer *ab)
>  {
>  	return 0;
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index af0aaccfaf57..d25d76b29e3c 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -144,6 +144,7 @@
>  #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
>  #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
> +#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM objext contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 8ed2d717c217..a8c3ec6ba60b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2226,6 +2226,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
>  	ab->skb = skb_peek(&ab->skb_list);
>  }
>  
> +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
> +{
> +	int i;
> +	int error;
> +	struct lsmcontext context;
> +
> +	if (!lsm_multiple_contexts()) {
> +		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
> +		if (error) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return;
> +		}
> +		audit_log_format(ab, " obj=%s", context.context);
> +		security_release_secctx(&context);
> +	} else {
> +		audit_log_format(ab, " obj=?");
> +		error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> +		if (error)
> +			goto error_path;
> +
> +		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +			if (blob->secid[i] == 0)
> +				continue;
> +			error = security_secid_to_secctx(blob, &context, i);
> +			if (error) {
> +				audit_log_format(ab, "%sobj_%s=?",
> +						 i ? " " : "",
> +						 lsm_slot_to_name(i));
> +				if (error != -EINVAL)
> +					audit_panic("error in audit_log_object_context");
> +			} else {
> +				audit_log_format(ab, "%sobj_%s=%s",
> +						 i ? " " : "",
> +						 lsm_slot_to_name(i),
> +						 context.context);
> +				security_release_secctx(&context);
> +			}
> +		}
> +
> +		audit_buffer_aux_end(ab);
> +	}
> +	return;
> +
> +error_path:
> +	audit_panic("error in audit_log_object_context");

This moves the audit_panic around, so certain operations are not
done before the call. I am currently not sure of the implications.

Paul?

> +}
>  
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 557713954a69..04bf3c04ef3d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1114,36 +1114,25 @@ static inline void audit_free_context(struct audit_context *context)
>  	kfree(context);
>  }
>  
> -static int audit_log_pid_context(struct audit_context *context, pid_t pid,
> -				 kuid_t auid, kuid_t uid,
> -				 unsigned int sessionid,
> -				 struct lsmblob *blob, char *comm)
> +static void audit_log_pid_context(struct audit_context *context, pid_t pid,
> +				  kuid_t auid, kuid_t uid,
> +				  unsigned int sessionid,
> +				  struct lsmblob *blob, char *comm)
>  {
>  	struct audit_buffer *ab;
> -	struct lsmcontext lsmctx;
> -	int rc = 0;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>  	if (!ab)
> -		return rc;
> +		return;
>  
>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
> -	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " obj=(none)");
> -			rc = 1;
> -		} else {
> -			audit_log_format(ab, " obj=%s", lsmctx.context);
> -			security_release_secctx(&lsmctx);
> -		}
> -	}
> +	if (lsmblob_is_set(blob))
> +		audit_log_object_context(ab, blob);
>  	audit_log_format(ab, " ocomm=");
>  	audit_log_untrustedstring(ab, comm);
>  	audit_log_end(ab);
> -
> -	return rc;
>  }
>  
>  static void audit_log_execve_info(struct audit_context *context,
> @@ -1420,18 +1409,10 @@ static void show_special(struct audit_context *context, int *call_panic)

If pushing audit_panic into audit_log_object_context() is acceptable then this call_panic arg is
no longer needed. The same goes for the call_panic arg in audit_log_name(). And call_panic can
be dropped from audit_log_exit()


>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
>  		if (osid) {
> -			struct lsmcontext lsmcxt;
>  			struct lsmblob blob;
>  
>  			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt,
> -						     LSMBLOB_FIRST)) {
> -				audit_log_format(ab, " osid=%u", osid);
> -				*call_panic = 1;
> -			} else {
> -				audit_log_format(ab, " obj=%s", lsmcxt.context);
> -				security_release_secctx(&lsmcxt);
> -			}
> +			audit_log_object_context(ab, &blob);
>  		}
>  		if (context->ipc.has_perm) {
>  			audit_log_end(ab);
> @@ -1588,19 +1569,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 from_kgid(&init_user_ns, n->gid),
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
> -	if (lsmblob_is_set(&n->lsmblob)) {
> -		struct lsmcontext lsmctx;
> -
> -		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
> -					     LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " osid=?");
> -			if (call_panic)
> -				*call_panic = 2;
> -		} else {
> -			audit_log_format(ab, " obj=%s", lsmctx.context);
> -			security_release_secctx(&lsmctx);
> -		}
> -	}
> +	if (lsmblob_is_set(&n->lsmblob))
> +		audit_log_object_context(ab, &n->lsmblob);
>  
>  	/* log the audit_names record type */
>  	switch (n->type) {
> @@ -1805,21 +1775,20 @@ static void audit_log_exit(void)
>  		struct audit_aux_data_pids *axs = (void *)aux;
>  
>  		for (i = 0; i < axs->pid_count; i++)
> -			if (audit_log_pid_context(context, axs->target_pid[i],
> -						  axs->target_auid[i],
> -						  axs->target_uid[i],
> -						  axs->target_sessionid[i],
> -						  &axs->target_lsm[i],
> -						  axs->target_comm[i]))
> -				call_panic = 1;
> -	}
> -
> -	if (context->target_pid &&
> -	    audit_log_pid_context(context, context->target_pid,
> -				  context->target_auid, context->target_uid,
> -				  context->target_sessionid,
> -				  &context->target_lsm, context->target_comm))
> -			call_panic = 1;
> +			audit_log_pid_context(context, axs->target_pid[i],
> +					      axs->target_auid[i],
> +					      axs->target_uid[i],
> +					      axs->target_sessionid[i],
> +					      &axs->target_lsm[i],
> +					      axs->target_comm[i]);
> +	}
> +
> +	if (context->target_pid)
> +		audit_log_pid_context(context, context->target_pid,
> +				      context->target_auid, context->target_uid,
> +				      context->target_sessionid,
> +				      &context->target_lsm,
> +				      context->target_comm);
>  
>  	if (context->pwd.dentry && context->pwd.mnt) {
>  		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);

