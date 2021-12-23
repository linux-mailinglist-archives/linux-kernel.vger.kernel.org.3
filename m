Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DDE47E669
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349212AbhLWQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:34:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhLWQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:34:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 699541F45B18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640277278;
        bh=Qo+8Q9CJpQIhlE37DynQZg8KW/eg5KmMXgQTR0EeLUs=;
        h=Cc:Subject:To:References:From:Date:In-Reply-To:From;
        b=BLVUJPuxMbd94dwn1Daihkw53sEhoukJCWGyYokVY8sTmFGs7EimMEEo1GyN12XJ0
         R+ncjYSJblKcHMjqkwv6yLdz6+aKw+5I+tNhrsP6d7UAn+GN9cWg2Rn6Q8Bu59NMxp
         Jl9Xv+9XyXGtD1xdP2dc/ueH2YYfLc/OntXbYhYnmcLwpa95DP537xerY40wfcx60w
         dV57xor6wz2/dUFWarjgNuUek/JQ+Be91ChXmeE/ukJBVxcroESqeuRTxtZlESruPw
         IusaZc+5ZnMKZbmZ1PJHdhb/aDhVZ0e7BwsRoiWElrX2jsqo5DtM1CllXscEQMxfPq
         9OziiFJ16IGnA==
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mihail Chindris <mihail.chindris@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] drivers:iio:dac make expression evaluation 64-bit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
 <CAHp75VcU8B8fydh874p6HpgGXXRYvNGdphH=i17JHB3DYJ1JZQ@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Message-ID: <eb59f405-24c6-69b8-beb1-465bfb783f61@collabora.com>
Date:   Thu, 23 Dec 2021 21:34:30 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU8B8fydh874p6HpgGXXRYvNGdphH=i17JHB3DYJ1JZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 11:49 PM, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 5:59 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Two 32-bit values are being evaluated using 32-bit arithmetic and then
>> passed to s64 type. It is wrong. Expression should be evaluated using
>> 64-bit arithmetic and then passed.
> 
> ...
> 
>>         dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
>>                                                         65536);
> 
> Shouldn't the above be fixed as well? Has anybody tried to compile on
> 32-bit arch this?
No, it correct already. In this case, rem is being typecasted to s64 and
then multiplied with a 32-bit number, 1000000. Thus 64-bit arithmetic is
being performed here.
