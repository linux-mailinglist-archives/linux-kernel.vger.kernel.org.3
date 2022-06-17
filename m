Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C854F919
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382731AbiFQOXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382720AbiFQOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:23:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A65C1D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:23:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso4738471pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RTRTndzcqGpDv1J2yjv0wl7rfjMqIl0ecAShZDEtx0E=;
        b=gDGVloWlIjR4peMDoBY3afbeVzNYW+UIy79mYC21BRxebHIepgX/IQLcSnaZPQUVpi
         CIRYPh1MMgm6Z4ComYznMCRiNrX50Tr/lndX489J2lCPjaioHMQq9itvFx0WGg6hY0ns
         xRT4Q9TkwMsiCisjNABb0uQUpuQFkksCUsNFVLKB+i48dhvZOKbrb//S8sY8E+AMKvpK
         5mAHxwolMqtv/neOBL30FkATA5WjjBjhSuiqQXbiURZsPjf5UvuRJjbBZs4wwsJg3xk4
         zAuS5NFfc4M9So18A/OGaSUewhxta+/kiIlryuYB+IhjHouvo0tleQCaCF4SWnEgP2Po
         bJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RTRTndzcqGpDv1J2yjv0wl7rfjMqIl0ecAShZDEtx0E=;
        b=UOLS+OLdJ5z1N3+yFOZj3q/ffeQc8qWIGEOM+EU1IkEBPFVcL/PtVk2X98zhKQhpsj
         KfzZTpTPcy0iWfw4SPv9ruBGBNvOtFjHBIeze7ONrLqJfgwKhIr3WannBZjfmKuEUbK8
         v0dlUlAUWWpZGotTvcpM0jPTR8F/NGMEqAS8rcKuWQmP8y5bj0fFQn9QC5vDQ003+wOC
         R5dLHIcxrnNePWCb+TTPUG34PWfhC7vnnnd3kk6lmT3FbesgDy9c8YPqiAycpZXeGOMy
         5VJnqxw5+wK8m3t4VrNLS2SIj3jFLPXPyoG7FP+iQNe6CZcWH95b39iTJvCRz+ipwg+W
         /B3w==
X-Gm-Message-State: AJIora9BX2TfjR2sDa+qruK9wzaEaavkMfITLPehVbSgePqpYJ78IF7f
        ePT+hJ6v9D1sypnkXTe9fqYh2w==
X-Google-Smtp-Source: AGRyM1u52ygM1NLKLxebtqnme5o4tf+SilzwuDSISYq1Mvj6ktsh8a3pJs2zK6JqnSwz0RW/nWKTxQ==
X-Received: by 2002:a17:90b:3591:b0:1e3:25d3:e78e with SMTP id mm17-20020a17090b359100b001e325d3e78emr10980375pjb.29.1655475799436;
        Fri, 17 Jun 2022 07:23:19 -0700 (PDT)
