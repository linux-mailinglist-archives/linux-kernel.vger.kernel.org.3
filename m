Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE275650A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiGDJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiGDJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:22:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9201A8;
        Mon,  4 Jul 2022 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656926518;
        bh=HMoS1mHTCb0aYIM2kEvkDESvBr9nhP5ZQSnCcrmAqkI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WM3DaYkAIQno5AiQpSFJZ/AhXVLC53+aKqhmQ7ph6FNDS7aSVSi9DGzhzWJ9MSEyP
         6Gh35+TryZWkjGrvaaMdH61meuw4EgecIxAlQTa+99xqkMR4VXSEc96vQ+jrNTCFuj
         81bquO/UGG8enqtTrcrChOaUvbSQ1XrMkDWKhqgo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17UQ-1nRr3s2qHC-012VwD; Mon, 04
 Jul 2022 11:21:58 +0200
Message-ID: <e000058a-0f19-a598-9fba-b745a2f2bca5@gmx.de>
Date:   Mon, 4 Jul 2022 11:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 7/9] serial: ar933x: Fix check for RS485 support
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
 <20220703170039.2058202-8-LinoSanfilippo@gmx.de>
 <CAHp75VfTYv51ZcBJHR3Ms9HQWjPccigrjUxHUq4NixKXdvm5Ew@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAHp75VfTYv51ZcBJHR3Ms9HQWjPccigrjUxHUq4NixKXdvm5Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Id1qi+1KGG9/mHMREikhKJXKJOm/mC299e/p+NZbAkVEh27OVQg
 zwdMhY2XvJFVbqed0wPJ7GZ3rSRxEL7YixQ6Lqxkq5CNBgaeh7uEvnapxfMag6aDy3USTBH
 qZLnCLJBVFZXfAGxTo0ncncejiGb35pPxBh69g483NaeibrfCX11vmTzTN7rkOuohhTWJJJ
 9dJ/rmLbAYhhGt/q4yGCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:acCP9qqwCv0=:ZPPf5ravFzQ+wjQizxVBmy
 jeewtXeAw2rGN3XPgRCtHqK3Cdr4FnkXsNI+nVeNWeroBol5I3I9kxz+IdTLNxZFSZQhBZGcP
 50jop2Fyw78WHlhYJnO8lwDMFvBxgF4LGhyxNbwwWZSS05ZxSX9Qjvk3ACqdeLABFdhZg/jDu
 5PVHPBEPpotDUbWi2rqzRkS8f2WssgMo4kw93/2z0nWqkooD16SVrQCsVAXP0LR+SsPG7lrqO
 zdOWFdbp5AjXSs1/DH41FGcNg4A5gGXn29lMzRZMUW+NeydKBswhqCeTa7VFj1qVc0q/hVM+A
 cUByeL6DaOKbba+tkbCoPBgP3FO66drIBwWJCMlOwCkp+/cvlgj6qIR0cKn6FLbVZ1l+Uqafh
 ueRDIOh0iMaJimfUZdZxmtDxCXEkKUofbyYaotRlZgdhQBVGgGETyyXA8TriqimsPmLrX3NFd
 Bovt7WEOqQ7M955ILMdbXkLtDH/DiaXKPzOcZFkwLy98ttlsNB0XTFHuN/FowwEy9KRpS8gvD
 Jpr+BgZfzRU4NfXM9jXQAv2jQEKmVURIwdTYs0gxJG9zSb9nh0izcKGs+Lfjqza8F0zjOAt8k
 Nms3urCYkFX96/OXMn/NM8219Y99qB6JKDraAy75JGXwGk5xFzvI5rySTKLzh64tZ6thVxUY9
 /DS+DQ94p8kI66NBmsSF1iDb7RRMEptjDj7qbzXCKpqCgzI+DIPQLxpR4bsguVpkUWXshniNN
 W3sgH48n+68R0GCIKWFiQfVxQtNZZojT2YA22ljlhCtQsbWoLRIW1QV8m0zHoU7EuYt7NDDT8
 gzvMZrFbv0IPza8pejF8pGZ/eDsmBvPRvj6LNySTmziC9HhH4DualX2/dOuE/3+11YHEHc9XT
 O/Qz9usxjs5iXHKf3q69hHBeBTTpmLoCSpx+hq5l0YaqGIdVAZjpPL1+sRNGz9VRSaUcKSYP0
 YgIrAPRVlUDFn9iqkTx7YTks35U2Ul8nWNHHR3kAfFyVYJ2K72c0WT8KmemfuQGT9bei6pyFh
 ep/8m9N0pDkRlPlRMh9NeOWZ2/TOT3gggN+zudv1gtxex+tikSYDRcIwWJ9BR0rJ7PI2xcbPa
 HA+5TG+MpXSR3HbAqNWxRCkuaLFKdvg+oiY/ze6rYCi8jgcHemGlknc9Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.07.22 20:39, Andy Shevchenko wrote:
> On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> w=
rote:
>>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Without an RTS GPIO RS485 is not possible so disable the support
>> regardless of whether RS485 is enabled at boottime or not. Also remove =
the
>
> boot time
>
>> now superfluous check for the RTS GPIO in ar933x_config_rs485().
>>
>> Fixes: e849145e1fdd ("serial: ar933x: Fill in rs485_supported")
>
> Is it an independent fix? If so, it should be the first patch in the
> series, otherwise if it's dependent on something from previous patches
> you need to mark all of them as a fix.
>

The fix is independent, patch 8 depends on the fix however. I was not
aware of this fixes-first rule for series with patches that are independen=
t
from each other. I will change the order accordingly in the next version o=
f the series.

Thanks,
Lino
