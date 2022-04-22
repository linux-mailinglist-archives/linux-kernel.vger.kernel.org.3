Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74750B30F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445576AbiDVIkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444898AbiDVIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:40:39 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90AD532E2;
        Fri, 22 Apr 2022 01:37:45 -0700 (PDT)
Received: from [10.8.192.2] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B502C3F14D;
        Fri, 22 Apr 2022 08:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650616658;
        bh=Q6SW+76/25YDPAJx9QomYz2DqlSHag1a8JfhGVDBPR0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pn3hdlgpfRX0aNdR1UmnstOl12XeoYAPHKqhACuh+LujBAWtfl5eO6+Fp74Hgg8BY
         dPfAZRmii+jzVtxneFtnyVYzQM1Ivl3DIVAXJmKsSl1AQpULcZ6GfO5/1aguSlhFTI
         d0FsG2yRshS68au0r53bW/sNtYh2Y38gbCTH2mYeHROhDLt7MgsCLcRNadFLIDA+SX
         ZLcurRZ9zTNK+b1Lh+pcUlZjH49JSzEePvYy9Z03FwnKxPqZ5HjgxLUrFz4lZPdP6h
         vaKLUIs95fYi5C8MqadbFVW7+kGEt6ckAaA0RtpErI9cvACdU9NdBcVQoNElHGIVWL
         ZTUirdKMfDICw==
