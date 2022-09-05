Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8745AD4CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiIEO3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiIEO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:29:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22504261C;
        Mon,  5 Sep 2022 07:29:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F377038680;
        Mon,  5 Sep 2022 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662388178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xy7njwcQGeP+otyXcMoBXsbQ4xfSpjO8lErq8eZ8WKk=;
        b=sT8iCJF4guIG1kezYYFvmhs8sgeaTz6yT1lKKbP4s5pbyjbDEEZzTLUoW+rJQlXE3EBfHz
        gxe9yb5sSide2IMvlavArv1QpYmBMr2+kgxpRVpoXr1mYm2q1n066fNVe9NDZ6yh+/6gkV
        9myAAGXNCIMTv8KxD9qabDkzeYnZ00E=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2F272C165;
        Mon,  5 Sep 2022 14:29:37 +0000 (UTC)
Date:   Mon, 5 Sep 2022 16:29:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, mwilck@suse.com
Subject: Re: [PATCH] module: Merge same-name module load requests
Message-ID: <YxYHzp1D315RcA4h@alley>
References: <20220905084131.14567-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905084131.14567-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-09-05 10:41:31, Petr Pavlu wrote:
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. For instance, udev can make a request to insert
> a frequency module for each individual CPU when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.
>
> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot.

Is it just an optimization or does it fix any real problem?
It would be nice to provide some more details here.
Otherwise, we do not know if the behavior change is worth it.


> This patch improves the behavior as follows:
> * A check whether a module load matches an already loaded module is
>   moved right after a module name is determined.
> * A new reference-counted shared_load_info structure is introduced to
>   keep track of duplicate load requests. Two loads are considered
>   equivalent if their module name matches. In case a load duplicates
>   another running insert, the code waits for its completion and then
>   returns -EEXIST or -ENODEV depending on whether it succeeded.

-ENODEV is strange, see https://www.gnu.org/software/libc/manual/html_node/Error-Codes.html

   Macro: int ENODEV

       “No such device.” The wrong type of device was given
       to a function that expects a particular sort of device.

IMHO, it does not fit here. What about -EBUSY?

   Macro: int EBUSY

       “Device or resource busy.” A system resource that can’t
       be shared is already in use. For example, if you try
       to delete a file that is the root of a currently mounted
       filesystem, you get this error.


