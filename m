Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A58483185
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiACNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:44:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:51753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbiACNoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641217444;
        bh=yaQHdpEO6ELc+KNDCcxAhySyf6kSbKGGUg4JlkIvxk0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LVGk9sFHCtOReTe3gdC1AG3e2q4l4s5WOJyddP3SuCGRF+jLNgquia4wTGSnOqj1T
         fLZpHisCbUAkt72OfBAJgB+KRG10kZ2jjiHlC7OKdRE+666bvLsCqCZ2DIavhJRFig
         Dj4flvEcl46zpxtXItc8nHXqz7Nramv3yo1yOTHw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.72] ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1mrKon21Uv-00V7hl; Mon, 03
 Jan 2022 14:44:04 +0100
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
To:     Lukas Wunner <lukas@wunner.de>
Cc:     jmades <jochen@mades.net>, gregkh@linuxfoundation.org,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
 <0e0e91b8-72f8-aa31-50e2-80090dd5613a@gmx.de>
 <20220102182801.GA22268@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <769e26e3-6ebe-5d41-484e-3aff033f00c5@gmx.de>
Date:   Mon, 3 Jan 2022 14:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220102182801.GA22268@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q20d/Pz6LffTlZL9sbytzXuMFoNESX16SsIkXD1fI8D/Ght3ib0
 PiCTumtGXkfbFJNM6deKjJKJPYsXigfp2R4LgPS/GdTY/WLeusNpM2VaZwINyq8K7hMT+VG
 FQEllyIY/JybHOX2baxk5Jh44JsMyogTzW2akotGUhY6dnT1jedARuNtvHjOh3vAXOATPkI
 gjI8bRKCzKzBmUvG6U2bQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CtiThadKlqQ=:HKMg+As/KGnUlblU2i9f+6
 4IVIew8mHSQXYSA/hUkNVhg2DlC90UgrugyLRp4s8/9wlvlBkWHwj0ibwHOLoXy+BvhXcdNCy
 plcbxpTvD1BdRkI0PntcUtCPEOa4Y/LJZnAjKWDrjGfYIIoQ42aeoDS2pRe7jznVhQrLFCNvg
 e4GjGyEWHV9vtjPyoW2wk+Oo1ejcAvtNl54+tNgC2MCQHV/r8+eCKouCyVX5ShMid08laZ02J
 XkOzwVbYMoAGKVfolPparpGoKrHwNQE/9Tj1MXwcPbZTMFSIcyPx7sbMyQgc01/uklQQlW/vi
 iFy5MNQvhZ71xbFEbVnwmpcIrP0+8Qzrw2xMV/0kUxf6twKfDBkKAHmcQJ0H01rLzV2RfDQEw
 m9Rd+sifj0tVQIFBm3xZiktQSZSI01NXTCAcknEXSBHia7r7kX2IxZWwpF4GV9NAyfTzFHqAv
 J74mgX8igKoEw92VpbfiN66+yrk+5hFgbuXhT/+Sr3ixC0r8mBObASAZc4G0w9RcmUMn+XMk6
 Uu4Gqq8xdDwakNtAGHnLu8zVS6afdgSMvIW83DdY7S5Z7OTvt+wJ1lECvwXy2/O15efVm2Kjn
 Op6pzBtOHYoN4NM+RKSWWb70KIlv4OYBH4FtmrdPUAy7bpssLqezQrCiKPr5CoydUBOf3DnP8
 5RG9Q0Vo28OhVNTxt6TCapBOdo/FJEcyLo5riSNO7nP9JYJNYy1LFpyaJUojf72YzDOmoR0hW
 fNw3DgSigmOhXvMhsr5JYg2Whg69Kjljt5lexnVHNeCnzkPhIYJed7E3RwzIMb09X+K/5kEjX
 DmwVfOz064HKo079cWOOzq15H4wJxdhqp3zo10TStjjf7WB1ttXWJCBLrlJ7poKc1/DD/9j3I
 GQ0ne5ym50Z7l5Xyjs+Ltr9uMsBVlW/A4Xv+fV/kFJdJDX5zcXWQycTlbCIkK61w6uqN0IEx+
 Dtpjz7iWiwIx8OSSzeNl0kSj7r2aEKYvle2rtF/buiz2XzoZt2chvjBZtx39MUIm/W+1ViZIa
 /WxqAu78nMq7iBbnUQQeJnichlRMwEm8eGCIQrGQqqNKR+L27fASDUxMQGeZBf5VLFSsCOWU9
 24bT3pd7w5YJZE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.22 at 19:28, Lukas Wunner wrote:
