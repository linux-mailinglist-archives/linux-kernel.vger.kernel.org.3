Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3441947E67D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349285AbhLWQiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:38:25 -0500
Received: from www381.your-server.de ([78.46.137.84]:34024 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbhLWQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=xclLypP0lYpJWHJx1fDqFO+MLwhcLhCsssUQkOWIW7o=; b=eLAxm37CVubS/3z1Rv/qNPKimf
        1A1ZPrevCrlOxjw7SyVlm873hMd6/RbwpiX6c90/eE7pfbVtkAV1FWUdLST3AwaAvLoUpS3SEb+5F
        mS98ggcVdiTb3YHHuhPvqivqJCIXgPV8JEBPdxm6f9wMEXPF8DRPhFMAY6K1gZE+qlQsPnVY2BGNk
        AQt6tJprZ08/daFYUJ+JPrrSLXOZDDU6NY3nGndOELMath842vgHJdpS2IHF/JjLpIkZ6FlbyIfkV
        y8ZLg1MFrP4LjjtuJjyZzsxIxcJS0N/h3MqTa+dZyh6Mb911wvvO/hcl+YVd+q8euF90rzilb56hY
        YTKZfzZw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n0R6h-000C54-Tw; Thu, 23 Dec 2021 17:38:19 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n0R6h-000S0O-FP; Thu, 23 Dec 2021 17:38:19 +0100
Subject: Re: [PATCH] drivers:iio:dac make expression evaluation 64-bit
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mihail Chindris <mihail.chindris@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
 <CAHp75VcU8B8fydh874p6HpgGXXRYvNGdphH=i17JHB3DYJ1JZQ@mail.gmail.com>
 <eb59f405-24c6-69b8-beb1-465bfb783f61@collabora.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <16f84d86-4135-8a19-c5e1-3fbe8db78947@metafoo.de>
Date:   Thu, 23 Dec 2021 17:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <eb59f405-24c6-69b8-beb1-465bfb783f61@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26399/Thu Dec 23 10:42:51 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 5:34 PM, Muhammad Usama Anjum wrote:
> On 12/22/21 11:49 PM, Andy Shevchenko wrote:
>> On Wed, Dec 22, 2021 at 5:59 PM Muhammad Usama Anjum
>> <usama.anjum@collabora.com> wrote:
>>> Two 32-bit values are being evaluated using 32-bit arithmetic and then
>>> passed to s64 type. It is wrong. Expression should be evaluated using
>>> 64-bit arithmetic and then passed.
>> ...
>>
>>>          dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
>>>                                                          65536);
>> Shouldn't the above be fixed as well? Has anybody tried to compile on
>> 32-bit arch this?
> No, it correct already. In this case, rem is being typecasted to s64 and
> then multiplied with a 32-bit number, 1000000. Thus 64-bit arithmetic is
> being performed here.

What Andy means is that this needs to be DIV_S64_ROUND_CLOSEST() to work 
on 32-bit platforms. But it is clearly unrelated to your change and 
should be in its own patch.

