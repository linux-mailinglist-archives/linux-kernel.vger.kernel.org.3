Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D54800E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbhL0PvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbhL0Pra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:47:30 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C45C08EAD4;
        Mon, 27 Dec 2021 07:43:16 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t19so25900542oij.1;
        Mon, 27 Dec 2021 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K80NjHp56E36SKpf0s6kBuH2VUARIQ8AlvzdshnRP+M=;
        b=k3BllzEKu9NR9NnQPmP8cstw65s6K/mANRiMydmRPxgF2XJXsomlUL9+QV91F0m8u6
         BDpgr+YUlypEo7FRw38KZqclCuDDpv24qYe+XQ/X2d1zqrG3x3NEZEr7xiBxkGrhr+gh
         8lhQOenlMN0WgZlyXUJ1I80oktH+hmSYft+PNqNyhBBzCTzqmfwr3wX3UvCP4C+E2PqY
         WAqu9L21aOdn4xH0KiMY/Qc7QpAJAql/lH6OvA2ijtCasaZ9BIs2Y2rNPpCvct5C76Xx
         OO7VCuk3LbdXiq5S3SF5Zd8CUKyrIEu2FWS2JzDcxR7ZAkV6ZUmff874Rka4lHIfVjGX
         7V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K80NjHp56E36SKpf0s6kBuH2VUARIQ8AlvzdshnRP+M=;
        b=h0TqTZh7CqHebqFeoq/45e2fjVcwGr5trVlh5kbfp6qB+xBJcx6c1jYZcphVPyjsfL
         KIYzzX9aSxMKgoqn88L/pR28BPxizsbKq+cVkkrIekzhYDG2UNNqITuiuH2eyvqxVfSz
         mFvT9jbyOyk9MBAqIGZ7whMNzNuROtsb2wUPHMTq8vmBPhqlT47lLjP0OiaFrr2TNQrq
         NIuko+PqBR7rU43yQ9L7106VN5bAIhnmdrGhJ9VYMEEmXF5gbEUB0+T/r6PR48pZF2Y1
         6rkmP4pn3gW6QLckXh7yGwsWaXI/a51bwsgoy9/wdg/Nf6KRH3aO7EbDx/AEVDTwtTnz
         B3UA==
X-Gm-Message-State: AOAM533zjmf3JD/Z72RsNPifnPuY3FQz8Vs6gS26uX7XRvgmgUDeUANe
        Ix3sxSPXQYnVsG46A/TZagk=
X-Google-Smtp-Source: ABdhPJzohQ58C+ddu+5BLYfOU4pD+3GOGf+9sxhLaw1DhB9zf+MK2FSWkf3Uqr78G2erxJ3rAFSKiQ==
X-Received: by 2002:a05:6808:1305:: with SMTP id y5mr13285886oiv.83.1640619795719;
        Mon, 27 Dec 2021 07:43:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm2891169otj.61.2021.12.27.07.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 07:43:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: Use min() instead of doing it manually
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        mezin.alexander@gmail.com
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211227113632.90672-1-jiapeng.chong@linux.alibaba.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e689de7b-033b-0ada-5135-faf7fdb1e26b@roeck-us.net>
Date:   Mon, 27 Dec 2021 07:43:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227113632.90672-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 3:36 AM, Jiapeng Chong wrote:
> Eliminate following coccicheck warning:
> 
> ./drivers/hwmon/nzxt-smart2.c:461:12-13: WARNING opportunity for min().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/hwmon/nzxt-smart2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 534d39b8908e..b30de7441fbb 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -458,7 +458,7 @@ static int send_output_report(struct drvdata *drvdata, const void *data,
>   
>   	ret = hid_hw_output_report(drvdata->hid, drvdata->output_buffer,
>   				   sizeof(drvdata->output_buffer));
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);

Nack, that is just confusing. ret is an error if < 0, and min obfuscates
that we want to return an error or 0.

Guenter
