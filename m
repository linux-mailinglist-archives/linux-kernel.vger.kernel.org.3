Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DBE50E2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbiDYOKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiDYOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A22CC8E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66113B817FE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9152FC385A4;
        Mon, 25 Apr 2022 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650895611;
        bh=BUUeQcOmkPg5mOVoy71O427Wru6emcgxlwvTEFbPYAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOcSqK4MyLOTv0XNCRaHezxQiAG+nImpHonibJfV8hXM7+fWecZnuYeBBKPjYIrRk
         zmx4r+xQEETHN/JaGRrX+C+w2Topin03i5GkQxM5CZnCcm/o/4QirvlWDs3UEIE6PR
         PQ7bTrQRlZKrU8YsebTa6hrIuc/E6gRsPTL/qQxE=
Date:   Mon, 25 Apr 2022 16:06:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
Message-ID: <Ymaq9z5fqbCdoQgw@kroah.com>
References: <1650892193-12888-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1650892193-12888-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:53PM +0530, Mukesh Ojha wrote:
> In following scenario(diagram), when one thread X running dev_coredumpm() adds devcd
> device to the framework which sends uevent notification to userspace
> and another thread Y reads this uevent and call to devcd_data_write()
> which eventually try to delete the queued timer that is not initialized/queued yet.
> 
> So, debug object reports some warning and in the meantime, timer is initialized
> and queued from X path. and from Y path, it gets reinitialized again and
> timer->entry.pprev=NULL and try_to_grab_pending() stucks.

Nit, please wrap your lines at 72 columns like git asked you to when you
made the commit

> 
> To fix this, introduce mutex to serialize the behaviour.
> 
>  	cpu0(X)			                      cpu1(Y)
> 
>     dev_coredump() uevent sent to userspace
>     device_add()  =========================> userspace process Y reads the uevents
>                                              writes to devcd fd which
>                                              results into writes to
> 
>                                             devcd_data_write()
>                                               mod_delayed_work()
>                                                 try_to_grab_pending()
>                                                   del_timer()
>                                                     debug_assert_init()
>    INIT_DELAYED_WORK
>    schedule_delayed_work
>                                                      debug_object_fixup()
>                                                       timer_fixup_assert_init()
>                                                        timer_setup()
>                                                          do_init_timer()   ==> reinitialized the
>                                                                                  timer to
>                                                                                  timer->entry.pprev=NULL
> 
>                                                   timer_pending()
>                                                    !hlist_unhashed_lockless(&timer->entry)
>                                                      !h->pprev  ==> del_timer checks
>                                                                   and finds it to be NULL
>  								  try_to_grab_pending() stucks.

Mix of tabs and spaces?  This can all go left a bit as well.

> 
> Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> v1->v2:
>  - Added del_wk_queued to serialize the race between devcd_data_write()
>    and disabled_store().
> 
>  drivers/base/devcoredump.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f4d794d..3e6fd6b 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -25,6 +25,8 @@ struct devcd_entry {
>  	struct device devcd_dev;
>  	void *data;
>  	size_t datalen;
> +	struct mutex mutex;

Document what this lock is for here please.  I think checkpatch asks you
for that, right?

> +	bool del_wk_queued;

Please spell this out better, you can use vowels :)

>  	struct module *owner;
>  	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>  			void *data, size_t datalen);
> @@ -84,7 +86,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct devcd_entry *devcd = dev_to_devcd(dev);
>  
> -	mod_delayed_work(system_wq, &devcd->del_wk, 0);
> +	mutex_lock(&devcd->mutex);
> +	if (!devcd->del_wk_queued) {
> +		devcd->del_wk_queued = true;
> +		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> +	}
> +	mutex_unlock(&devcd->mutex);
>  
>  	return count;
>  }
> @@ -112,7 +119,12 @@ static int devcd_free(struct device *dev, void *data)
>  {
>  	struct devcd_entry *devcd = dev_to_devcd(dev);
>  
> +	mutex_lock(&devcd->mutex);
> +	if (!devcd->del_wk_queued)
> +		devcd->del_wk_queued = true;
> +
>  	flush_delayed_work(&devcd->del_wk);
> +	mutex_unlock(&devcd->mutex);
>  	return 0;
>  }
>  
> @@ -278,13 +290,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	devcd->read = read;
>  	devcd->free = free;
>  	devcd->failing_dev = get_device(dev);
> -
> +	mutex_init(&devcd->mutex);

Why drop the blank line?

>  	device_initialize(&devcd->devcd_dev);
>  
>  	dev_set_name(&devcd->devcd_dev, "devcd%d",
>  		     atomic_inc_return(&devcd_count));
>  	devcd->devcd_dev.class = &devcd_class;
>  
> +	mutex_lock(&devcd->mutex);

Why lock this here?

> +	devcd->del_wk_queued = false;

This was already set to false above, right?  And if you want to
explicitly initialize it, do it where the other variables are
initialized up by mutex_init() please.

thanks,

greg k-h
