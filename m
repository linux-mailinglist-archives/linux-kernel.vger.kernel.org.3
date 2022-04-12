Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEC4FE984
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiDLUkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiDLUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:39:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799778921;
        Tue, 12 Apr 2022 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649795549;
        bh=IrspqYP8ymy9ueHzSGHCQmZBice+jhJrZO+S5bPpMWk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GBGjuOQvVglx1k+KBeiBiGY/1jHQqh3P1CmDsSga+SvcxhTvOnCIF33w4uL8EjkF5
         eE/I4/B2ka+7X5AMMBNt+Sd7cpf/MdU47xLt/6uwiz+f89whBAj6iY6Y7QhFqL/OA6
         +1LQma0vp7WIY3gomFwn/jMO14qApD9FDmbEPLlU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.135.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1ncglq2Hak-007B7f; Tue, 12
 Apr 2022 22:07:00 +0200
Message-ID: <d90f37a3-e91a-c2a2-e349-5f835b048e5b@gmx.de>
Date:   Tue, 12 Apr 2022 22:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] video: fbdev-MMP: replace usage of found with dedicated
 list iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331223503.902142-1-jakobkoschel@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220331223503.902142-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v3JE1ZICfMfPrsfvy8/eg3kgYv0qoPZEH4uA47/8+QfPmHfZC8F
 wuCWQdxmVwbOna7Nhk3SfJlsWB4Hrx7jlmLOstCstC04FFWEM+kq9gUooAqQO6LHsLXtK0X
 sNFkMEqV7A5+DltONIy/a2vCxkJ/HHMYane6dasVaYOz5ckKOdJnajhBWeUMhzpjVk3Hcgs
 EQCeR0mI9DgaAtz8MihpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qN/aei8zZyE=:EqvKNSZX+hPqr949MSxvMp
 eQKsFxq5fmqFbY3xjmMtT3D+wa+U+ht4xxcqst6URvYsRecL65NUDRHkJev6NvADnHJ5Kq2J0
 EBEX1O2BGYocKeRW0JjJ19YyPkfLozOwkk9ZogAYK4P0XGMdV7Tku9uiWPP1eBcRSbOo5t1we
 TCKpo52CVJsDNS3NT6fNfwR8avJ4bOW5Jei+B0+zAQpzs68ebmav1i/6o/531KJvmewRegbrG
 so2Txl41QLOz4uXId3BddAZXLWSwtzKqNl4F8ABfXcx/NQOcJY+fv3E51IXq6vcbzr7crNvnc
 AIlsgb+xHO0gY7NZwDkIj6gP2WvfsLgS0bvuHc6uG+7ujRis0Ai4w+4huytapG64jQx60MPi/
 veZX9fpmJ+8eO2hkRQ1zr+qBO72E6E44mOBupStaVfjBI1v9lncTp6rmshGETPhXH21oAtCQc
 49EvJJyM6ZyKAZnNOxAM5cF7sjc2IzCUzpZXLX3Fi7vIBzVDtHXqG2yBoOB1ZeMGaH1H33Bvo
 qRgKxDnpqvNHQ/CxiGKKLtbIzIqE/JaltcuwHPKuwpqPN6bfxHtlgqR7SqLqJgjoAGtSRO4/V
 pCjdcbSgRE0jfxuYR3wT0OBuEhaCpe6a+TYd7mQ9DR6YRjafIYB1fMVtKbU9nEAAeGmw2UAqg
 eqf7GNCbWwc1OHd9qy1SI03PW07Ud5bVAtTwmTF32lFXtyEmiIwRUOz/IEPcnKFnqNv/JMdrn
 /6qecm5MSM3ujxSZY4Bk8B7ZnM4vaU8kgsemPZr1uNkNatLXcTTOE7GJp8/7Ku366Fe7SGUA2
 w4P0K0TVqQmb8T2ZynX19uAlg3DBiABD01Vhcitvhtfg6xoIzWdbYdMXPyCsRbF6S0i6aKVRs
 TDWzrM4Ec/R+ktxCniUgh/ruAgdSZOdkbasXw4bp5Jlz46nEiPqU6fGkueqzk36k6ndXjidJK
 C3BmPtoHMc/X3o5lZrQk58dKuWbas600o3TjsUr21b9BDrcNGiekUZ/vzGjbRw/IUNysyRzwA
 PlNqk7HXOEKumV2ifOpwYaO+xIAO5xPvRXTTPVTOqTLqe/6veoNax9aSFkQKVdpJ229dKnNfQ
 md6ekKGn5pbbpk=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 00:35, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqX=
Pwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

applied.

Thanks!
Helge

> ---
>  drivers/video/fbdev/mmp/core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/co=
re.c
> index 154127256a2c..03707461eced 100644
> --- a/drivers/video/fbdev/mmp/core.c
> +++ b/drivers/video/fbdev/mmp/core.c
> @@ -127,19 +127,18 @@ EXPORT_SYMBOL_GPL(mmp_unregister_panel);
>   */
>  struct mmp_path *mmp_get_path(const char *name)
>  {
> -	struct mmp_path *path;
> -	int found =3D 0;
> +	struct mmp_path *path =3D NULL, *iter;
>
>  	mutex_lock(&disp_lock);
> -	list_for_each_entry(path, &path_list, node) {
> -		if (!strcmp(name, path->name)) {
> -			found =3D 1;
> +	list_for_each_entry(iter, &path_list, node) {
> +		if (!strcmp(name, iter->name)) {
> +			path =3D iter;
>  			break;
>  		}
>  	}
>  	mutex_unlock(&disp_lock);
>
> -	return found ? path : NULL;
> +	return path;
>  }
>  EXPORT_SYMBOL_GPL(mmp_get_path);
>
>
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275

