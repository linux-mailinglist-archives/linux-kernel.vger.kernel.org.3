Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FCB59A68A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350692AbiHSTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349705AbiHSTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:31:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA2D758A;
        Fri, 19 Aug 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660937501;
        bh=S9XSHGciNIn79h/yqTTFzk/eQagf9Lf+whoQDfPRleg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ddTEMirLyv+YLVRKyw3garrKG7yLA0m9QETbymTnuRXz42FyIYLb85j42Zo85+/kN
         S9sbMhwLECQFi9GzO+5RQpSxfg+yUuxN2wamTJM+gSJyHZz7A825kvEdyC9NhVIFkf
         ExBad+NNZtRdzeagqTSqDTJIm2W0KK5F343S5Gw0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1nrV6l0H98-00XeEg; Fri, 19
 Aug 2022 21:31:41 +0200
Message-ID: <9ad5cdb5-3f72-1305-b509-d0f68943b618@gmx.de>
Date:   Fri, 19 Aug 2022 21:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] parisc: handle failure of kmalloc in ccio_init_resources
Content-Language: en-US
To:     Li Qiong <liqiong@nfschina.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzhe <yuzhe@nfschina.com>
References: <20220819041510.75473-1-liqiong@nfschina.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220819041510.75473-1-liqiong@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KitrQKEzV9hFGl+PSdcnzshEw9jqQ8aecACCnOxaKzzfryANmcV
 IIh9BCpQMmEdWxnZ4cKAbzpyiSGJ61Zt3xTfK5mXU432DhfbIaiKzWnicD3a7Ji3CbPPrEX
 iBol1CIKhH+t8gW6LepnhCpThbfVOIejVfjc3+c6OeGO0HNtQetIWbuSJouLdtkmFh7PWbB
 vwRvEGmFZrI6THBXz/eDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8UfPHmWJ5o=:87dt2GN+iXv4oqnaofDWtV
 jgSNfkMtyrHUjA3qs/2MSBDuR2DSVEsnFfAEkhkMCb7VjeMrkJa7CriOzo4a15vbhZMLzGBn0
 UpJqxiJsE1pjvVJhhUZlHKXC4+nVbrnwX4TScMbiuoUbrTvlE+iMw56HUma/FcQzA+YdphTJ2
 4w2VChAMtWJJLNait2owgVKqDgIv4ZcpCsm1HqU8Zhq1JWCoEeg0s+C/8jdczmxK28+fL40yv
 4x67pAl+WgVX24EjFD0Iq1EEiW0CKpEweL8KWwn7gUiGoLoGR6neNDsuoxHqfOWXqEeFOs1tQ
 DsZuAH3boXsG1nKrH1zngLaC1tHrq4nyDPq+BIT7U1xT+XWRtEkS4TmIND3+Zax7oJTVz9WgK
 Izxshcte4sXDr5jsPKS7gBONxhhlH66j8ftfcLvE4SNgn8pRSS3HxshSguAb3qHhBpOabJWky
 hGWLYKbu2t9VC4C6tDMQwHFmzDREc+fkP9853MXBZBvIJt6lZbPgRfe2fZ+T1k8bFMtRyRKCq
 Wc17p+zsJBxXejPQT2USxyc6qp+o4k29SsSZkAYTX3ap0CPOf7KiBxG1t5kg6XIGpPHTN7nYR
 /zFA2zpjPJIWFT20p4JdflNv6HHghpU7xYxJzCjqRkgmJminzE2AB5NP0c3FYg8JHUYhQSa3Z
 ZR4W91+ifIh+ppNFcMzkxkCtbYaucnQpqmF4SZO70f7mHaqKDTbUWjGViKynshi123foLV7vV
 gc4jeNZc60o6mOVQO372rOf1DdNB93eUtOXp2IGhDDAy4scrOvdSAsnA+SY91o1VV30vpetl6
 PIo1/OYS3zLWknsfDxM/kEjCfx4tP+Nv/xUmlgSXHpvszTo4TUYC5Y8mrXAjU9dL58cJ7iPE/
 PNuuyhgLTZdGME7mHaz598SvTlJdXu6jawL7wS3PONtKL559UP0xyf8xlPvC5FkdSm4hbYg1q
 GfS8/YBGn/CgP9+VRdGB4WO/v9ZqE5bgPlP+Xk2K2T9mF9+4uxzeu2foATe/MYoHt/vcCiijW
 rUelFTq6uKI4NwLywHWL8zdCGOij1KXw3JptDD9PYsiXxDLOwM4HQ8CAsWqtutJCpY0epOlED
 J+M1+bOqgotA3//10TvYg4FEADmBiJWeo5EqYLhecCzagWR56YzE2qynA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 06:15, Li Qiong wrote:
> As the possible failure of the kmalloc(), it should be better
> to fix this error path, check and return '-ENOMEM' error code.
>
> Signed-off-by: Li Qiong <liqiong@nfschina.com>

applied.

Thanks!
Helge

> ---
>  drivers/parisc/ccio-dma.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
> index 9be007c9420f..f69ab90b5e22 100644
> --- a/drivers/parisc/ccio-dma.c
> +++ b/drivers/parisc/ccio-dma.c
> @@ -1380,15 +1380,17 @@ ccio_init_resource(struct resource *res, char *n=
ame, void __iomem *ioaddr)
>  	}
>  }
>
> -static void __init ccio_init_resources(struct ioc *ioc)
> +static int __init ccio_init_resources(struct ioc *ioc)
>  {
>  	struct resource *res =3D ioc->mmio_region;
>  	char *name =3D kmalloc(14, GFP_KERNEL);
> -
> +	if (unlikely(!name))
> +		return -ENOMEM;
>  	snprintf(name, 14, "GSC Bus [%d/]", ioc->hw_path);
>
>  	ccio_init_resource(res, name, &ioc->ioc_regs->io_io_low);
>  	ccio_init_resource(res + 1, name, &ioc->ioc_regs->io_io_low_hv);
> +	return 0;
>  }
>
>  static int new_ioc_area(struct resource *res, unsigned long size,
> @@ -1543,7 +1545,10 @@ static int __init ccio_probe(struct parisc_device=
 *dev)
>  		return -ENOMEM;
>  	}
>  	ccio_ioc_init(ioc);
> -	ccio_init_resources(ioc);
> +	if (ccio_init_resources(ioc)) {
> +		kfree(ioc);
> +		return -ENOMEM;
> +	}
>  	hppa_dma_ops =3D &ccio_ops;
>
>  	hba =3D kzalloc(sizeof(*hba), GFP_KERNEL);

