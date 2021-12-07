Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5014C46BDDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhLGOlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhLGOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:41:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C3C061574;
        Tue,  7 Dec 2021 06:37:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c32so34055190lfv.4;
        Tue, 07 Dec 2021 06:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s9/qxIrR8tF6zWnC2CNOSyvQJwZNDJC7C9nlCNHrx+o=;
        b=XAHGUhgbReJmLxZSPuCnTjbaTkHKyyoX7vnK7Kw5+SjE8r/O2NCLUCdTjCs+qYOhvx
         LcXgpFSugwfUj+dt9CFAvXQvyqA5gVfMMSP+Tc/3+CZSs0oP1auVjCAhZOthfCOJUIKv
         R35edurehJU05/8buCwtCBsmucGSxp6IADZKtf6cvl3os/koWo+sZhGOo0/OCaUthdO7
         7rzLJN2cWV5jh0UWjspEAc/vgnuqeAooqrNKJuePrEXLDlZR8iYcOwwyvcMtVmk2SgqH
         n1fTSvillj3C32O0v4eb4gE/6bWJEz43qQPRPaWO4TRn6CawNdgu9ktcI0wjwTzy2OYl
         7oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9/qxIrR8tF6zWnC2CNOSyvQJwZNDJC7C9nlCNHrx+o=;
        b=T7zTI6aGEwbuPkl2Ja1CggJoakl1LaG5CpNE8ooOPDUmr5i4mTIcj5c1fEADfQwBTd
         OCsdI1fnDChfBdcZUz7h/CL9fDz2kdERADLibD4fy8X+nFDD4foSpuHYH599C84ESwQN
         r+1i85/359tHcYjzlAobLqTC7mF/O6zcx80LSVyl5j8KdBJeOogeI8KfEu4bEQg/Idzb
         w4mHfOc09psf9QLBWPevbMOcWUVT2s9OtrLCKgMTLYeFTNIGiMFOP8S3LvrJrxnERSnw
         jgjeTrrxEfkgBnIthGFYFaD+ljdi8I8QjzzvT5XyEPJ8vozbqGoOHutn9wKkqQZ7miwG
         43cA==
X-Gm-Message-State: AOAM533Ad80TSLU6ubjnOIdXsK+bM49RpgZVoKk7RnN6vuP9eg6dt9+L
        DuZ3N7q62oURrFYS2gDaCzkOPyOd9oY=
X-Google-Smtp-Source: ABdhPJy3IcwVhC0N1gj9NrdzdMXNnC7pXCO5CThzlG6JGABXQ23FtLwCvvedNx07wrV55fr9SqN2xQ==
X-Received: by 2002:ac2:5a46:: with SMTP id r6mr41444829lfn.358.1638887869276;
        Tue, 07 Dec 2021 06:37:49 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id z23sm1676836ljk.136.2021.12.07.06.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:37:48 -0800 (PST)
Subject: Re: [PATCH] phy: tegra: add missing put_device() call in
 tegra210_xusb_padctl_probe()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Qing Wang <wangqing@vivo.com>, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638881776-3308-1-git-send-email-wangqing@vivo.com>
 <b56a0b92-cf64-570c-08f8-e7a54fc55946@gmail.com>
Message-ID: <e57c1c99-0743-c785-24e3-44654e4991f1@gmail.com>
Date:   Tue, 7 Dec 2021 17:37:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b56a0b92-cf64-570c-08f8-e7a54fc55946@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2021 17:35, Dmitry Osipenko пишет:
> 07.12.2021 15:56, Qing Wang пишет:
>> From: Wang Qing <wangqing@vivo.com>
>>
>> of_find_device_by_node() takes a reference to the embedded struct device 
>> which needs to be dropped when error return.
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>> ---
>>  drivers/phy/tegra/xusb-tegra210.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
>> index eedfc7c..05a0800
>> --- a/drivers/phy/tegra/xusb-tegra210.c
>> +++ b/drivers/phy/tegra/xusb-tegra210.c
>> @@ -3170,8 +3170,10 @@ tegra210_xusb_padctl_probe(struct device *dev,
>>  		goto out;
>>  	}
>>  
>> -	if (!platform_get_drvdata(pdev))
>> +	if (!platform_get_drvdata(pdev)) {
>> +		put_device(&pdev->dev);
>>  		return ERR_PTR(-EPROBE_DEFER);
>> +	}
>>  
>>  	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
>>  	if (!padctl->regmap)
>>
> 
> What if dev_get_regmap() fails? What if driver is removed?
> 
> Please either fix it properly or don't fix it.
> 

My bad, I see now in the code that this dev_get_regmap() fail is okay.
Nevertheless the driver removal is incorrect.
