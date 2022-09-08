Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB45B2395
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIHQ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:27:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6DF9120;
        Thu,  8 Sep 2022 09:27:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so3114080wru.6;
        Thu, 08 Sep 2022 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3ICuKknol5YpILZsOk7pACxUpATHdQ4OEZIYi1vqZio=;
        b=QLOHXXQnm6Nrq2L5bd6t4DAhEfH/9DWk7mr+48UhVMcq+rNytsLlxTm/mNNwqkmBWV
         MWiliboBWak732jTpkJliPF/7/tCvJnB/pQNEsO8wuXPIhm61+sEWyUBOvAMMnkyxlZ2
         ZxGAbt5dLmaGFSEWtNEaUsrb0BYpOj4/C0cttqRpYkx94P9IB/wlACFIGcswp4biu8rh
         au88pxfURiElI1JS9+PMxzzkD3XuXgvfT6vrOXPl3CGKao7U81EEQF1PmK0B8rqzihKz
         piBsVqvee5mxPATnDIQHpYReiAckYxsLBjR1c0O5C6TJnF2Su1Ra312//iIysC6JJB4j
         tBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3ICuKknol5YpILZsOk7pACxUpATHdQ4OEZIYi1vqZio=;
        b=cUSCOiMW8QYAcG8uK09mKyhsamtUNSlPirHXw8I1PFxKUCFDb5nkoRzc6p7VD623vf
         t7ESP7wcm+G9+RnOO+/v5z219VS2OiQ3d2sh4WxtsUU6biM1mnBh4ri3C+e64B8zla2p
         EaI7eik7m+afkkOfhaMKzB3aRAPevCu2cif6JS4ZNAGJCdpkostXPTyu7n49IMQ98jqA
         02QdLPX8CHYD7JQev3bjdsSL/09jGcTo4Fv9OR8nfGBYa/03RMQ4+7ZkRAdTs0m4hN++
         bGey0aCip+jC0Ct/g7AYj2HI19XobX8q+RPFvhSZd+PgcKk+TEXJmKMdCHaGgXJE++s8
         h+gA==
X-Gm-Message-State: ACgBeo2RmyG52WN1n/M52MgcRB7XWI9DzFOTNP66W5phsrboaGOclu6+
        bDERAB2GIJt+pODnWVD/cBY=
X-Google-Smtp-Source: AA6agR57Kt0uMyyLl4xHf64C/F/H486W/S1HP0tzZLCgcEgdJoEY4PI/DxoD3o37ca36UFcPQybAuQ==
X-Received: by 2002:a5d:59af:0:b0:22a:2fa5:c5c5 with SMTP id p15-20020a5d59af000000b0022a2fa5c5c5mr2205970wrr.333.1662654437032;
        Thu, 08 Sep 2022 09:27:17 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b00228da396f9dsm11168169wrr.84.2022.09.08.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:27:16 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
Date:   Thu, 08 Sep 2022 18:27:15 +0200
Message-ID: <2124701.Icojqenx9y@kista>
In-Reply-To: <20220906153034.153321-6-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com> <20220906153034.153321-6-peron.clem@gmail.com>
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

Dne torek, 06. september 2022 ob 17:30:34 CEST je Cl=E9ment P=E9ron napisal=
(a):
> Enable GPU OPP table for Beelink GS1.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts index
> 6249e9e02928..9ec49ac2f6fd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -5,6 +5,7 @@
>=20
>  #include "sun50i-h6.dtsi"
>  #include "sun50i-h6-cpu-opp.dtsi"
> +#include "sun50i-h6-gpu-opp.dtsi"
>=20
>  #include <dt-bindings/gpio/gpio.h>
>=20
> --
> 2.34.1


