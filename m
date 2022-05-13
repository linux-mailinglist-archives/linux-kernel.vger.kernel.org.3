Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0309526367
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiEMOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiEMOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:04:06 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B598369D2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652450644; x=1683986644;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IV4iYGo7pIxZHj+iT+8akiALKJwO+kZUW0gEutIT5x0=;
  b=RqXVIC/6m50q4XtXxaPlNCxBqbyd8hxHfECXIYABB/nazsA7aXvZ9xT1
   ZnHydgXvvepitKkKMSsa7nzAwS+1Hv+5ab/9+0yUyvdDRuG8qtLIAt8Iv
   wQe333UZNQWui6/qQsLoP+NnW3Trk+qSh8s3hIIpGGRlfuGdFGlaavDVj
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 13 May 2022 07:04:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 07:04:03 -0700
Received: from [10.216.62.117] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 07:04:00 -0700
Message-ID: <f251bc8f-7e72-cfd9-5eca-179c91880a1a@quicinc.com>
Date:   Fri, 13 May 2022 19:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND PATCH v4] devcoredump : Serialize devcd_del work
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <rafael@kernel.org>,
        <johannes@sipsolutions.net>, <keescook@chromium.org>
References: <1651558074-9620-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1651558074-9620-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder!

Thanks,
-Mukesh
On 5/3/2022 11:37 AM, Mukesh Ojha wrote:
> In following scenario(diagram), when one thread X running dev_coredumpm()
> adds devcd device to the framework which sends uevent notification to
> userspace and another thread Y reads this uevent and call to
> devcd_data_write() which eventually try to delete the queued timer that
> is not initialized/queued yet.
> 
> So, debug object reports some warning and in the meantime, timer is
> initialized and queued from X path. and from Y path, it gets reinitialized
> again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> 
> To fix this, introduce mutex and a boolean flag to serialize the behaviour.
> 
>   	cpu0(X)			                cpu1(Y)
> 
>      dev_coredump() uevent sent to user space
>      device_add()  ======================> user space process Y reads the
>                                            uevents writes to devcd fd
>                                            which results into writes to
> 
>                                           devcd_data_write()
>                                             mod_delayed_work()
>                                               try_to_grab_pending()
>                                                 del_timer()
>                                                   debug_assert_init()
>     INIT_DELAYED_WORK()
>     schedule_delayed_work()
>                                                     debug_object_fixup()
>                                                       timer_fixup_assert_init()
>                                                         timer_setup()
>                                                           do_init_timer()
>                                                         /*
>                                                          Above call reinitializes
>                                                          the timer to
>                                                          timer->entry.pprev=NULL
>                                                          and this will be checked
>                                                          later in timer_pending() call.
>                                                         */
>                                                   timer_pending()
>                                                    !hlist_unhashed_lockless(&timer->entry)
>                                                      !h->pprev
>                                                  /*
>                                                    del_timer() checks h->pprev and finds
>                                                    it to be NULL due to which
>                                                    try_to_grab_pending() stucks.
>                                                  */
> 
> Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> v3->v4:
>   - flg variable renamed to delete_work.
> 
> v2->v3:
>   Addressed comments from gregkh
>   - Wrapped the commit text and corrected the alignment.
>   - Described the reason to introduce new variables.
>   - Restored the blank line.
>   - rename the del_wk_queued to flg.
>   Addressed comments from tglx
>   - Added a comment which explains the race which looks obvious however
>     would not occur between disabled_store and devcd_del work.
> 
> 
> v1->v2:
>   - Added del_wk_queued flag to serialize the race between devcd_data_write()
>     and disabled_store() => devcd_free().
>   drivers/base/devcoredump.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f4d794d..1c06781 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -25,6 +25,47 @@ struct devcd_entry {
>   	struct device devcd_dev;
>   	void *data;
>   	size_t datalen;
> +	/*
> +	 * Here, mutex is required to serialize the calls to del_wk work between
> +	 * user/kernel space which happens when devcd is added with device_add()
> +	 * and that sends uevent to user space. User space reads the uevents,
> +	 * and calls to devcd_data_write() which try to modify the work which is
> +	 * not even initialized/queued from devcoredump.
> +	 *
> +	 *
> +	 *
> +	 *        cpu0(X)                                 cpu1(Y)
> +	 *
> +	 *        dev_coredump() uevent sent to user space
> +	 *        device_add()  ======================> user space process Y reads the
> +	 *                                              uevents writes to devcd fd
> +	 *                                              which results into writes to
> +	 *
> +	 *                                             devcd_data_write()
> +	 *                                               mod_delayed_work()
> +	 *                                                 try_to_grab_pending()
> +	 *                                                   del_timer()
> +	 *                                                     debug_assert_init()
> +	 *       INIT_DELAYED_WORK()
> +	 *       schedule_delayed_work()
> +	 *
> +	 *
> +	 * Also, mutex alone would not be enough to avoid scheduling of
> +	 * del_wk work after it get flush from a call to devcd_free()
> +	 * mentioned as below.
> +	 *
> +	 *	disabled_store()
> +	 *        devcd_free()
> +	 *          mutex_lock()             devcd_data_write()
> +	 *          flush_delayed_work()
> +	 *          mutex_unlock()
> +	 *                                   mutex_lock()
> +	 *                                   mod_delayed_work()
> +	 *                                   mutex_unlock()
> +	 * So, delete_work flag is required.
> +	 */
> +	struct mutex mutex;
> +	bool delete_work;
>   	struct module *owner;
>   	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>   			void *data, size_t datalen);
> @@ -84,7 +125,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct devcd_entry *devcd = dev_to_devcd(dev);
>   
> -	mod_delayed_work(system_wq, &devcd->del_wk, 0);
> +	mutex_lock(&devcd->mutex);
> +	if (!devcd->delete_work) {
> +		devcd->delete_work = true;
> +		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> +	}
> +	mutex_unlock(&devcd->mutex);
>   
>   	return count;
>   }
> @@ -112,7 +158,12 @@ static int devcd_free(struct device *dev, void *data)
>   {
>   	struct devcd_entry *devcd = dev_to_devcd(dev);
>   
> +	mutex_lock(&devcd->mutex);
> +	if (!devcd->delete_work)
> +		devcd->delete_work = true;
> +
>   	flush_delayed_work(&devcd->del_wk);
> +	mutex_unlock(&devcd->mutex);
>   	return 0;
>   }
>   
> @@ -122,6 +173,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
>   	return sysfs_emit(buf, "%d\n", devcd_disabled);
>   }
>   
> +/*
> + *
> + *	disabled_store()                                	worker()
> + *	 class_for_each_device(&devcd_class,
> + *		NULL, NULL, devcd_free)
> + *         ...
> + *         ...
> + *	   while ((dev = class_dev_iter_next(&iter))
> + *                                                             devcd_del()
> + *                                                               device_del()
> + *                                                                 put_device() <- last reference
> + *             error = fn(dev, data)                           devcd_dev_release()
> + *             devcd_free(dev, data)                           kfree(devcd)
> + *             mutex_lock(&devcd->mutex);
> + *
> + *
> + * In the above diagram, It looks like disabled_store() would be racing with parallely
> + * running devcd_del() and result in memory abort while acquiring devcd->mutex which
> + * is called after kfree of devcd memory  after dropping its last reference with
> + * put_device(). However, this will not happens as fn(dev, data) runs
> + * with its own reference to device via klist_node so it is not its last reference.
> + * so, above situation would not occur.
> + */
> +
>   static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
>   			      const char *buf, size_t count)
>   {
> @@ -278,13 +353,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   	devcd->read = read;
>   	devcd->free = free;
>   	devcd->failing_dev = get_device(dev);
> +	devcd->delete_work = false;
>   
> +	mutex_init(&devcd->mutex);
>   	device_initialize(&devcd->devcd_dev);
>   
>   	dev_set_name(&devcd->devcd_dev, "devcd%d",
>   		     atomic_inc_return(&devcd_count));
>   	devcd->devcd_dev.class = &devcd_class;
>   
> +	mutex_lock(&devcd->mutex);
>   	if (device_add(&devcd->devcd_dev))
>   		goto put_device;
>   
> @@ -301,10 +379,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   
>   	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>   	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> -
> +	mutex_unlock(&devcd->mutex);
>   	return;
>    put_device:
>   	put_device(&devcd->devcd_dev);
> +	mutex_unlock(&devcd->mutex);
>    put_module:
>   	module_put(owner);
>    free:
