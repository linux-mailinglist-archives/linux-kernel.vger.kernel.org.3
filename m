Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE72A4B225D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbiBKJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:45:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiBKJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:45:12 -0500
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 01:45:11 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EFBAA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644572710;
        bh=NM1bKcmX/dl/5DPV1+dpYflnMkoZbUuMneJ+tJvHcEM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Qu0TsK754zEm2zs6RXcbE7TZv2wkUJ8TSxF9qXjH9577evcsYavUbHttmrX/77ssU
         sGKeYNAg1zLAzE7XAJwq+Eha7IWWS6DV6mjU4Y5gMquq5szuMclSbqhKwi9FRhQNuZ
         FXjzyqS/Eka4mLuDmCXZwqHsvY8grQ+xvfjHGk3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.143.79]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1nYT5Z0T3O-00JM7j; Fri, 11
 Feb 2022 10:39:55 +0100
Message-ID: <17f233db-9591-3093-5e63-29e1c8f4b237@gmx.de>
Date:   Fri, 11 Feb 2022 10:39:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] video: s3c-fb: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     zhaoxiao <zhaoxiao@uniontech.com>, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220211032755.2271-1-zhaoxiao@uniontech.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220211032755.2271-1-zhaoxiao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rCkG0fxvjucaruFew1umM13DmyIqZn1revwD1+1XenYM/N02t2F
 lP1ajjY6yqN/CSzhJKFr8CdPiqyL/yp6ZLVx2AItRmNLoN1+xWp5bmBC5r28l/4GtxqKtpm
 Rx2o1+lxCNXZ2duS5CoAQ0ZqmQWfedfiDuETfsBa49upWXy5rHEGaJVMdfgYx4MsaJr+xv2
 5NUZDlIzBT/UUNHAqsILA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5gNyjIadc58=:5DOPWZ/AshOwzaGE3hQ1Rw
 I2Pmkd4wSZVWFYDmioKiGSNrV1mq+5rxkhSmyagBjpSUfwXweeqLrrYVVXhSG4xwHwKSA03We
 dTpLx8TBp1kp4iY4/NZRIVz0aeoRFZ+918u4PY+UxYKtd4AF6bm6BPaIac2fZrZZUC1GBzBTR
 4cCoPwDpKe7T5V/7jOgz+ueQOoEe4DuVGmt8XdGWdUKnLC2+O5K7hmoVBe3oKOlMUfKuaA7nb
 u2IH6RAPE3Y2iX8f/4EhPQZdeeNiB4UxxgaQVv2lL7zsxe6LStdDAwOqT7WVHAokaeUWkRpye
 36qSZMgcURbh026jJzPw19GzEnreau/QlGcfbcoPlflyQfFf+ItQXubnQAdUhVcBI5kvHSe8+
 ie2FRzczBQa8ACQCSRk/5rVnT7QgMKvLV6j1H9DS+n99PqQ2O/qoj02ni2SolmQitW8+JErlP
 8ZCkYLuKYHtUh8W2/qRIZzkNz8VcJl5SzAqC29R+Ts+85hFrrLZYco1tW02q2BX1GV1h7Pr+S
 sN18+WTHwJdyQOJA7Wje5RmBafa4MMFPLX3aBHqwrYCEn3GgxR5CFYTmw+b7kXUN44M9gXPpB
 QwE4w983HXam+mmOnBIHTHdVypnqdYI1kTI+eqySFg2UMu3puUyX6RpADbjD7wrLw0QY/NTNL
 vsHed/EABmTAIsDdyYoaw9ZQdp0lZuJb0aqGfUoYiK0F0A8BwMnhBriYkA1wMGXXmGMCbb+QB
 5X+hBi/3zK1jTAroEFAhF9ev3DgV43Iupkb5EWFS4q+3qubwZ3/v9wjRLKzX7oxEw0yv4wK2B
 aDNONr9rnEssBI8tW17Vi4sCNGyqiIn+VICztiV3s4C48Gyp2ZjiMHz2TF8FG4QBThICLNyD/
 IEJo2kV57NG4yZPlDxVO+cFNp4d2nKFdHyglmLbTsMxovXRJu1N40Pzts1AtVh4zC+F+4pSL+
 gHDxy32LFOqLBKFUYcOC/YWxpM0cozzTtq9wN0VvLCi7fJzUCsf1xy7Q6FjGRyulOEBurkAFw
 ndLhI4dhkbTd9Z6f2mQ8QrJaRHp22ZhFmXs/QMzv9RK2ZZ5UWPWK8goZwcotZMKvyA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 04:27, zhaoxiao wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/s3c-fb.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index 3b134e1bbc38..6ead7d3e2312 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1360,7 +1360,6 @@ static int s3c_fb_probe(struct platform_device *pd=
ev)
>  	struct device *dev =3D &pdev->dev;
>  	struct s3c_fb_platdata *pd;
>  	struct s3c_fb *sfb;
> -	struct resource *res;
>  	int win;
>  	int ret =3D 0;
>  	u32 reg;
> @@ -1418,13 +1417,13 @@ static int s3c_fb_probe(struct platform_device *=
pdev)
>  		goto err_lcd_clk;
>  	}
>
> -	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> +	sfb->irq_no =3D platform_get_irq(pdev, 0);
> +	if (sfb->irq_no < 0) {
>  		dev_err(dev, "failed to acquire irq resource\n");
>  		ret =3D -ENOENT;
>  		goto err_lcd_clk;
>  	}
> -	sfb->irq_no =3D res->start;
> +
>  	ret =3D devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
>  			  0, "s3c_fb", sfb);
>  	if (ret) {
>

