Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8B948B5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbiAKSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiAKSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:43:32 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE8AC06173F;
        Tue, 11 Jan 2022 10:43:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id i9so313967oih.4;
        Tue, 11 Jan 2022 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GpNeYP+ZR6OUFLEINi1QUPQn4aQI/nnpx2oqcRjgaxU=;
        b=iXtmUgCbRBiqCTxwl9mhU5tmBHeY1kdq5WxbJ9Tnt6nUCoK/PUm8R+ebm5j32BIssm
         KThQ94Aday13xrQCZ3HeWQDPbdCc8iUVSn7ciANsDZAYpZ8LT1dBq1zZ6MUvROQQ0Ubu
         A53s86jfbuFFNGgseo+pL4iqTh/XScWb3i2Pych5ObQIfId0n4kReymLPZt762LSI5/M
         asF1eUpzud+wOJxvZh7L/SW+hLAIkXoqomagGaz3klzQYuMCDwmmqsJbzTjZuGYLavWn
         F3UoJPJvgyEYVd6Rt4TBvxLuTa6+hhw2QgHJKmuPrQ0cRXrcmC6JvNfL9FToapSmR6T5
         wHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpNeYP+ZR6OUFLEINi1QUPQn4aQI/nnpx2oqcRjgaxU=;
        b=lqLc7WHeTUigadU7+k/CucSKCFsBWZV+yyV2e1L84fH981ylHodLgrqQ/5MWGBJSMH
         wc5XcoSMeDTAVQIsJqPXLzVLglrYExIhMmJ9uscOMvaODiVVdEQJYI1BwGaDXckEK77i
         NK0YrF/Sxt/d4KpxiiBbReIlVkB5IO8AAx6xIUqBIRJsQi4RshsEoKTeqTFw4ANXds6h
         Gx8a+k2TITHK5N/zHS0J2sC1mFscWUbdC4iOBENAb49cJUshwaxNAozc1CDrJWBJXi4p
         6uYQtZk0OVgklke4aPzF7CH3+isMFCfAYzJZiDlsZp+cWXv9AN0Ne3hbI54oyPl4J63T
         9aug==
X-Gm-Message-State: AOAM531VFJKJxTIii8lMXrl0yGBsUPZTQNezIxi/rVsKaqBLT48FtNrY
        viwB8d7amxGKWLmCDq4Iwm90k9GcZxA=
X-Google-Smtp-Source: ABdhPJxwckguTkCT8dwP3PfVIySLsZPGEz1d7gHoayyU787C6SF/f7MnkSj/JjnPasb5GqJsqqIwiA==
X-Received: by 2002:a05:6808:13ca:: with SMTP id d10mr2793573oiw.62.1641926611830;
        Tue, 11 Jan 2022 10:43:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm539128otp.52.2022.01.11.10.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 10:43:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-2-eugene.shalygin@gmail.com>
 <805dd382-262c-36f0-fcf5-5776223040c8@roeck-us.net>
 <CAB95QATsy2ACgyxWLy2PM2peqoYDEa_j96VNSHBG6GMd+x3LzQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <050ee3ed-4c30-afb9-d7ce-898d634284be@roeck-us.net>
Date:   Tue, 11 Jan 2022 10:43:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAB95QATsy2ACgyxWLy2PM2peqoYDEa_j96VNSHBG6GMd+x3LzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 9:22 AM, Eugene Shalygin wrote:
>> I do not see the point of marking this as doc strings
> …
>> and neither this one, nor anywhere else where "**" is used.
>> The resulting "documentation" is just confusing and provides no value.
> 
> My editor shows nice tooltips for /** comments and I did not realise
> kernel doc processes
> all the source unconditionally. Anyway, I removed them.
> 
>> Why not just "sensors" directly ? Is there ever going to be anything else ?
>> If not, the value could be added to the dmi array directly without pointer
>> indirection.
> 
> I once had an ASUS board where they changed board headers in some
> hardware revision. I suspect the EC sensors
> interface is valid for their other boards too, we just need users to
> collect those data. It's quite possible that the DMI
> board version would change in that case, so that we can add another
> DMI match if required.
> So, I'll take your advice and move the sensors to the driver_data field.
> 
>> FWIW, MODULE_VERSION tends to have zero value since it tends to end up
>> not being updated.
> 
> Setting the value to 0 then :)
> 

Just drop it.

Guenter

