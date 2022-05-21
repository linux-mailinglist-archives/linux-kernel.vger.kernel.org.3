Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819052FDD0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiEUPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352063AbiEUPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:25:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087DFDC
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA394B80707
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 15:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD0BC385A5;
        Sat, 21 May 2022 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653146745;
        bh=BvcCO0oBAp5zt3i7SHuNyNMcTeugNp3/W2Iqn/d6hnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fFe+Qr3lBnLfw7jDjLQy/y6jGqPLrWVo0K7X4pKA0BwsCfoCmdsBIxcDHH6PlW3Ch
         1r9FEcl4ygJOJ9DSDJ0PhBAZ73nprPJKvlQ7qbsY73EY/9GypZvR68R1Bkv7Fzmbkr
         Asn9gEk0Q/GfQo8FOYQ0X8AzxrM8ycw1rtXbm7I0VktCAMeNVmD/cPmDhgQ3WqE1pS
         4Xu+jXK/BTUS7BJ+ctHk/zV17GENCJv09beNa+yRzUu8nNeYWBnWbZ8Hue2eP2Z6mp
         L9wGNF2QRl+5032l/SBzS0czdA4CO++s9zLSrGDGlnuQlQE+IbybFcSvNxXsWk/e4M
         eo0+FE1kGgJCw==
Date:   Sun, 22 May 2022 00:25:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
Message-Id: <20220522002541.85a32eecd48cfee550d9a47c@kernel.org>
In-Reply-To: <20220512170008.1301613-2-xiehuan09@gmail.com>
References: <20220512170008.1301613-1-xiehuan09@gmail.com>
        <20220512170008.1301613-2-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, 13 May 2022 01:00:05 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce objtrace trigger to get the call flow by tracing any kernel
> object in the function parameter.
> 
> The objtrace trigger makes a list of the target object address from
> the given event parameter, and records all kernel function calls
> which has the object address in its parameter.

Thank you for updating this. Please read my comments below

