Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C704E1915
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 01:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbiCTADE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 20:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbiCTADC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 20:03:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71D5EBF3;
        Sat, 19 Mar 2022 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647734472;
        bh=hFobiD0Av9I4hKkI1kP4GGFNq/s/44RpeMZwSfBgc3c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PqKCQoexUgpht1kHUKyWOcgIyUGvwdsEF2BKQ4ntC7CxqdifOJlD7m1jZRDrV8HoV
         gxqSxo/y/MPcb5FQDJXBPZJolT+MC5eodSMtlPUgg4lyceVyw7MRymanITcbTJbtQ5
         GHYmxd202Jzv6Q+KWJWAU5kBiBsLTGl+b/TzQKLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.204]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1oKvuw0B6c-00sdcZ; Sun, 20
 Mar 2022 01:01:12 +0100
Subject: Re: [PATCH v4 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     u.kleine-koenig@pengutronix.de, linux@armlinux.org.uk,
        richard.genoud@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
 <20220228023928.1067-2-LinoSanfilippo@gmx.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <9cf25a55-9597-74d3-7829-6422c8a5a73c@gmx.de>
Date:   Sun, 20 Mar 2022 01:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220228023928.1067-2-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AUxWCItz1tm+yKQXwbhBjD4S3BmYFzw2v+jNazO1T0kwTCkHtob
 Pecyzp8X20LCrqzhrqfQDinKYmR+24IRLddX89cKYxPqgSYzE5yq3zeyMNG/JeyXJuvCoes
 XNksQk+zEi+BQjku9iX6cgR4Bgf3Yv5b0OJMxgCEcWDJTS0ZgGvQ3d8BCRneK1uL14tG+kl
 5KSP4UDwyoJeZPqvd2JWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:USVa+vBjMjo=:YU3b7lq8uHCDGNS9biTLoT
 ci09eq5EIElP6ylgBJdoQkG75c22H3fbdRoeYsBXFCveZ7IqiyoVJaYy8xdMAy2dPUsYm6L8V
 QyeA50MtuZTBZjg1EnWcKYlbg8GC9kTzaS7QzVAn9FR9LPYCVt/hHuc/BKZ4br/qh5wd+3+ev
 LIgOJLv54mNCgyRuH6t6jAMDKfxMHjirhJ8/cVNrt3KUoYk96bZhSKB59wqd0xxKdWelaclBa
 yH/bm6Gaq1lbPZfF2dEoLAzmyZAm5TVNrvNCyFyELkrM0vg3GPxF8aqb6rMwB9/Ma/MxEE7/B
 NgvXNdpXKKfzrL3y5dGYLD39xGgCH6wMuFNX7EGN1qUKfavrgPOBnJgrC+/zBGW1uxuXhOlj0
 0u6GfvleGUFA6oFIQNVea1ZBxIrriS72JMF5oEZtZVMB0psslFmZklTqs8wzvbk4TsGw943lH
 +qLyWQrxXxve3cuZBRroBFkW6vgFfKxmtYzT5LNeA/Nl/O7s8HWmGMF8JCrkcHwmXQRDRsZ7X
 NOvGQlChwTIQwWPgL3X2PJQ8cvrQRQVNWDuRkvDkmAdT9rJAexFZW/4FgF2DvhNPHFfq0H6tD
 9rcblGibdNSvmHIzy9DmFUIum7J5/OTggTPSFnswYqSpWQeCPT3kWnv16cQO24PU8jYHPrSNZ
 1exYdbSkpj3JsYmHj9ane/69lHJqLWrPOoFziqTUHcc8f5s3V1KDIIBc8Ro64/Luk5fTJBleh
 +pw+nz6XbmD5HzR60WkMTAT6XwFtcSIL7fOE7DiCNgpikxWJmfvSNpcJdlTIEnRFGXFruwL3Y
 E/t4LTQwHNBuUxmUOpz9JfJugc/LaAksGp17Ua3jCAjB0mkWww5iLOzukP2YQHosdpbNauRO0
 j+4AqAFnE2uD0WvkDJTY4Q8enKVotRqb6vIzoQBGfdohEnAj8IRvhjVit7wi2YPIexQ7MJ1BZ
 rmPHt7bVL3iWLrgQLr+QGn2Q8NF21SjKHnwjegSqlGlkUMxrrs6CbbWnOoe4GsqVlFTPf0j4u
 fccIrwmBb93tk3XuWP5FiCmC6rWWcAvzvaAM3x2d/L0qWMP53H284y9G8Ycry3cslN4C3ugZt
 r07LEfxtuwD/s0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Jiri,

On 28.02.22 at 03:39, Lino Sanfilippo wrote:
> Several drivers that support setting the RS485 configuration via userspa=
ce
> implement one or more of the following tasks:
>
> - in case of an invalid RTS configuration (both RTS after send and RTS o=
n
>   send set or both unset) fall back to enable RTS on send and disable RT=
S
>   after send
>
> - nullify the padding field of the returned serial_rs485 struct
>
> - copy the configuration into the uart port struct
>
> - limit RTS delays to 100 ms
>
> Move these tasks into the serial core to make them generic and to provid=
e
> a consistent behaviour among all drivers.
>

is this patch series mergeable now? Or is there anything else to do from m=
y side?

Regards,
Lino
