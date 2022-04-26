Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01C50EDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiDZBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:11:41 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF0113C98;
        Mon, 25 Apr 2022 18:08:34 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9FD663F1BD;
        Tue, 26 Apr 2022 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650935312;
        bh=NnYGpCsK3OiC7zEiHemQw74Hiqb4uZNP8e95378V+cU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iExdAXIgmrY6A/GzzU8vCd+/OZniwCuvl69y7jGiS0INR6yri2f5ZgZq1IfGfoGTU
         tzcqlznhWz67h/CzSluIKfi3paU86zr/osvB60tdOY1UsbC97mZTSWMfZRyj5Khq69
         8uqS9XQXa8uNoq6V8VSzCyGfY1ZjLfTdM93G7dg+kPmgf0rQjgkANAn+NpQ7safujh
         gsIKA+1WmoPH49c01amuypzjRiGT3kss4cbCrHgqxTe/08y6/a0FKtDfs3tUNDySlb
         zfkCPc3eH16MtCwfVVycBAVYAFq7M/THATL6A5QM1WUPL2BV8NzZtXR/AnBBmHh4mq
         EhogTyx8fyMdw==
Message-ID: <ad1e85e1-8706-7b93-59cd-99ccef273be4@canonical.com>
Date:   Mon, 25 Apr 2022 18:08:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 26/29] Audit: Add record for multiple task security
 contexts
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-27-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-27-casey@schaufler-ca.com>
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
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1420) record is:
> 
>     type=MAC_TASK_CONTEXTS[1420]
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> the "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on a subject security context.
> 
> Functions are created to manage the skb list in the audit_buffer.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Besides moving the aux fns, and the whining below
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 93 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 88 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 8eda133ca4c1..af0aaccfaf57 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -143,6 +143,7 @@
>  #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
>  #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
> +#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 4d44c05053b0..8ed2d717c217 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2175,8 +2175,61 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>  		audit_log_format(ab, "(null)");
>  }
>  
> +/**
> + * audit_buffer_aux_new - Add an aux record buffer to the skb list
> + * @ab: audit_buffer
> + * @type: message type
> + *
> + * Aux records are allocated and added to the skb list of
> + * the "main" record. The ab->skb is reset to point to the
> + * aux record on its creation. When the aux record in complete
> + * ab->skb has to be reset to point to the "main" record.
> + * This allows the audit_log_ functions to be ignorant of
> + * which kind of record it is logging to. It also avoids adding
> + * special data for aux records.
> + *
> + * On success ab->skb will point to the new aux record.
> + * Returns 0 on success, -ENOMEM should allocation fail.
> + */
> +static int audit_buffer_aux_new(struct audit_buffer *ab, int type)
> +{
> +	WARN_ON(ab->skb != skb_peek(&ab->skb_list));
> +
> +	ab->skb = nlmsg_new(AUDIT_BUFSIZ, ab->gfp_mask);
> +	if (!ab->skb)
> +		goto err;
> +	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> +		goto err;
> +	skb_queue_tail(&ab->skb_list, ab->skb);
> +
> +	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
> +			 (unsigned long long)ab->stamp.ctime.tv_sec,
> +			 ab->stamp.ctime.tv_nsec/1000000,
> +			 ab->stamp.serial);
> +
> +	return 0;
> +
> +err:
> +	kfree_skb(ab->skb);
> +	ab->skb = skb_peek(&ab->skb_list);
> +	return -ENOMEM;
> +}
> +
> +/**
> + * audit_buffer_aux_end - Switch back to the "main" record from an aux record
> + * @ab: audit_buffer
> + *
> + * Restores the "main" audit record to ab->skb.
> + */
> +static void audit_buffer_aux_end(struct audit_buffer *ab)
> +{
> +	ab->skb = skb_peek(&ab->skb_list);
> +}
> +
> +
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
> +	int i;
>  	int error;
>  	struct lsmblob blob;
>  	struct lsmcontext context;
> @@ -2185,16 +2238,44 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	if (!lsmblob_is_set(&blob))
>  		return 0;
>  
> -	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
> +	if (!lsm_multiple_contexts()) {
> +		error = security_secid_to_secctx(&blob, &context,
> +						 LSMBLOB_FIRST);
> +		if (error) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return 0;
> +		}
>  
> -	if (error) {
> -		if (error != -EINVAL)
> +		audit_log_format(ab, " subj=%s", context.context);
> +		security_release_secctx(&context);
> +	} else {
> +		/* Multiple LSMs provide contexts. Include an aux record. */
> +		audit_log_format(ab, " subj=?");

just me whining, you sure we can't just drop subj= here

> +		error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
> +		if (error)
>  			goto error_path;
> -		return 0;
> +		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +			if (blob.secid[i] == 0)
> +				continue;
> +			error = security_secid_to_secctx(&blob, &context, i);
> +			if (error) {
> +				audit_log_format(ab, "%ssubj_%s=?",
> +						 i ? " " : "",
> +						 lsm_slot_to_name(i));
> +				if (error != -EINVAL)
> +					audit_panic("error in audit_log_task_context");
> +			} else {
> +				audit_log_format(ab, "%ssubj_%s=%s",
> +						 i ? " " : "",
> +						 lsm_slot_to_name(i),
> +						 context.context);
> +				security_release_secctx(&context);
> +			}
> +		}
> +		audit_buffer_aux_end(ab);
>  	}
>  
> -	audit_log_format(ab, " subj=%s", context.context);
> -	security_release_secctx(&context);
>  	return 0;
>  
>  error_path:

