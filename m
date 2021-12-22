Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1247CE72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbhLVIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:44:27 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:9185 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbhLVIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:44:26 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 22 Dec
 2021 16:44:23 +0800
Message-ID: <81e31307-609a-bab4-0241-33d574b7ef44@amlogic.com>
Date:   Wed, 22 Dec 2021 16:44:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/3] tty: serial: meson: modify request_irq and free_irq
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-2-yu.tu@amlogic.com> <YcGCj2jGpzl+sKcT@kroah.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <YcGCj2jGpzl+sKcT@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/21 15:30, Greg Kroah-Hartman wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Dec 21, 2021 at 03:16:32PM +0800, Yu Tu wrote:
>> Change request_irq to devm_request_irq and free_irq to devm_free_irq.
>> It's better to change the code this way.
> 
> Why?  What did this fix up?  You still are manually requesting and
> freeing the irq.  What bug did you fix?
> 
I think this is exactly what you said. It's not necessary.
>>
>> The IRQF_SHARED interrupt flag was added because an interrupt error was
>> detected when the serial port was opened twice in a row on the project.
> 
> That is a different change.  Make that a different patch.
> 
The main purpose of this change is that I found some users in the actual 
project with the following usages:
(1)open(/dev/ttyAML0);
(2)open(/dev/ttyAML0);
The open function calls the meson_uart_startup function. If this is the 
case, an interrupt error is reported.So So the IRQF_SHARED flag was added.

I'm going to do this for now, remove free_irq and request_irq 
function,then add devm_request_irq in meson_uart_probe function.
This solves the above problem without adding IRQF_SHARED.
> thanks,
> 
> greg k-h
> 

