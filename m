Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F914E67B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbiCXRYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCXRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:24:48 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F11CB20;
        Thu, 24 Mar 2022 10:23:15 -0700 (PDT)
Message-ID: <611bdc11-e27c-f78d-5659-07fd17d34a3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648142593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLYTgmoKt4DGeOnzIOdDH5BrS5GHLereG51tatRL9jI=;
        b=QLrk/byyX99PsNrTlucOMYw00hrsmMGZLnYpI/TgzzYo6VG4hloQzkCdmIdjBEwYGVkayF
        DJyIDneFhFtqT1kq9J7jpFEB90z0LPIbteGE/9RnNrYNvTk8E2SlT8UX4Fp/tp+eiQwAdA
        i6r4arZyCCxVtCX3+ws8d2Ua0etzmfs=
Date:   Thu, 24 Mar 2022 20:23:12 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH v2] memcg: enable accounting for nft objects
Content-Language: en-US
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        kernel@openvz.org
References: <20220228122429.GC26547@breakpoint.cc>
 <f359be78-c95d-555a-67ec-f665f90e93b8@linux.dev> <Yjx95+4qTtcYFYrv@salvia>
In-Reply-To: <Yjx95+4qTtcYFYrv@salvia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry,
perhaps it was casued by Thunderbird settigns on my new work place,
I'll double check it and then send fixed patch version.

Thank you,
	Vasily Averin


