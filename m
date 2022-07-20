Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46CC57B970
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbiGTPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiGTPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:21:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065A3B959;
        Wed, 20 Jul 2022 08:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17FD6CE2189;
        Wed, 20 Jul 2022 15:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D96EC3411E;
        Wed, 20 Jul 2022 15:21:04 +0000 (UTC)
Date:   Wed, 20 Jul 2022 11:21:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V6 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <20220720112102.32415cc7@gandalf.local.home>
In-Reply-To: <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
References: <cover.1658244826.git.bristot@kernel.org>
        <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 19:27:06 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> +/*
> + * enabled_monitors interface.
> + */


Doesn't the rv_monitors_list need to be protected by the rv_interface_lock
mutex?

> +static void disable_all_monitors(void)
> +{
> +	struct rv_monitor_def *mdef;
> +

I think you need:

	mutex_lock(&rv_interface_lock);

> +	list_for_each_entry(mdef, &rv_monitors_list, list)
> +		disable_monitor(mdef);

	mutex_unlock(&rv_interface_lock);

> +}
> +
> +static int enabled_monitors_open(struct inode *inode, struct file *file)
> +{

As this gets called directly from the open system call.

> +	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
> +		disable_all_monitors();
> +
> +	return seq_open(file, &enabled_monitors_seq_ops);
> +};
> +

[..]

> +
> +static const struct file_operations enabled_monitors_ops = {
> +	.open		= enabled_monitors_open,

Here.

-- Steve

> +	.read		= seq_read,
> +	.write		= enabled_monitors_write,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
