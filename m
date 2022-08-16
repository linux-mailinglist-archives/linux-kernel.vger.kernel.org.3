Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4715963AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiHPUXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:23:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF692AC3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:23:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 202so10210818pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=T8rJsBvfTP/Wpqm4oI8sng03cm19nt45RRAG3AmLcOQ=;
        b=ky2j9+briAWYQADcgmep84eATgxml94jk+9c60bznCgnrbJ4kNmB0LgXQIfuKIAW+B
         32J7drpX4rUjRm37buUPoSUjB5adLp43GknpVa3w7euv1HNPlq0SEqjkMvwBlDdc2NKy
         0BPnp6p6SG5Il8zqK63IUh7u0jMllQIXVlees=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=T8rJsBvfTP/Wpqm4oI8sng03cm19nt45RRAG3AmLcOQ=;
        b=zryEshGRVuUJfrkQfkcTbUgmDt+GiNUpeoTvjq4WaEhFrWphzeARJ0r+CwKOQRqIX+
         GXW7RwZyobkPiT32ajqPQ9cNralJJZ/h72KVaVT309oFQGihumaQCbxuLRGjPNZJH9fi
         pyuC4xnoKBkDux0n4F1C82/0lIXTN09OY3i/xsuBPYEwcgHIWcDgEl0Y2mcIFIAgpafA
         SqCHemrnm/z3LEkSCQ32VhWpqtmcMfhjMCD8jTiPq64kljffJm70dX1Ai3VruwXgexnf
         ful/YljaYXBAXmL2L3BQwhqG3SVkPRcc19C/ysN6uoD9/7QCIhMTkQL64Vg49W7VzxXe
         lV4w==
X-Gm-Message-State: ACgBeo1q1dF8EzlKe8sZMpAcvYb5fBb4E66VjK8D2n8bBMdM2flws/Y1
        TZqLDZ6pLx2UzBLKUcOZ5DdsYw==
X-Google-Smtp-Source: AA6agR6vTDSZD60KlqgBoRNUSGhq7xB0JD3tVpZcPCcs0640D0VoxFLZ0/llfkBdw5vPHZz7if0h9w==
X-Received: by 2002:a63:d55:0:b0:41c:86b0:59b5 with SMTP id 21-20020a630d55000000b0041c86b059b5mr19262583pgn.351.1660681410475;
        Tue, 16 Aug 2022 13:23:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 5-20020a630405000000b0041d628dde58sm8097745pge.30.2022.08.16.13.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:23:29 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:23:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        gregkh@linuxfoundation.org, tglx@linutronix.de, sboyd@kernel.org,
        rafael@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] devcoredump : Serialize devcd_del work
Message-ID: <202208161322.B842DFC4E@keescook>
References: <1653660220-19197-1-git-send-email-quic_mojha@quicinc.com>
 <425df8db-d358-c1d7-820c-fc0485aa2721@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425df8db-d358-c1d7-820c-fc0485aa2721@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 09:43:48PM +0530, Mukesh Ojha wrote:
> Hi Johannes/Kees,

Hi!

> 
> Sorry for reminding on it again.
> Any hope of this one to get into devcoredump ?

I don't know this code well enough to comment on the solution, but it
seems designed and justified correctly, at least. :)

I'll leave it to Johannes for review.

-Kees