> 
> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
> for modules that have finished loading"), the kernel already did merge
> some of same load requests but it was more by accident and relied on
> specific timing. The patch brings this behavior back in a more explicit
> form.
>
> ---
>  kernel/module/main.c | 207 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 144 insertions(+), 63 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a4e4d84b6f4e..24d0777c48e3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2552,43 +2539,129 @@ static int may_init_module(void)
>  	return 0;
>  }
>  
> +static struct shared_load_info *
> +shared_load_info_alloc(const struct load_info *info)
> +{
> +	struct shared_load_info *shared_info =
> +		kzalloc(sizeof(*shared_info), GFP_KERNEL);
> +	if (shared_info == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	strscpy(shared_info->name, info->name, sizeof(shared_info->name));
> +	refcount_set(&shared_info->refcnt, 1);
> +	INIT_LIST_HEAD(&shared_info->list);
> +	return shared_info;
> +}
> +
> +static void shared_load_info_get(struct shared_load_info *shared_info)
> +{
> +	refcount_inc(&shared_info->refcnt);
> +}
> +
> +static void shared_load_info_put(struct shared_load_info *shared_info)
> +{
> +	if (refcount_dec_and_test(&shared_info->refcnt))
> +		kfree(shared_info);
> +}
> +
>  /*
> - * We try to place it in the list now to make sure it's unique before
> - * we dedicate too many resources.  In particular, temporary percpu
> + * Check that the module load is unique and make it visible to others. The code
> + * looks for parallel running inserts and already loaded modules. Two inserts
> + * are considered equivalent if their module name matches. In case this load
> + * duplicates another running insert, the code waits for its completion and
> + * then returns -EEXIST or -ENODEV depending on whether it succeeded.
> + *
> + * Detecting early that a load is unique avoids dedicating too many cycles and
> + * resources to bring up the module. In particular, it prevents temporary percpu
>   * memory exhaustion.
> + *
> + * Merging same load requests then primarily helps during the boot process. It
> + * can happen that the kernel receives a burst of requests to load the same
> + * module (for example, a same module for each individual CPU) and loading it
> + * eventually fails during its init call. Merging the requests allows that only
> + * one full attempt to load the module is made.
> + *
> + * On a non-error return, it is guaranteed that this load is unique.
>   */
> -static int add_unformed_module(struct module *mod)
> +static struct shared_load_info *add_running_load(const struct load_info *info)
>  {
> -	int err;
>  	struct module *old;
> +	struct shared_load_info *shared_info;
>  
> -	mod->state = MODULE_STATE_UNFORMED;
> -
> -again:
>  	mutex_lock(&module_mutex);
> -	old = find_module_all(mod->name, strlen(mod->name), true);
> -	if (old != NULL) {
> -		if (old->state != MODULE_STATE_LIVE) {
> -			/* Wait in case it fails to load. */
> +
> +	/* Search if there is a running load of a module with the same name. */
> +	list_for_each_entry(shared_info, &running_loads, list)
> +		if (strcmp(shared_info->name, info->name) == 0) {
> +			int err;
> +
> +			shared_load_info_get(shared_info);
>  			mutex_unlock(&module_mutex);
> +
>  			err = wait_event_interruptible(module_wq,
> -					       finished_loading(mod->name));
> -			if (err)
> -				goto out_unlocked;
> -			goto again;
> +						       shared_info->err != 0);
> +			if (!err)
> +				err = shared_info->err;

The logic around shared_info->err is a bit tricky. The value 0
means that the parallel load is still in progress. Any error
value means that it has finished. Where -EEXIST means that
the load actually succeeded.

Such optimizations might make sense when they might safe a lot
of memory. And even in these situations we should do out best
to keep the logic straightforward.

I suggest to set shared_info->err to the really returned value.
And use another logic to check if the load finished. Either
add a boolean. Or we might actually use shared_info->list.

struct shared_info is removed from @running_loads list when
the load finished. We could do in finalize_running_load():

	list_del_init(&shared_info->list);

and here:

			err = wait_event_interruptible(module_wq,
						       list_empty(&shared_info->list);

			/*
			 * Do not retry the module load when the parallel one
			 * failed. But do not return the exact error code
			 * because the parallel load might have used another
			 * module parameters. Instead return -EBUSY.
			 */
			if (!err) {
				err = shared_info->err ? -EBUSY : -EEXIST;
[...]


> +			shared_load_info_put(shared_info);
> +			shared_info = ERR_PTR(err);
> +			goto out_unlocked;
>  		}
> -		err = -EEXIST;
> +
> +	/* Search if there is a live module with the given name already. */
> +	old = find_module_all(info->name, strlen(info->name), true);
> +	if (old != NULL) {
> +		if (old->state == MODULE_STATE_LIVE) {
> +			shared_info = ERR_PTR(-EEXIST);
> +			goto out;
> +		}
> +
> +		/*
> +		 * Any active load always has its record in running_loads and so
> +		 * would be found above. This applies independent whether such
> +		 * a module is currently in MODULE_STATE_UNFORMED,
> +		 * MODULE_STATE_COMING, or even in MODULE_STATE_GOING if its
> +		 * initialization failed. It therefore means this must be an
> +		 * older going module and the caller should try later once it is
> +		 * gone.
> +		 */
> +		WARN_ON(old->state != MODULE_STATE_GOING);
> +		shared_info = ERR_PTR(-EAGAIN);

I would return -EBUSY here to avoid too many variants. The load failed because
the same module was being loaded or unloaded.

Anyway, it should be described in the commit message.

>  		goto out;
>  	}
> -	mod_update_bounds(mod);
> -	list_add_rcu(&mod->list, &modules);
> -	mod_tree_insert(mod);
> -	err = 0;
> +
> +	/* The load is unique, make it visible to others. */
> +	shared_info = shared_load_info_alloc(info);
> +	if (IS_ERR(shared_info))
> +		goto out;
> +	list_add(&shared_info->list, &running_loads);
>  
>  out:
>  	mutex_unlock(&module_mutex);
>  out_unlocked:
> -	return err;
> +	return shared_info;
> +}
> +
> +/* Complete the running load and inform other duplicate inserts about it. */
> +static void finalize_running_load(struct shared_load_info *shared_info, int err)
> +{
> +	mutex_lock(&module_mutex);
> +	list_del(&shared_info->list);
> +	shared_info->err = err == 0 ? -EEXIST : -ENODEV;

As explained above, I suggest to use:

	list_del_init(&shared_info->list);
	shared_info->err = err;

> +	mutex_unlock(&module_mutex);
> +
> +	wake_up_all(&module_wq);

Heh, this should be wake_up_interruptible() to match
the wait_event_interruptible().

The _all() variant is used when there exclusive waiters. I have
recently learned about it, see
https://lore.kernel.org/all/CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com/

But it should be fixed in a separate patch because the same mistake
was there even before.


Also it would make sense to add the wait queue head into struct
shared_info to reduce spurious wakeups. The head is small,
the struct is allocated anyway, and the lifecycle is the same.


> +	shared_load_info_put(shared_info);
> +}
> +
> +static void add_unformed_module(struct module *mod)
> +{
> +	mod->state = MODULE_STATE_UNFORMED;
> +
> +	mutex_lock(&module_mutex);
> +	mod_update_bounds(mod);
> +	list_add_rcu(&mod->list, &modules);
> +	mod_tree_insert(mod);
> +	mutex_unlock(&module_mutex);
>  }
>  
>  static int complete_formation(struct module *mod, struct load_info *info)

Otherwise, the patch looks good to me.

Best Regards,
Petr
