Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD62749061C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiAQKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236101AbiAQKkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642416013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcGzXSqurtgAtfCF+SCc3518Y+qQIml8H+Z9V3VdthQ=;
        b=fziIgT50Kny/N2NEBb89rHE/aKqVzQoHn1jvdeuiWzxZ/6XaTT0G76xRweHyRoqz5X6AsW
        PTYUPv+ImNVYcKKfAEhBAgm9DSOu50e9+wOr+TsEXJA5LCm0Tk0H5lt6kEGNzQtzJigxlm
        h34IWfjFvavMTuZNWkV8FGey73kzAKQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-ctGyKerlPZGR5nvNiAlCuA-1; Mon, 17 Jan 2022 05:40:12 -0500
X-MC-Unique: ctGyKerlPZGR5nvNiAlCuA-1
Received: by mail-ed1-f69.google.com with SMTP id a8-20020a056402168800b004022fcdeb25so3108365edv.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QcGzXSqurtgAtfCF+SCc3518Y+qQIml8H+Z9V3VdthQ=;
        b=FYMQWpJEx1EQm5fKItncQmmd0+zJWpXbD6O0i6ui8Ehy7Jb3PZHH0CBHktIqR7aCmK
         Xf3uZL8sCV+9Fhs3XAd9aBiN4Ml6bu5zudbOkrWyIa8zNum5Ah3okqCV22U5t2VgsT//
         BIDMmsDHG/KEERZG5ohLmTKR9sELBg/NLgc9nm4hITEubuAh3ELy5itH3gnKrP9Nyczy
         D8sJrNr0kOnTMnmMJZIeE26FdSkfhU/7BP0R4qLFG2nUDzPiaDrYMLbFREczE9bxD/UL
         lrpMJ2YWFLix/+oeVaD17EBrCSwqbN0+e7qreUqvZ9dDLhNvy5HWdXIeUd602FeS7uXE
         hYFw==
X-Gm-Message-State: AOAM532hYTYVxLo6gc9DGP1wyMUyOVC6yn3JkSlhKsYRh7kApqW6MtwG
        dUSWxjrAlX6+k6PyljBd3RMIqHo9SLbvm3AKachqBTGFqDumEb8egJgw83esNgEhorgc2u6kMA0
        mka524ipPhuRf6MumhFUq02Ie
X-Received: by 2002:a17:907:1c14:: with SMTP id nc20mr17351780ejc.618.1642416010551;
        Mon, 17 Jan 2022 02:40:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpr5O09kbO0c5GKJ5+UmUCI6fEtYiZK2pR4QOq/ogYk54w9H5OXp80+gpChlzZacbB1l1rLg==
X-Received: by 2002:a17:907:1c14:: with SMTP id nc20mr17351763ejc.618.1642416010242;
        Mon, 17 Jan 2022 02:40:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id e16sm5665312edu.15.2022.01.17.02.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:40:09 -0800 (PST)
