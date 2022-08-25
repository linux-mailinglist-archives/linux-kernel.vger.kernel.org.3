Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3747A5A1A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbiHYUx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHYUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:53:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C40AE215;
        Thu, 25 Aug 2022 13:53:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bq11so19477945wrb.12;
        Thu, 25 Aug 2022 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RzEfgQoYNzPoY67n3yQsstMockksnvCgN1zukS3McmI=;
        b=JnQ9KPQhp9ZpmwScAArGIa29Q4OMZwZDqrky/sbNY8FL9Qjz+o558fQ9oCTuVhRgUm
         X0GPPZRPxxLMU7jDh7G/+PVw4E5n1strEdUALkXQKReo8oHKnC0SUKE3QWTLDQeK7W+g
         KMi5DWl8fmiiD+srtwqRi7v6Oe1TgUF6U6/reJvA7D4y8+WTMlhrLI8piYwLXzeP4i5k
         EW+q35t0ZfYdkeaje3AN4zNZqGLXurXPJWo8VhMLlFBfJRUYa4gAJ1haE3J/DYWPbssJ
         XN2aQ4hJ5bSMMaAAlVJFXJzwbQimHoZ3UVmikEv7+M/WZ350vP3OMbcUZWQxDA0erw8m
         qWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RzEfgQoYNzPoY67n3yQsstMockksnvCgN1zukS3McmI=;
        b=Zk4slZxDL3kfj+wB1mJmBLGln/lh2lwoTF6bgG2CwlwnCpnXVCxdhQBGW5Yw7GPF7h
         5z50c3uv45h2sXM+d6TBKnD8A+SaSs5KZd0ZXEf7ek3Gq8NKNEsC1zEqWpq/nwJmnBMb
         TIUUAAggIUHVkDHZXFh4cXUdhYUnwWci7bs67CniIyOIHv/sQi8TnPIkM+pJ2bDGV9Og
         ozdx5ymos9gU3COBEWrZCmzHAdZ7HE1v3T1ELACUMnTqZTTbRYTTLqUvzqCJpe4rDsEh
         DFWqVBiRUmOVQZSRFGn+S6nVzKGnQ5KLXyWPqtTL8YQfCVbiaVZoUptETdKiFBpt2CD+
         f1TQ==
X-Gm-Message-State: ACgBeo0tktG09GUEFYh8Ja8JgLrGlrE3wkur/Frfw5Z7BUBe7zAf0LPt
        FHfBK7g4zroVTZytlIvIPeQc4HPyR3BORQ==
X-Google-Smtp-Source: AA6agR5YJb7JfDU3m31AivaBZ4rJAbMtFKqhzi2a8Ma+GwqO2PCZeFYvDIjHRz6tmC0BSVGr11eaYg==
X-Received: by 2002:a5d:6d0e:0:b0:21e:fc95:3dfc with SMTP id e14-20020a5d6d0e000000b0021efc953dfcmr3294787wrq.112.1661460832523;
        Thu, 25 Aug 2022 13:53:52 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id y2-20020adff142000000b0021f131de6aesm192612wro.34.2022.08.25.13.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:53:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: defconfig: Enable devfreq cooling device
Date:   Thu, 25 Aug 2022 22:53:51 +0200
Message-ID: <8106124.T7Z3S40VBb@kista>
In-Reply-To: <20220821173051.155038-2-peron.clem@gmail.com>
References: <20220821173051.155038-1-peron.clem@gmail.com> <20220821173051.155038-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 21. avgust 2022 ob 19:30:48 CEST je Cl=E9ment P=E9ron napisal(=
a):
> Devfreq cooling device framework is used in Panfrost
> to throttle GPU in order to regulate its temperature.
>=20
> Enable this driver for ARM64 SoC.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d5b2d2dd4904..109004e44d21 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -584,6 +584,7 @@ CONFIG_SENSORS_INA2XX=3Dm
>  CONFIG_SENSORS_INA3221=3Dm
>  CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
>  CONFIG_CPU_THERMAL=3Dy
> +CONFIG_DEVFREQ_THERMAL=3Dy
>  CONFIG_THERMAL_EMULATION=3Dy
>  CONFIG_IMX_SC_THERMAL=3Dm
>  CONFIG_IMX8MM_THERMAL=3Dm
> --
> 2.34.1