Message-ID: <5b4fbec9-2573-2980-c846-af58d20b6cfc@canonical.com>
Date:   Fri, 22 Apr 2022 01:37:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 28/29] LSM: Add /proc attr entry for full LSM context
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-29-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-29-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 07:59, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:
>         lsm1\0value\0lsm2\0value\0...
> This entry is not writable.
> 
> A security module may decide that its policy does not allow
> this information to be displayed. In this case none of the
> information will be displayed.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> Cc: linux-api@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/security/lsm.rst       | 14 +++++
>  fs/proc/base.c                       |  1 +
>  include/linux/lsm_hooks.h            |  6 +++
>  security/apparmor/include/procattr.h |  2 +-
>  security/apparmor/lsm.c              |  8 ++-
>  security/apparmor/procattr.c         | 22 ++++----
>  security/security.c                  | 79 ++++++++++++++++++++++++++++
>  security/selinux/hooks.c             |  2 +-
>  security/smack/smack_lsm.c           |  2 +-
>  9 files changed, 121 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index b77b4a540391..070225ae6ceb 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -143,3 +143,17 @@ separated list of the active security modules.
>  The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
>  module for which the ``/proc/pid/attr/current`` interface will
>  apply. This interface can be written to.
> +
> +The infrastructure does provide an interface for the special
> +case where multiple security modules provide a process context.
> +This is provided in compound context format.
> +
> +-  `lsm\0value\0lsm\0value\0`
> +
> +The `lsm` and `value` fields are NUL-terminated bytestrings.
> +Each field may contain whitespace or non-printable characters.
> +The NUL bytes are included in the size of a compound context.
> +The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
> +
> +The file ``/proc/pid/attr/context`` provides the security
> +context of the identified process.
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index f2d15348bdff..f8aed4404e7e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2828,6 +2828,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
>  	ATTR(NULL, "interface_lsm",	0666),
> +	ATTR(NULL, "context",		0444),
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index fd63ae215104..425538ebc606 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1401,6 +1401,12 @@
>   *	@pages contains the number of pages.
>   *	Return 0 if permission is granted.
>   *
> + * @getprocattr:
> + *	Provide the named process attribute for display in special files in
> + *	the /proc/.../attr directory.  Attribute naming and the data displayed
> + *	is at the discretion of the security modules.  The exception is the
> + *	"context" attribute, which will contain the security context of the
> + *	task as a nul terminated text string without trailing whitespace.
>   * @ismaclabel:
>   *	Check if the extended attribute specified by @name
>   *	represents a MAC label. Returns 1 if name is a MAC
> diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
> index 31689437e0e1..03dbfdb2f2c0 100644
> --- a/security/apparmor/include/procattr.h
> +++ b/security/apparmor/include/procattr.h
> @@ -11,7 +11,7 @@
>  #ifndef __AA_PROCATTR_H
>  #define __AA_PROCATTR_H
>  
> -int aa_getprocattr(struct aa_label *label, char **string);
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline);
>  int aa_setprocattr_changehat(char *args, size_t size, int flags);
>  
>  #endif /* __AA_PROCATTR_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 29181bc8c693..1ee58c1491ab 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -602,6 +602,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	const struct cred *cred = get_task_cred(task);
>  	struct aa_task_ctx *ctx = task_ctx(current);
>  	struct aa_label *label = NULL;
> +	bool newline = true;
>  
>  	if (strcmp(name, "current") == 0)
>  		label = aa_get_newest_label(cred_label(cred));
> @@ -609,11 +610,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  		label = aa_get_newest_label(ctx->previous);
>  	else if (strcmp(name, "exec") == 0 && ctx->onexec)
>  		label = aa_get_newest_label(ctx->onexec);
> -	else
> +	else if (strcmp(name, "context") == 0) {
> +		label = aa_get_newest_label(cred_label(cred));
> +		newline = false;
> +	} else
>  		error = -EINVAL;
>  
>  	if (label)
> -		error = aa_getprocattr(label, value);
> +		error = aa_getprocattr(label, value, newline);
>  
>  	aa_put_label(label);
>  	put_cred(cred);
> diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
> index fde332e0ea7d..172550f67fc0 100644
> --- a/security/apparmor/procattr.c
> +++ b/security/apparmor/procattr.c
> @@ -20,6 +20,7 @@
>   * aa_getprocattr - Return the profile information for @profile
>   * @profile: the profile to print profile info about  (NOT NULL)
>   * @string: Returns - string containing the profile info (NOT NULL)
> + * @newline: Should a newline be added to @string.
>   *
>   * Requires: profile != NULL
>   *
> @@ -28,20 +29,21 @@
>   *
>   * Returns: size of string placed in @string else error code on failure
>   */
> -int aa_getprocattr(struct aa_label *label, char **string)
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline)
>  {
>  	struct aa_ns *ns = labels_ns(label);
>  	struct aa_ns *current_ns = aa_get_current_ns();
> +	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED;
>  	int len;
>  
>  	if (!aa_ns_visible(current_ns, ns, true)) {
>  		aa_put_ns(current_ns);
>  		return -EACCES;
>  	}
> +	if (newline)
> +		flags |= FLAG_SHOW_MODE;
>  
> -	len = aa_label_snxprint(NULL, 0, current_ns, label,
> -				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -				FLAG_HIDDEN_UNCONFINED);
> +	len = aa_label_snxprint(NULL, 0, current_ns, label, flags);
>  	AA_BUG(len < 0);
>  
>  	*string = kmalloc(len + 2, GFP_KERNEL);
> @@ -50,19 +52,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
>  		return -ENOMEM;
>  	}
>  
> -	len = aa_label_snxprint(*string, len + 2, current_ns, label,
> -				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -				FLAG_HIDDEN_UNCONFINED);
> +	len = aa_label_snxprint(*string, len + 2, current_ns, label, flags);
>  	if (len < 0) {
>  		aa_put_ns(current_ns);
>  		return len;
>  	}
>  
> -	(*string)[len] = '\n';
> -	(*string)[len + 1] = 0;
> +	if (newline) {
> +		(*string)[len] = '\n';
> +		(*string)[++len] = 0;
> +	}
>  
>  	aa_put_ns(current_ns);
> -	return len + 1;
> +	return len;
>  }
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index be6682768760..4c6d4171ded6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -802,6 +802,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  	return 0;
>  }
>  
> +/**
> + * append_ctx - append a lsm/context pair to a compound context
> + * @ctx: the existing compound context
> + * @ctxlen: size of the old context, including terminating nul byte
> + * @lsm: new lsm name, nul terminated
> + * @new: new context, possibly nul terminated
> + * @newlen: maximum size of @new
> + *
> + * replace @ctx with a new compound context, appending @newlsm and @new
> + * to @ctx. On exit the new data replaces the old, which is freed.
> + * @ctxlen is set to the new size, which includes a trailing nul byte.
> + *
> + * Returns 0 on success, -ENOMEM if no memory is available.
> + */
> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
> +		      int newlen)
> +{
> +	char *final;
> +	size_t llen;
> +	size_t nlen;
> +	size_t flen;
> +
> +	llen = strlen(lsm) + 1;
> +	/*
> +	 * A security module may or may not provide a trailing nul on
> +	 * when returning a security context. There is no definition
> +	 * of which it should be, and there are modules that do it
> +	 * each way.
> +	 */
> +	nlen = strnlen(new, newlen);
> +
> +	flen = *ctxlen + llen + nlen + 1;
> +	final = kzalloc(flen, GFP_KERNEL);
> +
> +	if (final == NULL)
> +		return -ENOMEM;
> +
> +	if (*ctxlen)
> +		memcpy(final, *ctx, *ctxlen);
> +
> +	memcpy(final + *ctxlen, lsm, llen);
> +	memcpy(final + *ctxlen + llen, new, nlen);
> +
> +	kfree(*ctx);
> +
> +	*ctx = final;
> +	*ctxlen = flen;
> +
> +	return 0;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> @@ -2223,6 +2274,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	int rc = 0;
> +	int finallen = 0;
>  	int ilsm = lsm_task_ilsm(current);
>  	int slot = 0;
>  
> @@ -2250,6 +2305,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  		return -ENOMEM;
>  	}
>  
> +	if (!strcmp(name, "context")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +				     list) {
> +			rc = hp->hook.getprocattr(p, "context", &cp);
> +			if (rc == -EINVAL)
> +				continue;
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
> +					cp, rc);
> +			kfree(cp);
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +		}
> +		if (final == NULL)
> +			return -EINVAL;
> +		*value = final;
> +		return finallen;
> +	}
> +
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 653dd2e236f1..cd977493f734 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6346,7 +6346,7 @@ static int selinux_getprocattr(struct task_struct *p,
>  			goto bad;
>  	}
>  
> -	if (!strcmp(name, "current"))
> +	if (!strcmp(name, "current") || !strcmp(name, "context"))
>  		sid = __tsec->sid;
>  	else if (!strcmp(name, "prev"))
>  		sid = __tsec->osid;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 2190c03ae3d0..9e442c4495bf 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3485,7 +3485,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  	char *cp;
>  	int slen;
>  
> -	if (strcmp(name, "current") != 0)
> +	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
>  		return -EINVAL;
>  
>  	cp = kstrdup(skp->smk_known, GFP_KERNEL);

