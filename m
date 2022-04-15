Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763B2502EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbiDOS2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiDOS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:28:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC434B85F;
        Fri, 15 Apr 2022 11:26:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s25so10272327edi.13;
        Fri, 15 Apr 2022 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EekcWh/8jCGWV16H36tPED8Vs01NSjkm2Nwu29iMlQc=;
        b=ZXOOeILU2iPR1feimi6V7lfNKIdQ6DEwd0qedeJg5N935VMEBrXkFKmMv3e9updNwU
         B+xOC5oZopptgtFBST4TlNwmusBLtrLGTkAKtW8wlBofkYysbc1oXsps6IKcikfwkBSZ
         yka79q5Pl1JP/mREb6ThVUn1koZUnesaiD8giZm87TaKd0EV/oanulADBzDZteMDB7Sg
         feA7/p8brR9Iaok+1OQha6IyyLfoWoxsaB/4KtrNliTVFFbX0tc657Al6B1ndRNnymeR
         Fsljmhlu1vD0OfxJldirIjnkOBvk7zqEgYVH/xqbcL5qnHVhkCbY1Q5z+XAxrl7wW5ia
         HBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EekcWh/8jCGWV16H36tPED8Vs01NSjkm2Nwu29iMlQc=;
        b=yKVRYPl7Fu8teN3GN6tXiwcjtl3g+Z/L44tgLqnbeopkArWqKcF7z7ubO+54666qZ/
         k/eitr7RamILrbAv96WmcXZJkd2LJK5IlTFOMRTyTJTu8sVhORGXsBBwZg4Aolv1Zr+c
         nNvPL0asW3FN1kdv21qvQZcaXgqX4mvmTbFFdBiyQ6leequY7SSAabp4AJefJOfZHqHW
         bdjvDfP1T1+aIgwxlMOxbWVmaSWBS2LnGDdq2iPAzTD0d5KPj8WAa9/GkHSIb42T8ELn
         lwzi1YLhXv5E/Lm9yLnxTW2FGFlIBR0TGMYMyapQEjXtQM18LwDvTVasQyKzraN6QZ9/
         BF5w==
X-Gm-Message-State: AOAM5320eUHuQF0oAHs1TT1MyxeOj5Nx5j6oKBYHzqCWizy/eglV89qi
        lxYsC/Nte0s83X+xg2OsWMQ=
X-Google-Smtp-Source: ABdhPJxIdg4fiXZtkYpKyW0QIjHYQbDMo//4iIDaz8jJTH+0GC+XmAiZXM8XzR/NQazxg8LoAHtaKQ==
X-Received: by 2002:a05:6402:2318:b0:413:7645:fa51 with SMTP id l24-20020a056402231800b004137645fa51mr459041eda.201.1650047158910;
        Fri, 15 Apr 2022 11:25:58 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm1922911ejd.118.2022.04.15.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:25:58 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     tiny.windzz@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        wens@csie.org, samuel@sholland.org,
        Xiaobing Luo <luoxiaobing0926@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaobing Luo <luoxiaobing0926@gmail.com>
Subject: Re: [PATCH] fix memory leak in sun50i_cpufreq_nvmem_probe
Date:   Fri, 15 Apr 2022 20:25:57 +0200
Message-ID: <3167910.44csPzL39Z@jernej-laptop>
In-Reply-To: <20220414045917.3223700-1-luoxiaobing0926@gmail.com>
References: <20220414045917.3223700-1-luoxiaobing0926@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[resend]

=46irst, please update patch subject according to commit rules.

Dne =C4=8Detrtek, 14. april 2022 ob 06:59:17 CEST je Xiaobing Luo napisal(a=
):
> if sun50i_cpufreq_get_efuse failed, then opp_tables leak.
>=20
> unreferenced object 0xffff000010742a00 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294902015 (age 1187.652s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000b4dfebaa>] __kmalloc+0x338/0x474
>     [<00000000d6e716db>] sun50i_cpufreq_nvmem_probe+0xc4/0x36c
>     [<000000007d6082a0>] platform_probe+0x98/0x11c
>     [<00000000c990f549>] really_probe+0x234/0x5a0
>     [<000000002d9fecc6>] __driver_probe_device+0x194/0x224
>     [<00000000cf0b94fa>] driver_probe_device+0x64/0x13c
>     [<00000000f238e4cf>] __device_attach_driver+0xf8/0x180
>     [<000000006720e418>] bus_for_each_drv+0xf8/0x160
>     [<00000000df4f14f6>] __device_attach+0x174/0x29c
>     [<00000000782002fb>] device_initial_probe+0x20/0x30
>     [<00000000c2681b06>] bus_probe_device+0xfc/0x110
>     [<00000000964cf3bd>] device_add+0x5f0/0xcd0
>     [<000000004b9264e3>] platform_device_add+0x198/0x390
>     [<00000000fa82a9d0>] platform_device_register_full+0x178/0x210
>     [<000000009a5daf13>] sun50i_cpufreq_init+0xf8/0x168
>     [<000000000377cc7c>] do_one_initcall+0xe4/0x570
>=20
> Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>

Please add Fixes: tag.

Best regards,
Jernej

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> b/drivers/cpufreq/sun50i-cpufreq-nvmem.c index 2deed8d8773f..75e1bf3a08f7
> 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -98,8 +98,10 @@ static int sun50i_cpufreq_nvmem_probe(struct
> platform_device *pdev) return -ENOMEM;
>=20
>  	ret =3D sun50i_cpufreq_get_efuse(&speed);
> -	if (ret)
> +	if (ret) {
> +		kfree(opp_tables);
>  		return ret;
> +	}
>=20
>  	snprintf(name, MAX_NAME_LEN, "speed%d", speed);




