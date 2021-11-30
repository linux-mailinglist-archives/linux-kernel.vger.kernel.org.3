Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9A4630C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhK3KR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:17:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:59303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhK3KRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638267238;
        bh=z+lkEpp8CtXh8BnnGEgWNMyATCAdkFl13007QbDbsNo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LGUKVt4mF407KFlSA+VM1cs/x3BsW/QdDbFXfjuJBJozsem4PBeUZ8ORIVIeB0ilj
         9FAHuU/rbzXueXOFN6ehBJ8BfsNEen8UC6pqa+NDrxvhHkpi/c9xegmSQB7krl7Nyg
         OkdbcBHtsrhj50ZUiyDG7To6Z+/MsbfiRNq561J8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.145.109]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1mPzUm2tjp-0117qM; Tue, 30
 Nov 2021 11:13:57 +0100
Message-ID: <25f8e66c-09e8-f5d8-e3d5-ec48fbd8287d@gmx.de>
Date:   Tue, 30 Nov 2021 11:13:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/7] agp/nvidia: Ignore value returned by readl()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel.vetter@ffwll.ch, arnd@arndb.de, gregkh@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211112141628.12904-1-tzimmermann@suse.de>
 <20211112141628.12904-6-tzimmermann@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20211112141628.12904-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dRfPSSYh1TVh5d5cFLP5Od6HlMcPXgpHTkESTdsjj++SHSyY4Tq
 8mdnp8HL3YtqOje53u3LSveK1icJG27ENSKshLTWZx3jiIueB+WuwqRMq8i78UQsVhFWmmi
 1v5wUbHbki2H0MBnWhrESFRSvDjweFcKeMC3PRilHAszI44ETNOuHf5onJDyzC9LUv+SrTC
 WtaQZ5nDGZI7wEJwOJR0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QlkEoOWzQ/c=:vUkolq60akCO8xrXMjm2qE
 yJ5zI6zop2VPwe+DhymDxhEhuJXbP6lvEA66zU8IFqgcM89saEq3Klm5VQMF4HMn0kPefI+aY
 Ay3QdC7MSha4O46azOsd5B6dLM1g/uq9g1Rz4JVjKv1+M/KzPTJIpafcOOG7BzIMwf5e6rLqB
 ymLV7Mzn2ZsAkAFyiHhvU5zxTsDqXZuB/G1mg3MRDpGUc4LxQTJIbieuOwk+g6u44FXgaaaYK
 vQGvyAGVyzmX0HLGaWrB3CKLSfgfrQuZ7C77rvf9at6HWXh8RhxYTtuUeI+ZHMvmatWrbTzvc
 9MeWzYcudXw2Z/cDRQdF0zs+GOxZhTJ9vcqREW21Q0FyIveilVPshN1buuEvA12vUu1jtyvyV
 asTqUWzf3VvYOrYG0EtlV24qZyB4pHEV1/GuXYO001GQ4tw74SL1Qr2D765w2kUAquJnFg133
 DJfCcgt3uspDWuvtPH9GrFYRWKuAfFnxHxq7Sq6gmNh4bRy9wnidMNe59VRhzrWtVMGJto3EW
 T/BXIcGjTtsOSs2KDZRRHaBp3FTdqs7TZK/4mVldzmcloZI8xic8ztx99dCQ8wAI4/dl1VaWB
 hK318ci4vpACP+vr1gfOvIQFNNX96NVCIc3Ov+boF6OFZlVcwjwZqhRDDHMSH/roVevwDOSFL
 A5ws6s2UgTs9X14OumNtho50HR4wuv3dvouWSBRVEoCwqn85knD2OW5HC/Dk6dvJFYUkbyLMm
 EgpznBfDEikG23xJZMy6ImHctxbz8Cmrw/ZzFwxN16+3OWyTqmQ0CCd7C17I8wmwTxnAq1zUQ
 Vv32rr2wUM36X2qjLaCwagx8bdmC5SlvNSwIz23WJ053rhfey8o07vki18d+3WASnI3Vd//bR
 C//54TOIzOJfWUum0ckmfvaKPHXxkbwMeWeBambICH8lHSQi11EIrEyeNLkdE40GeCoQONyE+
 X8fRq55SRwBipwPVPZb5ic45GaM6oDMxSI8FNdUo0rw7p5GvzLm11bFGPFh+AmLdcvArtnitZ
 i+kr0ep8fzgHOKctimwxF/63TcomyrqCsSp1ReEKfjxK6GRxnQMiBBWysEH8M60c5gdMGBD5C
 pL6mwK6g/QMOXs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 15:16, Thomas Zimmermann wrote:
> Fix the compiler warning
>
>   drivers/char/agp/nvidia-agp.c: In function 'nvidia_tlbflush':
>   drivers/char/agp/nvidia-agp.c:264:22: warning: variable 'temp' set but=
 not used [-Wunused-but-set-variable]
>     264 |         u32 wbc_reg, temp;
>
> by removing the unused variable. The affected readl() is only
> required for flushing caches, but the returned value is not of
> interest.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/char/agp/nvidia-agp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp=
.c
> index f78e756157db..437b3581cbe5 100644
> --- a/drivers/char/agp/nvidia-agp.c
> +++ b/drivers/char/agp/nvidia-agp.c
> @@ -261,7 +261,7 @@ static int nvidia_remove_memory(struct agp_memory *m=
em, off_t pg_start, int type
>  static void nvidia_tlbflush(struct agp_memory *mem)
>  {
>  	unsigned long end;
> -	u32 wbc_reg, temp;
> +	u32 wbc_reg;
>  	int i;
>
>  	/* flush chipset */
> @@ -283,9 +283,9 @@ static void nvidia_tlbflush(struct agp_memory *mem)
>
>  	/* flush TLB entries */
>  	for (i =3D 0; i < 32 + 1; i++)
> -		temp =3D readl(nvidia_private.aperture+(i * PAGE_SIZE / sizeof(u32)))=
;
> +		(void)readl(nvidia_private.aperture+(i * PAGE_SIZE / sizeof(u32)));

IMHO the void is ugly.
Would tagging temp with "__maybe_unused" work ?

Helge


>  	for (i =3D 0; i < 32 + 1; i++)
> -		temp =3D readl(nvidia_private.aperture+(i * PAGE_SIZE / sizeof(u32)))=
;
> +		(void)readl(nvidia_private.aperture+(i * PAGE_SIZE / sizeof(u32)));
>  }
>
>
>

