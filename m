Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF684E25DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbiCUMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbiCUMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:00:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5C20F7D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:58:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d10so29269237eje.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=tqqiIpLTBH/4MyJcSp/sFT/gB1/sD2BSsd40ElAdaOw=;
        b=lCexYss4DcuUyoUIGwJK9ubCG7XUQSW7mnQK4tyWtHN0zgmfOIwHHBOAyu6GXnT4dx
         Ch9zQSD2cvTXneK5P6N+q65MYGjTPnlBbzHiZdt0WjWqPRlBkB0qh81eVxt0C/ybk8Sb
         C7t9R9fFPxOBCPTDgwIjOmGAXcnPbp8FTrurJdFxsGe+OIW2K5w2KvONB7vsxURqg9C5
         btRNP9ijiltOUXGyl7/yxeEd8uMBY+n/zphbsvxlklfySHhHjFS/ZQoRFydm/kBT7egZ
         ds7T0n8J87RIjhQ3xVyoXUf2xAFJQj+DsToIUGWj2JhTVBAsmBDN02RSMv7XpIBEV0y/
         Su6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=tqqiIpLTBH/4MyJcSp/sFT/gB1/sD2BSsd40ElAdaOw=;
        b=cD/R9rU9WHeQyNM+C3WGh7EBSg89N902gG9URL6ZSgukYV8fUiFS3UidmZxs2QKoJH
         V+eJSH4S8gHFsmzOcEU+6L2XutgkH/yGjHq5AuRqreAc2m0UWXIUe/rgcKN9hq3vxKmY
         fHo65WFaxdnERFVMah+Qjyg8ebZgOvj7wmixkiGAkl0s9XIZ3kKHMIyBtndZM1Clb+aY
         xteBGYmwjsKcp7PDR+els5oEkC2SaIdFIanfmqgtmwimLykH4YXdmgEGlSV7I8s2gKC6
         yQTrtMup7+cdBa98t86K1/zVMZqH6CAJZs+PQJBPfGxBOluMwLpe3Trn1wKlXGPI1rOi
         yJJw==
X-Gm-Message-State: AOAM531JAoppUx52VGUxFJBC8aHdCwINhNaQ7QrgEfvF7EgFK5MgE6yB
        hao0bhDcrUbfdiexIii5DNOlxA==
X-Google-Smtp-Source: ABdhPJzcOcz4bZpddTr6Wy4fSAUvv8yj7fkX0ktNMmkeQt+2Gw+AwGUfUjOj6KPuA6oy3uxrFzu6JQ==
X-Received: by 2002:a17:907:8687:b0:6da:824e:c8b8 with SMTP id qa7-20020a170907868700b006da824ec8b8mr20927854ejc.428.1647863926737;
        Mon, 21 Mar 2022 04:58:46 -0700 (PDT)
Received: from localhost (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7cac2000000b003f9b3ac68d6sm7793092edt.15.2022.03.21.04.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 04:58:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Mar 2022 12:58:45 +0100
Message-Id: <CIPJ0CT6EQI9.2C0T9KAHDODH2@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] ufs: qcom: drop custom Android boot parameters
References: <20220320110616.18355-1-krzk@kernel.org>
In-Reply-To: <20220320110616.18355-1-krzk@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun Mar 20, 2022 at 12:06 PM CET, Krzysztof Kozlowski wrote:
> The QCOM UFS driver requires an androidboot.bootdevice command line
> argument matching the UFS device name.  If the name is different, it
> refuses to probe.  Thise androidboot.bootdevice is provided by
> stock/vendor (from an Android-based device) bootloader.
>
> This does not make sense from Linux point of view.  Driver should be
> able to boot regardless of bootloader.  Driver should not depend on some
> Android custom environment data.
>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

As expected this makes UFS probe even if the node is named ufs@1d84000
on my device.

While I don't know why the code existed in the first place, it was added
back in 2015 with the introduction of the driver, so probably it's just
some remains from downstream that weren't cleaned up back then.

With this commit also 6b9afd8f96c6 ("arm64: dts: qcom: sm8250: change
ufs node name to ufshc") could be reverted (but it would probably make
more sense to rename all ufshc@ to ufs@ in a new commit).

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

>
> ---
>
> Not tested, please kindly provide tests.
>
> See also:
> https://lore.kernel.org/linux-devicetree/f61abc2b-3ce8-7b1f-3d28-8a4a03ec=
58eb@kernel.org/T/#u
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 0d2e950d0865..586c0e567ff9 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -957,18 +957,6 @@ static const struct reset_control_ops ufs_qcom_reset=
_ops =3D {
>  	.deassert =3D ufs_qcom_reset_deassert,
>  };
> =20
> -#define	ANDROID_BOOT_DEV_MAX	30
> -static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> -
> -#ifndef MODULE
> -static int __init get_android_boot_dev(char *str)
> -{
> -	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
> -	return 1;
> -}
> -__setup("androidboot.bootdevice=3D", get_android_boot_dev);
> -#endif
> -
>  /**
>   * ufs_qcom_init - bind phy with controller
>   * @hba: host controller instance
> @@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	struct resource *res;
>  	struct ufs_clk_info *clki;
> =20
> -	if (strlen(android_boot_dev) && strcmp(android_boot_dev, dev_name(dev))=
)
> -		return -ENODEV;
> -
>  	host =3D devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
>  	if (!host) {
>  		err =3D -ENOMEM;
> --=20
> 2.32.0

