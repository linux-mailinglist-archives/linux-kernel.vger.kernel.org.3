Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EE5846AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiG1TxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiG1TxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3481CFD5;
        Thu, 28 Jul 2022 12:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170AB61E26;
        Thu, 28 Jul 2022 19:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9935AC433D6;
        Thu, 28 Jul 2022 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659038001;
        bh=+y6opbN7WD1OrVOWmvnLM/pFLYkbXR/iL3cSrSYb7VM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=INr1tGg8pxuO+MgtZfzXRIQKpYtPIr3gaSms9ac5wnKSSZ5AqIBdQIQhLJGIo5nlC
         SujJUylOGhDoh8UXJ0+1RP/ciIixq7ZY3gqJvXMuZSNYYwGdo2YKaY+ScFwaWYaDgl
         jA3GM52qm6ounJ1u0vJ3P3fKUO2GOj8eLDabzbUWFOIp2+6gW/bi+jK5wwySl58YzK
         0ExCcQKjnKtecaHcHAguC46siqQ/BltXJcNHc7XBY0MhyrjPlFNL7EXtr5lE+lj3B6
         Hn++zsb7El7iQYSJ4NPIaisWLT0Sks4g7IVMDIUD0iEEOxma/YRQFfZTQS7dQbgT0C
         6r0lZ8kUwX5OQ==
Message-ID: <c56991fe-5028-3a5a-3dc6-85f70864f184@kernel.org>
Date:   Thu, 28 Jul 2022 21:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V8 01/16] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1658940828.git.bristot@kernel.org>
 <04fcaacb8c1e8dc0fd0289ceca8e3b1d29747c30.1658940828.git.bristot@kernel.org>
 <YuLJL7CoSYsStdsV@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YuLJL7CoSYsStdsV@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 19:36, Tao Zhou wrote:
> On Wed, Jul 27, 2022 at 07:11:29PM +0200, Daniel Bristot de Oliveira wrote:
> 
>> +static ssize_t enabled_monitors_write(struct file *filp, const char __user *user_buf,
>> +				      size_t count, loff_t *ppos)
>> +{
>> +	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> 
> If I am not wrong, but "joke" from myself is very possible.
> 
> char buff[MAX_RV_MONITOR_NAME_SIZE + 1];
> 
> +1 is for one '\0'. The above have '\0\0'. One '\0' is enough.

!

>> +	struct rv_monitor_def *mdef;
>> +	int retval = -EINVAL;
>> +	bool enable = true;
>> +	char *ptr = buff;
>> +	int len;
>> +
>> +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
> 
> Use `count > MAX_RV_MONITOR_NAME_SIZE` check the up bound.
> 
>> +		return -EINVAL;
>> +
>> +	memset(buff, 0, sizeof(buff));
>> +
>> +	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
> 
> simple_write_to_buffer(buff, sizeof(buff), ppos, user_buf, count)
> 
>> +	if (retval < 0)
>> +		return -EFAULT;
>> +
>> +	ptr = strim(buff);
> 
> I see isspace() that the mask `_S` is for space/lf/tab, but I do
> not know if the lf stands for being able to strim the '\n'. If so
> there is no problem here. if use buffer is "wip\n\n", we should
> treat it the same as "wip", no?

no.

> 
>> +/*
>> + * Monitoring on global switcher!
>> + */
>> +static bool __read_mostly monitoring_on;
>> +
>> +/**
>> + * rv_monitoring_on - checks if monitoring is on
>> + *
>> + * Returns 1 if on, 0 otherwise.
>> + */
>> +bool rv_monitoring_on(void)
>> +{
>> +	/* Ensures that concurrent monitors read consistent monitoring_on */
>> +	smp_rmb();
> 
> Here invalidate message will be processed and send the read message
> and get updated monitoring_on from another cpu. I feel confused
> because there is half part of the memory barrier pair. But this half
> way from my mind in this case has effect. This is the first time that
> I know it can be synced this way. Let me guess this way.
> 
>> +	return READ_ONCE(monitoring_on);
>> +}
> 
> I checked the load of monitoring_on, there are three cases:
> file read     file write(call load self)     event handler check
> Store of monitoring_on: one in init rv, another is file write after
> call load self.
> The file is created before the turn_monitoring_on() called in 
> rv_init_interface(). So there may be existing the store race
> at the init part. Just after the monitoring_on file created,
> and other cpus do monitoring_on flips operations and at the
> same time the init code do turn_monitor_on(). Or the enabled
> file be writen to enable/disable monitors happening before
> monitoring_on is set in init rv. That means the event handler
> can be start before the monitoring_on is turned on in init rv.
> The turn_monitoring_on() in rv_init_interface() is not a switcher
> because it may has been beated by file flips operations before.

there will be no monitors loaded at this point during boot time.

>> +
>> +/*
>> + * monitoring_on general switcher.
>> + */
>> +static ssize_t monitoring_on_read_data(struct file *filp, char __user *user_buf,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	const char *buff;
>> +
>> +	buff = rv_monitoring_on() ? "1\n" : "0\n";
> 
> I hope this will not be inlined..

Even if I add a lock, the value can change after the lock is unlocked before
returning to user-space...

> 
>> +
>> +	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
>> +}
>> +static void destroy_monitor_dir(struct rv_monitor_def *mdef)
>> +{
>> +	reactor_cleanup_monitor(mdef);
> 
> reactor_cleanup_monitor() appear in this patch but not defined.

I will have to send a v9 only fixing this because it breaks bisect.

It was caused by a last minute change... (boooh, Daniel!)

>> +	rv_remove(mdef->root_d);
>> +}
>> +struct dentry *get_monitors_root(void);
>> +int init_rv_monitors(struct dentry *root_dir);
> 
> init_rv_monitors() definition do not appear in this patch. Thanks,

Thanks!
-- Daniel
