Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F327757CDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiGUOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiGUOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:38:38 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB085F96;
        Thu, 21 Jul 2022 07:38:37 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:38:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658414315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7NIy/sFvH7jcPjQz5rMP0tVdv+pcC943zyadbA9JMA=;
        b=L0F5YCg/mY7nY9yWcaH8KzsTSg1GLC6SMZLH7EW7kL8sbqMO5Gu2Mz68CsIhU8JslpyEx+
        BAkn7T5mS+VxVOZPAzPXfVhJOHkaWg2ePTD7fIWopZqwVLXHGRqRCYmMpHctSa+gXAX8z+
        bbslSjgmX4YHZJxhdAewvyOGQW1srDc=
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
Subject: Re: [PATCH V6 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <Ytlk4ePA+TpGItJ6@geo.homenetwork>
References: <cover.1658244826.git.bristot@kernel.org>
 <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
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

On Tue, Jul 19, 2022 at 07:27:06PM +0200, Daniel Bristot de Oliveira wrote:

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <rv/rv.h>
> +
> +#include "rv.h"
> +
> +DEFINE_MUTEX(rv_interface_lock);
> +/*
> + * Enable a given monitor.
> + */
> +static int enable_monitor(struct rv_monitor_def *mdef)
> +{
> +	int retval;
> +
> +	if (!mdef->monitor->enabled) {
> +		retval = mdef->monitor->enable();
> +		if (retval)
> +			return retval;
> +	}
> +
> +	mdef->monitor->enabled = 1;

This should be placed at the end of the last if block. Otherwise
another assignment may be duplicated because it is already 1 now.
no?(not sure how compiler treat this..)

> +
> +/*
> + * Interface to read the enable/disable status of a monitor.

I see the 'status' but look a little more this function is about the
description of monitor, so:
/* Interface to read the description message of a monitor */
or others.

> + */
> +static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf, size_t count,
> +				      loff_t *ppos)
> +{
> +	struct rv_monitor_def *mdef = filp->private_data;
> +	char buff[256];
> +
> +	memset(buff, 0, sizeof(buff));
> +
> +	mutex_lock(&rv_interface_lock);
> +	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor->description);
> +	mutex_unlock(&rv_interface_lock);

