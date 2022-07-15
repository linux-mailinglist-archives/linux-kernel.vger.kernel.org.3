Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B0576307
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGONtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiGONtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:49:10 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019E240BC;
        Fri, 15 Jul 2022 06:49:08 -0700 (PDT)
Date:   Fri, 15 Jul 2022 21:48:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657892947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9s4Mr1J+0suKDIGr85spAp3Op0wmtujQR9qtd1lm93Q=;
        b=UPA7Px3FUyKI8wo6pTCUJG/aCYmUHN6Kz0zd9pwiVfRVba+VNSajQ7NJVAl1E6bop6whKW
        r68p6r8hhd5aPz0AB87AzxqioLBg+R2cHl6cXRAngXUweWsvDbwoeZ6Oho0AOnfSIuzMcd
        RuUh1DcNzb7Sf5qdpPDttYRrRqUsr/0=
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
Message-ID: <YtFwL+x9ruIZytW4@geo.homenetwork>
References: <cover.1657745645.git.bristot@kernel.org>
 <442b03c687c298b25c79aa5a16ec7fb2aef0f2c9.1657745645.git.bristot@kernel.org>
 <Ys/J5fLaojYeiVzL@geo.homenetwork>
 <3758d3bd-7272-e907-a51a-44a21d757674@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3758d3bd-7272-e907-a51a-44a21d757674@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:47:28PM +0200,
Daniel Bristot de Oliveira wrote:

> On 7/14/22 09:46, Tao Zhou wrote:
> > On Wed, Jul 13, 2022 at 11:17:17PM +0200,
> > Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> > 
> > [...]
> > 
> >> +void put_task_monitor_slot(int slot)
> >> +{
> >> +	lockdep_assert_held(&rv_interface_lock);
> >> +
> >> +	if (slot < 0 || slot > RV_PER_TASK_MONITORS) {
> > 
> > slot is the array index that should be 0 here. The up bound is not bigger
> > than 0 because the element of array now is RV_PER_TASK_MONITORS. 
> > 
> > So up bound check is 'slot > RV_PER_TASK_MONITORS-1'.
> 
> fixed! (slot >= RV...)
> 
> > [...]
> > 
> >> +/*
> >> + * interface for enabling/disabling a monitor.
> >> + */
> >> +static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
> >> +					 size_t count, loff_t *ppos)
> >> +{
> >> +	struct rv_monitor_def *mdef = filp->private_data;
> >> +	int retval;
> >> +	bool val;
> >> +
> >> +	retval = kstrtobool_from_user(user_buf, count, &val);
> >> +	if (retval)
> >> +		return retval;
> >> +
> >> +	retval = count;
> >> +
> >> +	mutex_lock(&rv_interface_lock);
> >> +
> >> +	if (val)
> >> +		retval = enable_monitor(mdef);
> >> +	else
> >> +		retval = disable_monitor(mdef);
> >> +
> >> +	mutex_unlock(&rv_interface_lock);
> >> +
> >> +	return retval ? retval : count;
> > 
> > Feel that this can be written `return retval ? : count;`
> 
> 
> why not...
> 
> > [...]
> > 
> >> +static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
> >> +{
> >> +	struct rv_monitor_def *m_def;
> >> +	loff_t l;
> >> +
> >> +	mutex_lock(&rv_interface_lock);
> >> +
> >> +	if (list_empty(&rv_monitors_list))
> >> +		return NULL;
> >> +
> >> +	m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
> >> +
> >> +	for (l = 0; l <= *pos; ) {
> >> +		m_def = enabled_monitors_next(m, m_def, &l);
> >> +		if (!m_def)
> >> +			break;
> > 
> > Is this check is inversed. enabled_monitors_start() will stop at first
> > enabled monitor, then enabled_monitors_next() do loop to next. Check
> > like the above, enabled_monitors_start() will loop to the last monitor.
> > But I doubt myself I do not mention/see it. Sorry for these.
> > 
> > the check is:
> > 
> >   if (m_def)
> >      break;
> > 
> > [...]
> 
> 
> see kernel/trace/trace_events.c:s_start...

I presumed @l changed in function enabled_monitors_next() will
impack on the @*pos of enabled_monitors_start(). But it's not.
@l is increased by 1 in enabled_monitors_next() and is used to
check with @*pos passed as parameter argument of enabled_monitors_start().
Absolutely I lost here.. Thanks.

> >> +static ssize_t
> >> +enabled_monitors_write(struct file *filp, const char __user *user_buf,
> >> +		      size_t count, loff_t *ppos)
> >> +{
> >> +	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> >> +	struct rv_monitor_def *mdef;
> >> +	int retval = -EINVAL;
> >> +	bool enable = true;
> >> +	char *ptr = buff;
> >> +	int len;
> >> +
> >> +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 2)
> > 
> > @count would not include '\0'. That the max val of @count is
> > MAX_RV_MONITOR_NAME_SIZE+1. So the up bound check of @count is
> > `count > MAX_RV_MONITOR_NAME_SIZE + 1`.
> 
> Fixed for v6...
> 
> -- Daniel
