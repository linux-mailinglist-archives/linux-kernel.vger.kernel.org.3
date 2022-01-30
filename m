Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7254A3563
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbiA3JmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:42:23 -0500
Received: from smtpcmd04132.aruba.it ([62.149.158.132]:56014 "EHLO
        smtpcmd04132.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354470AbiA3JmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:42:21 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Jan 2022 04:42:21 EST
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id E6cAnydGDkz4hE6cAn0wV7; Sun, 30 Jan 2022 10:35:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1643535319; bh=hhZnv6BXvXufeDI+XGxA7TmJQGnAM+C/uW4OZufjX2c=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=MdHy7msiX9mARobaYkjlMJsoCqbQy/cuReGtP/0lGxoi+WNwioYzzBWKRd0ZihA0C
         oPe7ccYGSOatg509kr55NpjQgfJxxcyRWO7VwWInIztDC0UBzHAZV2cg6EHiRGkqeW
         Z4m4iJYy9NLprA2x0JM565YRkFB2hdKAOV7/MCiJFKBAv7AdYfcMGcr4Xk3Q1nZ0h6
         +Sa6mdppl6cSuAqJehxJhb3jBNJGW2+2z3DTB5wAqjn8EWSq4GIKjSSQXBa39cymNe
         UmQOtPr6AoARul9hiylfHRRR/99ucz4pDhwzxGOzV3HYd9w9YG/1W+zYd2fdK+7QFR
         /tG3+5SXRynrg==
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
To:     Robert Hancock <robert.hancock@calian.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rasm@fe.up.pt" <rasm@fe.up.pt>,
        "jamesnuss@nanometrics.ca" <jamesnuss@nanometrics.ca>
References: <20220112205214.2060954-1-robert.hancock@calian.com>
 <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
 <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
 <f74e32552955b2293d814cfd14729ab190d8ddbe.camel@calian.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <5178d655-a9f0-0a0e-866c-b85b7eda69f3@enneenne.com>
Date:   Sun, 30 Jan 2022 10:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f74e32552955b2293d814cfd14729ab190d8ddbe.camel@calian.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMnxiDWInmmct3TJnCv5fB9dfFM2JarlYCsQDqVYRt1ctIfzVSERRwgIcxtlGIWhRQKfRIHzl/C+GVX2XJejJpAjnyn2hIx/5lEIl394iJJ5lOH/qHLS
 uNDf6+lY/jb+9fB7g8GB1OyjP3HsnFXy6jAkUfpqxXfZvMqyDWZokwXE1TGK5ONprCfCsgz3kxuZt51gNg/SDgsqcNwQZQLuJseVOHnB3m4x9y/hML1JNI80
 HNRcXwhqI1mMoyfAGMaIgvE3zv5IxM3buQcAOlRvxb2B30pw2w4wTNnYEVVeN3D07bYCdUBoMfbcHR71JGIVJdtOoMjgMUEMSZ6Fq5n9PT3ohAKbCM0qWwfW
 4PTWaJlzaaYG4yleDHudoubW0x2DOQxjkTX6PjuaWLtJwCsXzHzZnpvUJ4iKXtj83Xbk+b74
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/22 23:02, Robert Hancock wrote:
> On Thu, 2022-01-13 at 09:17 +0100, Rodolfo Giometti wrote:
>> On 12/01/22 22:07, Andy Shevchenko wrote:
>>> On Wed, Jan 12, 2022 at 02:52:14PM -0600, Robert Hancock wrote:
>>>> If the pps-gpio driver was probed prior to the GPIO device it uses, the
>>>> devm_gpiod_get call returned an -EPROBE_DEFER error, but pps_gpio_probe
>>>> replaced that error code with -EINVAL, causing the pps-gpio probe to
>>>> fail and not be retried later. Propagate the error return value so that
>>>> deferred probe works properly.
>>>
>>> FWIW,
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> It's not entirely clear to me what tree PPS patches are supposed to go through.
> Seems like some recent ones have gone through char-misc? Not sure if someone
> has this in their queue?

LinuxPPS has no its own tree. All related patches usually are sent to me to be
acked and to Greg Kroah-Hartman for inclusion.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
