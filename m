Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7047FAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 07:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhL0G4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 01:56:12 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:12930 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhL0G4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 01:56:11 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 27 Dec
 2021 14:56:09 +0800
Message-ID: <e041c9ed-ff42-a7e7-2fc5-03c96cc69a88@amlogic.com>
Date:   Mon, 27 Dec 2021 14:56:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] tty: serial: meson: add UART driver compatible with
 S4 SoC on-chip
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-4-yu.tu@amlogic.com>
 <CAFBinCB9Fre9Lea2CAm_8o8g1e3o8oX4ZONbN_bhykNXoFHDdQ@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCB9Fre9Lea2CAm_8o8g1e3o8oX4ZONbN_bhykNXoFHDdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
	Thank you very much for your reply.

On 2021/12/25 1:25, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> On Tue, Dec 21, 2021 at 8:17 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>
>> The S4 SoC on-chip UART uses a 12M clock as the clock source for
>> calculating the baud rate of the UART. But previously, chips used 24M or
>> other clock sources. So add this change. The specific clock source is
>> determined by chip design.
> Does the new S4 SoC use an external 12MHz XTAL or does it use a 24MHz XTAL?
> If there's still a 24MHz XTAL then I think this description is not
> correct - at least based on how I understand the UART controller.
> 
The S4 SoC uses 12MHz(UART_EE_A_REG5[27]=0x1,the bit is set in romcode). 
This register description is the same as the G12A and G12B you know.

> SoCs up to GXL and GXM had an internal divide-by-3 (clock divider) in
> the UART controller IP and an external 24MHz XTAL.
> This was not configurable, so the clock for all baud-rates had to be
> derived from an 8MHz (24MHz divided by 3) clock.
> 
> With the A311D (G12B, which is still using an external 24MHz XTAL) SoC
> the UART controller gained two new bits - with configurable dividers -
> according to the public datasheets:
> UART_EE_A_REG5[26]:
> - 0x0: divide the input clock by 3 (meaning: this internally works
> with an 8MHz clock)
> - 0x1: use the input clock directly without further division (meaning:
> this internally work with an 24MHz clock)
> UART_EE_A_REG5[27]:
> - 0x0: use the clock as configured in UART_EE_A_REG5[26]
> - 0x1: divide the input clock by 2 (meaning: this internally works
> with an 12MHz clock)
> 
> While writing this email I did some investigation and found that
> UART_EE_A_REG5[26] is used in the vendor kernel even for GXL and GXM
> SoCs.
> So this probably has been introduced with the GXL generation (and thus
> is missing on GXBB and earlier SoCs).
> Also UART_EE_A_REG5[27] seems to have been introduced with the G12A
> generation of SoCs (not surprising since G12A and G12B peripherals are
> very similar).
> 
> Does the UART controller not work with divide-by-3 (as we have it
> today) or are these configurable dividers to reduce jitter?
> 
The UART controller can work with divide-by-3.
The chip history as you described above, the current reason for using 
12MHz clock is really what you call reduce jitter. The UART mainly 
connects to Bluetooth and uses typical baud rates of 2Mhz, 3MHz and 
4MHz, so 12MHz is used as the clock source.
> 
> Best regards,
> Martin
> 
