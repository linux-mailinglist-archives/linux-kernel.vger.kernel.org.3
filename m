Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291150BBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449432AbiDVP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449453AbiDVP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:28:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273E79FF9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9AD4B8311E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E1FC385A4;
        Fri, 22 Apr 2022 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650641110;
        bh=bFBOnSSd8Z3aG2uTe1m7A8Ep/yiRRRcDKmvE7q1lsE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeHaUfuiA2aZG9aEA9DCeUFUzp+UxYVb46csOqekR/UVAFuI9S/YOSBI8RicbiuE7
         SVs5rgrOo58K9ZQ5Rdjyo59KpP1eA0qowgLu0B3r6KkKdWyz+J+Kwr+C7+OP48Y1zT
         gQnTnV6sbRYBfkKI0pZAIxnLP1rYYP5OyP5gy0io=
Date:   Fri, 22 Apr 2022 17:25:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: add BINDER_GET_EXTENDED_ERROR ioctl
Message-ID: <YmLI03OT6st9fcQD@kroah.com>
References: <20220421042040.759068-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421042040.759068-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:20:36AM +0000, Carlos Llamas wrote:
> Provide a userspace mechanism to pull precise error information upon
> failed operations. Extending the current error codes returned by the
> interfaces allows userspace to better determine the course of action.
> This could be for instance, retrying a failed transaction at a later
> point and thus offloading the error handling from the driver.
> 
> Some of the elements for logging failed transactions and similar are
> folded into this new logic to avoid duplication. Such is the case for
> error line numbers, which become irrelevant after assigning individual
> error messages instead.
> 
> This patch also adds BINDER_GET_EXTENDED_ERROR to the binderfs feature
> list, to help userspace determine if the new ioctl is supported by the
> driver.

Hint, when you say "also" in a changelog text, that's a hint that this
should be more than one patch.  The last thing should be a separate
change, right?


> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c            | 355 +++++++++++++++-------------
>  drivers/android/binder_internal.h   |   9 +-
>  drivers/android/binderfs.c          |   8 +
>  include/uapi/linux/android/binder.h |  16 ++
>  4 files changed, 219 insertions(+), 169 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880..42a324634f25 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2697,6 +2697,54 @@ static struct binder_node *binder_get_node_refs_for_txn(
>  	return target_node;
>  }
>  
> +#define binder_txn_error(x...)		binder_transaction_error(0, x)
> +#define binder_user_txn_error(x...)	binder_transaction_error(1, x)
> +static __printf(6, 7) void binder_transaction_error(int user,
> +				struct binder_transaction_log_entry *e,
> +				struct binder_extended_error *ee,
> +				uint32_t command, int32_t param,
> +				const char *format, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	/* don't override previous error */
> +	if (command != BR_OK && ee->command != BR_OK)
> +		return;
> +
> +	ee->command = command;
> +	ee->param = param;
> +
> +	va_start(args, format);
> +	vsnprintf(e->strerr, sizeof(e->strerr), format, args);
> +
> +	vaf.va = &args;
> +	vaf.fmt = format;
> +	if (user)
> +		binder_user_error("%d:%d %pV\n",
> +			e->from_proc, e->from_thread, &vaf);
> +	else
> +		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION, "%d:%d %pV\n",
> +			e->from_proc, e->from_thread, &vaf);
> +	va_end(args);
> +}
> +
> +static void binder_set_txn_from_error(struct binder_transaction *txn,
> +				      struct binder_extended_error *ee)
> +{
> +	struct binder_thread *from = binder_get_txn_from_and_acq_inner(txn);
> +
> +	if (!from)
> +		return;
> +
> +	/* don't override previous error */
> +	if (ee->command != BR_OK && from->ee.command == BR_OK)
> +		from->ee = *ee;
> +
> +	binder_inner_proc_unlock(from->proc);
> +	binder_thread_dec_tmpref(from);
> +}
> +
>  static void binder_transaction(struct binder_proc *proc,
>  			       struct binder_thread *thread,
>  			       struct binder_transaction_data *tr, int reply,
> @@ -2716,9 +2764,8 @@ static void binder_transaction(struct binder_proc *proc,
>  	struct binder_node *target_node = NULL;
>  	struct binder_transaction *in_reply_to = NULL;
>  	struct binder_transaction_log_entry *e;
> +	struct binder_extended_error ee;
>  	uint32_t return_error = 0;
> -	uint32_t return_error_param = 0;
> -	uint32_t return_error_line = 0;
>  	binder_size_t last_fixup_obj_off = 0;
>  	binder_size_t last_fixup_min_off = 0;
>  	struct binder_context *context = proc->context;
> @@ -2741,32 +2788,30 @@ static void binder_transaction(struct binder_proc *proc,
>  	e->data_size = tr->data_size;
>  	e->offsets_size = tr->offsets_size;
>  	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
> +	ee.id = t_debug_id;
> +	ee.command = BR_OK;
> +	ee.param = 0;
>  
>  	if (reply) {
>  		binder_inner_proc_lock(proc);
>  		in_reply_to = thread->transaction_stack;
>  		if (in_reply_to == NULL) {
>  			binder_inner_proc_unlock(proc);
> -			binder_user_error("%d:%d got reply transaction with no transaction stack\n",
> -					  proc->pid, thread->pid);
> -			return_error = BR_FAILED_REPLY;
> -			return_error_param = -EPROTO;
> -			return_error_line = __LINE__;
> +			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
> +				"reply with no transaction stack");
>  			goto err_empty_call_stack;
>  		}
>  		if (in_reply_to->to_thread != thread) {
>  			spin_lock(&in_reply_to->lock);
> -			binder_user_error("%d:%d got reply transaction with bad transaction stack, transaction %d has target %d:%d\n",
> -				proc->pid, thread->pid, in_reply_to->debug_id,
> +			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
> +				"bad transaction stack in reply to %d %d:%d",
> +				in_reply_to->debug_id,
>  				in_reply_to->to_proc ?
>  				in_reply_to->to_proc->pid : 0,
>  				in_reply_to->to_thread ?
>  				in_reply_to->to_thread->pid : 0);
>  			spin_unlock(&in_reply_to->lock);
>  			binder_inner_proc_unlock(proc);
> -			return_error = BR_FAILED_REPLY;
> -			return_error_param = -EPROTO;
> -			return_error_line = __LINE__;
>  			in_reply_to = NULL;
>  			goto err_bad_call_stack;
>  		}
> @@ -2777,20 +2822,17 @@ static void binder_transaction(struct binder_proc *proc,
>  		if (target_thread == NULL) {
>  			/* annotation for sparse */
>  			__release(&target_thread->proc->inner_lock);
> -			return_error = BR_DEAD_REPLY;
> -			return_error_line = __LINE__;
> +			binder_txn_error(e, &ee, BR_DEAD_REPLY, 0,
> +				"reply target not found");
>  			goto err_dead_binder;
>  		}
>  		if (target_thread->transaction_stack != in_reply_to) {
> -			binder_user_error("%d:%d got reply transaction with bad target transaction stack %d, expected %d\n",
> -				proc->pid, thread->pid,
> +			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
> +				"bad target transaction stack %d vs %d",
>  				target_thread->transaction_stack ?
>  				target_thread->transaction_stack->debug_id : 0,
>  				in_reply_to->debug_id);
>  			binder_inner_proc_unlock(target_thread->proc);
> -			return_error = BR_FAILED_REPLY;
> -			return_error_param = -EPROTO;
> -			return_error_line = __LINE__;
>  			in_reply_to = NULL;
>  			target_thread = NULL;
>  			goto err_dead_binder;
> @@ -2812,15 +2854,15 @@ static void binder_transaction(struct binder_proc *proc,
>  			binder_proc_lock(proc);
>  			ref = binder_get_ref_olocked(proc, tr->target.handle,
>  						     true);
> -			if (ref) {
> +			if (ref)
>  				target_node = binder_get_node_refs_for_txn(
>  						ref->node, &target_proc,
>  						&return_error);
> -			} else {
> -				binder_user_error("%d:%d got transaction to invalid handle, %u\n",
> -						  proc->pid, thread->pid, tr->target.handle);
> -				return_error = BR_FAILED_REPLY;
> -			}
> +			else
> +				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
> +					-EINVAL,
> +					"invalid transaction handle %u",
> +					tr->target.handle);
>  			binder_proc_unlock(proc);
>  		} else {
>  			mutex_lock(&context->context_mgr_node_lock);
> @@ -2833,11 +2875,9 @@ static void binder_transaction(struct binder_proc *proc,
>  				return_error = BR_DEAD_REPLY;
>  			mutex_unlock(&context->context_mgr_node_lock);
>  			if (target_node && target_proc->pid == proc->pid) {
> -				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
> -						  proc->pid, thread->pid);
> -				return_error = BR_FAILED_REPLY;
> -				return_error_param = -EINVAL;
> -				return_error_line = __LINE__;
> +				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
> +					-EINVAL,
> +					"forbidden self transaction by context manager");
>  				goto err_invalid_target_handle;
>  			}
>  		}
> @@ -2845,22 +2885,20 @@ static void binder_transaction(struct binder_proc *proc,
>  			/*
>  			 * return_error is set above
>  			 */
> -			return_error_param = -EINVAL;
> -			return_error_line = __LINE__;
> +			binder_txn_error(e, &ee, return_error, -EINVAL,
> +				"cannot find target node");

You do this a lot, how about making this one commit (first one), and
then adding the new "back end" to the error stuff in a second commit.
That would make it much easier to review, first commit does nothing new,
second one adds the new functionality, and third adds the feature flag.

thanks,

greg k-h
