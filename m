Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EFA5B2382
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIHQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIHQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:22:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02AF6BB2;
        Thu,  8 Sep 2022 09:22:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j26so11224096wms.0;
        Thu, 08 Sep 2022 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BGJkDCrH9LUETLojStwhWIkhR+B86SO7RtaDm8mEauY=;
        b=RwwiQVwY3vPDuBMeJPweBE13KC2iNRsTP4Vym9M1/Csm0+yjy39dSZH1eRmMJQ7DPf
         X1W0LL7pZBiVEjDYb8rni6zFiWXk6JPpre+OPuSyyTGKG2J2Lnw2ZZ/DiioV2puNrvxe
         lgJKA6xkp4yD0gVlJsyYmJT98qPycD9g3d8Ef3nRiaS4pnFgg/9+NXbuH2wplSNb3PLX
         5iwiYkF0c//LMUt89PSWwemaaMg+fpQPqjwinnhTywaw5UFB7ztNNK95XEVRyiqkvweg
         A2pWaONnp6dXB4FXxNq+2FnCwhN57frNVkLEhERdAExAlMezKX2Dll3/t0Lx5pi82Cj9
         iRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BGJkDCrH9LUETLojStwhWIkhR+B86SO7RtaDm8mEauY=;
        b=Qw/1zpNkIMCw/HwY3Grh8A9Oi3yqgyRiPYJgdzeHVrtNRcIbBX7FFA4Ca66Lbk8z5z
         GW9h5DSYQhM6FXZqJ5LNgg31RIgBcE5VdnUAV5N/MOSiUzYDMh6TPHSRxYKRnHbJO27w
         CJPGJpGoSL65Xavg6LucCduUboIxZFVMSVQEKEmTx8gnEZD1++0KB6nTGyGgHawEoB6q
         UhOcP6T3p4VYhjEfGKydw8+CWSW/g4/rFkxdLdETlhjAfMQB2R8xguttAqmVSsh1olgi
         b8Ji7YQzGHi5daU1viVkPCpnUjT+9Z777YBrBJ5Lri7voPXZMAM5PUHN40RyXgXN8K2y
         PNNw==
X-Gm-Message-State: ACgBeo0gcLv6iLrJzlNfPtDis1ElGn7/vBGfy1CjwjQsJPyIoIh0h05I
        6j4cpgpLBe6z4cYAxyolplo=
X-Google-Smtp-Source: AA6agR6pbG+z44fWrfFFIpuYP73XS0I+jlnQ3zyiFTQUkL9ZblBelz2Ua8uw4IiIH1knjpm6bfYGuA==
X-Received: by 2002:a05:600c:a199:b0:3a5:dddf:ac6d with SMTP id id25-20020a05600ca19900b003a5dddfac6dmr2795265wmb.44.1662654170957;
        Thu, 08 Sep 2022 09:22:50 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003a607e395ebsm4357001wmq.9.2022.09.08.09.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:22:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Thu, 08 Sep 2022 18:22:49 +0200
Message-ID: <3508969.R56niFO833@kista>
In-Reply-To: <20220906153034.153321-3-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com> <20220906153034.153321-3-peron.clem@gmail.com>
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

Dne torek, 06. september 2022 ob 17:30:31 CEST je Cl=E9ment P=E9ron napisal=
(a):
> Add a simple cooling map for the GPU.
>=20
> This cooling map come from the vendor kernel 4.9 with a
> 2=B0C hysteresis added.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


