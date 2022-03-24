Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008654E62F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349960AbiCXMNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiCXMNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:13:10 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE3AA8891;
        Thu, 24 Mar 2022 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1648123898; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnCAvLWdM1Y5d8SOO6pcXoGJy8s/S8dfYLfjzDercYo=;
        b=RDFMgE5lRxQ5dNk3YEU3j9gxoWl85Ijk2rTXFAd79SyCDijcOk5SbSMhvmw6uA5re/tUd9
        +D52uN65yhrxGIRjAfi6T5Zua0daT6oqbweLkgu6DYYOZllGXSgmuhlkT+w/bP8nrojdjW
        UmPpc2Ouwhhi6nICVfJK7DyaH6lpCI4=
Date:   Thu, 24 Mar 2022 12:11:29 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] thermal:hisi_termal: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
To:     Hesham Almatary <hesham.almatary@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
Message-Id: <5J099R.20GRUWFVWC5D1@crapouillou.net>
In-Reply-To: <20220324103443.4563-1-hesham.almatary@huawei.com>
References: <20220324103443.4563-1-hesham.almatary@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hesham,

Le jeu., mars 24 2022 at 10:34:43 +0000, Hesham Almatary=20
<hesham.almatary@huawei.com> a =E9crit :
> Cleaning up the driver to use pm_sleep_ptr() macro instead of #ifdef
> guards is simpler and allows the compiler to remove those functions
> if built without CONFIG_PM_SLEEP support.
>=20
> Signed-off-by: Hesham Almatary <hesham.almatary@huawei.com>

Looks good.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/thermal/hisi_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/hisi_thermal.c=20
> b/drivers/thermal/hisi_thermal.c
> index 9a21ac0ceb11..b29ab09040d5 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -629,7 +629,6 @@ static int hisi_thermal_remove(struct=20
> platform_device *pdev)
>  	return 0;
>  }
>=20
> -#ifdef CONFIG_PM_SLEEP
>  static int hisi_thermal_suspend(struct device *dev)
>  {
>  	struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
> @@ -651,15 +650,14 @@ static int hisi_thermal_resume(struct device=20
> *dev)
>=20
>  	return ret;
>  }
> -#endif
>=20
> -static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
> +static DEFINE_SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
>  			 hisi_thermal_suspend, hisi_thermal_resume);
>=20
>  static struct platform_driver hisi_thermal_driver =3D {
>  	.driver =3D {
>  		.name		=3D "hisi_thermal",
> -		.pm		=3D &hisi_thermal_pm_ops,
> +		.pm		=3D pm_sleep_ptr(&hisi_thermal_pm_ops),
>  		.of_match_table =3D of_hisi_thermal_match,
>  	},
>  	.probe	=3D hisi_thermal_probe,
> --
> 2.25.1
>=20


