Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DE05570CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376548AbiFWCAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiFWCAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:00:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4841A8;
        Wed, 22 Jun 2022 19:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655949568;
        bh=eHLrXoaVIZ1xfowGuPkrjSutjDijEW9mNY1mSSTy7Hs=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=dVxayAJtkrKhwCe8TAok0nyRmqcUoR/obTtkgJ73SdCpCAfxI1YvayXkd8jAABJLB
         RhPekNgr0zWGV2msj/svCbaK12vILTcFW3eIrOuT9JcmBLN40QZ/R2E2RJehlrvftT
         3/v/3A4rQoe0JRZjUBhqsdiilf1CuQF7cma0tkIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1nbzTy32Cc-0180Px; Thu, 23
 Jun 2022 03:59:28 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
 <YrNLtg+BZlwKsBbF@smile.fi.intel.com>
Message-ID: <2dda5707-6f13-6d33-863d-a88b89e88a88@gmx.de>
Date:   Thu, 23 Jun 2022 03:59:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrNLtg+BZlwKsBbF@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1h6TWrYpfJlbjpVfY8XbPGnncDZ0s81dGshYVaZQhCahGxzh20d
 2PQcSUMKU/60rn4UawD2s2L9Eovlnw35HjykR4G7onljbtwQ5t8NoZpI22IBCPWvcA/ucDP
 /fDNCkCCt77EOIWr/2DQVypWMx2/R0HhEpktSIgvK96AFXuPZMAxtGGdqtvHpHiXvTg/679
 hNatqpKiYPA+mYDPULOmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J6FyruJLVLI=:AUQtvNTc+wsJKhm6A2Ij/2
 BVwnrDgOse//leMfUapxhuBGd/5ButtZsKBy1oOEXJ0NSbaku34B+ylYPHJ1UJVWy5KO/RMfg
 x82ZksE29wEETS3T+6x2R8QKRn32qfehAF6lPQHmWur5BjWjIkgT5MQnZipUWpfh+JtjM7pFb
 FMyKOFg0L6HQTJlOvDLG9rxonntBHwezWN2guUurgVxJTQJsCVHeCG41aolkev7eTvpEFyjqY
 iNZWxMVsWZlyEooViSeOIx5W8ncMrtkHtx3maorkgEjPEO02JBvMvcJv3PhfvIpRaEDfSzk8a
 94MRYWFsvNT0sgYc4GZbJ2hHhxi9iCpmJyLcREIANu1ZTBKebVPNFKq7RP6YKOnjH10e74msL
 7THz65ICyn9qQiRXPFugVnOk7peXcg6+qluvSU5baP0lJQtoIpp9zLV+Wtz+KtGDjcNEUWeQG
 ejXeARIiFkoib2lwGm8MgWuR52uOauUXdZ9ZPF2LlbP/kKzOQjP9w5WSfKpjrYvkqrATs2pYg
 ndFDDuGlm75vRWMNY0Tgq8NEYCoUNs5rItjrnUQUr0ZOf+ioZ5h4VXnytk5BmaG/6oAF4M0Yi
 Irl/dw2Q0xlkPlfPxxMNGYc777S7bGf/gZ2po5xlDlP55hDXD/TSb1P/8M3FZvKwAiFIads3Q
 Cd7O+8qYHfAG8BOeBnQhQkmxMJgPYuYxqvk1SqyBywQRnAAaGhXzWCLLznStF+vvNfzlF0eP0
 QSFe7nIB77BBen3nBGTLo+5dOy4kxG7Yt0B2puZ5nFVcT9Csszy3j+IStONqlglbrJYAYnS2e
 1IqSMIWGe5HEr/+yIJyTbKbGLHQwF1/PhkEMZ4juY7iCKXZpFeShHJp8hk5p/UWGNWz6JrIQ7
 N7tyqW/Wh6jMhyuU8Tkl2TZ25YPoSladO0gVFKYGqxCn9GNaJuLYIq3DN6Ou07qPnopYk8OQa
 1Kzp61yY4YaHuuNVhUry6EhuQo4KB214QN71jWiOOFgjumIzAunN/dMTm6K5bJOa9P8kmtaHE
 +JKwvacZuosOjMpFdulHzXmb7WaBrQMNMUl4Uce1aja2UEgKp3FnVh4XlZS8yfYLHjnvv+tpt
 NVqloygSF75oUPV+ByluyzRoCsyrUfkrschW4m65bmNqTYEHShku62SkA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 22.06.22 at 19:04, Andy Shevchenko wrote:
> On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bu=
s
>> termination is supported by the driver.
>
> I'm not sure I got the usefulness of this change.
> We request GPIO line as optional, so if one is defined it in the DT/ACPI=
, then
> they probably want to (opportunistically) have it>
>
> With your change it's possible to have a DTS where GPIO line defined in =
a
> broken way and user won't ever know about it, if they are using platform=
s
> without termination support.
>

This behavior is not introduced with this patch, also in the current code =
the driver
wont inform the user if it does not make use erroneous defined termination=
 GPIO.

This patch at least prevents the driver from allocating and holding a GPIO=
 descriptor across
the drivers lifetime that will never be used.

Furthermore it simplifies the code in patch 2 when we want to set the GPIO=
, since we can
skip the check whether or not the termination GPIO is supported by the dri=
ver.



Regards,
Lino

