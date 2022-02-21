Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F4C4BEE54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiBUXVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:21:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiBUXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:21:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2E275E1;
        Mon, 21 Feb 2022 15:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645485568;
        bh=0PDuuvV4gPmzvIMULIgaTzx2skF6pBwzkA8LWxeWBYs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KUCzMnpcOnAEw6LofcvHN2n6O9nA8SpfBb/+00WP5mmE1UE1TN9F8PIEtdM9HnrG4
         Bl/+NuyZqF1vEcspfXWHwWAuCQQdoVGgqMuByjqmtnN+GZSfEBMBrmNno4pNxWvg2G
         SeFATGhhV81438Uk+lFJ38otyPiyNw9/RkPGthWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.47] ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1o99Sj2zKL-00vfHH; Tue, 22
 Feb 2022 00:19:28 +0100
Subject: Re: [PATCH 2 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, u.kleine-koenig@pengutronix.de,
        linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-2-LinoSanfilippo@gmx.de> <YhPcfMtE7xhykgcI@kroah.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <5982f410-9e67-f1b1-7cb5-28330fae306e@gmx.de>
Date:   Tue, 22 Feb 2022 00:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YhPcfMtE7xhykgcI@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V7fg3jJoNiscRHi8TUXjkEDwmGMmW0a/kmQgEh78znc/ax6P1vb
 i28qrvOMmhhK7zfnyTDsm28v5kH8fRfMfVac0KOiqSwkvOmc1pm81wVAO7cer9Yow7HG2Pz
 NRcM3Haen6q9cT6psBZ1RsJNuVAnLKPm/Q2ki6RNpg2ECaUC5VroC1EdSFGKmRw5l2pFbZD
 HYLIUdQt7X6TlWwQp9cLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XE1lGwkfLPo=:th4sFlrzQZgUMFeO623FK9
 HcZ2ef+g4gyj82rQbRNko5KKzi8KgnisfK46Xxqs6O/oOEcrZpjzwOn3D549TVo1wQX15H/fD
 IRcssAvGuDQPymZeI05w4LdRBMlgHvDyJkNv53travF/82iMHy0UiD9ZckUgO8jL0Edw5vXMe
 omGCcKWrtvVPkxIeGx7Nm1+t9ZJO7HtPpRgfKIiWJY6obkSxtH6afybmYFum4/wkPdgIWbZUo
 QVP6rlPAt7p2kzQySMV4iOHqyCdc7dRi/SvT/1jegK7NPDCLFD5WGcEPRSIvKro2z5plb1Rjs
 bhGmNnkGtCH7bmpiD/rWjtqijrMsRyLeXhiyu9xf6BAPbCv3j8x40SxoOiorvdNCvmQbnL/N4
 DG1ZE4Loil5uJpVfqXBKv/9ALKp/QND5+eFo6X6A9hg1FKJ9ob+qqw1ySt6mMLs+wjMLUhKF8
 PVjknepEfeui8QsBzEDpz2v3ZW/3KoYDCzi3OPOoqZaKK4bZjgccxpRM+YBScWWlOyl/7wQyt
 WFVCvuzIYVusJ8GtdUwN0PqfvI3hoUAl+MUL4kN2+aSZk0h7hmT2qGs8F9aiFq8k5px0E9RYX
 aCmQe8K4lSPZZE4s2LpLzLTzdSbqCo2UzBcB/YwAJGocDTJASQJAPUiMY07mxKt/lvqxBqpJH
 Lz5vIV2VLzYfDDtAu0HpKVv2cgQNbn6rWqocRH5teJQOYnfNi89AX9tSlY/17Lh9umZnGeyy5
 p0uANROfis4tSq9VwIo8t2FHoUGsOxqF9AIvviSMSNbEDVorsD/t0fIVxjqiBr8c9vrnU0Ou8
 7XXC0GlIyFadUt7EYUgM/Q2jQ7IAcpOQyJUEoMdvfMmZj/h32ukL/I2GFI4jFI+ivetlZ+vdW
 SpM2fnbqoAbsvxOP4DnpKHuNxaz43ITVtyuflt0n8QtlxLJ0vHF1ANsfuxFIjOoKqYOJbPG1O
 RGu43XaqZlHjJVyKWrm9sX970sBYBgdEiJXSUhJ16jy8wHpL8u5Bb7PVW3V1H8BDEqnhHTi5+
 jFTiEPKbtPlPvgCYH8axBCTrdYoJ4iCPFybPQ0P39YN2hTZ4LnhsLCPW91YCCu9gIdV1cIgMo
 xRygjpsitjzL2A=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 21.02.22 at 19:39, Greg KH wrote:

>> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
>> index fa6b16e5fdd8..859045a53231 100644
>> --- a/include/uapi/linux/serial.h
>> +++ b/include/uapi/linux/serial.h
>> @@ -128,6 +128,9 @@ struct serial_rs485 {
>>  							   (if supported) */
>>  	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
>>  	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
>> +#define SER_RS485_MAX_RTS_DELAY		100		/* Max time with active
>> +							   RTS before/after
>> +							   data sent (msecs) */
>
> Why is this a userspace value now?  What can userspace do with this
> number?  Once we add this, it's fixed for forever.
>
> thanks,
>
> greg k-h
>


Ok, I think we do not really need to expose it to userspace, since we
clamp the delay anyway if it is too big. I will correct this in the next
patch version.

Regards,
Lino



