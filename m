Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200C59F41A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiHXHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiHXHWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:22:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A73ECC5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:22:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O0pj9F030233;
        Wed, 24 Aug 2022 07:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KSkKskx476wX/mQ0qnU3htu00dyK2uBbynZNIrL/6lk=;
 b=cxMN9BiOJs1uAcZi9Deo3r7olQmTOOs5kfqKbjWja5pwoZS55yuQLSLkoZIAvlsEFCVX
 KJ80D7CXrPjUZ4VmhnDvaT6qIYWpFUO3BBKOAf6MZJYMzvfs1nFzPlF/wezZUPTm5lS0
 mNX5ZY48AsSDMkKCNVnjzRAwE51gH0jGFxg4cS9kcOCrZQ0h0aTeTSRd1DoVw9MZepx7
 +zwGUvUX90qay6OlWyMLmSqpvyLoYhr77XubIgOoSJIUBv76l7xAU2FqtDkxRqssKS5H
 QZvwniryLYSj5w34XAPRHwbLhNwg+fdKcFxjuFHsYgrVqccqODlVLDYVqNwVQFcvU56J MQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pjjguh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 07:22:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27O7MJKd018186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 07:22:19 GMT
Received: from [10.216.22.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 00:22:14 -0700
Message-ID: <eca45e44-f93d-84db-8741-f0ca41d0b556@quicinc.com>
Date:   Wed, 24 Aug 2022 12:52:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5] devcoredump : Serialize devcd_del work
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1653660220-19197-1-git-send-email-quic_mojha@quicinc.com>
 <425df8db-d358-c1d7-820c-fc0485aa2721@quicinc.com>
 <202208161322.B842DFC4E@keescook>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <202208161322.B842DFC4E@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P9T6nlT_lQAAGG3kX4CY5PYw-aq-nEUy
X-Proofpoint-GUID: P9T6nlT_lQAAGG3kX4CY5PYw-aq-nEUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/2022 1:53 AM, Kees Cook wrote:
> On Thu, Aug 11, 2022 at 09:43:48PM +0530, Mukesh Ojha wrote:
>> Hi Johannes/Kees,
> 
> Hi!
> 
>>
>> Sorry for reminding on it again.
>> Any hope of this one to get into devcoredump ?
> 
> I don't know this code well enough to comment on the solution, but it
> seems designed and justified correctly, at least. :)

Thanks Kees for the reply.

Hi @Johannes,

This patch is running in our internal build from a very long time and it 
did not show any regression.
Would like to get your ack on it ?

