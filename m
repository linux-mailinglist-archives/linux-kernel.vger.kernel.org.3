Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47D5482BA6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 16:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiABPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 10:07:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:33791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbiABPHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641136014;
        bh=KunESDzCXubevMtXl1PEadmm5CtsLXSTc0jxLr8BhLo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iwqJU4GsALterf+HDFBc2A8HTiXv0eglcefCuPxaZHLMdEKP1Ixlad7iAgB5RgeT8
         au8nq+yRjbQtb8B2uvkIBOY/oUiKEN+/SqqUNGRzZLVllLptuZCYDrwhSvTBkOvsNT
         PEj+fltUlxWuk8osH4IlxN3K8rw6PNTWZuxiq1dE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.47] ([149.172.237.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1psI-1n6EIn3pM0-002Eo8; Sun, 02
 Jan 2022 16:06:54 +0100
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
To:     Lukas Wunner <lukas@wunner.de>, jmades <jochen@mades.net>
Cc:     gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <0e0e91b8-72f8-aa31-50e2-80090dd5613a@gmx.de>
Date:   Sun, 2 Jan 2022 16:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220102100710.GA29858@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qfV3hFRe0cXkt7y6BdDimm8+qqNjs79FFVtbeJFHADJCqhaCTnC
 RjdYpXI1Qn2A4ECb0Wl7mcUkI+TVVZOcp1Fg2b1K1WT8PHQsCfHgYPCLkwI4Fff5J/TAr7I
 i4GTaAgOckGxz4vQoTN91zTWEPZ/En4AyO8acoQHCITWbuMMo9eTyNQ2oY3HLpH9fLex8a7
 rR9pBv2//PyYgFPWTd6pA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IZirMuAbmU8=:zoLi1rE9pZykwhMpGc8KBt
 KszDmk/jb9mtB+q/CrjWKof3UR+pmtVhYQsEP2bKAGmQSpbIqT1LNxg9POpwbw6SQ9rzl15Lk
 vzfZDPHfL99Y2CptBjXcIXe68qBYudWiyuR2qH9RaXAEZfs64H0mJv0Um1w2CBHCOQRNkSHBJ
 S1onKO4TziRj358fERfRCMcgqB67HzxdttPT5DKa+sMeGoF054hxrXrK2jzMxwITksu6w54KP
 7+w044PjmU6T6BeYh7QSojP7khyvIAyIbw74rZL+lK6azA9qh+iInadImZZClYsb0pZCpuWCd
 +PTfqRx3go7x4T/RLkIzhRDQBGnxdUcBPv8aY+A6x+DT/Obb6rU1CZN7etpJNQlwxdT1XT7EH
 La6VPQT9/RpXWBiUk21YeL4na8wvD9dJuY5YCdnNEdXtZBDHw/9DCQXK51pf6WHaBeNr8MRgm
 8X9pwVDhi5FnyScKS5z6pBAj0DlwjbFRsV+tTmnYdBjhC3Ce09eiqQpJyDjFARgKQTjADhv79
 OkIwI696D1y+avQ8ZnXPwx1767eL1SQ6s421Os6RNKS7k9ptjRAvY7QHXQdirEYGXkRuFtuUd
 bqKrFmZlM9kRXfMfDOqy98V2GJUiWRF+oZ/tCWV7uj6BubCcY+yNliXOiW2S0tpDrrXExTB/N
 ymb9kliEZW3npo2J8X/bZYGvrDfWe1QyfKI3zG1mS3kehM/Ny4F7l1DP/g4/M7NsrNqZ7HrBx
 zJY0gX2SRDh0ebe3SMLr+c16U8bF0suQFx2P/975AK2rcy3tb9tRVkzrbousI3P6A4/EvASOw
 Pnv1QC6V3fDNGr0/AotvKcd0A/wbaAr3D6O2ZDeL/Zzi5cTdETQubxfS4J335A/gtHEqIVbOU
 DijQaFrhgV8/+85dr+ock6Xxtqcy6rUfXL42+tBylatjgJ5BBb9/RB5J9JBDpZn1DampFm8dF
 l2E2KGBhNGIuexy31QhtMPXhIaa4O2OqB9Ars92MJx2HlHNIU+gpSjv7cR+eQRJZXVGYBzSBI
 bElv3vkYJrsfsdHPsyDn2oiB0T98AnRVdh69hqbm7KFDJ55ug1kTL4hGzdbq4Re1SZolynrkI
 cHv+00e9cEyWp4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 02.01.22 at 11:07, Lukas Wunner wrote:
> On Fri, Dec 31, 2021 at 05:15:14PM +0000, jmades wrote:
>> Based on the "0001-serial-amba-pl011-add-RS485-support.patch" this chan=
ge is necesarry otherwise the RTS-line will be pulled up in SER_RS485_RTS_=
BEFORE_SEND mode before sending data. This hinders the driver to receive d=
ata, f.ex. when the device is an RS485 slave device.
>>
>> Signed-off-by: jmades <jochen@mades.net>
>
> Patch is correct, but commit message could be improved:
>
> * Subject should be in imperative mood (by convention), it should be
>   prepended by "serial: pl011: " (in line with previous commits touching
>   this driver, use "git log --oneline amba-pl011.c") and the trailing do=
t
>   is unnecessary, e.g.:
>
>   "serial: pl011: Fix incorrect rs485 RTS polarity on set_mctrl"
>
> * Commit message should be wrapped at 72 characters (so that it appears
>   centered when displayed with "git log" on an 80 chars terminal).
>   The reference to "0001-serial-amba-pl011-add-RS485-support.patch"
>   should be replaced with a reference to the offending commit, e.g.:
>
>   "Commit 8d479237727c ("serial: amba-pl011: add RS485 support") sought
>   to keep RTS deasserted on set_mctrl if rs485 is enabled.  However it
>   did so only if deasserted RTS polarity is high.  Fix it in case it's
>   low."
>
>   Feel free to copy this to a v2 of your patch and amend as you see fit.
>
> * Add tags for the offending commit:
>
>   Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
>   Cc: stable@vger.kernel.org # v5.15+
>
> * Be sure to cc the author of the offending commit.
>
> Thanks,
>
> Lukas
>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
>> index 537f37ac4..1749c1498 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *po=
rt, unsigned int mctrl)
>>  	    container_of(port, struct uart_amba_port, port);
>>  	unsigned int cr;
>>
>> -	if (port->rs485.flags & SER_RS485_ENABLED)
>> -		mctrl &=3D ~TIOCM_RTS;
>> +	if (port->rs485.flags & SER_RS485_ENABLED) {
>> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>> +			mctrl &=3D ~TIOCM_RTS;
>> +		else
>> +			mctrl |=3D TIOCM_RTS;
>> +	}
>>
>>  	cr =3D pl011_read(uap, REG_CR);

Does this logic really have to be implemented in the driver? It looks as i=
f the serial core already takes
RS485 into account before calling set_mctrls(). At least I get the impress=
ion when looking
at uart_tiocmset() and uart_port_dtr_rts(). Also other drivers like imx si=
mply seem to ignore RTS in case
of RS485.

Regards,
Lino
