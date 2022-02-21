Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63594BEAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiBUST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:19:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiBUSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:18:30 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA779108D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:08:41 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id MD6uno17DHZHJMD6unoA5U; Mon, 21 Feb 2022 19:08:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 21 Feb 2022 19:08:39 +0100
X-ME-IP: 90.126.236.122
Message-ID: <79bdf543-4882-360e-567f-493e84f09d6b@wanadoo.fr>
Date:   Mon, 21 Feb 2022 19:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] fsi: Aspeed: Fix a potential double free
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, linux-fsi@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
References: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
 <CACPK8XfxZRXtU0Bn+f0=B3CGUE8A8i9Ob_a9=2t=TzLc5a+75w@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CACPK8XfxZRXtU0Bn+f0=B3CGUE8A8i9Ob_a9=2t=TzLc5a+75w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/02/2022 à 10:24, Joel Stanley a écrit :
> Hi Christophe,
> 
> Thanks for the patch.
> 
> On Sun, 9 Jan 2022 at 21:56, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> A struct device can never be devm_alloc()'ed.
>> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
>> embedded in "struct fsi_master_aspeed".
>>
>> Since "struct device" is embedded, the data structure embedding it must be
>> released with the release function, as is already done here.
>>
>> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed" and
>> update all error handling branches accordingly.
> 
> This looks like a problem with the design of the fsi master structure.
> It's a common pattern to devm_alloc the platform devices as they are
> probed, the fsi masters all embed a copy of struct fsi_master, which
> as you say embeds struct device.
> 
> Can we learn from other bus drivers (eg i2c?) how we should lay out
> these structures?
> 
Hi,
I won't do it myself.

This goes beyond my knowledge and without the possibility to test it, it 
would be just some random trial and error (as I did in the first broken 
version of this patch).

CJ
