Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E0550A62E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiDUQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356775AbiDUQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:52:48 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2EEAE61;
        Thu, 21 Apr 2022 09:49:57 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5275D3F212;
        Thu, 21 Apr 2022 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650559793;
        bh=cE0mr3ujI3By6bbSMsOYsbG0H9B5mOQfowagLjHY8uE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VOFCPwOBYkQuJ0ehu2hFXzRHENWvA/GCeQ+0pzKigqwMpgde470YQdArfwtnpvhYS
         eBTHYb0ilcA1jISHq8xnCr0mcxWOcFWMy4BwodZyP3Q2IhRqYEqPpH/z6LiXfJmks5
         VOLZpgGmiYGOnKySPp6JUu2QHsckGFR/Ft6OygAxNK+d+xyZ5vcvLt70QdBsaWewPH
         +otsB9YVXh5CJ0J6DZyUwbalEWE8HvE7kSDwtfHonuP2XGjXFO5ArDwKPZNgiIp6nI
         SXUZeybDizbNSR04yFGtA0ouYiZiDzp0/JTLYC0gaFlo3kXNUCUce+8Dod1ht9hiAO
         gHOzpD+oOxEJQ==
Message-ID: <0673dfee-4968-9b72-dd4e-b5fdffac0a7d@canonical.com>
Date:   Thu, 21 Apr 2022 09:49:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 06/29] LSM: Use lsmblob in security_audit_rule_match
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-7-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 07:59, Casey Schaufler wrote:
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
> 
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. The scaffolding function lsmblob_init()
> fills the blob with the value of the old secid, ensuring that
> it is available to the appropriate module hook. The sources of
> the secid, security_task_getsecid() and security_inode_getsecid(),
> will be converted to use the blob structure later in the series.
> At the point the use of lsmblob_init() is dropped.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> Cc: linux-audit@redhat.com
> ---
>  include/linux/security.h |  5 +++--
>  kernel/auditfilter.c     |  6 ++++--
>  kernel/auditsc.c         | 16 +++++++++++-----
>  security/security.c      |  5 +++--
>  4 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3666eddad59a..ee5d14dac65f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1955,7 +1955,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr,
>  			     struct audit_lsm_rules *lsmrules);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>  			      struct audit_lsm_rules *lsmrules);
>  void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
>  
> @@ -1972,7 +1972,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>  	return 0;
>  }
>  
> -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +static inline int security_audit_rule_match(struct lsmblob *blob,
> +					    u32 field, u32 op,
>  					    struct audit_lsm_rules *lsmrules)
>  {
>  	return 0;
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index de75bd6ad866..15cd4fe35e9c 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1337,6 +1337,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>  
>  		for (i = 0; i < e->rule.field_count; i++) {
>  			struct audit_field *f = &e->rule.fields[i];
> +			struct lsmblob blob;
>  			pid_t pid;
>  			u32 sid;
>  
> @@ -1369,8 +1370,9 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_str) {
>  					security_current_getsecid_subj(&sid);
> -					result = security_audit_rule_match(sid,
> -						   f->type, f->op,
> +					lsmblob_init(&blob, sid);
> +					result = security_audit_rule_match(
> +						   &blob, f->type, f->op,
>  						   &f->lsm_rules);
>  				}
>  				break;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d272b5cf18a8..a9d5bfa37cb3 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -468,6 +468,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  	const struct cred *cred;
>  	int i, need_sid = 1;
>  	u32 sid;
> +	struct lsmblob blob;
>  	unsigned int sessionid;
>  
>  	if (ctx && rule->prio <= ctx->prio)
> @@ -678,8 +679,10 @@ static int audit_filter_rules(struct task_struct *tsk,
>  					security_current_getsecid_subj(&sid);
>  					need_sid = 0;
>  				}
> -				result = security_audit_rule_match(sid, f->type,
> -							f->op, &f->lsm_rules);
> +				lsmblob_init(&blob, sid);
> +				result = security_audit_rule_match(&blob,
> +							f->type, f->op,
> +							&f->lsm_rules);
>  			}
>  			break;
>  		case AUDIT_OBJ_USER:
> @@ -692,15 +695,17 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			if (f->lsm_str) {
>  				/* Find files that match */
>  				if (name) {
> +					lsmblob_init(&blob, name->osid);
>  					result = security_audit_rule_match(
> -								name->osid,
> +								&blob,
>  								f->type,
>  								f->op,
>  								&f->lsm_rules);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
> +						lsmblob_init(&blob, n->osid);
>  						if (security_audit_rule_match(
> -							n->osid, f->type, f->op,
> +							&blob, f->type, f->op,
>  							&f->lsm_rules)) {
>  							++result;
>  							break;
> @@ -710,7 +715,8 @@ static int audit_filter_rules(struct task_struct *tsk,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type != AUDIT_IPC)
>  					break;
> -				if (security_audit_rule_match(ctx->ipc.osid,
> +				lsmblob_init(&blob, ctx->ipc.osid);
> +				if (security_audit_rule_match(&blob,
>  							      f->type, f->op,
>  							      &f->lsm_rules))
>  					++result;
> diff --git a/security/security.c b/security/security.c
> index 9e0139b0d346..ced1c76a380f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2703,7 +2703,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
>  	}
>  }
>  
> -int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>  			      struct audit_lsm_rules *lsmrules)
>  {
>  	struct security_hook_list *hp;
> @@ -2714,7 +2714,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
>  			continue;
>  		if (lsmrules->rule[hp->lsmid->slot] == NULL)
>  			continue;
> -		rc = hp->hook.audit_rule_match(secid, field, op,
> +		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
> +					field, op,
>  					&lsmrules->rule[hp->lsmid->slot]);
>  		if (rc)
>  			return rc;

