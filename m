Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D450B49E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446399AbiDVKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387553AbiDVKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:06:10 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A01541A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650621798; x=1682157798;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yf2qmsRUOFBdIveTbGFM5oYjvAQrEDph/yXgsf+vBRc=;
  b=CTs8tZJ/2M+zEBX0H5qyt3Kp0ayxJuy2F+otgdp3TUhLaO8JvtHob8R5
   Rs4EZMRqdPKoEDMbIaVntFeJOzes4Z4I2ycMOLdXSXEJzf/9lnHWfIw23
   vxezMlg+yOFJlnbyTuzx+nKAMAmFIc3GZ7XejCK/ttV/KWgG+JKkVwQvC
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2022 03:03:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 03:03:17 -0700
Received: from [10.110.71.240] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 03:03:14 -0700
Message-ID: <11ff242b-195c-de75-d3d2-3e7b17a2ef3c@quicinc.com>
Date:   Fri, 22 Apr 2022 15:33:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] devcoredump : Serialize devcd_del work
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <tglx@linutronix.de>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <johannes@sipsolutions.net>
References: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Request you all the review comments on the fix of the described problem?

-Mukesh


On 4/19/2022 3:57 PM, Mukesh Ojha wrote:
> In following scenario(diagram), when one thread X running dev_coredumpm() adds devcd
> device to the framework which sends uevent notification to userspace
> and another thread Y reads this uevent and call to devcd_data_write()
> which eventually try to delete the queued timer that is not initialized/queued yet.
> 
> So, debug object reports some warning and in the meantime, timer is initialized
> and queued from X path. and from Y path, it gets reinitialized again and
> timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> 
> To fix this, introduce mutex to serialize the behaviour.
> 
>   	cpu0(X)			                      cpu1(Y)
> 
>      dev_coredump() uevent sent to userspace
>      device_add()  =========================> userspace process Y reads the uevents
>                                               writes to devcd fd which
>                                               results into writes to
> 
>                                              devcd_data_write()
>                                                mod_delayed_work()
>                                                  try_to_grab_pending()
>                                                    del_timer()
>                                                      debug_assert_init()
>     INIT_DELAYED_WORK
>     schedule_delayed_work
>                                                       debug_object_fixup()
>                                                        timer_fixup_assert_init()
>                                                         timer_setup()
>                                                           do_init_timer()   ==> reinitialized the
>                                                                                   timer to
>                                                                                   timer->entry.pprev=NULL
> 
>                                                    timer_pending()
>                                                     !hlist_unhashed_lockless(&timer->entry)
>                                                       !h->pprev  ==> del_timer checks
>                                                                    and finds it to be NULL
>   								  try_to_grab_pending() stucks.
> 
> Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/base/devcoredump.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f4d794d..316f566 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -25,6 +25,7 @@ struct devcd_entry {
>   	struct device devcd_dev;
>   	void *data;
>   	size_t datalen;
> +	struct mutex mutex;
>   	struct module *owner;
>   	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>   			void *data, size_t datalen);
> @@ -84,7 +85,9 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct devcd_entry *devcd = dev_to_devcd(dev);
>   
> +	mutex_lock(&devcd->mutex);
>   	mod_delayed_work(system_wq, &devcd->del_wk, 0);
> +	mutex_unlock(&devcd->mutex);
>   
>   	return count;
>   }
> @@ -112,7 +115,9 @@ static int devcd_free(struct device *dev, void *data)
>   {
>   	struct devcd_entry *devcd = dev_to_devcd(dev);
>   
> +	mutex_lock(&devcd->mutex);
>   	flush_delayed_work(&devcd->del_wk);
> +	mutex_unlock(&devcd->mutex);
>   	return 0;
>   }
>   
> @@ -278,13 +283,14 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   	devcd->read = read;
>   	devcd->free = free;
>   	devcd->failing_dev = get_device(dev);
> -
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
> @@ -301,10 +307,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
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
