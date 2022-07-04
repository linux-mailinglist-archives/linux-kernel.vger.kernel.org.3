Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37D56563F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGDM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiGDM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 642BB6435
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656939363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Q2W9IhoLr9hA8yfbyW7WYSxnxRt8vpH+vp3WlOn7Yo=;
        b=Q81hTU3kcgBh81MKxvQDJpOGHrjafR/UKCeP4Sxx+QGL4lwHaVOvTu8Bp1KeQwwZQaHEaG
        ovjNm3PxXZAUZjq0LLDyRBcO/KgPdS9coFDoDGBEP5NzLE8BjE9ZvPhJ2h27ROhP7BEZhA
        rhfZ+FS/DxYny8ejcyolRfrHxoIo5Ho=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-xaDTCbcoOeCm5MlDvEdPXg-1; Mon, 04 Jul 2022 08:55:56 -0400
X-MC-Unique: xaDTCbcoOeCm5MlDvEdPXg-1
Received: by mail-wm1-f71.google.com with SMTP id n35-20020a05600c3ba300b003a02d7bd5caso5320280wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0Q2W9IhoLr9hA8yfbyW7WYSxnxRt8vpH+vp3WlOn7Yo=;
        b=CU9ATAUYSETj9BrP8dlNrDYjkzWnn/YXDknCcbaZM24km+5n8vL+DhDm1sAwKeLOWz
         mSR51H4OtMYnOREXA3B1XOJII4STx8OcEWhjMuDVC1rjN2Rap6/yzIaIFb1dwqDEkgHk
         wUleNrQg5iNjjJB8oyMv/DHH9Zxbevil6DAkKpkaiQMHWvYDNAIJB9lavbqeSERE98/x
         iASgRPD4fZDYNXDiLRKqdu3NxRaVDmc2H+2mST9H2ST2dtGaKj2AtMqSu1SrGPGbzeJu
         mIro/a05wt4WU8n/Tb8VSucAFyYhQeS6Mtkf6yZkbtWZMvGFXu9O+vrZiZHeIXn3azvD
         yPuA==
X-Gm-Message-State: AJIora9kWWHmFMwmSXE4ozlOM1pIZfu6NVUjUsXK4khkGZV8fTfi5aMM
        zrcAqytJ66FXRzdwcYfQQO0hydB/Wmv1ge4Fj+9sT/MjdYc2P/yc/VPVTo9YFH1wj7gJXrp6JFH
        nmQcDrUqW4ltrJ2yIkiY3O6Sz
X-Received: by 2002:a5d:5747:0:b0:21d:65e9:be07 with SMTP id q7-20020a5d5747000000b0021d65e9be07mr7784954wrw.215.1656939355383;
        Mon, 04 Jul 2022 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/qb1+a8BQ8V/JawOxW6gJmON61Dt6yYdpZnDA/WObkCU3CFPzyZovOG91Wp1Ays5SJ10Fuw==
X-Received: by 2002:a5d:5747:0:b0:21d:65e9:be07 with SMTP id q7-20020a5d5747000000b0021d65e9be07mr7784929wrw.215.1656939355116;
        Mon, 04 Jul 2022 05:55:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q13-20020adff50d000000b0021d64a11727sm5235633wro.49.2022.07.04.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:55:54 -0700 (PDT)
Message-ID: <83fa378f-b331-0cb7-5878-d4d23a543b18@redhat.com>
Date:   Mon, 4 Jul 2022 14:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] drm: Prevent drm_copy_field() to attempt copying a
 NULL pointer
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>
References: <20220701120755.2135100-1-javierm@redhat.com>
 <20220701120755.2135100-3-javierm@redhat.com>
 <b90d5ae5-8629-8be8-6390-f22f97ec4f5e@suse.de>
 <8e783b8c-e7b9-3d8e-e80d-2f2608421293@redhat.com>
In-Reply-To: <8e783b8c-e7b9-3d8e-e80d-2f2608421293@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 14:36, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> Thanks for your feedback.
> 

[snip]

>>> +	/* don't attempt to copy a NULL pointer */
>>> +	if (WARN_ONCE(!value, "BUG: the value to copy was not set!"))
>>> +		return -EINVAL;
>>> +
>>
>> We usually assume that the caller passes the correct arguments. This is 
>> different for no reasons. I'd rather not take this patch unless there's 
>> a security implication to the ioctl interface (e.g., leaking information 
>> because of this NULL ptr).
>>
> 
> This can lead from an oops (soft panic) to a kernel crash for a buggy driver.
> 
> I see from where you are coming from but then I think we should sanitize the
> filled struct drm_driver fields in drm_dev_register() and make it fail early.
> 
> Would you agree with such a patch? But what I think that we shouldn't allow
> is to attempt copying a NULL pointer, if we can easily prevent it.
>

I mean something like the following patch (didn't add a commit message
for brevity):

From 4c13400c54e0e29918a8eb248013f54cd2660f4f Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 4 Jul 2022 14:53:48 +0200
Subject: [PATCH] drm: Check in drm_dev_register() that required DRM driver
 fields were set

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/drm_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..d4eebaf37e23 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -842,6 +842,12 @@ static void remove_compat_control_link(struct drm_device *dev)
 	kfree(name);
 }
 
+static inline bool check_drm_driver_fields(const struct drm_driver *driver)
+{
+	/* required since are copied to user-space by DRM_IOCTL_VERSION */
+	return driver->name && driver->date && driver->desc;
+}
+
 /**
  * drm_dev_register - Register DRM device
  * @dev: Device to register
@@ -865,7 +871,11 @@ static void remove_compat_control_link(struct drm_device *dev)
 int drm_dev_register(struct drm_device *dev, unsigned long flags)
 {
 	const struct drm_driver *driver = dev->driver;
-	int ret;
+	int ret = -EINVAL;
+
+	if (drm_WARN(dev, !check_drm_driver_fields(driver),
+		     "Required DRM drivers fields not set.\n"))
+			goto out_err;
 
 	if (!driver->load)
 		drm_mode_config_validate(dev);
@@ -913,6 +923,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 out_unlock:
 	if (drm_dev_needs_global_mutex(dev))
 		mutex_unlock(&drm_global_mutex);
+out_err:
 	return ret;
 }
 EXPORT_SYMBOL(drm_dev_register);
-- 
2.36.1

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

