Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FC483DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiADIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:20:37 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:39621 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiADIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:20:36 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 4 Jan
 2022 16:20:33 +0800
Message-ID: <1f16f430-677e-d1f0-1a7f-bf1d1a7c3c47@amlogic.com>
Date:   Tue, 4 Jan 2022 16:20:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com>
 <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com>
 <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com>
 <CAFBinCB2nF0TwRE1uJ4UTB_avcqRBfOHR1CDSe29dB1o-YjEHQ@mail.gmail.com>
 <7278bace-a2b9-0cfc-55b3-c19311e3352e@amlogic.com>
 <CAFBinCCwE1DbP+Y49o3WxNdeE11ZK=HcGbXa0Sq52tch+eNhrQ@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCCwE1DbP+Y49o3WxNdeE11ZK=HcGbXa0Sq52tch+eNhrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
	Thank you very much for your reply.
On 2022/1/3 3:36, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On Sat, Jan 1, 2022 at 2:30 PM Yu Tu <yu.tu@amlogic.com> wrote:
> [...]
>>> Interesting, thanks for sharing that u-boot turns these clocks on.
>>> Let's say someone wanted to make u-boot save power and turn off all
>>> UART clocks except the one for uart_AO (where we typically connect the
>>> serial console).
>>> In that case the pclk of uart_C (just to choose an example here) is
>>> turned off. Would there be a problem then accessing the registers of
>>> uart_C before clk_prepare_enable is called?
>> The way you describe it, it does hang. This would not be recommended on
>> actual projects.
>>
>> At present, AmLogic chips are older than S4 Soc, and we have no way to
>> deal with this problem. We have to tell customers not to use it in this
>> way。Customers rarely use it in real projects.On the S4 SOC we will use
>> a clock like the UART pclk to control the shutdown using two registers,
>> one safe (need to operate in EL3) and one normal (EL1). It will only be
>> closed if both registers are closed. This mainly prevents misoperation.
> oh, interesting that there's some updates specifically with the S4 SoCs :-)
> 
>> With your experience, I'd like to know how you deal with this kind of
>> problem.
> Before this patch the driver simply turns on the clock from within
> meson_uart_probe() (specifically it does so in
> meson_uart_probe_clock()).
> I think there's advanced power-saving techniques. Maybe for now we
> keep it simple and just enable the clock(s) at probe time and disable
> them at driver remove time. What do you think?
> 
I agree with you.
> 
> Best regards,
> Martin
> 