Received: from [10.184.0.6] ([199.101.192.133])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b001635a8f9dfdsm3750629plg.26.2022.06.17.07.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 07:23:19 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Yang Shen <shenyang39@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-accelerators@lists.ozlabs.org
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica> <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica> <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <53b9acef-ad32-d0aa-fa1b-a7cb77a0d088@linaro.org>
Message-ID: <1fab1f9a-5c6c-8190-829b-4bacf15eb306@linaro.org>
Date:   Fri, 17 Jun 2022 22:23:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <53b9acef-ad32-d0aa-fa1b-a7cb77a0d088@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/17 下午4:20, Zhangfei Gao wrote:
>
>
> On 2022/6/17 下午2:05, Zhangfei Gao wrote:
>>
>>
>> On 2022/6/16 下午4:14, Jean-Philippe Brucker wrote:
>>> On Thu, Jun 16, 2022 at 12:10:18PM +0800, Zhangfei Gao wrote:
>>>>>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>>>>>> index 281c54003edc..b6219c6bfb48 100644
>>>>>> --- a/drivers/misc/uacce/uacce.c
>>>>>> +++ b/drivers/misc/uacce/uacce.c
>>>>>> @@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode 
>>>>>> *inode, struct file *filep)
>>>>>>        if (!q)
>>>>>>            return -ENOMEM;
>>>>>> +    mutex_lock(&uacce->queues_lock);
>>>>>> +
>>>>>> +    if (!uacce->parent->driver) {
>>>>> I don't think this is useful, because the core clears 
>>>>> parent->driver after
>>>>> having run uacce_remove():
>>>>>
>>>>>     rmmod hisi_zip        open()
>>>>>      ...                 uacce_fops_open()
>>>>>      __device_release_driver()      ...
>>>>>       pci_device_remove()
>>>>>        hisi_zip_remove()
>>>>>         hisi_qm_uninit()
>>>>>          uacce_remove()
>>>>>           ...              ...
>>>>>                        mutex_lock(uacce->queues_lock)
>>>>>       ...                  if (!uacce->parent->driver)
>>>>>       device_unbind_cleanup()      /* driver still valid, proceed */
>>>>>        dev->driver = NULL
>>>> The check  if (!uacce->parent->driver) is required, otherwise NULL 
>>>> pointer
>>>> may happen.
>>> I agree we need something, what I mean is that this check is not
>>> sufficient.
>>>
>>>> iommu_sva_bind_device
>>>> const struct iommu_ops *ops = dev_iommu_ops(dev);  ->
>>>> dev->iommu->iommu_dev->ops
>>>>
>>>> rmmod has no issue, but remove parent pci device has the issue.
>>> Ah right, relying on the return value of bind() wouldn't be enough 
>>> even if
>>> we mandated SVA.
>>>
>>> [...]
>>>>> I think we need the global uacce_mutex to serialize uacce_remove() 
>>>>> and
>>>>> uacce_fops_open(). uacce_remove() would do everything, including
>>>>> xa_erase(), while holding that mutex. And uacce_fops_open() would 
>>>>> try to
>>>>> obtain the uacce object from the xarray while holding the mutex, 
>>>>> which
>>>>> fails if the uacce object is being removed.
>>>> Since fops_open get char device refcount, uacce_release will not 
>>>> happen
>>>> until open returns.
>>> The refcount only ensures that the uacce_device object is not freed as
>>> long as there are open fds. But uacce_remove() can run while there are
>>> open fds, or fds in the process of being opened. And atfer 
>>> uacce_remove()
>>> runs, the uacce_device object still exists but is mostly unusable. For
>>> example once the module is freed, uacce->ops is not valid anymore. But
>>> currently uacce_fops_open() may dereference the ops in this case:
>>>
>>>     uacce_fops_open()
>>>      if (!uacce->parent->driver)
>>>      /* Still valid, keep going */
>>>      ...                    rmmod
>>>                          uacce_remove()
>>>      ...                     free_module()
>>>      uacce->ops->get_queue() /* BUG */
>>
>> uacce_remove should wait for uacce->queues_lock, until fops_open 
>> release the lock.
>> If open happen just after the uacce_remove: unlock, uacce_bind_queue 
>> in open should fail.
>>
>>> Accessing uacce->ops after free_module() is a use-after-free. We 
>>> need all
>> you men parent release the resources.
>>> the fops to synchronize with uacce_remove() to ensure they don't use 
>>> any
>>> resource of the parent after it's been freed.
>> After fops_open, currently we are counting on parent driver stop all 
>> dma first, then call uacce_remove, which is assumption.
>> Like drivers/crypto/hisilicon/zip/zip_main.c: 
>> hisi_qm_wait_task_finish, which will wait uacce_release.
>> If comments this , there may other issue,
>> Unable to handle kernel paging request at virtual address 
>> ffff80000b700204
>> pc : hisi_qm_cache_wb.part.0+0x2c/0xa0
>>
>>> I see uacce_fops_poll() may have the same problem, and should be inside
>>> uacce_mutex.
>> Do we need consider this, uacce_remove can happen anytime but not 
>> waiting dma stop?
>>
>> Not sure uacce_mutex can do this.
>> Currently the sequence is
>> mutex_lock(&uacce->queues_lock);
>> mutex_lock(&uacce_mutex);
>>
>> Or we set all the callbacks of uacce_ops to NULL?
> How about in uacce_remove
> mutex_lock(&uacce_mutex);
> uacce->ops = NULL;
> mutex_unlock(&uacce_mutex);
>
> And check uacce->ops  first when using.
>

Diff like this, will merge together.

  drivers/misc/uacce/uacce.c | 65 ++++++++++++++++++++++++++++++++------
  1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index b6219c6bfb48..311192728132 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -23,6 +23,11 @@ static int uacce_start_queue(struct uacce_queue *q)
          goto out_with_lock;
      }