On 3/24/22 17:19, Pablo Neira Ayuso wrote:
> Hm. Patch does not apply for some reason. git am complains. And
> manually applying this also fails.
> 
> patch -p1 < vasily.averin.txt
> patching file net/netfilter/core.c
> Hunk #1 FAILED at 58.
> 1 out of 1 hunk FAILED -- saving rejects to file net/netfilter/core.c.rej
> patching file net/netfilter/nf_tables_api.c
> Hunk #1 FAILED at 1113.
> Hunk #2 FAILED at 1803.
> Hunk #3 FAILED at 2026.
> Hunk #4 FAILED at 2126.
> Hunk #5 FAILED at 2156.
> Hunk #6 FAILED at 2169.
> Hunk #7 FAILED at 2177.
> Hunk #8 FAILED at 2186.
> Hunk #9 FAILED at 2349.
> Hunk #10 FAILED at 2797.
> Hunk #11 FAILED at 3405.
> Hunk #12 FAILED at 3818.
> Hunk #13 FAILED at 4382.
> Hunk #14 FAILED at 5921.
> Hunk #15 FAILED at 6165.
> Hunk #16 FAILED at 6477.
> Hunk #17 FAILED at 6643.
> Hunk #18 FAILED at 7404.
> Hunk #19 FAILED at 7412.
> 19 out of 19 hunks FAILED -- saving rejects to file net/netfilter/nf_tables_api.c.rej
> 
> On Mon, Mar 21, 2022 at 08:02:22AM +0300, Vasily Averin wrote:
>> nftables replaces iptables, but it lacks memcg accounting.
>>
>> This patch account most of the memory allocation associated with nft
>> and should protect the host from misusing nft inside a memcg restricted
>> container.
>>
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> ---
>>  net/netfilter/core.c          |  2 +-
>>  net/netfilter/nf_tables_api.c | 44 +++++++++++++++++------------------
>>  2 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/net/netfilter/core.c b/net/netfilter/core.c
>> index 8a77a3fd69bc..77ae3e8d344c 100644
>> --- a/net/netfilter/core.c
>> +++ b/net/netfilter/core.c
>> @@ -58,7 +58,7 @@ static struct nf_hook_entries *allocate_hook_entries_size(u16 num)
>>  	if (num == 0)
>>  		return NULL;
>> -	e = kvzalloc(alloc, GFP_KERNEL);
>> +	e = kvzalloc(alloc, GFP_KERNEL_ACCOUNT);
>>  	if (e)
>>  		e->num_hook_entries = num;
>>  	return e;
>> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
>> index d71a33ae39b3..04be94236a34 100644
>> --- a/net/netfilter/nf_tables_api.c
>> +++ b/net/netfilter/nf_tables_api.c
>> @@ -1113,16 +1113,16 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
>>  	}
>>  	err = -ENOMEM;
>> -	table = kzalloc(sizeof(*table), GFP_KERNEL);
>> +	table = kzalloc(sizeof(*table), GFP_KERNEL_ACCOUNT);
>>  	if (table == NULL)
>>  		goto err_kzalloc;
>> -	table->name = nla_strdup(attr, GFP_KERNEL);
>> +	table->name = nla_strdup(attr, GFP_KERNEL_ACCOUNT);
>>  	if (table->name == NULL)
>>  		goto err_strdup;
>>  	if (nla[NFTA_TABLE_USERDATA]) {
>> -		table->udata = nla_memdup(nla[NFTA_TABLE_USERDATA], GFP_KERNEL);
>> +		table->udata = nla_memdup(nla[NFTA_TABLE_USERDATA], GFP_KERNEL_ACCOUNT);
>>  		if (table->udata == NULL)
>>  			goto err_table_udata;
>> @@ -1803,7 +1803,7 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
>>  	struct nft_hook *hook;
>>  	int err;
>> -	hook = kmalloc(sizeof(struct nft_hook), GFP_KERNEL);
>> +	hook = kmalloc(sizeof(struct nft_hook), GFP_KERNEL_ACCOUNT);
>>  	if (!hook) {
>>  		err = -ENOMEM;
>>  		goto err_hook_alloc;
>> @@ -2026,7 +2026,7 @@ static struct nft_rule_blob *nf_tables_chain_alloc_rules(unsigned int size)
>>  	if (size > INT_MAX)
>>  		return NULL;
>> -	blob = kvmalloc(size, GFP_KERNEL);
>> +	blob = kvmalloc(size, GFP_KERNEL_ACCOUNT);
>>  	if (!blob)
>>  		return NULL;
>> @@ -2126,7 +2126,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
>>  		if (err < 0)
>>  			return err;
>> -		basechain = kzalloc(sizeof(*basechain), GFP_KERNEL);
>> +		basechain = kzalloc(sizeof(*basechain), GFP_KERNEL_ACCOUNT);
>>  		if (basechain == NULL) {
>>  			nft_chain_release_hook(&hook);
>>  			return -ENOMEM;
>> @@ -2156,7 +2156,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
>>  		if (flags & NFT_CHAIN_HW_OFFLOAD)
>>  			return -EOPNOTSUPP;
>> -		chain = kzalloc(sizeof(*chain), GFP_KERNEL);
>> +		chain = kzalloc(sizeof(*chain), GFP_KERNEL_ACCOUNT);
>>  		if (chain == NULL)
>>  			return -ENOMEM;
>> @@ -2169,7 +2169,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
>>  	chain->table = table;
>>  	if (nla[NFTA_CHAIN_NAME]) {
>> -		chain->name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL);
>> +		chain->name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL_ACCOUNT);
>>  	} else {
>>  		if (!(flags & NFT_CHAIN_BINDING)) {
>>  			err = -EINVAL;
>> @@ -2177,7 +2177,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
>>  		}
>>  		snprintf(name, sizeof(name), "__chain%llu", ++chain_id);
>> -		chain->name = kstrdup(name, GFP_KERNEL);
>> +		chain->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
>>  	}
>>  	if (!chain->name) {
>> @@ -2186,7 +2186,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
>>  	}
>>  	if (nla[NFTA_CHAIN_USERDATA]) {
>> -		chain->udata = nla_memdup(nla[NFTA_CHAIN_USERDATA], GFP_KERNEL);
>> +		chain->udata = nla_memdup(nla[NFTA_CHAIN_USERDATA], GFP_KERNEL_ACCOUNT);
>>  		if (chain->udata == NULL) {
>>  			err = -ENOMEM;
>>  			goto err_destroy_chain;
>> @@ -2349,7 +2349,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
>>  		char *name;
>>  		err = -ENOMEM;
>> -		name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL);
>> +		name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL_ACCOUNT);
>>  		if (!name)
>>  			goto err;
>> @@ -2797,7 +2797,7 @@ static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
>>  		goto err1;
>>  	err = -ENOMEM;
>> -	expr = kzalloc(expr_info.ops->size, GFP_KERNEL);
>> +	expr = kzalloc(expr_info.ops->size, GFP_KERNEL_ACCOUNT);
>>  	if (expr == NULL)
>>  		goto err2;
>> @@ -3405,7 +3405,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
>>  	}
>>  	err = -ENOMEM;
>> -	rule = kzalloc(sizeof(*rule) + size + usize, GFP_KERNEL);
>> +	rule = kzalloc(sizeof(*rule) + size + usize, GFP_KERNEL_ACCOUNT);
>>  	if (rule == NULL)
>>  		goto err_release_expr;
>> @@ -3818,7 +3818,7 @@ static int nf_tables_set_alloc_name(struct nft_ctx *ctx, struct nft_set *set,
>>  		free_page((unsigned long)inuse);
>>  	}
>> -	set->name = kasprintf(GFP_KERNEL, name, min + n);
>> +	set->name = kasprintf(GFP_KERNEL_ACCOUNT, name, min + n);
>>  	if (!set->name)
>>  		return -ENOMEM;
>> @@ -4382,11 +4382,11 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
>>  	alloc_size = sizeof(*set) + size + udlen;
>>  	if (alloc_size < size || alloc_size > INT_MAX)
>>  		return -ENOMEM;
>> -	set = kvzalloc(alloc_size, GFP_KERNEL);
>> +	set = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
>>  	if (!set)
>>  		return -ENOMEM;
>> -	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL);
>> +	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL_ACCOUNT);
>>  	if (!name) {
>>  		err = -ENOMEM;
>>  		goto err_set_name;
>> @@ -5921,7 +5921,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>>  	err = -ENOMEM;
>>  	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data,
>>  				      elem.key_end.val.data, elem.data.val.data,
>> -				      timeout, expiration, GFP_KERNEL);
>> +				      timeout, expiration, GFP_KERNEL_ACCOUNT);
>>  	if (elem.priv == NULL)
>>  		goto err_parse_data;
>> @@ -6165,7 +6165,7 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
>>  	err = -ENOMEM;
>>  	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data,
>>  				      elem.key_end.val.data, NULL, 0, 0,
>> -				      GFP_KERNEL);
>> +				      GFP_KERNEL_ACCOUNT);
>>  	if (elem.priv == NULL)
>>  		goto fail_elem;
>> @@ -6477,7 +6477,7 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
>>  	}
>>  	err = -ENOMEM;
>> -	obj = kzalloc(sizeof(*obj) + ops->size, GFP_KERNEL);
>> +	obj = kzalloc(sizeof(*obj) + ops->size, GFP_KERNEL_ACCOUNT);
>>  	if (!obj)
>>  		goto err2;
>> @@ -6643,7 +6643,7 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
>>  	obj->key.table = table;
>>  	obj->handle = nf_tables_alloc_handle(table);
>> -	obj->key.name = nla_strdup(nla[NFTA_OBJ_NAME], GFP_KERNEL);
>> +	obj->key.name = nla_strdup(nla[NFTA_OBJ_NAME], GFP_KERNEL_ACCOUNT);
>>  	if (!obj->key.name) {
>>  		err = -ENOMEM;
>>  		goto err_strdup;
>> @@ -7404,7 +7404,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
>>  	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
>> -	flowtable = kzalloc(sizeof(*flowtable), GFP_KERNEL);
>> +	flowtable = kzalloc(sizeof(*flowtable), GFP_KERNEL_ACCOUNT);
>>  	if (!flowtable)
>>  		return -ENOMEM;
>> @@ -7412,7 +7412,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
>>  	flowtable->handle = nf_tables_alloc_handle(table);
>>  	INIT_LIST_HEAD(&flowtable->hook_list);
>> -	flowtable->name = nla_strdup(nla[NFTA_FLOWTABLE_NAME], GFP_KERNEL);
>> +	flowtable->name = nla_strdup(nla[NFTA_FLOWTABLE_NAME], GFP_KERNEL_ACCOUNT);
>>  	if (!flowtable->name) {
>>  		err = -ENOMEM;
>>  		goto err1;
>> -- 
>> 2.25.1
>>

