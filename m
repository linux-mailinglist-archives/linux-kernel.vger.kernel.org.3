Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0156558C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiGDMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGDMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BBD3DFBA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656938200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6XAl/UoRgtIYPlAFa1ES/f21tcJoEgK9+CpVrRA0TdY=;
        b=RUlumiOMh4DfvF2QCCpzhsjBu6y0YTnmj6h/xez+ebl1K1+XoeUPD8QZ9ylzIzPgh8dFC0
        B1g3+vY7ONnhrqTMBO4uaMlm3LLTjRFHHaXKMbwcFtxDPyArxxSFBu33cPJ5WT6fO1GKWC
        vwjUyKE9wvaBl4JAa3J4McdP8gQaViE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-eZCjTGvNPd6dpqAh_wMzog-1; Mon, 04 Jul 2022 08:36:39 -0400
X-MC-Unique: eZCjTGvNPd6dpqAh_wMzog-1
Received: by mail-wm1-f70.google.com with SMTP id p6-20020a05600c358600b003a0483b3c2eso5289183wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6XAl/UoRgtIYPlAFa1ES/f21tcJoEgK9+CpVrRA0TdY=;
        b=3o9/P2sVKSG4G3bB9/7UG03rlCP2dYVl8ia46t1oHjrgVmMnsmh0DKO8p544wKnBF+
         zuYvFk292ufaJ2mIoBYs8qSuMEe4KXwM+sGvbzMf2C9YEzc8W3aUt/vJIlWxICHOwSbO
         6Pwcl37SGsv7vo5GhPwwlWkir6DK1IWT8/DhIrXZEeixH6YiJXaiVlFr+2w8jLCJ2+En
         jqjZgqRze7ATdFjdrl5APrrqXWItqRfMU35r6YoTXnltkVV/FClGuJDMU++jnqz348UY
         OBBYPGF9DM6Ey61UuOFpH7mstCTZCgXfmqMEfzPtVYHx57DgzMu0Dx5bU6eG0/ZUlw4w
         Qh3w==
X-Gm-Message-State: AJIora+V0N7lowGVuOkm7NxCRFJXW5SBzp+JIH7H369yxHWNz+o/LZLZ
        bI01qrBOg2iRhLQalfvUPfT1GxQM9ARC3Qxdn9Am7Eoo0as8zisvE441oOVjnqnY/g7Ix8pNOCf
        u0+9+KiSz823lgla5oaa2kohz
X-Received: by 2002:a5d:5847:0:b0:21b:e465:1e5e with SMTP id i7-20020a5d5847000000b0021be4651e5emr26746662wrf.584.1656938196390;
        Mon, 04 Jul 2022 05:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tXzI1QL2litH0LjbhZGQ+hdOdCGD2OX8GU1PHLFfopf9elskiTdwwj/WUVrodwkHkK/i3IIA==
X-Received: by 2002:a5d:5847:0:b0:21b:e465:1e5e with SMTP id i7-20020a5d5847000000b0021be4651e5emr26746645wrf.584.1656938196153;
        Mon, 04 Jul 2022 05:36:36 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az38-20020a05600c602600b003a0323463absm19478592wmb.45.2022.07.04.05.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:36:35 -0700 (PDT)
Message-ID: <8e783b8c-e7b9-3d8e-e80d-2f2608421293@redhat.com>
Date:   Mon, 4 Jul 2022 14:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] drm: Prevent drm_copy_field() to attempt copying a
 NULL pointer
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>
References: <20220701120755.2135100-1-javierm@redhat.com>
 <20220701120755.2135100-3-javierm@redhat.com>
 <b90d5ae5-8629-8be8-6390-f22f97ec4f5e@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <b90d5ae5-8629-8be8-6390-f22f97ec4f5e@suse.de>
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

Hello Thomas,

Thanks for your feedback.

