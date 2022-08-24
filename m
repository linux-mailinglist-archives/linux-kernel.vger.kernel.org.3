Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F45A0206
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiHXTVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:21:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89750718;
        Wed, 24 Aug 2022 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661368857;
        bh=cEGCdd30CgrUWQ0H56Vy99IDtXt1g7QCNpyfAOL1brQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C0bT28TDmSfOfZDUKFGb1p6j73bKRa3h4JO/2yqceXryl4Eq2j9ah4RqmmGhIybkq
         0SPF2UOnLry2W9e7PXf/LfqeCMrmnQi1ZoprErska3AJrEB0FQsClU+S3rp+OMwvTl
         Wv5FAfuCoD3IalIQ0+4CITJKM+3V57dp3YE9e6wY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.173.19]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1pPC2A3ASF-011iCP; Wed, 24
 Aug 2022 21:20:57 +0200
Message-ID: <559e9805-3e38-fa50-d3ce-5eee317832bf@gmx.de>
Date:   Wed, 24 Aug 2022 21:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] parisc: ccio-dma: Add missing iounmap in error path
 in ccio_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     liqiong@nfschina.com
References: <20220824093657.3365027-1-yangyingliang@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220824093657.3365027-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8+G+me1KousmzGJtM2e0ceNDHs1+YkPZFm31l+50i9bkDC+Fm6m
 dD/+5xJY/t9JLGNSyych5FsvtNWdxVtKCVe+LEWz7gjrDmZd6rS0tgJbFnic3MH6sfkN++d
 v7ZeSe049GqIJb5qKHDB32vQSHedpuAo2QKVCJeMMXt9FMzz+j+lMRowKCHHEPfb0WwalM3
 3fewfRwl1f9QjxaGaYCkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nvPYbvSR2D8=:W4KYjgiGqEk/W/EbtmrjLN
 Y9mmGSDi1aa51cLS35QKP2o+4bvoxIOFgtOuaUXl7H5mbVCvF9BaJNK1BNTFz7GZ8R3PQ2gWL
 jvF+hBro57dtzty+QbR/jL5BUPiH4yxLafId7SIphw2p3nJgKIZv8fhVHLnxT5VQ05br/6H3E
 kUf9jvbsoeJwO+HBxqejWkY0ujDbdZmiVWmUEFQ1vIOl0gkuXPo+cl7mXEh1MQ3MMbz5wZgIB
 s9Hb0i6lJg4LFUcpBzKnM2w+nnbcTk++mmuuUbWagtJozqzP1y6tN1OuCw2aU92vB5PXuHAMu
 hVn3DOwNKY7d8GelQmFOYEfJ5W2uy6fI2TsfnqcHZNj9kZ4U7lwVFr/gQ4uw7OcIC/+4G3kzU
 QQifEmAcavR5d81Po305MtvExccWfEQ0adOZEfjJEQ7pcqghpbo6XiKTuxjvBOhTrZfB7GNXz
 HXa46ZfoKMt2kRgFTwuuMC4diruP/xTYbAX5I5GLPjp5Lz6Zqg+IlHLzH95Z2xq6YIJk6D8mc
 3UMlJIY/N2uFUHMzIHYTM8wwB225GlH3aUcbftIWZTigcQpZUTlE0qK3slh8Lo14zri1mvYMX
 Qn9PoGk2wIIUrvg1NlRqWfXbUCbE2wZg1Dq33q42REKfd3ooBxKQ1zqqa3b2PCdo05GjcxUEl
 82UspImzPDGKvM/q32drvT6TR7Rl8Cu+oGunckUhfXfSqcDNOmCWL+HrhPwKGl1WN4TDK19f3
 /Lh38ratORoRLEjGtAuKA9AOjCx+iyPQTJIRXkztfkeTjWp/jv5+yYPnFMt8D+57JGq0z2heT
 qN1JHfHAXnaDa+ECjq1AUz/rjJgq4EEeXGY6Eyo0z4wXHkEZ3OlSmO9KNRPLYZekXco9p1cTb
 nL9GECkECUo6K2cI8mwtBt+qA4d7G3b0Lh486dVh4ZD1KrZU0U5e7frmbehCVXhTy+RHOiAgF
 3HOm1TS8vVTySdaS126SSwZ7d3CAQa+abqLUKkmMzUGNJzFPmJnwP8AYLwEawpvEbBmoeBnuQ
 hErmmtP1TJ0ughA3mvE1zuxHM3b6j/MC2bHrhqRgQ4RdjDCcIxg/OyxZTbZS/Z8ouequfdXPH
 hXK4QDRHTyZ6SnDEybyXTWWQhCUFFOLuqtNuK/XsKhY7o01qNfBPXLxLA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 11:36, Yang Yingliang wrote:
> Add missing iounmap() before return from ccio_probe(), if ccio_init_reso=
urces()
> fails.
>
> Fixes: d46c742f827f ("parisc: ccio-dma: Handle kmalloc failure in ccio_i=
nit_resources()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

applied.
Thanks!
Helge


> ---
>  drivers/parisc/ccio-dma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
> index f223afe47d10..a66386043aa6 100644
> --- a/drivers/parisc/ccio-dma.c
> +++ b/drivers/parisc/ccio-dma.c
> @@ -1546,6 +1546,7 @@ static int __init ccio_probe(struct parisc_device =
*dev)
>  	}
>  	ccio_ioc_init(ioc);
>  	if (ccio_init_resources(ioc)) {
> +		iounmap(ioc->ioc_regs);
>  		kfree(ioc);
>  		return -ENOMEM;
>  	}