> On Sun, Jan 02, 2022 at 04:06:53PM +0100, Lino Sanfilippo wrote:
>> On 02.01.22 at 11:07, Lukas Wunner wrote:
>>> On Fri, Dec 31, 2021 at 05:15:14PM +0000, jmades wrote:
>>>> --- a/drivers/tty/serial/amba-pl011.c
>>>> +++ b/drivers/tty/serial/amba-pl011.c
>>>> @@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *=
port, unsigned int mctrl)
>>>>  	    container_of(port, struct uart_amba_port, port);
>>>>  	unsigned int cr;
>>>>
>>>> -	if (port->rs485.flags & SER_RS485_ENABLED)
>>>> -		mctrl &=3D ~TIOCM_RTS;
>>>> +	if (port->rs485.flags & SER_RS485_ENABLED) {
>>>> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>>>> +			mctrl &=3D ~TIOCM_RTS;
>>>> +		else
>>>> +			mctrl |=3D TIOCM_RTS;
>>>> +	}
>>>>
>>>>  	cr =3D pl011_read(uap, REG_CR);
>>
>> Does this logic really have to be implemented in the driver?
>
> No, it doesn't have to be and indeed I'm working towards consolidating
> it in the serial core with this collection of patches:
>
> https://git.kernel.org/gregkh/tty/c/d3b3404df318
> https://lore.kernel.org/all/f49f945375f5ccb979893c49f1129f51651ac738.164=
1129062.git.lukas@wunner.de
> https://lore.kernel.org/all/e22089ab49e6e78822c50c8c4db46bf3ee885623.164=
1129328.git.lukas@wunner.de
> https://lore.kernel.org/all/bceeaba030b028ed810272d55d5fc6f3656ddddb.164=
1129752.git.lukas@wunner.de
> https://github.com/l1k/linux/commit/532ef2ad757f
>
> The last of these removes the rs485 logic from pl011_set_mctrl().
> I'll post it once the others (and Jochen Mades' patch) have landed.
>
> Even though the logic is eventually removed from pl011_set_mctrl(),
> Jochen's patch makes sense as a backportable fix for v5.15.
>
>
>> It looks as if the serial core already takes RS485 into account before
>> calling set_mctrls(). At least I get the impression when looking
>> at uart_tiocmset() and uart_port_dtr_rts(). Also other drivers like imx
>> simply seem to ignore RTS in case of RS485.
>
> The logic in uart_port_dtr_rts() is broken.  That's fixed by d3b3404df31=
8,
> which is queued up in tty-next for v5.17.
>
> The pl011 driver papered over it with its own rs485-specific logic in
> pl011_set_mctrl().  But as Jochen Mades correctly pointed out, that
> only worked correctly if RTS is driven high on idle.
>
>
> The logic in uart_tiocmset() is correct, but not sufficient because
> uart_throttle(), uart_unthrottle and uart_set_termios() need to become
> rs485-aware as well.  That's also addressed by the above-linked
> GitHub commit.
>


Thanks for this information. I have one or two patches prepared a while ag=
o that
aim into a similar direction (move RS485 related code out of the drivers i=
nto
the serial core). I will send them in the next days.

Best regards,
Lino



