Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCF6574607
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiGNHrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiGNHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:46:59 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD337196;
        Thu, 14 Jul 2022 00:46:57 -0700 (PDT)
Date:   Thu, 14 Jul 2022 15:46:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657784816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TJviPunlwH7RxQV4jVLO1pPXI9F2og9+lwfZ75k6+g=;
        b=OKMxJzzUX/eSiaPlxOT6jOv1GE3aUntvTUhYa/zLy2CJbOPuL7nAwGJXJ8p5NWffeqB118
        YTbQyjLtSsm/NH6anB6VLWIOm/CcVlhhocIHHlNwmTBehCgatSEn1F4yO/M8UNl/aXO16n
        reyCtQJBf8EZKXDfUHbKAMrUCx3bEwQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
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
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V5 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <Ys/J5fLaojYeiVzL@geo.homenetwork>
References: <cover.1657745645.git.bristot@kernel.org>
 <442b03c687c298b25c79aa5a16ec7fb2aef0f2c9.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442b03c687c298b25c79aa5a16ec7fb2aef0f2c9.1657745645.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:17:17PM +0200,
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

[...]

> +void put_task_monitor_slot(int slot)
> +{
> +	lockdep_assert_held(&rv_interface_lock);
> +
> +	if (slot < 0 || slot > RV_PER_TASK_MONITORS) {

slot is the array index that should be 0 here. The up bound is not bigger
than 0 because the element of array now is RV_PER_TASK_MONITORS. 

So up bound check is 'slot > RV_PER_TASK_MONITORS-1'.

[...]

> +/*
> + * interface for enabling/disabling a monitor.
> + */
> +static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct rv_monitor_def *mdef = filp->private_data;
> +	int retval;
> +	bool val;
> +
> +	retval = kstrtobool_from_user(user_buf, count, &val);
> +	if (retval)
> +		return retval;
> +
> +	retval = count;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	if (val)
> +		retval = enable_monitor(mdef);
> +	else
> +		retval = disable_monitor(mdef);
> +
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return retval ? retval : count;

Feel that this can be written `return retval ? : count;`

[...]

> +static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct rv_monitor_def *m_def;
> +	loff_t l;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	if (list_empty(&rv_monitors_list))
> +		return NULL;
> +
> +	m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
> +
> +	for (l = 0; l <= *pos; ) {
> +		m_def = enabled_monitors_next(m, m_def, &l);
> +		if (!m_def)
> +			break;

Is this check is inversed. enabled_monitors_start() will stop at first
enabled monitor, then enabled_monitors_next() do loop to next. Check
like the above, enabled_monitors_start() will loop to the last monitor.
But I doubt myself I do not mention/see it. Sorry for these.

the check is:

  if (m_def)
     break;

[...]

> +static ssize_t
> +enabled_monitors_write(struct file *filp, const char __user *user_buf,
> +		      size_t count, loff_t *ppos)
> +{
> +	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> +	struct rv_monitor_def *mdef;
> +	int retval = -EINVAL;
> +	bool enable = true;
> +	char *ptr = buff;
> +	int len;
> +
> +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 2)

@count would not include '\0'. That the max val of @count is
MAX_RV_MONITOR_NAME_SIZE+1. So the up bound check of @count is
`count > MAX_RV_MONITOR_NAME_SIZE + 1`.

Thanks,
Tao
> +		return -EINVAL;
> +
> +	memset(buff, 0, sizeof(buff));
> +
> +	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
> +	if (!retval)
> +		return -EFAULT;
> +
> +	ptr = strim(buff);
> +
> +	if (ptr[0] == '!') {
> +		enable = false;
> +		ptr++;
> +	}
> +
> +	len = strlen(ptr);
> +	if (!len)
> +		return count;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	retval = -EINVAL;
> +
> +	list_for_each_entry(mdef, &rv_monitors_list, list) {
> +		if (strcmp(ptr, mdef->monitor->name) != 0)
> +			continue;
> +
> +		/*
> +		 * Monitor found!
> +		 */
> +		if (enable)
> +			retval = enable_monitor(mdef);
> +		else
> +			retval = disable_monitor(mdef);
> +
> +		if (!retval)
> +			retval = count;
> +
> +		break;
> +	}
> +
> +	mutex_unlock(&rv_interface_lock);
> +	return retval;
> +}