Message-ID: <c0d8388b-a4c1-2723-0399-b17434da6d24@redhat.com>
Date:   Mon, 17 Jan 2022 11:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/x86: ISST: Fix possible circular locking
 dependency detected
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        liwei.song@windriver.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112022521.54669-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220112022521.54669-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/22 03:25, Srinivas Pandruvada wrote:
> As reported:
> 
> [  256.104522] ======================================================
> [  256.113783] WARNING: possible circular locking dependency detected
> [  256.120093] 5.16.0-rc6-yocto-standard+ #99 Not tainted
> [  256.125362] ------------------------------------------------------
> [  256.131673] intel-speed-sel/844 is trying to acquire lock:
> [  256.137290] ffffffffc036f0d0 (punit_misc_dev_lock){+.+.}-{3:3}, at: isst_if_open+0x18/0x90 [isst_if_common]
> [  256.147171]
> [  256.147171] but task is already holding lock:
> [  256.153135] ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x2a/0x170
> [  256.160407]
> [  256.160407] which lock already depends on the new lock.
> [  256.160407]
> [  256.168712]
> [  256.168712] the existing dependency chain (in reverse order) is:
> [  256.176327]
> [  256.176327] -> #1 (misc_mtx){+.+.}-{3:3}:
> [  256.181946]        lock_acquire+0x1e6/0x330
> [  256.186265]        __mutex_lock+0x9b/0x9b0
> [  256.190497]        mutex_lock_nested+0x1b/0x20
> [  256.195075]        misc_register+0x32/0x1a0
> [  256.199390]        isst_if_cdev_register+0x65/0x180 [isst_if_common]
> [  256.205878]        isst_if_probe+0x144/0x16e [isst_if_mmio]
> ...
> [  256.241976]
> [  256.241976] -> #0 (punit_misc_dev_lock){+.+.}-{3:3}:
> [  256.248552]        validate_chain+0xbc6/0x1750
> [  256.253131]        __lock_acquire+0x88c/0xc10
> [  256.257618]        lock_acquire+0x1e6/0x330
> [  256.261933]        __mutex_lock+0x9b/0x9b0
> [  256.266165]        mutex_lock_nested+0x1b/0x20
> [  256.270739]        isst_if_open+0x18/0x90 [isst_if_common]
> [  256.276356]        misc_open+0x100/0x170
> [  256.280409]        chrdev_open+0xa5/0x1e0
> ...
> 
> The call sequence suggested that misc_device /dev file can be opened
> before misc device is yet to be registered, which is done only once.
> 
> Here punit_misc_dev_lock was used as common lock, to protect the
> registration by multiple ISST HW drivers, one time setup, prevent
> duplicate registry of misc device and prevent load/unload when device
> is open.
> 
> We can split into locks:
> - One which just prevent duplicate call to misc_register() and one
> time setup. Also never call again if the misc_register() failed or
> required one time setup is failed. This lock is not shared with
> any misc device callbacks.
> 
> - The other lock protects registry, load and unload of HW drivers.
> 
> Sequence in isst_if_cdev_register()
> - Register callbacks under punit_misc_dev_open_lock
> - Call isst_misc_reg() which registers misc_device on the first
> registry which is under punit_misc_dev_reg_lock, which is not
> shared with callbacks.
> 
> Sequence in isst_if_cdev_unregister
> Just opposite of isst_if_cdev_register
> 
> Reported-and-tested-by: Liwei Song <liwei.song@windriver.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  .../intel/speed_select_if/isst_if_common.c    | 97 ++++++++++++-------
>  1 file changed, 63 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index c9a85eb2e860..e8424e70d81d 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -596,7 +596,10 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
>  	return ret;
>  }
>  
> -static DEFINE_MUTEX(punit_misc_dev_lock);
> +/* Lock to prevent module registration when already opened by user space */
> +static DEFINE_MUTEX(punit_misc_dev_open_lock);
> +/* Lock to allow one share misc device for all ISST interace */
> +static DEFINE_MUTEX(punit_misc_dev_reg_lock);
>  static int misc_usage_count;
>  static int misc_device_ret;
>  static int misc_device_open;
> @@ -606,7 +609,7 @@ static int isst_if_open(struct inode *inode, struct file *file)
>  	int i, ret = 0;
>  
>  	/* Fail open, if a module is going away */
> -	mutex_lock(&punit_misc_dev_lock);
> +	mutex_lock(&punit_misc_dev_open_lock);
>  	for (i = 0; i < ISST_IF_DEV_MAX; ++i) {
>  		struct isst_if_cmd_cb *cb = &punit_callbacks[i];
>  
> @@ -628,7 +631,7 @@ static int isst_if_open(struct inode *inode, struct file *file)
>  	} else {
>  		misc_device_open++;
>  	}
> -	mutex_unlock(&punit_misc_dev_lock);
> +	mutex_unlock(&punit_misc_dev_open_lock);
>  
>  	return ret;
>  }
> @@ -637,7 +640,7 @@ static int isst_if_relase(struct inode *inode, struct file *f)
>  {
>  	int i;
>  
> -	mutex_lock(&punit_misc_dev_lock);
> +	mutex_lock(&punit_misc_dev_open_lock);
>  	misc_device_open--;
>  	for (i = 0; i < ISST_IF_DEV_MAX; ++i) {
>  		struct isst_if_cmd_cb *cb = &punit_callbacks[i];
> @@ -645,7 +648,7 @@ static int isst_if_relase(struct inode *inode, struct file *f)
>  		if (cb->registered)
>  			module_put(cb->owner);
>  	}
> -	mutex_unlock(&punit_misc_dev_lock);
> +	mutex_unlock(&punit_misc_dev_open_lock);
>  
>  	return 0;
>  }
> @@ -662,6 +665,43 @@ static struct miscdevice isst_if_char_driver = {
>  	.fops		= &isst_if_char_driver_ops,
>  };
>  
> +static int isst_misc_reg(void)
> +{
> +	mutex_lock(&punit_misc_dev_reg_lock);
> +	if (misc_device_ret)
> +		goto unlock_exit;
> +
> +	if (!misc_usage_count) {
> +		misc_device_ret = isst_if_cpu_info_init();
> +		if (misc_device_ret)
> +			goto unlock_exit;
> +
> +		misc_device_ret = misc_register(&isst_if_char_driver);
> +		if (misc_device_ret) {
> +			isst_if_cpu_info_exit();
> +			goto unlock_exit;
> +		}
> +	}
> +	misc_usage_count++;
> +
> +unlock_exit:
> +	mutex_unlock(&punit_misc_dev_reg_lock);
> +
> +	return misc_device_ret;
> +}
> +
> +static void isst_misc_unreg(void)
> +{
> +	mutex_lock(&punit_misc_dev_reg_lock);
> +	if (misc_usage_count)
> +		misc_usage_count--;
> +	if (!misc_usage_count && !misc_device_ret) {
> +		misc_deregister(&isst_if_char_driver);
> +		isst_if_cpu_info_exit();
> +	}
> +	mutex_unlock(&punit_misc_dev_reg_lock);
> +}
> +
>  /**
>   * isst_if_cdev_register() - Register callback for IOCTL
>   * @device_type: The device type this callback handling.
> @@ -679,38 +719,31 @@ static struct miscdevice isst_if_char_driver = {
>   */
>  int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
>  {
> -	if (misc_device_ret)
> -		return misc_device_ret;
> +	int ret;
>  
>  	if (device_type >= ISST_IF_DEV_MAX)
>  		return -EINVAL;
>  
> -	mutex_lock(&punit_misc_dev_lock);
> +	mutex_lock(&punit_misc_dev_open_lock);
> +	/* Device is already open, we don't want to add new callbacks */
>  	if (misc_device_open) {
> -		mutex_unlock(&punit_misc_dev_lock);
> +		mutex_unlock(&punit_misc_dev_open_lock);
>  		return -EAGAIN;
>  	}
> -	if (!misc_usage_count) {
> -		int ret;
> -
> -		misc_device_ret = misc_register(&isst_if_char_driver);
> -		if (misc_device_ret)
> -			goto unlock_exit;
> -
> -		ret = isst_if_cpu_info_init();
> -		if (ret) {
> -			misc_deregister(&isst_if_char_driver);
> -			misc_device_ret = ret;
> -			goto unlock_exit;
> -		}
> -	}
>  	memcpy(&punit_callbacks[device_type], cb, sizeof(*cb));
>  	punit_callbacks[device_type].registered = 1;
> -	misc_usage_count++;
> -unlock_exit:
> -	mutex_unlock(&punit_misc_dev_lock);
> +	mutex_unlock(&punit_misc_dev_open_lock);
>  
> -	return misc_device_ret;
> +	ret = isst_misc_reg();
> +	if (ret) {
> +		/*
> +		 * No need of mutex as the misc device register failed
> +		 * as no one can open device yet. Hence no contention.
> +		 */
> +		punit_callbacks[device_type].registered = 0;
> +		return ret;
> +	}
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(isst_if_cdev_register);
>  
> @@ -725,16 +758,12 @@ EXPORT_SYMBOL_GPL(isst_if_cdev_register);
>   */
>  void isst_if_cdev_unregister(int device_type)
>  {
> -	mutex_lock(&punit_misc_dev_lock);
> -	misc_usage_count--;
> +	isst_misc_unreg();
> +	mutex_lock(&punit_misc_dev_open_lock);
>  	punit_callbacks[device_type].registered = 0;
>  	if (device_type == ISST_IF_DEV_MBOX)
>  		isst_delete_hash();
> -	if (!misc_usage_count && !misc_device_ret) {
> -		misc_deregister(&isst_if_char_driver);
> -		isst_if_cpu_info_exit();
> -	}
> -	mutex_unlock(&punit_misc_dev_lock);
> +	mutex_unlock(&punit_misc_dev_open_lock);
>  }
>  EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
>  
> 

