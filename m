Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F3479C55
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhLRTfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhLRTfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:35:40 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20FC061574;
        Sat, 18 Dec 2021 11:35:40 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso7273299ota.5;
        Sat, 18 Dec 2021 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hcmmLIR+F0h0egoEbx+zZr0kOvK7O/jxEGio+V5xpTY=;
        b=ODKNx2oQbL44hyrA4e9o3RNOqSLCFBk9FcvogZCM1cjKMrbfcqr9IPF6Moxs7HsD+H
         GkV4/Yr9ec7ffDMPbvEBncC5NAWW7V7txJoZsXfmD7JIDpGaCWrXSmqHWN8VwQp7csnj
         xzRuQcc9xZTTWQv/N65DZW0k4M5Il5hJuXrlb7WSfARwJalR6Yt/60S/U1wtTd6rXZaD
         bPO0cg0OKFmQ47xn5KDCZrdk1M0nXMqKwwIIz66r68C8OMvWY0fwUt9wo+3pbANz2UVd
         odW/MLT9+sfiVGLd+WVThyj5lzz4DDMgoW7Ui3Hf7O1NEsSS+5sSNYQL4EpNH0zFMJfI
         483A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hcmmLIR+F0h0egoEbx+zZr0kOvK7O/jxEGio+V5xpTY=;
        b=mbkFvBsuOIgJRy1hr2X4QHdvlj94NE8j2eu14Gv+ZW4PgcCH3CmmHALl1jXVUmzu1z
         gydGzRiAtAlbYM1qb/guTbdxPgw7u2lVICpqjyZCNAJiILSfO4Ycbp7aZD806vP0Oirl
         WXnau3aSxT5vDHkL3oYU8J/sYLLjsyq+bcWl3lyC+Ivb61ZVcWbIW8B8X2Xx1dp6JcLr
         87o2AiFOhvybkCLIPTwPPkKHH4D88+4V11a/aQWdAIzZOSke4NOrJSNGAvhYSps2CtKJ
         E63nUUJYzhARe3UM66wpQKuPPh2fCocBKZ4PiQj1ru7vv3GACkFnLEhmmk11UwQvWe1g
         Xe4g==
X-Gm-Message-State: AOAM530mCEmAwITwVRXvE0IMRzw/wcKO8JkTDZGSUGcQxRwHlspR0gSz
        lF9pYIpobixyEXSLUkFCQ6YIzyyM52g=
X-Google-Smtp-Source: ABdhPJxtfpqx1k6ybhCQiMs/ZcIcW7k9XC7pFl0ks2F+KbufHn6Jv3pXo66WY5xrIZG66tXPrYjBww==
X-Received: by 2002:a9d:4b09:: with SMTP id q9mr6281522otf.140.1639856138568;
        Sat, 18 Dec 2021 11:35:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p23sm2320474otf.37.2021.12.18.11.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 11:35:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] hwmon: (nct6775) Additional check for ChipID before
 ASUS WMI usage
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211218192616.611878-1-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3bcc4982-d496-6721-e40c-b0ed2da0ee83@roeck-us.net>
Date:   Sat, 18 Dec 2021 11:35:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218192616.611878-1-pauk.denis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/21 11:26 AM, Denis Pauk wrote:
> WMI monitoring methods can be changed or removed in new ASUS boards
> BIOS versions. Such versions return zero instead of a real one as
> Chip ID.
> 
> Commit adds additional validation for the result of Chip ID call
> before enabling access by ASUS WMI methods.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> ---
>   drivers/hwmon/nct6775.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 57ce8633a725..034347ed51c4 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -5038,7 +5038,8 @@ static int __init sensors_nct6775_init(void)
>   				   board_name);
>   		if (err >= 0) {
>   			/* if reading chip id via WMI succeeds, use WMI */
> -			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
> +			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) &&
> +			    tmp) {

Please drop the continuation line; the above hurts readability, and in that case
up to 100 columns are allowed.

Thanks,
Guenter

>   				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
>   				access = access_asuswmi;
>   			} else {
> 
> base-commit: 2585cf9dfaaddf00b069673f27bb3f8530e2039c
> 

