Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD46B50A635
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbiDUQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiDUQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:54:08 -0400
X-Greylist: delayed 81 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 09:51:18 PDT
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556749266;
        Thu, 21 Apr 2022 09:51:18 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 387AF4019D;
        Thu, 21 Apr 2022 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650559876;
        bh=ld8fVszvK/3E4H3tYAuLWfYLXCWj/coqjBjg5dU3/hE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tONA08z62V/uN3+5EEYlJVI+wxGcCu0XsugILzrpOZLXguQ570uO+oFgo4w3HWfae
         vT0BM16cYtQ8tTQ4pzZgjLcO4ra6caoo2mM9iWYNXa+gAWcaRDpuDCd0yJ7bN20fbT
         CxqdJdei+nW7ToJQNYkNl9qF1tlMFVkM/xDc6TUmddOhbK42+CabJjFvCfFFnyxOAr
         3LjaMXwTuVzGI+Otc7sXFKg080BrUddn/HD2uqJnMFWjWdx6yiESSI4YbyDPJ00UAS
         MYP0fnGYEgXzTfo8otaic99n2S0V/VK4d5JH8tSeEKvnUk/5rtIwqwZX9iSCb52Q+6
         XlS6Z9RypQCRw==
Message-ID: <9aff97f4-ae7b-905f-5c06-3bb3904ae525@canonical.com>
Date:   Thu, 21 Apr 2022 09:51:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 01/29] integrity: disassociate ima_filter_rule from
 security_audit_rule
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-2-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-2-casey@schaufler-ca.com>
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
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new fuctions are put in security.c because
> they use security module registered hooks that we don't
> want exported.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/linux/security.h     | 24 ++++++++++++++++++++++++
>  security/integrity/ima/ima.h | 26 --------------------------
>  security/security.c          | 21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 25b3ef71f495..2986342dad41 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1917,6 +1917,30 @@ static inline void security_audit_rule_free(void *lsmrule)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_AUDIT */
>  
> +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +void ima_filter_rule_free(void *lsmrule);
> +
> +#else
> +
> +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> +					   void **lsmrule)
> +{
> +	return 0;
> +}
> +
> +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> +					    void *lsmrule)
> +{
> +	return 0;
> +}
> +
> +static inline void ima_filter_rule_free(void *lsmrule)
> +{ }
> +
> +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> +
>  #ifdef CONFIG_SECURITYFS
>  
>  extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index be965a8715e4..1b5d70ac2dc9 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -418,32 +418,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
>  }
>  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
>  
> -/* LSM based policy rules require audit */
> -#ifdef CONFIG_IMA_LSM_RULES
> -
> -#define ima_filter_rule_init security_audit_rule_init
> -#define ima_filter_rule_free security_audit_rule_free
> -#define ima_filter_rule_match security_audit_rule_match
> -
> -#else
> -
> -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -				       void **lsmrule)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline void ima_filter_rule_free(void *lsmrule)
> -{
> -}
> -
> -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					void *lsmrule)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_IMA_LSM_RULES */
> -
>  #ifdef	CONFIG_IMA_READ_POLICY
>  #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
>  #else
> diff --git a/security/security.c b/security/security.c
> index b7cf5cbfdc67..22543fdb6041 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2586,6 +2586,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>  }
>  #endif /* CONFIG_AUDIT */
>  
> +#ifdef CONFIG_IMA_LSM_RULES
> +/*
> + * The integrity subsystem uses the same hooks as
> + * the audit subsystem.
> + */
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> +{
> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +}
> +
> +void ima_filter_rule_free(void *lsmrule)
> +{
> +	call_void_hook(audit_rule_free, lsmrule);
> +}
> +
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +{
> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +}
> +#endif /* CONFIG_IMA_LSM_RULES */
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>  {

