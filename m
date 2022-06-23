Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47A5589F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiFWUT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:19:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8164128723;
        Thu, 23 Jun 2022 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656015566;
        bh=7z0s+WHf2+v1qxr7m1rw9SjbVWQ/P3W5Q+Q8hQUhFL4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QtTskdiVf9SnLc0VDy0EIhIbvpMEzrUAMWnmUFkmkUODhMQ/kqzxpJQVzZsHpBX89
         kCFS99QVz5o6YiBoT++oDJplAkjhZPv3AeBAgMSNGdOdtrU+5tCV/z6pnf/zKBNZiz
         cjYEO5nRUkXUaQEGqMKQ/UWOw5/htUwm/b9qIvUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1nJMNn1pnR-00q9Ow; Thu, 23
 Jun 2022 22:19:26 +0200
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
 <YrNLtg+BZlwKsBbF@smile.fi.intel.com>
 <2dda5707-6f13-6d33-863d-a88b89e88a88@gmx.de>
 <CAHp75Vd_ix=bJs9k6bYM8S+3f_Pw7Tvs9DhPcZxu1=33T=mQ7A@mail.gmail.com>
 <52ea773c-b5b0-fc4d-9b85-022676778af7@gmx.de>
 <YrSVozxvPZtJdQL5@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <ed24e677-4179-5bb6-54ba-5657442b9c63@gmx.de>
Date:   Thu, 23 Jun 2022 22:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrSVozxvPZtJdQL5@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R+h3v9u71I2BMWiuwJYl5ijLux5TSOJmiFNOdVkiUBhncJoBYBj
 Rpba1VLsz5PHFzMjtBa1BsosaVGfcUk1ZECJJOlVS4qskkA5UY/GboaENpFRfKFWsxMBvd9
 91FcB4CF+HNLwr8+H2xoEBkMJY56ompf3/WhsPfqj3qGjPuquDLrVq2Lmfm1vXqwHiAx345
 xPfK2FSueTie/lNWc0DiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ypiX5zbmpH8=:3CTlB2vV9+v2noZpkCw0V2
 1ToshIfaQqtoMscI0pX4QT62ADYtN+IpTCk2i7BkrnHytxC7icSm1HWVYvJwdoKZwhyW9SRp0
 xfqEHnzToVVi7We2Y+xv4O855spRcG0Y9KDFOVBuC0PZT3UZwr5zel2fNJJ63a13PcNaTvOnX
 tlMZlW4ogqyGCrkBeRlwNXRa6xG8iEZEWQHALl1mHRRcSZKQAKQ2NAQN/+sK332zRVROiXJHs
 ycPqL9BJ0/bH/HxY1nWdaT1Iq44oH2PKLOa3Tpgw5t82OzexUIOF2/YmS20KINt5HAaavOsu8
 ugSfRP99tjSz/1ZHrzq6mfFNxsniw2r/UG36ORQwCLezs4sGG2k3XJkX0S+51xwIA1tlwMTK8
 FxbSmkHGg1+A8QPutHq4ia3Tb0MQQ5ZqM/GMNgzadlr6lax0J2Q/hiRF/U6a6yPx5iNXqeU90
 kMxgZqOU3cbZqnZW+OGNrjbIG2h5nS5/YB6zVWji/p3fphtfL92u/lSfHvxHk1thsV7AksN+C
 xsn/5z9ipZo50IHuxYCzpHfYmYxpv7VEhfnP5lBsp0GaqWSVCBHXDooFK5Rxh1uqU1foPZ68t
 CSH2TLnBrZ9XOofredqSdV5NcY0myIxfLJ4FOr4FKoMKSTQA9j8iDdoNkgzl1WMNyfNDF/Ids
 NHDPssN8+4axOHqWt6Vvh3aXpvomN+NCowaYBrUle20g49spd7I/tLGGFDDXkQLUoE07jn6NZ
 1PE/2dy9ZVrzNYpCD+rCAllqrP9wT9Shm3eAIAtLit1+1+YWSbAB2QQ8yYB/+B1EuMPgS4iRu
 wiypOa1DvVby8APC0n775tUZYsXAvlpah0iMrEA9+mO8pSFOUCr1nmIS0vTD/It5kdG+g4VPw
 LTQYhDotdZYbL5pekeP1pQPhO4hzE1lwgIddL4xFyTM53QKp87QCUjCy2uHe+EwerKDk+Q4Pc
 mG2G2LhXOhjVdRcvPrft8flDrVE1WPnn4yaTcDMvwSgOHwz8QJ+nOOsWU1J4oUMTcv1ifjzJv
 GGnyzzdpKaRxCKD+qm2ozFYQsF1jxxzKgA5mZiiV/rdeNWOzpx0t5GUGpoxNGB0fVAzF128b4
 NE6awCfFITxHdB11Xh0DxC0f2HgzcllNK69RBsP/yOJIux8TkGhahtS1Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.22 at 18:32, Andy Shevchenko wrote:

>>
>> Ok I see the point. So what about changing it to:
>
> You mean adding below after the existing code in the module?

Right, to be more precise between getting the gpio and the error check:


	port->rs485_term_gpio =3D devm_gpiod_get_optional(dev, "rs485-term",
							GPIOD_OUT_LOW);

	if (port->rs485_term_gpio &&
	    !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
		dev_warn(port->dev,
			"%s (%d): RS485 termination gpio not supported by driver\n",
			port->name, port->line);
		devm_gpiod_put(dev, port->rs485_term_gpio);
		port->rs485_term_gpio =3D NULL;
	}

	if (IS_ERR(port->rs485_term_gpio)) {
		ret =3D PTR_ERR(port->rs485_term_gpio);
		port->rs485_term_gpio =3D NULL;
		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
	}

Regards,
Lino

>
>> 	if (port->rs485_term_gpio &&
>> 	    !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
>> 		dev_warn(port->dev,
>> 			"%s (%d): RS485 termination gpio not supported by driver\n",
>> 			port->name, port->line);
>> 		devm_gpiod_put(dev, port->rs485_term_gpio);
>> 		port->rs485_term_gpio =3D NULL;
>> 	}
>>
>> This would also be consistent to the warnings we print in uart_sanitize=
_serial_rs485() for invalid
>> RS485 settings.
>
> Probably it's okay, but I dunno we have much on this to gain. Users may =
start
> complaining of this (harmless) warning. I leave it to others to comment.
>