> 
> -Mukesh
> 
> 
> On 5/27/2022 7:33 PM, Mukesh Ojha wrote:
> > In following scenario(diagram), when one thread X running dev_coredumpm()
> > adds devcd device to the framework which sends uevent notification to
> > userspace and another thread Y reads this uevent and call to
> > devcd_data_write() which eventually try to delete the queued timer that
> > is not initialized/queued yet.
> > 
> > So, debug object reports some warning and in the meantime, timer is
> > initialized and queued from X path. and from Y path, it gets reinitialized
> > again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> > 
> > To fix this, introduce mutex and a boolean flag to serialize the behaviour.
> > 
> >   	cpu0(X)			                cpu1(Y)
> > 
> >      dev_coredump() uevent sent to user space
> >      device_add()  ======================> user space process Y reads the
> >                                            uevents writes to devcd fd
> >                                            which results into writes to
> > 
> >                                           devcd_data_write()
> >                                             mod_delayed_work()
> >                                               try_to_grab_pending()
> >                                                 del_timer()
> >                                                   debug_assert_init()
> >     INIT_DELAYED_WORK()
> >     schedule_delayed_work()
> >                                                     debug_object_fixup()
> >                                                       timer_fixup_assert_init()
> >                                                         timer_setup()
> >                                                           do_init_timer()
> >                                                         /*
> >                                                          Above call reinitializes
> >                                                          the timer to
> >                                                          timer->entry.pprev=NULL
> >                                                          and this will be checked
> >                                                          later in timer_pending() call.
> >                                                         */
> >                                                   timer_pending()
> >                                                    !hlist_unhashed_lockless(&timer->entry)
> >                                                      !h->pprev
> >                                                  /*
> >                                                    del_timer() checks h->pprev and finds
> >                                                    it to be NULL due to which
> >                                                    try_to_grab_pending() stucks.
> >                                                  */
> > 
> > Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> > v4->v5:
> >   - Rebased it.
> > 
> > v3->v4:
> >   - flg variable renamed to delete_work.
> > 
> > v2->v3:
> >   Addressed comments from gregkh
> >   - Wrapped the commit text and corrected the alignment.
> >   - Described the reason to introduce new variables.
> >   - Restored the blank line.
> >   - rename the del_wk_queued to flg.
> >   Addressed comments from tglx
> >   - Added a comment which explains the race which looks obvious however
> >     would not occur between disabled_store and devcd_del work.
> > 
> > 
> > v1->v2:
> >   - Added del_wk_queued flag to serialize the race between devcd_data_write()
> >     and disabled_store() => devcd_free().
> >   drivers/base/devcoredump.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 81 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > index f4d794d..1c06781 100644
> > --- a/drivers/base/devcoredump.c
> > +++ b/drivers/base/devcoredump.c
> > @@ -25,6 +25,47 @@ struct devcd_entry {
> >   	struct device devcd_dev;
> >   	void *data;
> >   	size_t datalen;
> > +	/*
> > +	 * Here, mutex is required to serialize the calls to del_wk work between
> > +	 * user/kernel space which happens when devcd is added with device_add()
> > +	 * and that sends uevent to user space. User space reads the uevents,
> > +	 * and calls to devcd_data_write() which try to modify the work which is
> > +	 * not even initialized/queued from devcoredump.
> > +	 *
> > +	 *
> > +	 *
> > +	 *        cpu0(X)                                 cpu1(Y)
> > +	 *
> > +	 *        dev_coredump() uevent sent to user space
> > +	 *        device_add()  ======================> user space process Y reads the
> > +	 *                                              uevents writes to devcd fd
> > +	 *                                              which results into writes to
> > +	 *
> > +	 *                                             devcd_data_write()
> > +	 *                                               mod_delayed_work()
> > +	 *                                                 try_to_grab_pending()
> > +	 *                                                   del_timer()
> > +	 *                                                     debug_assert_init()
> > +	 *       INIT_DELAYED_WORK()
> > +	 *       schedule_delayed_work()
> > +	 *
> > +	 *
> > +	 * Also, mutex alone would not be enough to avoid scheduling of
> > +	 * del_wk work after it get flush from a call to devcd_free()
> > +	 * mentioned as below.
> > +	 *
> > +	 *	disabled_store()
> > +	 *        devcd_free()
> > +	 *          mutex_lock()             devcd_data_write()
> > +	 *          flush_delayed_work()
> > +	 *          mutex_unlock()
> > +	 *                                   mutex_lock()
> > +	 *                                   mod_delayed_work()
> > +	 *                                   mutex_unlock()
> > +	 * So, delete_work flag is required.
> > +	 */
> > +	struct mutex mutex;
> > +	bool delete_work;
> >   	struct module *owner;
> >   	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> >   			void *data, size_t datalen);
> > @@ -84,7 +125,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
> >   	struct device *dev = kobj_to_dev(kobj);
> >   	struct devcd_entry *devcd = dev_to_devcd(dev);
> > -	mod_delayed_work(system_wq, &devcd->del_wk, 0);
> > +	mutex_lock(&devcd->mutex);
> > +	if (!devcd->delete_work) {
> > +		devcd->delete_work = true;
> > +		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> > +	}
> > +	mutex_unlock(&devcd->mutex);
> >   	return count;
> >   }
> > @@ -112,7 +158,12 @@ static int devcd_free(struct device *dev, void *data)
> >   {
> >   	struct devcd_entry *devcd = dev_to_devcd(dev);
> > +	mutex_lock(&devcd->mutex);
> > +	if (!devcd->delete_work)
> > +		devcd->delete_work = true;
> > +
> >   	flush_delayed_work(&devcd->del_wk);
> > +	mutex_unlock(&devcd->mutex);
> >   	return 0;
> >   }
> > @@ -122,6 +173,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
> >   	return sysfs_emit(buf, "%d\n", devcd_disabled);
> >   }
> > +/*
> > + *
> > + *	disabled_store()                                	worker()
> > + *	 class_for_each_device(&devcd_class,
> > + *		NULL, NULL, devcd_free)
> > + *         ...
> > + *         ...
> > + *	   while ((dev = class_dev_iter_next(&iter))
> > + *                                                             devcd_del()
> > + *                                                               device_del()
> > + *                                                                 put_device() <- last reference
> > + *             error = fn(dev, data)                           devcd_dev_release()
> > + *             devcd_free(dev, data)                           kfree(devcd)
> > + *             mutex_lock(&devcd->mutex);
> > + *
> > + *
> > + * In the above diagram, It looks like disabled_store() would be racing with parallely
> > + * running devcd_del() and result in memory abort while acquiring devcd->mutex which
> > + * is called after kfree of devcd memory  after dropping its last reference with
> > + * put_device(). However, this will not happens as fn(dev, data) runs
> > + * with its own reference to device via klist_node so it is not its last reference.
> > + * so, above situation would not occur.
> > + */
> > +
> >   static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
> >   			      const char *buf, size_t count)
> >   {
> > @@ -278,13 +353,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >   	devcd->read = read;
> >   	devcd->free = free;
> >   	devcd->failing_dev = get_device(dev);
> > +	devcd->delete_work = false;
> > +	mutex_init(&devcd->mutex);
> >   	device_initialize(&devcd->devcd_dev);
> >   	dev_set_name(&devcd->devcd_dev, "devcd%d",
> >   		     atomic_inc_return(&devcd_count));
> >   	devcd->devcd_dev.class = &devcd_class;
> > +	mutex_lock(&devcd->mutex);
> >   	if (device_add(&devcd->devcd_dev))
> >   		goto put_device;
> > @@ -301,10 +379,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >   	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> >   	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > -
> > +	mutex_unlock(&devcd->mutex);
> >   	return;
> >    put_device:
> >   	put_device(&devcd->devcd_dev);
> > +	mutex_unlock(&devcd->mutex);
> >    put_module:
> >   	module_put(owner);
> >    free:

-- 
Kees Cook
