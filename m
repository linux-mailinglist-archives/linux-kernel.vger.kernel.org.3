Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D572B467D48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382708AbhLCSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:30:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:60137 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1359662AbhLCSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:30:20 -0500
Received: (qmail 429917 invoked by uid 1000); 3 Dec 2021 13:26:55 -0500
Date:   Fri, 3 Dec 2021 13:26:55 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: runtime: Capture device status before disabling
 runtime PM
Message-ID: <Yaphb0hcqTQ3S78n@rowland.harvard.edu>
References: <4723000.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4723000.31r3eYUQgx@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:24:45PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some cases (for example, during system-wide suspend and resume of
> devices) it is useful to know whether or not runtime PM has ever been
> enabled for a given device and, if so, what the runtime PM status of
> it had been right before runtime PM was disabled for it last time.
> 
> For this reason, introduce a new struct dev_pm_info field called
> last_status that will be used for capturing the runtime PM status of
> the device when its power.disable_depth counter changes from 0 to 1.
> 
> The new field will be set to RPM_INVALID to start with and whenever
> power.disable_depth changes from 1 to 0, so it will be valid only
> when runtime PM of the device is currently disabled, but it has been
> enabled at least once.
> 
> Immediately use power.last_status in rpm_resume() to make it handle
> the case when PM runtime is disabled for the device, but its runtime
> PM status is RPM_ACTIVE more consistently.  Namely, make it return 1
> if power.last_status is also equal to RPM_ACTIVE in that case (the
> idea being that if the status was RPM_ACTIVE last time when
> power.disable_depth was changing from 0 to 1 and it is still
> RPM_ACTIVE, it can be assumed to reflect what happened to the device
> last time when it was using runtime PM) and -EACCES otherwise.
> 
> Update the documentation to provide a description of last_status and
> change the description of pm_runtime_resume() in it to reflect the
> new behavior of rpm_active().
> 
> While at it, rearrange the code in pm_runtime_enable() to be more
> straightforward and replace the WARN() macro in it with a pr_warn()
> invocation which is less disruptive.
> 
> Link: https://lore.kernel.org/linux-pm/20211026222626.39222-1-ulf.hansson@linaro.org/t/#u
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/power/runtime_pm.rst |   14 +++++++++----
>  drivers/base/power/runtime.c       |   38 +++++++++++++++++++------------------
>  include/linux/pm.h                 |    2 +
>  3 files changed, 32 insertions(+), 22 deletions(-)
> 
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -744,11 +744,10 @@ static int rpm_resume(struct device *dev
>   repeat:
>  	if (dev->power.runtime_error)
>  		retval = -EINVAL;
> -	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> -	    && dev->power.runtime_status == RPM_ACTIVE)
> -		retval = 1;
>  	else if (dev->power.disable_depth > 0)
> -		retval = -EACCES;
> +		retval = dev->power.runtime_status == RPM_ACTIVE &&
> +			 dev->power.last_status == RPM_ACTIVE ? 1 : -EACCES;

Suggestion for a small improvement in readability: The way this 
statement is broken between two lines, it looks as if the ?: operator 
has higher precedence than the && operator, which is very confusing.  
Adding parentheses would help.  Even better would be to rewrite this as 
an "if" statement:

		if (dev->power.runtime_status == RPM_ACTIVE &&
		    dev->power.last_status == RPM_ACTIVE)
			retval = 1;
		else
			retval = -EACCES;

Alan Stern
