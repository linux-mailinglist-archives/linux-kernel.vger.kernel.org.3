Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1D4FF26A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiDMIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiDMIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:45:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159AB4EF6E;
        Wed, 13 Apr 2022 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B9YkVN+zETpSpWU7cq4MarKPe7gLn1sjGxlryEkU3KY=; b=NMi8W15yKp4NbzUmRlKny8mtun
        v5DgHy67mWCb95llT6faiT7MogK0iutOj78TgY3E3U71KyQijbZqXIChZwd5uJ0piWWZY+49xwEPf
        dMJAfDEJqSpye3xK9gDP0MNO3VPYS3464lCe4aTyzMeLgIq4lO6oM/PtQ3cyRaOxHLG3lrLJLD5AA
        0C1hC6LcDtUE4PW+XJwTSubkJgRlyjEfpjekfV4Eg8P5d5TLRdmo4qEgqdAFnb2BnU9mshakqKak+
        7rvCsC7d+gygP4qmD/qmNJJOsUU2W/6kMp05Z9dEIqwHAlmk4kYQaM67BuFSkRGjenwrVxbs7/+QK
        bdFW+PUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neYal-004bFE-TQ; Wed, 13 Apr 2022 08:43:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFF959861CB; Wed, 13 Apr 2022 10:43:09 +0200 (CEST)
Date:   Wed, 13 Apr 2022 10:43:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v2 02/12] device-core: Add dev->lock_class to enable
 device_lock() lockdep validation
Message-ID: <20220413084309.GV2731@worktop.programming.kicks-ass.net>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982969858.684294.17819743973041389492.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164982969858.684294.17819743973041389492.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:01:38PM -0700, Dan Williams wrote:
> The device_lock() is hidden from lockdep by default because, for
> example, a device subsystem may do something like:
> 
> ---
> device_add(dev1);
> ...in driver core...
> device_lock(dev1);
> bus->probe(dev1); /* where bus->probe() calls driver1_probe() */
> 
> driver1_probe(struct device *dev)
> {
> 	...do some enumeration...
> 	dev2->parent = dev;
> 	/* this triggers probe under device_lock(dev2); */
> 	device_add(dev2);
> }
> ---
> 
> To lockdep, that device_lock(dev2) looks like a deadlock because lockdep

Recursion, you're meaning to say it looks like same lock recursion.

> only sees lock classes, not individual lock instances. All device_lock()
> instances across the entire kernel are the same class. However, this is
> not a deadlock in practice because the locking is strictly hierarchical.
> I.e. device_lock(dev1) is held over device_lock(dev2), but never the
> reverse.

I have some very vague memories from a conversation with Alan Stern,
some maybe 10 years ago, where I think he was explaining to me this was
not in fact a simple hierarchy.

> In order for lockdep to be satisfied and see that it is
> hierarchical in practice the mutex_lock() call in device_lock() needs to
> be moved to mutex_lock_nested() where the @subclass argument to
> mutex_lock_nested() represents the nesting level, i.e.:

That's not an obvious conclusion; lockdep has lots of funny annotations,
subclasses is just one.

I think the big new development in lockdep since that time with Alan
Stern is that lockdep now has support for dynamic keys; that is lock
keys in heap memory (as opposed to static storage).

> s/device_lock(dev1)/mutex_lock_nested(&dev1->mutex, 1)/
> 
> s/device_lock(dev2)/mutex_lock_nested(&dev2->mutex, 2)/
> 
> Now, what if the internals of the device_lock() could be annotated with
> the right @subclass argument to call mutex_lock_nested()?
> 
> With device_set_lock_class() a subsystem can optionally add that
> metadata. The device_lock() still takes dev->mutex, but when
> dev->lock_class is >= 0 it additionally takes dev->lockdep_mutex with
> the proper nesting. Unlike dev->mutex, dev->lockdep_mutex is not marked
> lockdep_set_novalidate_class() and lockdep will become useful... at
> least for one subsystem at a time.
> 
> It is still the case that only one subsystem can be using lockdep with
> lockdep_mutex at a time because different subsystems will collide class
> numbers. You might say "well, how about subsystem1 gets class ids 0 to 9
> and subsystem2 gets class ids 10 to 20?". MAX_LOCKDEP_SUBCLASSES is 8,
> and 8 is just enough class ids for one subsystem of moderate complexity.

Again, that doesn't seem like an obvious suggestion at all. Why not give
each subsystem a different lock key?


