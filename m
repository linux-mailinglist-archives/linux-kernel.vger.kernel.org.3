Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D543D5641AB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGBQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiGBQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:51:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1274BDE93;
        Sat,  2 Jul 2022 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656780663;
        bh=mUyhruXIhmuUViMeDFbRQp4XSTkRwYDiNt+WsCvGuuM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IAv5TECA6DaGDanu4F2UESXF9U4moCqIxQji5xOqiyBEcqkHYY6nfGeJy9vMUCEeH
         CEo2AWjmKthmW2XDuFNd+PGaGDVhDJnJ9Ewwb8ZthEs4qEX3YEQb28EWUBVY3Reh6I
         /Y8bOrvSyWmXh7j1b7mgqHSSYAPko34986YQpylI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1nr6qx0112-00Ik4J; Sat, 02
 Jul 2022 18:51:03 +0200
Message-ID: <dd7bd8a5-19e2-fc39-357a-7633cf4997e4@gmx.de>
Date:   Sat, 2 Jul 2022 18:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
 <20220625194951.GA2879@wunner.de>
 <fbce8d7e-86e-d47e-bcd8-5b99754d1d2e@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <fbce8d7e-86e-d47e-bcd8-5b99754d1d2e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KV+4xPvzh0c7cByKeFFk/pLcKFJ1ZO2uSNEEgxRyg3FJs6W66M9
 49CwH2GFa49hMrEpMPhGlXwgvKHiWeWkhZCbzE+fUo+oFH8iEd8Zl2HWpS2wXZPhVHdaqJs
 leXq7fpqRzpmIyK8+yZCGLeZYwSRvY5RB5KFL8igB7oZ6m7qLsVtxAlB0ufkvllsNyh2x7L
 gYhtSjBVzSb9SMohfo1eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gK6ld9oDcxA=:ClhnIwM/mA5AvWRKq/whT4
 vlqN9ckew6KPdywCugY9q9WBB1eWTfDTaHJcW3F9ZUHgIEqOk+XzSLwP7KT3GReWRQji/VKnw
 B3u0LmhLwS+Ci88M0h4Ta9LxE5zfxaFG/Sw+1964WrE5HYDkFr0k8IKNNukSvYjPGQFgdfkX3
 c1QwcRCCNhOJv1wpdAHtk61guvU7OtENaYGZnwlIrW6VRDiKOUjAcU4TBiwmVcIn2dARxFtyn
 6e7gS9RBXJbJdvUGzLvYOBNC10egN/hP4tn7tQd9pi0jaxKl766tgH0vYZlYVNH/saqde/nDW
 W4PTZBlp1SHkYcAwDpqBNTEOGAar5EZ64jOLBf4kE0Fry6qQsLJ/22MDXKpyfWw9/X4HVY4Ru
 oNoxRN+p6moAVOAdvHwU8ziXYmVNTS8MgACHc15vr0R3jTasfznn8S0NPrjlYmoeDxCERlNBu
 0/NAxzslsTmAij2gD4ZstA98YC/mZm6cF5N1eIucf/ehWzRmaWpxmpLRlvSQZiXwwEQiVdZAk
 7Us7+SpGyeEesQTNCEpUM9U3Pkz7v082PoIcrUp//9130HnghuozMgfJyUUhgfw/kSYvSwOWH
 sZCeaXdVzuCycsaorpb3ehKi2wzzy4dPjVmQpVE5erKV1zi3xaBr6+bRyrF0hM3sZ1jnp9BHF
 FOEgi3VrXFjUPtRV6x717bHt0jz2SK4NQwgI5k7609GYIWUzHZPbz84kv7Jyp6BUEMs+jO3rb
 gHdjWCWuknMkJWVTo4Rr8QQuHCL0627C6YyH6wT9qGtBYFHZdACwmMyautyW8XuSa/WNxxxVi
 WltMwdTyclzPTY4DKU86Sb9i03GETuX93OmB41XMljBbh8OKo8qXqY8xvC93eCwp9pHLlphi8
 x67OU+iEmIF+80BOZWSIOUkGN7jlkRStF+ncNEgoosBHvLV9aZFb1PIhKMKkYNEEEGd0fVZyP
 hbNRyrtFv9lKEjI88QHKD8xhY2qbGcb/2N784nwVDKof4Krg7fSOcXOTzfx/jOYsOzh5pqp3q
 RkfRe5xMAXArhsO3S3oAJGlbnxP3OM3cD4LDpbh0Meg5KEVsHtG82Y11d5cjq3JZSKPQb9qvf
 6JbgCcch4pAhMuMX8wIWlOdRFqEy1rBZ/dvlbQB2B2foNy27TUdKMQWDg==
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

On 27.06.22 11:05, Ilpo J=C3=A4rvinen wrote:
> On Sat, 25 Jun 2022, Lukas Wunner wrote:

>>
>> I think what you want to do is amend uart_get_rs485_mode() to set
>> SER_RS485_TERMINATE_BUS in port->rs485_supported_flags if a GPIO
>> was found in the DT.  Instead of the change proposed above.

Agreed.

>
> That seems appropriate (and is a fix).
>
> What makes it a bit complicated though is that it's a pointer currently
> and what it points to is shared per driver (besides being const):
> 	const struct serial_rs485       *rs485_supported;
> While it could be embedded into uart_port, there's the .padding which we
> might not want to bloat uart_port with. Perhaps create non-uapi struct
> kserial_rs485 w/o .padding and add static_assert()s to ensure the
> layout is identical to serial_rs485?
>
>

This seems to be indeed the cleanest solution.

Regards,
Lino



