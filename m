Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6809C4636F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbhK3OqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbhK3OqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:46:22 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A49C061574;
        Tue, 30 Nov 2021 06:43:03 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bk14so41670342oib.7;
        Tue, 30 Nov 2021 06:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oefm58NjnsdL/hN4YReYEUsqMs/3lHxBM+H4kBlTQt8=;
        b=bFHW5N3FlZWWpNumt0eA0sLzZOMUpWYSEc200H7q2bN0ccA60BjJ1byUhtVxRUNmlY
         h8AI/fDwBQkgJGyfHCGod/8D8pMhNNiZRHHU83TyMgALoWj1RAA3ejrtiEYO3U7h8qEc
         HV4w328nOkpMg6/QZ6jMBZNsCbdaRmIpH9U/snA8sQD4gGxqWJDc5g4gMfBykvnsJVSj
         z6Xkat+Nv8h+zSVOxklIcVz5ix5VfssEL/Pme0s1bzDE9e2xlFLZFixx6BPpMTREKnsg
         IKjD37DFl90+rXZ5M7g29YeKC48BM2vW9uAPq9eyvmQqwpfB7hM9jbko7+lN2zVrBK/Z
         TDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oefm58NjnsdL/hN4YReYEUsqMs/3lHxBM+H4kBlTQt8=;
        b=EKZetKyF3aQlGetBkahjnovFx+Ch0pUyiy7PVfjSuwhqi1qgO0kN0Jc9JKJ9x7AG0u
         4tvZ9tOW8k84RjgQxwRrNv4jFUU6fHJA4F/9nPEWmDdeJkr91CkZEDpxavw+P5Fi/UPj
         ijAiuFg767yw24Flmr4s+hi/pcL9QAFf6ZKLIdY6+oWyj4HnoyxEGWKQDidOuNmccmbo
         vM4JzyMqpFvzvyY6q0zmEwmAQrJCiMYAJgyT24x/BI5jG1HxZVXoJpEu22HMFkpwTDKG
         h8DWgNIJm9elL4jL6N7+pWYfZj2XXpQQAmNSZALdzAkhve/2Qffob7ANMuV5YlZU9LOW
         +JPQ==
X-Gm-Message-State: AOAM531By+TA93pf56ZChmGYp+sQDEVdnZS44aXGpr4jWfsEMrPTnyhz
        xoXrV58CFicZzmTwjCAVVSQ=
X-Google-Smtp-Source: ABdhPJzUyIVSu9V/90zR6AW5HTCk/oFoGlB+30ylrT3FwjvzwyV49Qotilvy78HvaF70hUVHNWW8ng==
X-Received: by 2002:aca:add3:: with SMTP id w202mr4587060oie.100.1638283382727;
        Tue, 30 Nov 2021 06:43:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d8sm3884086oiw.24.2021.11.30.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:43:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Nov 2021 06:43:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (asus_wmi_ec_sensors) fix array overflow
Message-ID: <20211130144300.GA269056@roeck-us.net>
References: <20211130105034.GG5827@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130105034.GG5827@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:50:34PM +0300, Dan Carpenter wrote:
> Smatch detected an array out of bounds error:
> 
>     drivers/hwmon/asus_wmi_ec_sensors.c:562 asus_wmi_ec_configure_sensor_setup()
>     error: buffer overflow 'hwmon_attributes' 8 <= 9
> 
> The hwmon_attributes[] array needs to be declared with "hwmon_max"
> elements.
> 
> Fixes: c04c7f7bfcbe ("hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus_wmi_ec_sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
> index f612abc66c89..22a1459305a7 100644
> --- a/drivers/hwmon/asus_wmi_ec_sensors.c
> +++ b/drivers/hwmon/asus_wmi_ec_sensors.c
> @@ -41,7 +41,7 @@
>  #define ASUSWMI_MAX_BUF_LEN		128
>  #define SENSOR_LABEL_LEN		16
>  
> -static u32 hwmon_attributes[] = {
> +static u32 hwmon_attributes[hwmon_max] = {
>  	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
>  	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
>  	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