+    if (!q->uacce->ops) {
+        ret = -EINVAL;
+        goto out_with_lock;
+    }
+
      if (q->uacce->ops->start_queue) {
          ret = q->uacce->ops->start_queue(q);
          if (ret < 0)
@@ -46,6 +51,9 @@ static int uacce_put_queue(struct uacce_queue *q)
      if (q->state == UACCE_Q_ZOMBIE)
          goto out;

+    if (!uacce->ops)
+        goto out;
+
      if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
          uacce->ops->stop_queue(q);

@@ -65,6 +73,7 @@ static long uacce_fops_unl_ioctl(struct file *filep,
  {
      struct uacce_queue *q = filep->private_data;
      struct uacce_device *uacce = q->uacce;
+    long ret;

      switch (cmd) {
      case UACCE_CMD_START_Q:
@@ -74,10 +83,17 @@ static long uacce_fops_unl_ioctl(struct file *filep,
          return uacce_put_queue(q);

      default:
-        if (!uacce->ops->ioctl)
-            return -EINVAL;
+        mutex_lock(&uacce_mutex);
+
+        if (!uacce->ops || !uacce->ops->ioctl) {
+            ret = -EINVAL;
+            goto out_with_lock;
+        }

-        return uacce->ops->ioctl(q, cmd, arg);
+        ret = uacce->ops->ioctl(q, cmd, arg);
+out_with_lock:
+        mutex_unlock(&uacce_mutex);
+        return ret;
      }
  }

@@ -138,10 +154,13 @@ static int uacce_fops_open(struct inode *inode, 
struct file *filep)

      mutex_lock(&uacce->queues_lock);

-    if (!uacce->parent->driver) {
+    mutex_lock(&uacce_mutex);
+    if (!uacce->parent || !uacce->ops) {
+        mutex_unlock(&uacce_mutex);
          ret = -ENODEV;
          goto out_with_lock;
      }
+    mutex_unlock(&uacce_mutex);

      ret = uacce_bind_queue(uacce, q);
      if (ret)
@@ -226,6 +245,11 @@ static int uacce_fops_mmap(struct file *filep, 
struct vm_area_struct *vma)

      mutex_lock(&uacce_mutex);

+    if (!uacce->ops) {
+        ret = -EINVAL;
+        goto out_with_lock;
+    }
+
      if (q->state != UACCE_Q_INIT && q->state != UACCE_Q_STARTED) {
          ret = -EINVAL;
          goto out_with_lock;
@@ -271,9 +295,18 @@ static __poll_t uacce_fops_poll(struct file *file, 
poll_table *wait)
      struct uacce_device *uacce = q->uacce;

      poll_wait(file, &q->wait, wait);
-    if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
+
+    mutex_lock(&uacce_mutex);
+    if (!uacce->ops)
+        goto out_with_lock;
+
+    if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q)) {
+        mutex_unlock(&uacce_mutex);
          return EPOLLIN | EPOLLRDNORM;
+    }

+out_with_lock:
+    mutex_unlock(&uacce_mutex);
      return 0;
  }

@@ -312,12 +345,20 @@ static ssize_t available_instances_show(struct 
device *dev,
                      char *buf)
  {
      struct uacce_device *uacce = to_uacce_device(dev);
+    ssize_t ret;

-    if (!uacce->ops->get_available_instances)
-        return -ENODEV;
+    mutex_lock(&uacce_mutex);
+    if (!uacce->ops || !uacce->ops->get_available_instances) {
+        ret = -ENODEV;
+        goto out_with_lock;
+    }
+
+    ret = sysfs_emit(buf, "%d\n",
+             uacce->ops->get_available_instances(uacce));

-    return sysfs_emit(buf, "%d\n",
-               uacce->ops->get_available_instances(uacce));
+out_with_lock:
+    mutex_unlock(&uacce_mutex);
+    return ret;
  }

  static ssize_t algorithms_show(struct device *dev,
@@ -523,6 +564,12 @@ void uacce_remove(struct uacce_device *uacce)

      /* disable sva now since no opened queues */
      uacce_disable_sva(uacce);
+
+    mutex_lock(&uacce_mutex);
+    uacce->parent = NULL;
+    uacce->ops = NULL;
+    mutex_unlock(&uacce_mutex);
+
      mutex_unlock(&uacce->queues_lock);

      if (uacce->cdev)
-- 
2.25.1

