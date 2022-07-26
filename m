Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D28580EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiGZI25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiGZI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:28:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3030551;
        Tue, 26 Jul 2022 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658824097;
        bh=3RSP2yx7K3NGv3aWWQj5WbiKUEF0R+QuwyU5XYA0lUQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FZIClfp0A6gDrpjYXvMXdJF1dM4XQ6/hzxaqkzy2/9p2tPkLBXw5zeCbcPigkVy2L
         9a5fXGTE+ETaRSWT8xYYmod5nIaSDKVNnrbpXQRiLMVheXMZojrvjhhDwevoBc/nsx
         q14gcXlyqUzIPczzYcCU8ngPymNsYIQFCn0jPB7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.186.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1nbQvt1lBs-00ey03; Tue, 26
 Jul 2022 10:28:17 +0200
Message-ID: <70afefa0-2f18-c8c0-33cd-f6abd4010535@gmx.de>
Date:   Tue, 26 Jul 2022 10:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] parisc: check the return value of ioremap() in
 lba_driver_probe()
Content-Language: en-US
To:     williamsukatube@163.com, James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
References: <20220722025709.2924616-1-williamsukatube@163.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220722025709.2924616-1-williamsukatube@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u3lbQyxSlwgZR4uGgGbLerNKFvAO9zBJMtW2I/xOystHTZU2Dq9
 A1RpqVXYlLWi6Nr2yYM6ypc8dJ+s5newIk6hN6NaSDNpotsmAknZZp1LSyAxCpPOur9FBGI
 awF3RtMbRyU66qvm/ogPg/f6YOvbH0vuYMKmOqB76ypuvBV/vJ0+JcqNCfGaZxStcVcRW1Z
 eJZbWpYP4sriFM/Gx5lmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UelfYpVGDxQ=:EMXQzo4e6WvwZbHYqb9Abt
 7wPcX2/jGLJVTVQYRbjgI/kudpHTeHgiSlSH/h5sREgKbkvVjxjErmw7Jl+BjGiIsWQS2Wqjt
 RCplNTp7UA6fcSA4Y+VZT0CJoNtlpIS7IVy8ZAXjBF4O9xqNGiV/HkRpyGXlKN4RgOPuxzoc/
 mhYKjEon549Mt16AICOTEE3I6QKshib7+NSz6l4HJtb4L7zfPe5Hdyay4VYeHHsl0SS91Y4sj
 fJ3NuBWq4DHdsXtgwa64/WyHSxr0ImCv/5lMD60K6hElaSnCrGwC8QUV0ipZNsuIXcCKhaBjV
 Wkua2KGbW6Z/Y/XDWQJqN+x6U+tvIqVaBJgZFpNa/O/h7mQ0m8uNxd7ST6GmXOzQ06JJaMhhe
 HOadky/AO8iw2XNEEKk/qCkF7qX01CPk6eDskEU+EwQoDt2bGXAYjoJ6SMFc47ce/BpkQmmDW
 GCD81pZq+UHPgzv42GDlwRb79MGAWxGq801jBKjhqimRrTCPQzABDb4Y8vXldulnGJZ0TSrzV
 Uj5NHB7L1X5CfeLZ38sI0kl3jqRm49dM2C1f1Hocfn9S2a9XC/9ykDMFNn+zBxSa/5gy3LArk
 cNQzhDaa/k8P4pilmLK89wSD8/YpJPAlAIaeJFHBvtKouS7lN3cI8+/B2uKVcZGwBhAtwcF6Q
 deo1zM5uQQGIXzaBsuQSFzMevIuPju4G78ctbm+P1zaRHW7l7eJXCqTYC6i7wukUt7p2uawtC
 CEyIrJsSxjo513grqu6ZD8Jf+MXnDPeCrk8Bj4KtMuM2CuEZZljXs0km1CoLwrnFxYzSGUtaj
 K2VPTmLLMvWF6Q96msyAe/3OtRHJwEaw4h+eeUopUroKuyqhyoRD+kjqyH3aJUvPtgTJMYeec
 kKkpNtr1Zmotwp7T7Af73ZCMVMcaEZQG/7VkVgyDPXlN1N0MF5K6iYaIWVg4TkI4YgmP/WW5U
 p5bMfm5eso5u0dBFVkDqs8Vqk+Lg6IDnEB24xElBWcTt66Z7pV4Zj8b8j1xY11GcKWL/xz2gH
 IfdrwKdT57KK7c2UZZznP6eevPnSljgEcXd+u5hx1UaJkOfRowcgO0xaL5u3PEut9eTdTtWyF
 X1lAqZ4rOUbSyoS8ag2HqHXnC7uN75nsTaxeOHUJIM024B9p2I0b8yfbw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 04:57, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@gmail.com>
>
> The function ioremap() in lba_driver_probe() can fail, so
> its return value should be checked.
>
> Fixes: 4bdc0d676a643 ("remove ioremap_nocache and devm_ioremap_nocache")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

applied.

Thanks!
Helge

> ---
>  drivers/parisc/lba_pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
> index 732b516c7bf8..afc6e66ddc31 100644
> --- a/drivers/parisc/lba_pci.c
> +++ b/drivers/parisc/lba_pci.c
> @@ -1476,9 +1476,13 @@ lba_driver_probe(struct parisc_device *dev)
>  	u32 func_class;
>  	void *tmp_obj;
>  	char *version;
> -	void __iomem *addr =3D ioremap(dev->hpa.start, 4096);
> +	void __iomem *addr;
>  	int max;
>
> +	addr =3D ioremap(dev->hpa.start, 4096);
> +	if (addr =3D=3D NULL)
> +		return -ENOMEM;
> +
>  	/* Read HW Rev First */
>  	func_class =3D READ_REG32(addr + LBA_FCLASS);
>

