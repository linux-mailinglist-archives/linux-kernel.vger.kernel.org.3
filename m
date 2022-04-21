Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227250A631
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiDUQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiDUQxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:53:43 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F994888F;
        Thu, 21 Apr 2022 09:50:52 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 338AE3F220;
        Thu, 21 Apr 2022 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650559849;
        bh=2DG3agqZjNytTzNe0loT9pgVlejRsgs8lmk2z1lMY40=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YB5qk9IUE9X7PduRp9d6MLO+xQsarbdtDtFXq2nF9+pwcgorjgvhEXkY4PC4FERw0
         IjFunQ9KCVqS/XjDkerJ5ZenVwynf7XbDwlAv9QHknWt/azqJovr7emMTku4YMtUxz
         kB6BL1atr2A7VrN/VOe1NhAAyY84hozIIowXlFAOPyw3gT/3zo35YlHkog1tHd0fa4
         T0kJ+ckNligvKBP3Ke/TXxZmyaaUhgwXBtP+Sh3kL5vchxngXPFJ6HVusVE7M+etA9
         uEOtQut38Kfv/tIxethGILytXdsFjE9/0FiJVUrNnVqHbOa9MCzFcL31p8fM4CEon9
         VmzYZpmeWS4ag==
Message-ID: <466b7347-d601-c2c7-7974-947105cf81e2@canonical.com>
Date:   Thu, 21 Apr 2022 09:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 04/29] LSM: provide lsm name and id slot mappings
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-5-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-5-casey@schaufler-ca.com>
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
> Provide interfaces to map LSM slot numbers and LSM names.
> Update the LSM registration code to save this information.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>


Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/linux/security.h |  4 ++++
>  security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ed51baa94a30..d00870d2b416 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -195,6 +195,10 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
>  	return !memcmp(bloba, blobb, sizeof(*bloba));
>  }
>  
> +/* Map lsm names to blob slot numbers */
> +extern int lsm_name_to_slot(char *name);
> +extern const char *lsm_slot_to_name(int slot);
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> diff --git a/security/security.c b/security/security.c
> index 49fa61028da2..d1ddbb857af1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -477,6 +477,50 @@ static int lsm_append(const char *new, char **result)
>   * Current index to use while initializing the lsmblob secid list.
>   */
>  static int lsm_slot __lsm_ro_after_init;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
> +
> +/**
> + * lsm_name_to_slot - Report the slot number for a security module
> + * @name: name of the security module
> + *
> + * Look up the slot number for the named security module.
> + * Returns the slot number or LSMBLOB_INVALID if @name is not
> + * a registered security module name.
> + */
> +int lsm_name_to_slot(char *name)
> +{
> +	int i;
> +
> +	for (i = 0; i < lsm_slot; i++)
> +		if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
> +			return i;
> +
> +	return LSMBLOB_INVALID;
> +}
> +
> +/**
> + * lsm_slot_to_name - Get the name of the security module in a slot
> + * @slot: index into the interface LSM slot list.
> + *
> + * Provide the name of the security module associated with
> + * a interface LSM slot.
> + *
> + * If @slot is LSMBLOB_INVALID return the value
> + * for slot 0 if it has been set, otherwise NULL.
> + *
> + * Returns a pointer to the name string or NULL.
> + */
> +const char *lsm_slot_to_name(int slot)
> +{
> +	if (slot == LSMBLOB_INVALID)
> +		slot = 0;
> +	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
> +		return NULL;
> +
> +	if (lsm_slotlist[slot] == NULL)
> +		return NULL;
> +	return lsm_slotlist[slot]->lsm;
> +}
>  
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -498,6 +542,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	if (lsmid->slot == LSMBLOB_NEEDED) {
>  		if (lsm_slot >= LSMBLOB_ENTRIES)
>  			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>  		lsmid->slot = lsm_slot++;
>  		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>  			   lsmid->slot);