[...]
> +
> +static bool object_exist(void *obj, struct trace_array *tr)
> +{
> +	int i, max;
> +	struct objtrace_data *obj_data;
> +
> +	obj_data = get_obj_data(tr);
> +	if (!obj_data)
> +		return false;
> +
> +	max = atomic_read(&obj_data->num_traced_obj);

max = READ_ONCE(&obj_data->num_traced_obj);
 (see below)

> +	smp_rmb();
> +	for (i = 0; i < max; i++) {
> +		if (obj_data->traced_obj[i].obj == obj)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool object_empty(struct trace_array *tr)
> +{
> +	struct objtrace_data *obj_data;
> +
> +	obj_data = get_obj_data(tr);
> +	if (!obj_data)
> +		return false;
> +
> +	return !atomic_read(&obj_data->num_traced_obj);

return !READ_ONCE(&obj_data->num_traced_obj);
 (see below)

> +}
> +
> +static void set_trace_object(void *obj, struct trace_array *tr)
> +{
> +	unsigned long flags;
> +	struct object_instance *obj_ins;
> +	struct objtrace_data *obj_data;
> +
> +	if (in_nmi())
> +		return;
> +
> +	if (!obj && object_exist(obj, tr))
> +		return;
> +
> +	obj_data = get_obj_data(tr);
> +	if (!obj_data)
> +		return;
> +
> +	/* only this place has write operations */
> +	raw_spin_lock_irqsave(&obj_data->obj_data_lock, flags);
> +	if (atomic_read(&obj_data->num_traced_obj) == MAX_TRACED_OBJECT) {

Since obj_data->num_traced_obj update is protected by obj_data->obj_data_lock,
you don't need atomic operation. What you need is using READ_ONCE() to
access the num_traced_obj outside of this protected area.

> +		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> +				"object_pool is full, can't trace object:0x%px\n", obj);
> +		goto out;
> +	}
> +	obj_ins = &obj_data->traced_obj[atomic_read(&obj_data->num_traced_obj)];
> +	obj_ins->obj = obj;
> +	obj_ins->tr = tr;
> +	/* make sure the num_traced_obj update always appears after traced_obj update */
> +	smp_wmb();
> +	atomic_inc(&obj_data->num_traced_obj);
> +out:
> +	raw_spin_unlock_irqrestore(&obj_data->obj_data_lock, flags);
> +}
> +
[...]
> +
> +static int
> +event_object_trigger_parse(struct event_command *cmd_ops,
> +		       struct trace_event_file *file,
> +		       char *glob, char *cmd, char *param_and_filter)
> +{
> +	struct event_trigger_data *trigger_data;
> +	struct objtrace_trigger_data *obj_data;
> +	struct ftrace_event_field *field;
> +	char *objtrace_cmd, *arg;
> +	char *param, *filter;
> +	int ret;
> +	bool remove;
> +
> +	remove = event_trigger_check_remove(glob);
> +
> +	/*
> +	 * separate the param and the filter:
> +	 * objtrace:add:OBJ[:COUNT] [if filter]
> +	 */
> +	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
> +	if (ret)
> +		return ret;
> +
> +	objtrace_cmd = strsep(&param, ":");
> +	if (!objtrace_cmd || strcmp(objtrace_cmd, "add")) {
> +		pr_err("error objtrace command\n");
> +		return -EINVAL;
> +	}
> +
> +	arg = strsep(&param, ":");
> +	if (!arg)
> +		return -EINVAL;
> +
> +	field = trace_find_event_field(file->event_call, arg);
> +	if (!field)
> +		return -EINVAL;
> +
> +	if (field->size != sizeof(void *)) {
> +		pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
> +		return -EINVAL;
> +	}
> +
> +	if (remove && !field_exist(file, cmd_ops, field->name))
> +		return -EINVAL;

This may return -ENOENT.

> +
> +	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> +	if (!obj_data)
> +		return -ENOMEM;
> +
> +	obj_data->field = field;
> +	obj_data->tr = file->tr;
> +	snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);

If objtrace_cmd is fixed command string, can you make this a flag, like
OBJTRACE_CMD_ADD.

> +
> +	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
> +	if (!trigger_data) {
> +		kfree(obj_data);
> +		return -ENOMEM;
> +	}
> +	if (remove) {
> +		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> +		kfree(obj_data);
> +		kfree(trigger_data);
> +		return 0;
> +	}
> +
> +	ret = event_trigger_parse_num(param, trigger_data);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> +	if (ret < 0)
> +		goto out_free;
> +
> +	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> +	if (ret)
> +		goto out_free;
> +
> +	return ret;
> +
> + out_free:
> +	event_trigger_reset_filter(cmd_ops, trigger_data);
> +	kfree(obj_data);
> +	kfree(trigger_data);
> +	return ret;
> +}
> +
> +static struct event_command trigger_object_cmd = {
> +	.name			= "objtrace",
> +	.trigger_type		= ETT_TRACE_OBJECT,
> +	.flags			= EVENT_CMD_FL_NEEDS_REC,
> +	.parse			= event_object_trigger_parse,
> +	.reg			= register_trigger,
> +	.unreg			= unregister_trigger,
> +	.get_trigger_ops	= objecttrace_get_trigger_ops,
> +	.set_filter		= set_trigger_filter,
> +};
> +
> +__init int register_trigger_object_cmd(void)
> +{
> +	int ret;
> +
> +	ret = register_event_command(&trigger_object_cmd);
> +	WARN_ON(ret < 0);
> +
> +	return ret;
> +}
> +
> +int allocate_objtrace_data(struct trace_array *tr)
> +{
> +	struct objtrace_data *obj_data;
> +	struct ftrace_ops *fops;
> +
> +	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> +	if (!obj_data)
> +		return -ENOMEM;
> +
> +	tr->obj_data = obj_data;

I suggest to move this line after initializing all field in
the obj_data.

> +	obj_data->tr = tr;
> +	fops = &obj_data->fops;
> +	fops->func = trace_object_events_call;
> +	fops->flags = FTRACE_OPS_FL_SAVE_REGS;
> +	fops->private = tr;
> +
> +	raw_spin_lock(&obj_data->obj_data_lock);

You don't need to lock this spinlock becuase this data structure
is not used yet. Also, you need to initialize the lock with
__RAW_SPIN_LOCK_UNLOCKED() macro.

> +	list_add(&obj_data->head, &obj_data_head);
> +	raw_spin_unlock(&obj_data->obj_data_lock);
> +	return 0;
> +}


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
