Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB80448D578
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiAMKMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:12:21 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:44691 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiAMKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642068733;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gjSeIaAVPPUOlY0waP3Qt3bcY7tgnjSTzfK/vzsotbk=;
    b=W6jVuclrIweWyP3Tk9Ry3jRW8ZMFFe8YWpxygzZPa0Sb0G19l+h6Zo0sGGvauzcWPW
    s4oGisDgwCL7TCn8UK1ZmHoFlVoTs/TvqW/rTg92Q14+f8StKhjmlo1nRCAAOrJx6KxR
    l+KjveyU9mDfS4JyGoMqowzIo4J0ABaFOTf5Y2M44CYriMhWAmjSfFiS7HjMtANck0eV
    allkxys2WEKi2zz6N2WsVDpJeW9hDnKJaxiHWOCD6txN4GtzZ+/8MEWZ5P/D7wWsChXT
    XhvfTI/kWEAJ/yDjCDTAlG+AifocRmXZ1oTggsBhsYqhrGdMZLC8n4GI+I1cVSxzvEFh
    z30g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/BEppjnAC9QlFFS7UbO3fgyYpMDJqZr"
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id Y49088y0DACCQvK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 13 Jan 2022 11:12:12 +0100 (CET)
Date:   Thu, 13 Jan 2022 11:12:12 +0100 (CET)
From:   Jochen Mades <jochen@mades.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Message-ID: <1489312180.3256431.1642068732902@webmail.strato.com>
In-Reply-To: <20220102100710.GA29858@wunner.de>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_3256430_984438116.1642068732902"
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev33
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3256430_984438116.1642068732902
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

> Patch is correct, but commit message could be improved:
> 
> * Subject should be in imperative mood (by convention), it should be
>   prepended by "serial: pl011: " (in line with previous commits touching
>   this driver, use "git log --oneline amba-pl011.c") and the trailing dot
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

Find attached the patch with the new subject and corretced commit message.

> * Add tags for the offending commit:
> 
>   Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
>   Cc: stable@vger.kernel.org # v5.15+
> 
> * Be sure to cc the author of the offending commit.

Sorry I don't know how to do that correctly. Can you please give support/hints?

 
> Thanks,
> 
> Lukas
> 
> > ---
> >  drivers/tty/serial/amba-pl011.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 537f37ac4..1749c1498 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
> >  	    container_of(port, struct uart_amba_port, port);
> >  	unsigned int cr;
> >  
> > -	if (port->rs485.flags & SER_RS485_ENABLED)
> > -		mctrl &= ~TIOCM_RTS;
> > +	if (port->rs485.flags & SER_RS485_ENABLED) {
> > +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> > +			mctrl &= ~TIOCM_RTS;
> > +		else
> > +			mctrl |= TIOCM_RTS;
> > +	}
> >  
> >  	cr = pl011_read(uap, REG_CR);
------=_Part_3256430_984438116.1642068732902
Content-Type: application/octet-stream;
 name=0001-serial-pl011-Fix-incorrect-rs485-RTS-polarity-on-set.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-serial-pl011-Fix-incorrect-rs485-RTS-polarity-on-set.patch
X-Part-Id: f1625624c73e46c9af41987e48acb7b2

RnJvbSA5MDY5MGIzZThhZmJkZmJiYjVjZWIwZjZjZWY0MGVkMjgyYjFjMDA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBqbWFkZXMgPGpvY2hlbkBtYWRlcy5uZXQ+CkRhdGU6IE1vbiwg
MjcgRGVjIDIwMjEgMDg6Mzc6MjYgKzAwMDAKU3ViamVjdDogW1BBVENIXSBzZXJpYWw6IHBsMDEx
OiBGaXggaW5jb3JyZWN0IHJzNDg1IFJUUyBwb2xhcml0eSBvbiBzZXRfbWN0cmwKCkNvbW1pdCA4
ZDQ3OTIzNzcyN2MgKCJzZXJpYWw6IGFtYmEtcGwwMTE6IGFkZCBSUzQ4NSBzdXBwb3J0Iikgc291
Z2h0CnRvIGtlZXAgUlRTIGRlYXNzZXJ0ZWQgb24gc2V0X21jdHJsIGlmIHJzNDg1IGlzIGVuYWJs
ZWQuIEhvd2V2ZXIgaXQgZGlkCnNvIG9ubHkgaWYgZGVhc3NlcnRlZCBSVFMgcG9sYXJpdHkgaXMg
aGlnaC4gRml4IGl0IGluIGNhc2UgaXQncyBsb3cuCgpTaWduZWQtb2ZmLWJ5OiBqbWFkZXMgPGpv
Y2hlbkBtYWRlcy5uZXQ+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYyB8IDgg
KysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKaW5kZXggNTM3ZjM3YWM0Li4xNzQ5YzE0OTggMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKKysrIGIvZHJpdmVycy90dHkv
c2VyaWFsL2FtYmEtcGwwMTEuYwpAQCAtMTY0Niw4ICsxNjQ2LDEyIEBAIHN0YXRpYyB2b2lkIHBs
MDExX3NldF9tY3RybChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25lZCBpbnQgbWN0cmwp
CiAJICAgIGNvbnRhaW5lcl9vZihwb3J0LCBzdHJ1Y3QgdWFydF9hbWJhX3BvcnQsIHBvcnQpOwog
CXVuc2lnbmVkIGludCBjcjsKIAotCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9F
TkFCTEVEKQotCQltY3RybCAmPSB+VElPQ01fUlRTOworCWlmIChwb3J0LT5yczQ4NS5mbGFncyAm
IFNFUl9SUzQ4NV9FTkFCTEVEKSB7CisJCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4
NV9SVFNfQUZURVJfU0VORCkKKwkJCW1jdHJsICY9IH5USU9DTV9SVFM7CisJCWVsc2UKKwkJCW1j
dHJsIHw9IFRJT0NNX1JUUzsKKwl9CiAKIAljciA9IHBsMDExX3JlYWQodWFwLCBSRUdfQ1IpOwog
Ci0tIAoyLjIwLjEKCg==
------=_Part_3256430_984438116.1642068732902--
