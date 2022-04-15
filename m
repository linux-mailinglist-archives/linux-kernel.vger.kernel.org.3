Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED98502EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbiDOS3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiDOS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:29:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB14D9DF;
        Fri, 15 Apr 2022 11:26:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z12so10754365edl.2;
        Fri, 15 Apr 2022 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiEEMcnc8dyMVnBJRf8MBjYNQSDHZ+TAbtPueaX++m0=;
        b=XlyJgGlEKw1+nZmDqLlTFmkpRbE3WY6xFRWI29Ehk3YkJS42+sroJQPzN2D6UZAaTO
         Dk4PkGS/yk/DjxDprFA5+I+AMs7pCnfcCdg1AtYAQL3yuiVxetD0tq3x3aTBurzQlVuM
         93h0RU+gr6RmWzxcz2zEQ9QNYBLtjSJcCTzEQnir3MVaCwvybVDECwX6eUKEQn6VVfvC
         LTMbMkf/CGKNdftyt7Si0DkDsrmapJcb3SdCvCNBjeS4bsRhav+7UX1Dh0m+qJPhKRiU
         rJZW47By9XhQxEMklWuVQyoIT9vvNKK+i2xU0Pr4Bb2v/+ddexNSwJwK9M7dSo29Qiq8
         zslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiEEMcnc8dyMVnBJRf8MBjYNQSDHZ+TAbtPueaX++m0=;
        b=WO8v9iS1iP+Uz5Yqq74yJdyjQmFBFRQOyH/WQ3Z24SEA9j/C2acfaCSy5n9l7YBOt5
         Cqy2tncwRUL4OGKuof4/ncehoqpeU9ZA1manNCcUHjlWJoCRmHDNp8mOvsyQUztOnrF2
         NTJMNXTvUK9T8fd+6/yJ+tnKDOf313vjL2vI2Tv8pHhetnSPbdkhAvM8E1sO3gYX8jcE
         2j8X1RRix0p/L1Sfy85y8NKhT7V+GoBKth5tQk93AGBdfzOKMT88pZCldDkcugU21AYK
         cP2s+uvDQGLxjBRtERxmsj3bbMv8nJQV4ebo09h/LGf6J1Msg6eJ/xwRgGD/DSY0g4Ya
         5hpA==
X-Gm-Message-State: AOAM533/Z7QRJAN3QHHYwp6AEsrktF69SdIcxJVPRRzMTYBma2NBxETM
        R/JNJNzoZazXcPkQTFpTdos=
X-Google-Smtp-Source: ABdhPJzE85rlxtGMZSL07NJOiy1Xzm62tnxA5MAw9j5i4vVTV49Kks/7gyXFAgjcN+z8CCTqudY4UA==
X-Received: by 2002:a05:6402:84e:b0:422:b76c:bef8 with SMTP id b14-20020a056402084e00b00422b76cbef8mr497096edz.238.1650047204478;
        Fri, 15 Apr 2022 11:26:44 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709063a0200b006e05b7ce3efsm1910625eje.107.2022.04.15.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:26:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] rtc: sun6i: Add NVMEM provider
Date:   Fri, 15 Apr 2022 20:26:43 +0200
Message-ID: <10062096.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20220413231731.56709-1-samuel@sholland.org>
References: <20220413231731.56709-1-samuel@sholland.org>
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

Dne =C4=8Detrtek, 14. april 2022 ob 01:17:30 CEST je Samuel Holland napisal=
(a):
> The sun6i RTC provides 32 bytes of general-purpose data registers.
> They can be used to save data in the always-on RTC power domain.
> The registers are writable via 32-bit MMIO accesses only.
>=20
> Expose them with a NVMEM provider so they can be used by other drivers.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
>  drivers/rtc/rtc-sun6i.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 5b3e4da63406..755aeb82a285 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -71,6 +71,10 @@
>  #define SUN6I_LOSC_OUT_GATING			0x0060
>  #define SUN6I_LOSC_OUT_GATING_EN_OFFSET		0
>=20
> +/* General-purpose data */
> +#define SUN6I_GP_DATA				0x0100
> +#define SUN6I_GP_DATA_SIZE			0x20
> +
>  /*
>   * Get date values
>   */
> @@ -662,6 +666,39 @@ static const struct rtc_class_ops sun6i_rtc_ops =3D {
>  	.alarm_irq_enable	=3D sun6i_rtc_alarm_irq_enable
>  };
>=20
> +static int sun6i_rtc_nvmem_read(void *priv, unsigned int offset, void
> *_val, size_t bytes) +{
> +	struct sun6i_rtc_dev *chip =3D priv;
> +	u32 *val =3D _val;
> +	int i;
> +
> +	for (i =3D 0; i < bytes / 4; ++i)
> +		val[i] =3D readl(chip->base + SUN6I_GP_DATA + offset + 4 *=20
i);
> +
> +	return 0;
> +}
> +
> +static int sun6i_rtc_nvmem_write(void *priv, unsigned int offset, void
> *_val, size_t bytes) +{
> +	struct sun6i_rtc_dev *chip =3D priv;
> +	u32 *val =3D _val;
> +	int i;
> +
> +	for (i =3D 0; i < bytes / 4; ++i)
> +		writel(val[i], chip->base + SUN6I_GP_DATA + offset + 4 *=20
i);
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config sun6i_rtc_nvmem_cfg =3D {
> +	.type		=3D NVMEM_TYPE_BATTERY_BACKED,
> +	.reg_read	=3D sun6i_rtc_nvmem_read,
> +	.reg_write	=3D sun6i_rtc_nvmem_write,
> +	.size		=3D SUN6I_GP_DATA_SIZE,
> +	.word_size	=3D 4,
> +	.stride		=3D 4,
> +};
> +
>  #ifdef CONFIG_PM_SLEEP
>  /* Enable IRQ wake on suspend, to wake up from RTC. */
>  static int sun6i_rtc_suspend(struct device *dev)
> @@ -795,6 +832,11 @@ static int sun6i_rtc_probe(struct platform_device
> *pdev) if (ret)
>  		return ret;
>=20
> +	sun6i_rtc_nvmem_cfg.priv =3D chip;
> +	ret =3D devm_rtc_nvmem_register(chip->rtc, &sun6i_rtc_nvmem_cfg);
> +	if (ret)
> +		return ret;
> +
>  	dev_info(&pdev->dev, "RTC enabled\n");
>=20
>  	return 0;




