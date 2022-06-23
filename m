Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB445570DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377606AbiFWCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiFWCEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:04:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7D21E17;
        Wed, 22 Jun 2022 19:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655949824;
        bh=rL6VxwOlcQhp3wySuLV2AVqCnX+m+t3FXl4nhTKJ5ws=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZZwmaEkfEIryCj9VqC7uZKxRfBg1xVaL+Asbg5SQZSd2PKLffCEJAyA7+6d5DPPEy
         SHKQ8Jcb+ke+izHiwfZaeGCZI04sSEFZVNQBXaiZkVxsSYwH5cVUGGGt3shBXkY3QM
         igo9R5ZiOHICwehDeIhdxupqsmYf4Ep2x+E5m/00=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1oIzDR3xIg-00OstY; Thu, 23
 Jun 2022 04:03:44 +0200
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-3-LinoSanfilippo@gmx.de>
 <YrNMMQUYdgDz45Jc@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <7f502ad0-8c86-5029-8801-238402c48d0e@gmx.de>
Date:   Thu, 23 Jun 2022 04:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrNMMQUYdgDz45Jc@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BHxZUtz7aL7d4oKsWy5vYNIC67j+odc8NKypfMy1GloZQ3bEmOb
 ThmaeUBb1M4nT3ehnOa/eJ0ynUyqQwiSPkZxaHMn4NOlADvT2+9BBBYd/F/hIicZgJWcvQq
 RVV8l/6cGIQ7SwC7vP5L5lfB0mhgKhZnEmN3Dj/Xjg0aODb+pAYzhwoziO/sPfbVHpaPhiY
 ndFlH5HGRFb54+BCrIZrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtEHicE+FI8=:yUFwRsuReLOQVavO9hKK1d
 uvdYBUGK8F3iZi6GoL+aNxZkFYun6mOL3Ub+zJBbwxSxTzxH1Fd/KmTfmoGspV+CR1EZYsJBo
 4yduTQQBprc5gAzmGLlifyhCw3nZ8qCUPlLMAgDX2aJkB6e6ckGaBZhvBMaHKFnqY3+037+fc
 ilc4eIfEtzWvfDP5lF+DLQs7pT5XaB0adr8hzRAqa5d01hY9xwPO9BdwA/vTgJFTnsfC6a3BL
 OLnLOJCiec2wPB3j0qYgv04D1nnp6hs6vNvixo4rGXF48rO6dG9evq/1afG0YWe80ju3EV4eJ
 nSr5kkGVuEaK8xmTPpd8QVFq0T6I96ivchOTSPFK/KA5LLloNnaIiKVN8MnLpNluk0R6zR5AT
 vCx9YCUCAYQHzr8ynJeJFDeteP1NiRSpULmnO50j03axY3zXXRJxtD2wmG5t83uSAn+v/qngO
 ZOMExJ+n7YFcF3gmpKiouSwfyakxPQP8eSx6mezq2VIELAqRyxYLcGywX9nsbkEUCncTQVDv2
 sB7o2wyMUdPw89ZSqKxLYIMeW5Glk0Dy2nj1LSEkwQjhk8np1+KKmfN2egkFBUYDqc+/tz2TC
 crQz7N9nEjiQBK4tDRY0c2gRU9/Dijh5fjqzhFuXb43V5Y0cCn9YIml50D+TNXG/YPzyiT6k4
 pEeP+l/d3XvjuO+j/vztY+hRNwb/xG+Ng7xJ1G7eg+8z8mqgMnIpIFvcgQwukaOJAbDMSW3ba
 QN+kXOOLYAk1xZzXytuHjfMO33GmIBrVsy0HmUL18CsYxxSDKLCo+rZK9uOjs1mE70DnKNr92
 btitCvr8ZLzpV7pSwJEww23hcBqQDk2pgMGSxdKJ8xt6Yuyehr3Bz4XRD7169vh+C5y0KALl9
 ckXFnRYuY0RcKv9GODEdtYfiSRFltT9ZI07LJaCS1gUO3IYGlrZDfNgvhucKTS0g2jrszyZ0J
 A8FB+1Q9i3QpEDPrr2Sc9OzyDKOCFIW5KU7D+cNKJbR8yTHpBCuQKqAy5T/c7zpJCq/kMBJ3/
 R69HGuocmsFmh+OIip9HnKQJKnBi9F/CxIYa35/RDhv6VRTk4ZF5/mHLvMdaHcolZ73nBGZdW
 tgODXSbx1j4Fd3EelYHn0gXiQlI5Vi7pH/QMNHsblr+m+XQDQuuuLtrQw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.22 at 19:06, Andy Shevchenko wrote:
> On Wed, Jun 22, 2022 at 05:46:53PM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In serial8250_em485_config() the termination GPIO is set with the uart_=
port
>> spinlock held. This is an issue if setting the GPIO line can sleep (e.g=
.
>> since the concerning GPIO expander is connected via SPI or I2C).
>>
>> Fix this by setting the termination line outside of the uart_port spinl=
ock
>> in the serial core.
>
> This doesn't describe that this patch is actually changing GPIO to suppo=
rt
> sleep mode. So, it doesn't fix anything. Please rephrase the commit mess=
age
> accordingly.

Good point, I will adjust the commit message in the next version.

>> This also makes setting the termination GPIO generic for all uart drive=
rs.
>
> UART
>

Right, upper letters should be used.

Thanks a lot for the review!

Regards,
Lino


