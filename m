Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489EB50EC93
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiDYXal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiDYXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:30:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D374E3B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:27:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650929252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=XzijQAge0g89gvUrSzz3FX6p0MRkFUXLNxnrJ7DF4DE=;
        b=kBEyZ55od/TF7AtcKuEJ5Xr1drsvLAWFj7m7dcEE4x9ejzCWS36+yfD3UWXyZ+4jljFixE
        qcNEV0QVjV/ygHp6ApcTIoBFbQQMENkBTpoztwUlKPG3nRel0Pj0KD9brmFkyhxaYD/Lbn
        GthxwXdUyj+Fi4kroMXA0HlLkUG7X6w01NCNuoRNIzF2rXznl9yPW0KyDyj/1h1H+DxGLj
        tPFUjeUTzzwqg0xZRH+0EQEdDrhraPSeKsjWoRFXJ7CziEInM2v8KBb6d77FGehjc/M2se
        8cHEEWqOKP3aTmx+M7w4pf2ncGpY9Geb13Z0bxi9yZTjqVhnuBK6bePcKaXxkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650929252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=XzijQAge0g89gvUrSzz3FX6p0MRkFUXLNxnrJ7DF4DE=;
        b=Pi6abstAJhkxcijAUhcpfHz/jongQ6IVzDmYFZAyDKGgUDjxY4+/Q0xgQNFi4WoWz/4AVJ
        MkHxNqvQU8sjLNDQ==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 06/13] procfs: add per-pid task isolation state
In-Reply-To: <20220315153313.997111717@fedora.localdomain>
Date:   Tue, 26 Apr 2022 01:27:32 +0200
Message-ID: <87v8uwzqu3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> Add /proc/pid/task_isolation file, to query the state of
> task isolation configuration.
>
> ---

Lacks a Signed-off-by...

>  fs/proc/base.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

> +#ifdef CONFIG_TASK_ISOLATION
> +
> +struct qoptions {
> +	unsigned long mask;
> +	char *name;
> +};
> +
> +static struct qoptions iopts[] = {
> +	{ISOL_F_QUIESCE, "quiesce"},
> +};
> +#define ILEN (sizeof(iopts) / sizeof(struct qoptions))

Reinventing ARRAY_SIZE() just because this isolation muck is special?

> +static struct qoptions qopts[] = {
> +	{ISOL_F_QUIESCE_VMSTATS, "vmstat_sync"},
> +};
> +#define QLEN (sizeof(qopts) / sizeof(struct qoptions))

Ditto.

> +static void show_isolation_state(struct seq_file *m,
> +				 struct qoptions *iopt,
> +				 int mask,
> +				 const char *hdr)
> +{
> +	int i;
> +
> +	seq_printf(m, hdr);
> +	for (i = 0; i < ILEN; i++) {
> +		if (mask & iopt->mask)
> +			seq_printf(m, "%s ", iopt->name);
> +		iopt++;
> +	}
> +	if (mask == 0)
> +		seq_printf(m, "none ");
> +	seq_printf(m, "\n");
> +}
> +
> +int proc_pid_task_isolation(struct seq_file *m, struct pid_namespace *ns,
> +			    struct pid *pid, struct task_struct *t)

This is required to be global without a prototype because?

> +{
> +	int active_mask, quiesce_mask, conf_mask;
> +	struct task_isol_info *task_isol_info;
> +	struct inode *inode = m->private;
> +	struct task_struct *task = get_proc_task(inode);
> +
> +	task_isol_info = t->task_isol_info;
> +	if (!task_isol_info)
> +		active_mask = quiesce_mask = conf_mask = 0;
> +	else {
> +		active_mask = task_isol_info->active_mask;
> +		quiesce_mask = task_isol_info->quiesce_mask;
> +		conf_mask = task_isol_info->conf_mask;
> +	}
> +
> +	show_isolation_state(m, iopts, conf_mask, "Configured state: ");
> +	show_isolation_state(m, iopts, active_mask, "Active state: ");
> +	show_isolation_state(m, qopts, quiesce_mask, "Quiescing: ");

And once you have 10 features with 10 subfeature masks supported, all of
this ends up in fs/proc/base.c just because all of this nonsense is
required to be disconnected from the actual task isolation code, right?

Just because a lot of crap has been dumped over time into that file does
not justify to mindlessly dump more crap into it.

Thanks,

        tglx
