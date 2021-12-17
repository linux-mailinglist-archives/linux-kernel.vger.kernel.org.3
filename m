Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90555479162
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhLQQXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhLQQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:23:01 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A7C061574;
        Fri, 17 Dec 2021 08:23:01 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id w15-20020a4a354f000000b002d85ef0533dso858281oog.7;
        Fri, 17 Dec 2021 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SWouGLhvvViiSRQIcz77xxUNZKE9YIw+jCvyIogx2qo=;
        b=gVXZk6lefkDrmA1JgBaEyfz91cHaOp7MBXAqVt5Ffjh38o6ttNZL/KDAnryVeYENHB
         B7stdvNm6neYJuz7OzZeve3PMO5Ia7UHSmCJqrmHmbcp3CfBZzli2xoOPKQsRAFBi5Zz
         vOyBJ3Y6ojXoQk2yuTDzZawBq6VVjwHZ3s/cBcBrhIIJF0uwl9P95H+79ixRV6aDai+y
         j8xVBy57g2x63/ifjMLajZKADUnu+3rFWBREg4SxMiqib/ywSNO3XyaQg8Y2+JuHDrRt
         vfWOU2EymBZmU/H8xoJSnEDHmU9gQLii5ybzuha/0uyLcRzZZ2SdVEHItRGD5IWvZYay
         lX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SWouGLhvvViiSRQIcz77xxUNZKE9YIw+jCvyIogx2qo=;
        b=F/1DIM/XBuduW2VBnP8SNLB84xyAlbeW8uE3Rzo7w8AnaNcJBA6wN36ctYhC+G5r5H
         UiKU4ab0BdRiNtKvJI/WZa83KgI9UsDRNgv6v0/Nqv84vDFWH4L/PeGBZtb0BYdRFugV
         IKOGw9cLww2v0+LmWPXIesKydDMnhaAtHzUQ8IWSfSEJTHX3EgGNJB8BQIHm9AHjQR1O
         AJggK9LQr7D3rVPY+kHV5zdp6FVM21aPraYhbPQaahEKU46TSOkctta4jF4vbcaa5YW6
         WFrFfPqAqZBGpLFXEFFed+YWnvP0XkApTPTPQahpX1yMMQMjIWsXr6T5TfLutSJwOTBv
         FtKA==
X-Gm-Message-State: AOAM533+V9BblT9yVjMImT57VzFTdm35P/9WBzUeisijd3QPAFFIKOus
        3BT5bzwWMC6zUekTKfI3uZonNWu4k+M=
X-Google-Smtp-Source: ABdhPJzsKt3QzsUMKg8VRd8GOtk1w/RP311+v9SHCny7qC3j+JN/+H5GM1sNlds0P4UkllfajW6o0Q==
X-Received: by 2002:a4a:d284:: with SMTP id h4mr2429603oos.31.1639758180843;
        Fri, 17 Dec 2021 08:23:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm1675549oig.4.2021.12.17.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:23:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211128184549.9161-1-pauk.denis@gmail.com>
 <20211217002223.63b1e0a7@netbook-debian>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
Message-ID: <c6bf6ce9-8b45-e4a2-7167-83bdc8437fca@roeck-us.net>
Date:   Fri, 17 Dec 2021 08:22:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217002223.63b1e0a7@netbook-debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 2:22 PM, Denis Pauk wrote:
> Hi,
> 
> Could you please provide a some feedback about such idea?
> 
> I have bigger list of supported boards that requires ACPI mutex lock,
> but I prefer to have some feedback before send next version of patch.
> 
> I have created separate patch[1] with only boards where WMI methods is
> enough. And if work on patch takes some time/additional patch
> versions(for sure it will), I prefer to have that patch merged and
> rebase current patch over resulted list of boards.
> 

Looking through the code, I am absolutely not happy with it. It makes
the driver even more unreadable than it already is, and on top of that
makes it vulnerable to problems in the ACPI code. Example: If ACPI fails
to unlock the mutex, the driver will end up being non-functional.

At some point, we have to face it: ASUS doesn't support Linux, and they
make it hard to access chips like this. I think the chip should be
accessed through "official" channels only if provided (ie WMI/ACPI),
or not at all.

Guenter
