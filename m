Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE8536DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiE1R2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiE1R2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:28:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F12662;
        Sat, 28 May 2022 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653758903;
        bh=lR1SmAw3TFZ2GVQGx6Xrltu1975YzeKIyfCgmu3IbmI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TwY7VeAEA96tsQkihp6Y53kt7fF5IFdDfZK0kJxOBVZ3BN2JoTOn2gxG+EPBXayd0
         1TwauGiZ+ZSWnFHxazRzYiuBm8Wp4/7b3LubTm90l5WpGZl8Em0bmA6eslfp46oUzy
         YonBZifAugCbrq9EgfOvRT9SQtNkdIyKqODPRRa0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.176.6]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1nRjkI0V9B-00nyNC; Sat, 28
 May 2022 19:28:23 +0200
Message-ID: <90a293d4-698f-5c9a-9435-3a26ea0ae97f@gmx.de>
Date:   Sat, 28 May 2022 19:28:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] fbdev: vesafb: Fix a use-after-free due early fb_info
 cleanup
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Pascal Ernster <dri-devel@hardfalcon.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220526194752.307192-1-javierm@redhat.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220526194752.307192-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q/afMmrV6TEcA8Ald4h2sa2uBYvXhgfWAKP3dhZtZKDXuX7L5bR
 7U8+ZHdeYUwdMiakb0VwOYuClbKKl+haWFBSOYmF+SHHED0qpI0GIqLlrUB0RXSFWtrqhTb
 AkERe7Q+TtAfR5JiIGY4CIOfm1wpUd4Ipilwn4bw331ESA1gn2Hyv3EYZgRMgmYDnN0B/kz
 dL+IkvX24bMKe5Hhl+kdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XqlM8cU89UE=:eTOTT44CHSOooba+fOdkyo
 y1MrLZk9ZF2hFIn2zAV64IipZRcch4TDAmcOQt1UnVDoWfg8AlPW7kQyvq5Mb0gcIb7YTmMb+
 Ln6ECUlnPq6IjylwUES9rrADlRUQrT8TxSUSTLlfppRpi/I1tEWt1UIgPkQj3qKiyBDp0T2cW
 pVPFSD+DWm3PhsvpO1MKsvFNuQyNzj5SE9NYvrhnZMTSXCWEREmugIRmXUXV5N8HXsgFx+1by
 0vLeeaxz1f9yPwz8CNloOIkA8JGoGYDg0nc3ih94KY2nQqw99TwbRy5Qv8iL6wqu6C2gRFaqg
 g5U3IMGg/uDbjSmr+IMTOU6PB22HmuyLFAjMPTfCNKOYfXUjX7Iq50hAN+LYQhPunEIwxK+qr
 fmqigX0CR00JfCnzuQYt+EFZo7Kt00ocWT2prVauDK4heXV4gwJtzcSVkyy4tKIwYs1LXTIHy
 NBMByrSq6ZBIYXVmCyvzobNlk8yQ8Edznm5TG19y+B7C3W/mogQAdbSvpl2rWLhuaZMIvnzZQ
 d90hIfQeIHW3iU4UUwfQxkTvmKBQSaHgIeAfYG9fqWPL3qC1pHnNNIdc0QQ/EWXTdoxz2O/cA
 vwJHUPPsHbBHNbZ14vv1OAOPZEoSHnawhbLrQDkbAEL43nM0ZWeoSd7MjsgSbxe33DhVDPfcA
 FVwFhff+sw0KW9pyjcLj2n2bssGVitMJ/8PnASUnAaS4uW6DPyLCBBziIRhexGjAx6+r90zfJ
 BPW1qpm6QsDSDLMA5k7eZ30AWoWbJAPFPnZW/Z84HZ5TKNN2LvsF48abqc7EdxxFlbo2v1psQ
 qLU8Pv+vleI3K0geCzXBa33Y/nQK1T8UmMfPLpun4LWaH9J66oMwuSMOO1JmUrLp5+5u7lAY5
 dszI+2Z36wvyMgor8SOD2QfU2JvAh3jYYFkdDNtjy/RMFuaGcDCEkJQaQxVvMl26N3jMBGAyn
 xAI7dWt09WCE7bmZPWqmXRjZ4RGnBPKrTjIMSpIgk40wdhpLe9Z3fr32/HAsOs9q8X9Ga7siv
 NNUnlntJml8yv33RX450oCMkteJrBGzYkUvSqFnKSllLwHNuPpGc1JF8Ahn1iw1HXDlB6jkQe
 dk+elHRX383UtQQk6OeBRavSUqvawhcFUufJ7Htlgz07/c9V6b5L258Zw==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 21:47, Javier Martinez Canillas wrote:
> Commit b3c9a924aab6 ("fbdev: vesafb: Cleanup fb_info in .fb_destroy rath=
er
> than .remove") fixed a use-after-free error due the vesafb driver freein=
g
> the fb_info in the .remove handler instead of doing it in .fb_destroy.
>
> This can happen if the .fb_destroy callback is executed after the .remov=
e
> callback, since the former tries to access a pointer freed by the latter=
.
>
> But that change didn't take into account that another possible scenario =
is
> that .fb_destroy is called before the .remove callback. For example, if =
no
> process has the fbdev chardev opened by the time the driver is removed.
>
> If that's the case, fb_info will be freed when unregister_framebuffer() =
is
> called, making the fb_info pointer accessed in vesafb_remove() after tha=
t
> to no longer be valid.
>
> To prevent that, move the expression containing the info->par to happen
> before the unregister_framebuffer() function call.
>
> Fixes: b3c9a924aab6 ("fbdev: vesafb: Cleanup fb_info in .fb_destroy rath=
er than .remove")
> Reported-by: Pascal Ernster <dri-devel@hardfalcon.net>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

applied to the fbdev git tree.

Thanks!
Helge


> ---
>
>  drivers/video/fbdev/vesafb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index e25e8de5ff67..929d4775cb4b 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -490,11 +490,12 @@ static int vesafb_remove(struct platform_device *p=
dev)
>  {
>  	struct fb_info *info =3D platform_get_drvdata(pdev);
>
> -	/* vesafb_destroy takes care of info cleanup */
> -	unregister_framebuffer(info);
>  	if (((struct vesafb_par *)(info->par))->region)
>  		release_region(0x3c0, 32);
>
> +	/* vesafb_destroy takes care of info cleanup */
> +	unregister_framebuffer(info);
> +
>  	return 0;
>  }
>

