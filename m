Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31705760D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiGOLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGOLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4E88F0B;
        Fri, 15 Jul 2022 04:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F203562304;
        Fri, 15 Jul 2022 11:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACD8C3411E;
        Fri, 15 Jul 2022 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657885657;
        bh=bOhZ+ZI4CCMrYCxTvYYbqkus2jBN41LpMcdBoZMKp/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SDERY9zqlsrtHlvd/ExgvUcaD4kQ7ZZyzri8/3NQv5dDaUmjeTI8fcSj2HCegu/rP
         ParWgDunpLCv4CdUCPloAJh5r+witRQgOLd5pBTI+RRRf6GO59dwT7B+qvnEyxY0TH
         MdTultRbNQ7f6hBEe2na8NbKiNLlePVOnPCIXGImYeNk4sNXNiEpaUqt+110dm/AJd
         kpT9bvs87G59/CEALa8mJLmKqmY47FQRwTrigRUx2FrXMW8KtLZFC/ieZQ80qJyFfX
         g1Ynll8wssHbduvEcrfdWL/0c3LVMYxBKfrizfRPI3g9gqgB4y2k1sdekQ1+buwjuq
         e1qT0xLPbdcpQ==
Message-ID: <3758d3bd-7272-e907-a51a-44a21d757674@kernel.org>
Date:   Fri, 15 Jul 2022 13:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 01/16] rv: Add Runtime Verification (RV) interface
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
References: <cover.1657745645.git.bristot@kernel.org>
 <442b03c687c298b25c79aa5a16ec7fb2aef0f2c9.1657745645.git.bristot@kernel.org>
 <Ys/J5fLaojYeiVzL@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <Ys/J5fLaojYeiVzL@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 09:46, Tao Zhou wrote:
> On Wed, Jul 13, 2022 at 11:17:17PM +0200,
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
> [...]
> 
>> +void put_task_monitor_slot(int slot)
>> +{
>> +	lockdep_assert_held(&rv_interface_lock);
>> +
>> +	if (slot < 0 || slot > RV_PER_TASK_MONITORS) {
> 
> slot is the array index that should be 0 here. The up bound is not bigger
> than 0 because the element of array now is RV_PER_TASK_MONITORS. 
> 
> So up bound check is 'slot > RV_PER_TASK_MONITORS-1'.

fixed! (slot >= RV...)

> [...]
> 
>> +/*
>> + * interface for enabling/disabling a monitor.
>> + */
>> +static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
>> +					 size_t count, loff_t *ppos)
>> +{
>> +	struct rv_monitor_def *mdef = filp->private_data;
>> +	int retval;
>> +	bool val;
>> +
>> +	retval = kstrtobool_from_user(user_buf, count, &val);
>> +	if (retval)
>> +		return retval;
>> +
>> +	retval = count;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	if (val)
>> +		retval = enable_monitor(mdef);
>> +	else
>> +		retval = disable_monitor(mdef);
>> +
>> +	mutex_unlock(&rv_interface_lock);
>> +
>> +	return retval ? retval : count;
> 
> Feel that this can be written `return retval ? : count;`


why not...

> [...]
> 
>> +static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
>> +{
>> +	struct rv_monitor_def *m_def;
>> +	loff_t l;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	if (list_empty(&rv_monitors_list))
>> +		return NULL;
>> +
>> +	m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
>> +
>> +	for (l = 0; l <= *pos; ) {
>> +		m_def = enabled_monitors_next(m, m_def, &l);
>> +		if (!m_def)
>> +			break;
> 
> Is this check is inversed. enabled_monitors_start() will stop at first
> enabled monitor, then enabled_monitors_next() do loop to next. Check
> like the above, enabled_monitors_start() will loop to the last monitor.
> But I doubt myself I do not mention/see it. Sorry for these.
> 
> the check is:
> 
>   if (m_def)
>      break;
> 
> [...]


see kernel/trace/trace_events.c:s_start...

>> +static ssize_t
>> +enabled_monitors_write(struct file *filp, const char __user *user_buf,
>> +		      size_t count, loff_t *ppos)
>> +{
>> +	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
>> +	struct rv_monitor_def *mdef;
>> +	int retval = -EINVAL;
>> +	bool enable = true;
>> +	char *ptr = buff;
>> +	int len;
>> +
>> +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 2)
> 
> @count would not include '\0'. That the max val of @count is
> MAX_RV_MONITOR_NAME_SIZE+1. So the up bound check of @count is
> `count > MAX_RV_MONITOR_NAME_SIZE + 1`.

Fixed for v6...

-- Daniel