> diff --git a/include/linux/device.h b/include/linux/device.h
> index af2576ace130..6083e757e804 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -402,6 +402,7 @@ struct dev_msi_info {
>   * @mutex:	Mutex to synchronize calls to its driver.
>   * @lockdep_mutex: An optional debug lock that a subsystem can use as a
>   * 		peer lock to gain localized lockdep coverage of the device_lock.
> + * @lock_class: per-subsystem annotated device lock class
>   * @bus:	Type of bus device is on.
>   * @driver:	Which driver has allocated this
>   * @platform_data: Platform data specific to the device.
> @@ -501,6 +502,7 @@ struct device {
>  					   dev_set_drvdata/dev_get_drvdata */
>  #ifdef CONFIG_PROVE_LOCKING
>  	struct mutex		lockdep_mutex;
> +	int			lock_class;
>  #endif
>  	struct mutex		mutex;	/* mutex to synchronize calls to
>  					 * its driver.
> @@ -762,18 +764,100 @@ static inline bool dev_pm_test_driver_flags(struct device *dev, u32 flags)
>  	return !!(dev->power.driver_flags & flags);
>  }
>  
> +static inline void device_lock_assert(struct device *dev)
> +{
> +	lockdep_assert_held(&dev->mutex);
> +}
> +
>  #ifdef CONFIG_PROVE_LOCKING
>  static inline void device_lockdep_init(struct device *dev)
>  {
>  	mutex_init(&dev->lockdep_mutex);
> +	dev->lock_class = -1;
>  	lockdep_set_novalidate_class(&dev->mutex);
>  }
> -#else
> +
> +static inline void device_lock(struct device *dev)
> +{
> +	/*
> +	 * For double-lock programming errors the kernel will hang
> +	 * trying to acquire @dev->mutex before lockdep can report the
> +	 * problem acquiring @dev->lockdep_mutex, so manually assert
> +	 * before that hang.
> +	 */
> +	lockdep_assert_not_held(&dev->lockdep_mutex);
> +
> +	mutex_lock(&dev->mutex);
> +	if (dev->lock_class >= 0)
> +		mutex_lock_nested(&dev->lockdep_mutex, dev->lock_class);
> +}
> +
> +static inline int device_lock_interruptible(struct device *dev)
> +{
> +	int rc;
> +
> +	lockdep_assert_not_held(&dev->lockdep_mutex);
> +
> +	rc = mutex_lock_interruptible(&dev->mutex);
> +	if (rc || dev->lock_class < 0)
> +		return rc;
> +
> +	return mutex_lock_interruptible_nested(&dev->lockdep_mutex,
> +					       dev->lock_class);
> +}
> +
> +static inline int device_trylock(struct device *dev)
> +{
> +	if (mutex_trylock(&dev->mutex)) {
> +		if (dev->lock_class >= 0)
> +			mutex_lock_nested(&dev->lockdep_mutex, dev->lock_class);

This must be the weirdest stuff I've seen in a while.

> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void device_unlock(struct device *dev)
> +{
> +	if (dev->lock_class >= 0)
> +		mutex_unlock(&dev->lockdep_mutex);
> +	mutex_unlock(&dev->mutex);
> +}
> +
> +/*
> + * Note: this routine expects that the state of @dev->mutex is stable
> + * from entry to exit. There is no support for changing lockdep
> + * validation classes, only enabling and disabling validation.
> + */
> +static inline void device_set_lock_class(struct device *dev, int lock_class)
> +{
> +	/*
> +	 * Allow for setting or clearing the lock class while the
> +	 * device_lock() is held, in which case the paired nested lock
> +	 * might need to be acquired or released now to accommodate the
> +	 * next device_unlock().
> +	 */
> +	if (dev->lock_class < 0 && lock_class >= 0) {
> +		/* Enabling lockdep validation... */
> +		if (mutex_is_locked(&dev->mutex))
> +			mutex_lock_nested(&dev->lockdep_mutex, lock_class);
> +	} else if (dev->lock_class >= 0 && lock_class < 0) {
> +		/* Disabling lockdep validation... */
> +		if (mutex_is_locked(&dev->mutex))
> +			mutex_unlock(&dev->lockdep_mutex);
> +	} else {
> +		dev_warn(dev,
> +			 "%s: failed to change lock_class from: %d to %d\n",
> +			 __func__, dev->lock_class, lock_class);
> +		return;
> +	}
> +	dev->lock_class = lock_class;
> +}
> +#else /* !CONFIG_PROVE_LOCKING */

This all reads like something utterly surreal... *WHAT*!?!?

If you want lockdep validation for one (or more) dev->mutex instances,
why not pull them out of the no_validate class and use the normal
locking?

This is all quite insane.
