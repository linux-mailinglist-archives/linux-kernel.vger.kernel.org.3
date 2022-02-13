Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC694B3D76
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiBMUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:35:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiBMUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:35:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291653706;
        Sun, 13 Feb 2022 12:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644784523;
        bh=Cpfn90elRMfLDzVx1L0uUsc/bngOYlVfTxhI1KBAubs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QXbayB3CLJvUIrtr2HCtBtBb/9Kg/W9P6C/x8te4PK/cgiwOmNIohBi39+8xjCwuQ
         PSAzLp2K00mFT/7+Pjak2e5OV16l4E8xZCTfJiQPIPEDEgtAkWYxQFNJ+ya2YCMhkf
         T8gyrjPOdoFGGL3zd18Wzbdtgmh+obv9Xx87LBDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.238]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1oFSQQ1Wp3-00wnYQ; Sun, 13
 Feb 2022 21:35:23 +0100
Message-ID: <0baabcbc-196e-08fa-e2db-b7e925993cc1@gmx.de>
Date:   Sun, 13 Feb 2022 21:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] serial: parisc: GSC: fix build when PCI_LBA is not set
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20220213193903.8815-1-rdunlap@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220213193903.8815-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VtVfDMh6PpTirPXZK3QeaRFqqIwIHU/pf/eKlHf4xg8mCtFgPqM
 0un+1BVwxQPBWoD2z9yHZZlDQAqqUZKUXLQUM4+bWHqW493Xbq2ARTFm+YnIeZCWUeA9Npy
 vhHQlWhtBg2ZidCPPkC/pOpMLmcLpy43PKBZyQZqXK/2sljyhd0yyX7zVv39db+Ye+dDYBS
 wo1ZElku24Y2XB23QpP0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VluQsaZyw/Y=:5jh84tWLI+vZjJ7skyNgVj
 UU1YMjeJbJmx5zdnLLl8VzaE97CN7qjXX2+j4sQIqJAn4d+G/XE+rpOrdQgTP9NMkPdLDiy22
 ILBMayVofTwKbJMTcJ/XTRKSlUMyJ6CTuL6QarwvUk7XFHhZCpAxvNe/yfWy28Pi/WKqQl+oB
 wVnrrNLiF+a/vcWMOY9TjMMkgp7rttocA98xnFBdjt84Gc9VydlU+JYFR2iuD0xNLt+IbgRv5
 4zhsPt9O0w0yyUSlQ9qOa/WOyhRH/jxJ5/A2ShPDFze9ea88vlPDmG7BHdpZR6Y5uQ2U9rxoR
 BvpPUEltnRLVFJghijGBMWcTOZPCQ+Cgl6a/KpwPS5GdS2y2SvXYC+4QpFyJZ2UPnIxuy6xWo
 +lJKvoOAgxIOTOrwB+/vd0680GWxnMJw5ihx9+jpXQXnC7I2RFc1/zoBWN/w/DN+Zd8gfWEMp
 smz/lnVIzPKfmKmBk234+a34Vsu1KbTRu1aQ0B9IJIMJNZx777Qw0Md0cjb/X0fVsG+MM/W2+
 iJy4fll8z/j8ustxQLYDECcWshriZUfOV3oCTBXXzPO9HSv9kZBqdo2sbn5mrLo7eDhQfp0iL
 a1eO8NM4JEFUOfvRw+1k8wU2oWQnGLyGVGJf8GF0vUOi8A7vvjXVmYzF89qyK81R8/Rd4ALIR
 ebYV/bSsedDe8hY9Um17iHvYg4lWICqrL1iNBWRoQZgdy7a/yJHMonF/w3atLNqkY/oRhlwrG
 gbMSeAug8INydJkuMGuy/BekMiZJzs+cyf8EGvLQ2YrbQFZcEvhuuywzrI51mqo3fVqaLxx25
 NzkA4Iy/JWNRDwqS4bqELQgwIBMuFI2QBQTgxMIbCXbL05NDAqaCjiQusPuUW77GPQLVR2Kok
 cFj1QNZFLURv46UNo6gl4rrq6NfWP5D+JtkTdawGbFhZAskzpDkq2u5W4n2heMS2CxlPg5CYm
 ZFQI+5b89PQWNiua7TM++LCvqNLCtdIRHTRCQ/Cakv1nFf+3Mbw+1/Frst2e2bHE60y5wa6iO
 yhGT/XjDDbARyIvjh/UYbegGF47RnJ6zBfq16xn1FaWEOM9aPFE5kDVTb4CjGntg+0sodGpKA
 hbX0P233+uB/Ic=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 2/13/22 20:39, Randy Dunlap wrote:
> There is a build error when using a kernel .config file from
> 'kernel test robot' for a different build problem:
>
> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>
> when:
>   CONFIG_GSC=3Dy
>   CONFIG_SERIO_GSCPS2=3Dy
>   CONFIG_SERIAL_8250_GSC=3Dy
>   CONFIG_PCI is not set
>     and hence PCI_LBA is not set.
>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>
> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.

It maybe makes the build error go away, but ...

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>
>  config SERIAL_8250_GSC
>  	tristate
> -	depends on SERIAL_8250 && GSC
> +	depends on SERIAL_8250 && GSC && PCI_LBA
>  	default SERIAL_8250

The serial device is on the GSC bus, so if you make it
dependend on the PCI bus it will not be useable on machines
which only have a GSC bus...

We need another patch.
Do you have a link to the build error?

Helge
