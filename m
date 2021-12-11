Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221864714A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhLKQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:05:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36984 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhLKQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:05:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB753CE000E;
        Sat, 11 Dec 2021 16:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D923AC004DD;
        Sat, 11 Dec 2021 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639238754;
        bh=6ECba4zdP0TaGj8u/SYfplHplf34p0rrMv4pwmsei6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U960he549WfnNuFXf5suQqjHX5W8DH78NwL2ETn3ZR8RjrlVrY0OB/A3YUC+L0kpA
         2VnlTtSs4cLjoFf9+cxilQnPzP7j/Hu+3vOGS1SE6Oh7bgYN2FSZO6wOd8BCsing+7
         wkqw5zNZWp9PermN6xinxrCW7hHAFuLudPzh4sSfVPOwveY/9Lfx1R8Zu/qq8mUuEd
         iq3gCBOm23Kx+XuQypMypcO4lZomp5SSegRjni23wO/vEj7iIP5UEnpmtiJgbEppZN
         Dd7Y0ggiY7DyWwFljDSo/ABsaPzFz5Z6XpOw4d+Se4vQ+beBLwqAiJglTunEjec8nz
         cH9wNYnV/OiKw==
Received: by pali.im (Postfix)
        id B4E5A735; Sat, 11 Dec 2021 17:05:51 +0100 (CET)
Date:   Sat, 11 Dec 2021 17:05:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211211160551.agftqd7g3dtyu2x6@pali>
References: <20211211155422.16830-1-W_Armin@gmx.de>
 <20211211155422.16830-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211155422.16830-3-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 December 2021 16:54:22 Armin Wolf wrote:
> The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> with i8k_mutex held. Judging from the hwmon code, this mutex
> only needs to be held when setting the fan speed/mode, so
> the operation of I8K_SET_FAN is guaranteed to be atomic.
> Unify both functions and reduce the locking of i8k_mutex
> to I8K_SET_FAN.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 186d40938036..d8c6e75bb374 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -449,12 +449,12 @@ static int i8k_get_power_status(void)
>   * Procfs interface
>   */
> 
> -static int
> -i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd, unsigned long arg)
> +static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
>  {
> -	int val = 0;
> -	int speed, err;
> +	struct dell_smm_data *data = PDE_DATA(file_inode(fp));
>  	int __user *argp = (int __user *)arg;
> +	int speed, err;
> +	int val = 0;
> 
>  	if (!argp)
>  		return -EINVAL;
> @@ -516,11 +516,13 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  		if (copy_from_user(&speed, argp + 1, sizeof(int)))
>  			return -EFAULT;
> 
> +		mutex_lock(&data->i8k_mutex);
>  		err = i8k_set_fan(data, val, speed);
>  		if (err < 0)
> -			return err;
> -
> -		val = i8k_get_fan_status(data, val);
> +			val = err;
> +		else
> +			val = i8k_get_fan_status(data, val);
> +		mutex_unlock(&data->i8k_mutex);
>  		break;
> 
>  	default:
> @@ -536,18 +538,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  	return 0;
>  }
> 
> -static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> -{
> -	struct dell_smm_data *data = PDE_DATA(file_inode(fp));
> -	long ret;
> -
> -	mutex_lock(&data->i8k_mutex);
> -	ret = i8k_ioctl_unlocked(fp, data, cmd, arg);
> -	mutex_unlock(&data->i8k_mutex);
> -
> -	return ret;
> -}
> -
>  /*
>   * Print the information for /proc/i8k.
>   */
> --
> 2.30.2
> 