On 7/4/22 14:30, Thomas Zimmermann wrote:
> Hi
> 
> Am 01.07.22 um 14:07 schrieb Javier Martinez Canillas:
>> The drm_copy_field() helper is used to copy some struct drm_driver fields
>> to userspace through the DRM_IOCTL_VERSION ioctl. But it could be possible
>> that the driver didn't set some of the fields and are instead set to NULL.
>>
>> If that is the case, the drm_copy_field() attempts to copy a NULL pointer:
>>
>> [ +10.395966] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
>> [  +0.010955] Mem abort info:
>> [  +0.002835]   ESR = 0x0000000096000004
>> [  +0.003872]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  +0.005395]   SET = 0, FnV = 0
>> [  +0.003113]   EA = 0, S1PTW = 0
>> [  +0.003182]   FSC = 0x04: level 0 translation fault
>> [  +0.004964] Data abort info:
>> [  +0.002919]   ISV = 0, ISS = 0x00000004
>> [  +0.003886]   CM = 0, WnR = 0
>> [  +0.003040] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000115dad000
>> [  +0.006536] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>> [  +0.006925] Internal error: Oops: 96000004 [#1] SMP
>> ...
>> [  +0.011113] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  +0.007061] pc : __pi_strlen+0x14/0x150
>> [  +0.003895] lr : drm_copy_field+0x30/0x1a4
>> [  +0.004156] sp : ffff8000094b3a50
>> [  +0.003355] x29: ffff8000094b3a50 x28: ffff8000094b3b70 x27: 0000000000000040
>> [  +0.007242] x26: ffff443743c2ba00 x25: 0000000000000000 x24: 0000000000000040
>> [  +0.007243] x23: ffff443743c2ba00 x22: ffff8000094b3b70 x21: 0000000000000000
>> [  +0.007241] x20: 0000000000000000 x19: ffff8000094b3b90 x18: 0000000000000000
>> [  +0.007241] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab14b9af40
>> [  +0.007241] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>> [  +0.007239] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa524ad67d4d8
>> [  +0.007242] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 6c6e6263606e7141
>> [  +0.007239] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>> [  +0.007241] x2 : 0000000000000000 x1 : ffff8000094b3b90 x0 : 0000000000000000
>> [  +0.007240] Call trace:
>> [  +0.002475]  __pi_strlen+0x14/0x150
>> [  +0.003537]  drm_version+0x84/0xac
>> [  +0.003448]  drm_ioctl_kernel+0xa8/0x16c
>> [  +0.003975]  drm_ioctl+0x270/0x580
>> [  +0.003448]  __arm64_sys_ioctl+0xb8/0xfc
>> [  +0.003978]  invoke_syscall+0x78/0x100
>> [  +0.003799]  el0_svc_common.constprop.0+0x4c/0xf4
>> [  +0.004767]  do_el0_svc+0x38/0x4c
>> [  +0.003357]  el0_svc+0x34/0x100
>> [  +0.003185]  el0t_64_sync_handler+0x11c/0x150
>> [  +0.004418]  el0t_64_sync+0x190/0x194
>> [  +0.003716] Code: 92402c04 b200c3e8 f13fc09f 5400088c (a9400c02)
>> [  +0.006180] ---[ end trace 0000000000000000 ]---
>>
>> Reported-by: Peter Robinson <pbrobinson@gmail.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/gpu/drm/drm_ioctl.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index e1b9a03e619c..dacaddc59c82 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -474,6 +474,10 @@ static int drm_copy_field(char __user *buf, size_t *buf_len, const char *value)
>>   {
>>   	size_t len;
>>   
>> +	/* don't attempt to copy a NULL pointer */
>> +	if (WARN_ONCE(!value, "BUG: the value to copy was not set!"))
>> +		return -EINVAL;
>> +
> 
> We usually assume that the caller passes the correct arguments. This is 
> different for no reasons. I'd rather not take this patch unless there's 
> a security implication to the ioctl interface (e.g., leaking information 
> because of this NULL ptr).
>

This can lead from an oops (soft panic) to a kernel crash for a buggy driver.

I see from where you are coming from but then I think we should sanitize the
filled struct drm_driver fields in drm_dev_register() and make it fail early.

Would you agree with such a patch? But what I think that we shouldn't allow
is to attempt copying a NULL pointer, if we can easily prevent it.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

