Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B050A62C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiDUQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiDUQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:53:14 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B844A31;
        Thu, 21 Apr 2022 09:50:21 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 009803F9FA;
        Thu, 21 Apr 2022 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650559820;
        bh=BXz685sFL8rdyjQ9kBf25sVINuvvahr5YRVOc5euerA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tyd0I/38mEHEve20KNd4pZE9qotAI63N0s8ndhBq1bFwNR/9ZwDj60KqyGSEwOfR7
         czctBCV1EnYNzVV4ANfGAscsZ32mgO/G/24VoDmYnsJT07MpfNNxIjdi9tkA+hqrzQ
         TCrSIcGzPcUHf2DQtZw0/gCa2owo2tTDI50GRFcuyN/8/Zbgzb61KAaDJVl7vonIIz
         0kxc4QwnF5pz3TCLmSKoBCfAS+6YdOqMWThPesWcbbnA92Qpoev7byT+lDXiZGesLn
         kUUQ17QTHGi7pwMsy5b2Mp9z5l3yKkS4Cgo7eCrKM93upTPRcL221fQOY0Nzt+W79R
         d59EsGwiX9cOA==
Message-ID: <d86f9efa-8a5b-099f-4bd6-5b46a90fb73d@canonical.com>
Date:   Thu, 21 Apr 2022 09:50:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 05/29] IMA: avoid label collisions with stacked LSMs
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-6-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-6-casey@schaufler-ca.com>
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
> Integrity measurement may filter on security module information
> and needs to be clear in the case of multiple active security
> modules which applies. Provide a boot option ima_rules_lsm= to
> allow the user to specify an active security module to apply
> filters to. If not specified, use the first registered module
> that supports the audit_rule_match() LSM hook. Allow the user
> to specify in the IMA policy an lsm= option to specify the
> security module to use for a particular rule.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> To: Mimi Zohar <zohar@linux.ibm.com>
> To: linux-integrity@vger.kernel.org
> ---
>  Documentation/ABI/testing/ima_policy |  8 ++++-
>  include/linux/security.h             | 14 ++++----
>  security/integrity/ima/ima_policy.c  | 51 ++++++++++++++++++++++++----
>  security/security.c                  | 35 +++++++++++++++----
>  4 files changed, 89 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 839fab811b18..64863e9d87ea 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -26,7 +26,7 @@ Description:
>  				[uid=] [euid=] [gid=] [egid=]
>  				[fowner=] [fgroup=]]
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
> -				 [obj_user=] [obj_role=] [obj_type=]]
> +				 [obj_user=] [obj_role=] [obj_type=]] [lsm=]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
>  				[appraise_flag=] [appraise_algos=] [keyrings=]
>  		  base:
> @@ -126,6 +126,12 @@ Description:
>  
>  			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
>  
> +		It is possible to explicitly specify which security
> +		module a rule applies to using lsm=.  If the security
> +		module specified is not active on the system the rule
> +		will be rejected.  If lsm= is not specified the first
> +		security module registered on the system will be assumed.
> +
>  		Example of measure rules using alternate PCRs::
>  
>  			measure func=KEXEC_KERNEL_CHECK pcr=4
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d00870d2b416..3666eddad59a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1985,25 +1985,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
>  #endif /* CONFIG_AUDIT */
>  
>  #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> -void ima_filter_rule_free(void *lsmrule);
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			 int lsmslot);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
> +			  int lsmslot);
> +void ima_filter_rule_free(void *lsmrule, int lsmslot);
>  
>  #else
>  
>  static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -					   void **lsmrule)
> +				       void **lsmrule, int lsmslot)
>  {
>  	return 0;
>  }
>  
>  static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +					void *lsmrule, int lsmslot)
>  {
>  	return 0;
>  }
>  
> -static inline void ima_filter_rule_free(void *lsmrule)
> +static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
>  { }
>  
>  #endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index eea6e92500b8..97470354c8ae 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -89,6 +89,7 @@ struct ima_rule_entry {
>  	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
>  	int pcr;
>  	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
> +	int which;		/* which LSM rule applies to */
>  	struct {
>  		void *rule;	/* LSM file metadata specific */
>  		char *args_p;	/* audit value */
> @@ -285,6 +286,20 @@ static int __init default_appraise_policy_setup(char *str)
>  }
>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
>  
> +static int ima_rules_lsm __ro_after_init;
> +
> +static int __init ima_rules_lsm_init(char *str)
> +{
> +	ima_rules_lsm = lsm_name_to_slot(str);
> +	if (ima_rules_lsm < 0) {
> +		ima_rules_lsm = 0;
> +		pr_err("rule lsm \"%s\" not registered", str);
> +	}
> +
> +	return 1;
> +}
> +__setup("ima_rules_lsm=", ima_rules_lsm_init);
> +
>  static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>  {
>  	struct ima_rule_opt_list *opt_list;
> @@ -356,7 +371,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  	int i;
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		ima_filter_rule_free(entry->lsm[i].rule);
> +		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  }
> @@ -407,7 +422,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     entry->which);
>  		if (!nentry->lsm[i].rule)
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				nentry->lsm[i].args_p);
> @@ -623,14 +639,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  			security_inode_getsecid(inode, &osid);
>  			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
>  						   Audit_equal,
> -						   rule->lsm[i].rule);
> +						   rule->lsm[i].rule,
> +						   rule->which);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
>  			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
>  						   Audit_equal,
> -						   rule->lsm[i].rule);
> +						   rule->lsm[i].rule,
> +						   rule->which);
>  			break;
>  		default:
>  			break;
> @@ -1025,7 +1043,7 @@ enum policy_opt {
>  	Opt_fowner_lt, Opt_fgroup_lt,
>  	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_lsm, Opt_label, Opt_err
>  };
>  
>  static const match_table_t policy_tokens = {
> @@ -1073,6 +1091,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_template, "template=%s"},
>  	{Opt_keyrings, "keyrings=%s"},
>  	{Opt_label, "label=%s"},
> +	{Opt_lsm, "lsm=%s"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -1091,7 +1110,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  	entry->lsm[lsm_rule].type = audit_type;
>  	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>  				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rule);
> +				      &entry->lsm[lsm_rule].rule,
> +				      entry->which);
>  	if (!entry->lsm[lsm_rule].rule) {
>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>  			entry->lsm[lsm_rule].args_p);
> @@ -1780,6 +1800,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  						 &(template_desc->num_fields));
>  			entry->template = template_desc;
>  			break;
> +		case Opt_lsm:
> +			result = lsm_name_to_slot(args[0].from);
> +			if (result == LSMBLOB_INVALID) {
> +				int i;
> +
> +				for (i = 0; i < MAX_LSM_RULES; i++)
> +					entry->lsm[i].args_p = NULL;
> +				result = -EINVAL;
> +				break;
> +			}
> +			entry->which = result;
> +			result = 0;
> +			break;
>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
>  			result = -EINVAL;
> @@ -1816,6 +1849,7 @@ ssize_t ima_parse_add_rule(char *rule)
>  	struct ima_rule_entry *entry;
>  	ssize_t result, len;
>  	int audit_info = 0;
> +	int i;
>  
>  	p = strsep(&rule, "\n");
>  	len = strlen(p) + 1;
> @@ -1833,6 +1867,9 @@ ssize_t ima_parse_add_rule(char *rule)
>  
>  	INIT_LIST_HEAD(&entry->list);
>  
> +	for (i = 0; i < MAX_LSM_RULES; i++)
> +		entry->which = ima_rules_lsm;
> +
>  	result = ima_parse_rule(p, entry);
>  	if (result) {
>  		ima_free_rule(entry);
> @@ -2158,6 +2195,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  		seq_puts(m, "appraise_flag=check_blacklist ");
>  	if (entry->flags & IMA_PERMIT_DIRECTIO)
>  		seq_puts(m, "permit_directio ");
> +	if (entry->which >= 0)
> +		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));
>  	rcu_read_unlock();
>  	seq_puts(m, "\n");
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index d1ddbb857af1..9e0139b0d346 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2728,19 +2728,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
>   * The integrity subsystem uses the same hooks as
>   * the audit subsystem.
>   */
> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			 int lsmslot)
>  {
> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list)
> +		if (hp->lsmid->slot == lsmslot)
> +			return hp->hook.audit_rule_init(field, op, rulestr,
> +							lsmrule);
> +
> +	return 0;
>  }
>  
> -void ima_filter_rule_free(void *lsmrule)
> +void ima_filter_rule_free(void *lsmrule, int lsmslot)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
> +		if (hp->lsmid->slot == lsmslot) {
> +			hp->hook.audit_rule_free(lsmrule);
> +			return;
> +		}
> +	}
>  }
>  
> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
> +			  int lsmslot)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
> +		if (hp->lsmid->slot == lsmslot)
> +			return hp->hook.audit_rule_match(secid, field, op,
> +							 lsmrule);
> +
> +	return 0;
>  }
>  #endif /* CONFIG_IMA_LSM_RULES */
>  