-Mukesh
> 
> I'll leave it to Johannes for review.
> 
> -Kees
> 
>>
>> -Mukesh
>>
>>
>> On 5/27/2022 7:33 PM, Mukesh Ojha wrote:
>>> In following scenario(diagram), when one thread X running dev_coredumpm()
>>> adds devcd device to the framework which sends uevent notification to
>>> userspace and another thread Y reads this uevent and call to
>>> devcd_data_write() which eventually try to delete the queued timer that
>>> is not initialized/queued yet.
>>>
>>> So, debug object reports some warning and in the meantime, timer is
>>> initialized and queued from X path. and from Y path, it gets reinitialized
>>> again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.
>>>
>>> To fix this, introduce mutex and a boolean flag to serialize the behaviour.
>>>
>>>    	cpu0(X)			                cpu1(Y)
>>>
>>>       dev_coredump() uevent sent to user space
>>>       device_add()  ======================> user space process Y reads the
>>>                                             uevents writes to devcd fd
>>>                                             which results into writes to
>>>
>>>                                            devcd_data_write()
>>>                                              mod_delayed_work()
>>>                                                try_to_grab_pending()
>>>                                                  del_timer()
>>>                                                    debug_assert_init()
>>>      INIT_DELAYED_WORK()
>>>      schedule_delayed_work()
>>>                                                      debug_object_fixup()
>>>                                                        timer_fixup_assert_init()
>>>                                                          timer_setup()
>>>                                                            do_init_timer()
>>>                                                          /*
>>>                                                           Above call reinitializes
>>>                                                           the timer to
>>>                                                           timer->entry.pprev=NULL
>>>                                                           and this will be checked
>>>                                                           later in timer_pending() call.
>>>                                                          */
>>>                                                    timer_pending()
>>>                                                     !hlist_unhashed_lockless(&timer->entry)
>>>                                                       !h->pprev
>>>                                                   /*
>>>                                                     del_timer() checks h->pprev and finds
>>>                                                     it to be NULL due to which
>>>                                                     try_to_grab_pending() stucks.
>>>                                                   */
>>>
>>> Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>> v4->v5:
>>>    - Rebased it.
>>>
>>> v3->v4:
>>>    - flg variable renamed to delete_work.
>>>
>>> v2->v3:
>>>    Addressed comments from gregkh
>>>    - Wrapped the commit text and corrected the alignment.
>>>    - Described the reason to introduce new variables.
>>>    - Restored the blank line.
>>>    - rename the del_wk_queued to flg.
>>>    Addressed comments from tglx
>>>    - Added a comment which explains the race which looks obvious however
>>>      would not occur between disabled_store and devcd_del work.
>>>
>>>
>>> v1->v2:
>>>    - Added del_wk_queued flag to serialize the race between devcd_data_write()
>>>      and disabled_store() => devcd_free().
>>>    drivers/base/devcoredump.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 81 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
>>> index f4d794d..1c06781 100644
>>> --- a/drivers/base/devcoredump.c
>>> +++ b/drivers/base/devcoredump.c
>>> @@ -25,6 +25,47 @@ struct devcd_entry {
>>>    	struct device devcd_dev;
>>>    	void *data;
>>>    	size_t datalen;
>>> +	/*
>>> +	 * Here, mutex is required to serialize the calls to del_wk work between
>>> +	 * user/kernel space which happens when devcd is added with device_add()
>>> +	 * and that sends uevent to user space. User space reads the uevents,
>>> +	 * and calls to devcd_data_write() which try to modify the work which is
>>> +	 * not even initialized/queued from devcoredump.
>>> +	 *
>>> +	 *
>>> +	 *
>>> +	 *        cpu0(X)                                 cpu1(Y)
>>> +	 *
>>> +	 *        dev_coredump() uevent sent to user space
>>> +	 *        device_add()  ======================> user space process Y reads the
>>> +	 *                                              uevents writes to devcd fd
>>> +	 *                                              which results into writes to
>>> +	 *
>>> +	 *                                             devcd_data_write()
>>> +	 *                                               mod_delayed_work()
>>> +	 *                                                 try_to_grab_pending()
>>> +	 *                                                   del_timer()
>>> +	 *                                                     debug_assert_init()
>>> +	 *       INIT_DELAYED_WORK()
>>> +	 *       schedule_delayed_work()
>>> +	 *
>>> +	 *
>>> +	 * Also, mutex alone would not be enough to avoid scheduling of
>>> +	 * del_wk work after it get flush from a call to devcd_free()
>>> +	 * mentioned as below.
>>> +	 *
>>> +	 *	disabled_store()
>>> +	 *        devcd_free()
>>> +	 *          mutex_lock()             devcd_data_write()
>>> +	 *          flush_delayed_work()
>>> +	 *          mutex_unlock()
>>> +	 *                                   mutex_lock()
>>> +	 *                                   mod_delayed_work()
>>> +	 *                                   mutex_unlock()
>>> +	 * So, delete_work flag is required.
>>> +	 */
>>> +	struct mutex mutex;
>>> +	bool delete_work;
>>>    	struct module *owner;
>>>    	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>>>    			void *data, size_t datalen);
>>> @@ -84,7 +125,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
>>>    	struct device *dev = kobj_to_dev(kobj);
>>>    	struct devcd_entry *devcd = dev_to_devcd(dev);
>>> -	mod_delayed_work(system_wq, &devcd->del_wk, 0);
>>> +	mutex_lock(&devcd->mutex);
>>> +	if (!devcd->delete_work) {
>>> +		devcd->delete_work = true;
>>> +		mod_delayed_work(system_wq, &devcd->del_wk, 0);
>>> +	}
>>> +	mutex_unlock(&devcd->mutex);
>>>    	return count;
>>>    }
>>> @@ -112,7 +158,12 @@ static int devcd_free(struct device *dev, void *data)
>>>    {
>>>    	struct devcd_entry *devcd = dev_to_devcd(dev);
>>> +	mutex_lock(&devcd->mutex);
>>> +	if (!devcd->delete_work)
>>> +		devcd->delete_work = true;
>>> +
>>>    	flush_delayed_work(&devcd->del_wk);
>>> +	mutex_unlock(&devcd->mutex);
>>>    	return 0;
>>>    }
>>> @@ -122,6 +173,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
>>>    	return sysfs_emit(buf, "%d\n", devcd_disabled);
>>>    }
>>> +/*
>>> + *
>>> + *	disabled_store()                                	worker()
>>> + *	 class_for_each_device(&devcd_class,
>>> + *		NULL, NULL, devcd_free)
>>> + *         ...
>>> + *         ...
>>> + *	   while ((dev = class_dev_iter_next(&iter))
>>> + *                                                             devcd_del()
>>> + *                                                               device_del()
>>> + *                                                                 put_device() <- last reference
>>> + *             error = fn(dev, data)                           devcd_dev_release()
>>> + *             devcd_free(dev, data)                           kfree(devcd)
>>> + *             mutex_lock(&devcd->mutex);
>>> + *
>>> + *
>>> + * In the above diagram, It looks like disabled_store() would be racing with parallely
>>> + * running devcd_del() and result in memory abort while acquiring devcd->mutex which
>>> + * is called after kfree of devcd memory  after dropping its last reference with
>>> + * put_device(). However, this will not happens as fn(dev, data) runs
>>> + * with its own reference to device via klist_node so it is not its last reference.
>>> + * so, above situation would not occur.
>>> + */
>>> +
>>>    static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
>>>    			      const char *buf, size_t count)
>>>    {
>>> @@ -278,13 +353,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>>>    	devcd->read = read;
>>>    	devcd->free = free;
>>>    	devcd->failing_dev = get_device(dev);
>>> +	devcd->delete_work = false;
>>> +	mutex_init(&devcd->mutex);
>>>    	device_initialize(&devcd->devcd_dev);
>>>    	dev_set_name(&devcd->devcd_dev, "devcd%d",
>>>    		     atomic_inc_return(&devcd_count));
>>>    	devcd->devcd_dev.class = &devcd_class;
>>> +	mutex_lock(&devcd->mutex);
>>>    	if (device_add(&devcd->devcd_dev))
>>>    		goto put_device;
>>> @@ -301,10 +379,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>>>    	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>>>    	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
>>> -
>>> +	mutex_unlock(&devcd->mutex);
>>>    	return;
>>>     put_device:
>>>    	put_device(&devcd->devcd_dev);
>>> +	mutex_unlock(&devcd->mutex);
>>>     put_module:
>>>    	module_put(owner);
>>>     free:
> 
