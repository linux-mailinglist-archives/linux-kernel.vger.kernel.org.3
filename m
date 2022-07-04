Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA4565E25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiGDTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiGDTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:49:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7110A7;
        Mon,  4 Jul 2022 12:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 950AAB812A1;
        Mon,  4 Jul 2022 19:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6AEC3411E;
        Mon,  4 Jul 2022 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656964162;
        bh=IQVtwsEeec0X0H652uGrEAoAYDLVO3bwow8hDmu8X1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kpCGHmlL9B5+2kXN4u2OZY977890MUVEO/g7l3Jtk4S0sPCxo2J2Vi9/q/z8bnH+e
         EoAm6CqZb3mpJ8pwWEEdnUeTd9HzgVORioIA9IfOH8xLJ3m6oAimYuMq1h9rQC/8jP
         jEO1XFKbBGRpXkX0DGD90lzBhF+6rIGj0UaCUYzgWkLv8agyZFyoCXhiapGKzfIW1d
         JaE9YeTVnTbTSbkNraDMiTOGHAaQjeFNUYzalLcAuPu6FBRvfPMixCTPV2B7nMksd5
         LEDv67WEktf3tvXPDC6B4tg/bGTJ8F4mIlfxN6N8q5yy7qV8n4FSErqd3lK0+yYsPC
         62aUMJfvfY3Kg==
Message-ID: <549fa553-ba75-97c1-9afb-9d2684902bde@kernel.org>
Date:   Mon, 4 Jul 2022 21:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <20220623162635.636f3d3c@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220623162635.636f3d3c@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 22:26, Steven Rostedt wrote:
> On Thu, 16 Jun 2022 10:44:43 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

[ removing comments that I agreed and changed the code/log accordingly ]

>>
>>  "monitoring_on"
>>    - It is an on/off general switcher for monitoring. Note
>>    that it does not disable enabled monitors, but stop the per-entity
>>    monitors of monitoring the events received from the system.
>>    It resambles the "tracing_on" switcher.
> 
> You mean that the tracepoints are still attached, but the process of
> monitoring isn't doing anything?

correct, I am now mentioning it in the comment.
 
[...]

>> +static int disable_monitor(struct rv_monitor_def *mdef)
>> +{
>> +	if (mdef->monitor->enabled) {
>> +		mdef->monitor->enabled = 0;
>> +		mdef->monitor->stop();
>> +	}
>> +
>> +	mdef->enabled = 0;
> 
> What's the difference between mdef->enabled and mdef->monitor->enabled?

Ooops, the mdef->enabled is a leftover... removing mdef->enabled.

>> +	return 0;
>> +}
>> +

[...]

>> +static int create_monitor_dir(struct rv_monitor_def *mdef)
>> +{
>> +	struct dentry *root = get_monitors_root();
>> +	struct dentry *tmp;
>> +	const char *name = mdef->monitor->name;
>> +	int retval = 0;
>> +
>> +	mdef->root_d = rv_create_dir(name, root);
>> +
>> +	if (!mdef->root_d)
>> +		return -ENOMEM;
>> +
>> +	tmp = rv_create_file("enable", 0600,
> 
> I'd recommend make the modes (0600) into macros. I recently changed
> these for tracing, and having them hard coded was a pain.
> 
> #define RV_FILE_READ	0600
> 

Added:
#define RV_MODE_WRITE                   TRACE_MODE_WRITE
#define RV_MODE_READ                    TRACE_MODE_READ


>> +			     mdef->root_d, mdef,
>> +			     &interface_enable_fops);
>> +	if (!tmp) {
>> +		retval = -ENOMEM;
>> +		goto out_remove_root;
>> +	}
>> +
>> +	tmp = rv_create_file("desc", 0400,
> 
> Same here, and in all other cases.
> 
>> +			      mdef->root_d, mdef,
>> +			      &interface_desc_fops);
>> +	if (!tmp) {
>> +		retval = -ENOMEM;
>> +		goto out_remove_root;
>> +	}
>> +
>> +	return retval;
>> +
>> +out_remove_root:
>> +	rv_remove(mdef->root_d);
>> +	return retval;
>> +}

[...]
>> +static ssize_t
>> +enabled_monitors_write(struct file *filp, const char __user *user_buf,
>> +		      size_t count, loff_t *ppos)
>> +{
>> +	char buff[MAX_RV_MONITOR_NAME_SIZE+1];
>> +	struct rv_monitor_def *mdef;
>> +	int retval = -EINVAL;
>> +	bool enable = true;
>> +	char *ptr = buff;
>> +	int len;
>> +
>> +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE+1)
>> +		return -EINVAL;
>> +
>> +	memset(buff, 0, sizeof(buff));
>> +
>> +	retval = simple_write_to_buffer(buff, sizeof(buff)-1, ppos, user_buf,
>> +					count);
>> +	if (!retval)
>> +		return -EFAULT;
>> +
>> +	if (buff[0] == '!') {
>> +		enable = false;
>> +		ptr++;
>> +	}
>> +
>> +	len = strlen(ptr);
>> +	if (!len)
>> +		return count;
>> +	/*
>> +	 * remove \n
>> +	 */
>> +	ptr[len-1] = '\0';
> 
> Are you sure there's an '\n' here?
> 
> One could just do "write(fd, "monitor", 7)"
> 
> Perhaps use strim()

ack.

> 
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	retval = -EINVAL;
>> +
>> +	list_for_each_entry(mdef, &rv_monitors_list, list) {
>> +		if (strcmp(ptr, mdef->monitor->name) == 0) {
> 
> BTW, you could do:
> 
> 		if (strcmp(ptr, mdef->monitor->name) != 0)
> 			continue;
> 
> And then get rid of an extra indent below.
> 
>> +			/*
>> +			 * Monitor found!
>> +			 */
>> +			if (enable)
>> +				retval = enable_monitor(mdef);
>> +			else
>> +				retval = disable_monitor(mdef);
>> +
>> +			if (retval)
>> +				goto out;
> 
> Why not just break?
> 
> In fact, you could just do:
> 
> 			if (!retval)
> 				retval = count;
> 			break;

yep, it looks better.

-- Daniel
