Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E184F4E7426
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356004AbiCYN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356003AbiCYN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6F52E5A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B65861A8D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436D8C340E9;
        Fri, 25 Mar 2022 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648214697;
        bh=qGzLP82Bl+/OSSKs1PKyy8id47mkTQdsSwRmZUIb1V0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q3gnttoOT5ZOfc/2F2mlpGGfbDau/VaRVxQ3YMFYAHI5qO7zfx+upTbQkz4zWl+QB
         FLWQqxHnju2kKaygLzc6EUxM7HxQGd6H8GtY9br9ahf70JjCVdkBv7O+cGxYqqR0rT
         +n7+SkHN92A5qwOa8UDNWXFR1H6ygttcr/+DPuL53ygQzzmUUvCkJ+qvixbAvbOEtn
         AwTzfCZT3R9ImQpdqvQaxwlYIYZjGHoVV9cRLkP5LC+L7ZNqitYea/prkxkeHmeVBW
         /ojLrbpWRUOsqk0qCxBSoRAi9EqHRFJ/4Ayu9GUCZYBmAITfYYojmgscMNDEm10SBi
         axiy9z69tDYQQ==
Date:   Fri, 25 Mar 2022 08:24:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <20220325132455.GA1556133@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324213445.3055538-1-tansuresh@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropped "trivial" from cc]

On Thu, Mar 24, 2022 at 02:34:45PM -0700, Tanjore Suresh wrote:
> This changes the bus driver interface to take in a flag to indicate
> whether a bus and associated devices are willing to participate in
> the asynchronous shutdown. If this flag is not set bus driver
> implementation will follow synchronous shutdown semantics.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>

There's useful functionality here.  Some hints to make it more
digestable:

- Add a cover letter to give an overview.  The patches themselves
  should be sent as responses to the cover letter so everything is
  connected in the email archives.

  [1] is a nice example of what this looks like.  You can currently
  find your series as [2], which searches for everything from you, but
  there's no single permanent URL that finds the whole series.

- Send the whole series (cover letter + patches) to everybody, so
  people can see the context and where each piece fits.

  No need to CC the "trivial@kernel.org" list.  That's for things like
  tiny, obviously correct patches that can be reviewed very quickly.

- Wait a week or so for any comments on this series before sending a
  revised v2.  When you send a v2, use "git format-patch -v 2" or
  similar to mark it as v2.  Also include notes what what changed
  between v1 (this posting) and v2.  [1] has nice examples of how to
  do that, both in the cover letter and the individual patches.

- Update this commit log so it matches the code (there is no longer a
  flag).

- Write commit logs in imperative mood; see [3, 4].

  In this case, your commit log should probably have two parts: the
  first to outline the problem, and the second to say what this
  patches does about it, e.g., something like this:

    Driver .shutdown() methods are all run serially, so there's no
    parallelism even across unrelated devices.

    Add an optional asynchronous shutdown method so drivers can
    schedule work to be done in parallel.

A few code comments below.

[1] https://lore.kernel.org/linux-pci/20220325093827.4983-1-pali@kernel.org/T/#t
[2] https://lore.kernel.org/all/?q=f%3Atansuresh
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v5.16#n134
[4] https://chris.beams.io/posts/git-commit/

> ---
>  drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
>  include/linux/device/bus.h | 10 ++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..359e7067e8b8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>  void device_shutdown(void)
>  {
>  	struct device *dev, *parent;
> +	LIST_HEAD(async_shutdown_list);
>  
>  	wait_for_device_probe();
>  	device_block_probing();
> @@ -4523,7 +4524,14 @@ void device_shutdown(void)
>  				dev_info(dev, "shutdown_pre\n");
>  			dev->class->shutdown_pre(dev);
>  		}
> -		if (dev->bus && dev->bus->shutdown) {
> +
> +		if (dev->bus && dev->bus->shutdown_pre) {
> +			if (initcall_debug)
> +				dev_info(dev, "shutdown_pre\n");
> +			dev->bus->shutdown_pre(dev);
> +			list_add(&dev->kobj.entry,
> +				&async_shutdown_list);
> +		} else if (dev->bus && dev->bus->shutdown) {
>  			if (initcall_debug)
>  				dev_info(dev, "shutdown\n");
>  			dev->bus->shutdown(dev);
> @@ -4543,6 +4551,35 @@ void device_shutdown(void)
>  		spin_lock(&devices_kset->list_lock);
>  	}
>  	spin_unlock(&devices_kset->list_lock);
> +
> +	/*
> +	 * Second pass spin for only devices, that have configured
> +	 * Asynchronous shutdown.
> +	 */
> +	while (!list_empty(&async_shutdown_list)) {
> +		dev = list_entry(async_shutdown_list.next, struct device,
> +				kobj.entry);
> +		parent = get_device(dev->parent);
> +		get_device(dev);
> +		/*
> +		 * Make sure the device is off the  list
> +		 */
> +		list_del_init(&dev->kobj.entry);
> +		if (parent)
> +			device_lock(parent);
> +		device_lock(dev);
> +		if (dev->bus && dev->bus->shutdown_post) {
> +			if (initcall_debug)
> +				dev_info(dev,
> +				"shutdown_post called\n");
> +			dev->bus->shutdown_post(dev);
> +		}
> +		device_unlock(dev);
> +		if (parent)
> +			device_unlock(parent);
> +		put_device(dev);
> +		put_device(parent);
> +	}

I'm not a driver core expert, but AFAICS, the existing model is that
.shutdown() is always synchronous.  We call it for each device
serially.

And your proposal is to allow some shutdown processing to happen in
parallel, by adding .shutdown_pre() to *schedule* work that can happen
after .shutdown_pre() returns, and .shutdown_post() to *wait* for all
that scheduled work to complete.

IIUC, .shutdown_post() is completely synchronous, just like the
existing .shutdown() is, so it seems unnecessary to add it.

Seems like it would be simpler to add an optional .shutdown_async()
method.  This method would be called in a loop *before* the existing
loop that calls .shutdown(), and it could start the async work.

Drivers that implement .shutdown_async() would at the same time update
their .shutdown() methods to wait for all the work started by
.shutdown_async().

>  }
>  
>  /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index a039ab809753..e261819601e9 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -49,6 +49,14 @@ struct fwnode_handle;
>   *		will never get called until they do.
>   * @remove:	Called when a device removed from this bus.
>   * @shutdown:	Called at shut-down time to quiesce the device.
> + * @shutdown_pre:	Called at the shutdown-time to start the shutdown
> + *			process on the device. This entry point will be called
> + *			only when the bus driver has indicated it would like
> + *			to participate in asynchronous shutdown completion.
> + * @shutdown_post:	Called at shutdown-time  to complete the shutdown
> + *			process of the device. This entry point will be called
> + *			only when the bus drive has indicated it would like to
> + *			participate in the asynchronous shutdown completion.
>   *
>   * @online:	Called to put the device back online (after offlining it).
>   * @offline:	Called to put the device offline for hot-removal. May fail.
> @@ -93,6 +101,8 @@ struct bus_type {
>  	void (*sync_state)(struct device *dev);
>  	void (*remove)(struct device *dev);
>  	void (*shutdown)(struct device *dev);
> +	void (*shutdown_pre)(struct device *dev);
> +	void (*shutdown_post)(struct device *dev);
>  
>  	int (*online)(struct device *dev);
>  	int (*offline)(struct device *dev);
> -- 
> 2.35.1.1021.g381101b075-goog
> 
