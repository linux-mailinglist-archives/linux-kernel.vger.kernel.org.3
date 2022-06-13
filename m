Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD154978B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiFMQNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244865AbiFMQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:12:20 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFFD2314C;
        Mon, 13 Jun 2022 07:04:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 732A81BF204;
        Mon, 13 Jun 2022 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655129056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgP4W2WcGLch0G1Z/a9d2JFCittPWMEM8INjyTTlF+o=;
        b=RHeR1FQ/oaGkFKglO95swbvRFaOAhB3zVTr+Iu4qezNsX0NWdqd7VE7g+YxKY7iFNIVvpD
        MRpE2qdYhxKxv4prc6X1uYby+AmIMIrmMKOW5nDMKrbDKLpjCe34ppD9oFa07wgsvyE3DY
        EohfY0giovrsbV8ylO/1gDQjesMK33L6IoOhYAVGPb6Ei/9+SDN7Gl5sAqQ406fyQ5FcbH
        TjZcAVfd5btd9c2VyMjB3W2zfTCFIfEiC47EM29IDqY0fopU4MX4Bp+YwiRGWOH3cYXBTi
        a6JfGmL63vnILBbjFDpLHbGSBRhUAqJf0GRIE95tXyPs5qDjFuE4VPDITSQZhw==
Date:   Mon, 13 Jun 2022 16:04:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/2] mtd: allow getting MTD device associated with a
 specific DT node
Message-ID: <20220613160411.48b07515@xps-13>
In-Reply-To: <20220611204651.19947-1-zajec5@gmail.com>
References: <20220611204651.19947-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Sat, 11 Jun 2022 22:46:50 +0200:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MTD subsystem API allows interacting with MTD devices (e.g. reading,
> writing, handling bad blocks). So far a random driver could get MTD
> device only by its name (get_mtd_device_nm()). This change allows
> getting them also by a DT node.
>=20
> This API is required for drivers handling DT defined MTD partitions in a
> specific way (e.g. U-Boot (sub)partition with environment variables).
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> V3: First introduction of of_get_mtd_device_by_node()
>=20
> mtd maintainers: please let know how would you like this patch
> processed. Would that be OK for you to Review/Ack it and let it go
> through NVMEM tree?

Yes

> ---
>  drivers/mtd/mtdcore.c   | 28 ++++++++++++++++++++++++++++
>  include/linux/mtd/mtd.h |  1 +
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 9eb0680db312..7dc214271c85 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1154,6 +1154,34 @@ int __get_mtd_device(struct mtd_info *mtd)
>  }
>  EXPORT_SYMBOL_GPL(__get_mtd_device);
> =20
> +/**
> + * of_get_mtd_device_by_node - obtain an MTD device associated with a gi=
ven node
> + *
> + * @np: device tree node
> + */
> +struct mtd_info *of_get_mtd_device_by_node(struct device_node *np)

Shall we try to use a more of-agnostic syntax or is it too complex here?

> +{
> +	struct mtd_info *mtd =3D NULL;
> +	struct mtd_info *tmp;
> +	int err;
> +
> +	mutex_lock(&mtd_table_mutex);
> +
> +	err =3D -ENODEV;
> +	mtd_for_each_device(tmp) {
> +		if (mtd_get_of_node(tmp) =3D=3D np) {
> +			mtd =3D tmp;
> +			err =3D __get_mtd_device(mtd);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&mtd_table_mutex);
> +
> +	return err ? ERR_PTR(err) : mtd;
> +}
> +EXPORT_SYMBOL_GPL(of_get_mtd_device_by_node);
> +
>  /**
>   *	get_mtd_device_nm - obtain a validated handle for an MTD device by
>   *	device name
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 955aee14b0f7..6fc841ceef31 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -677,6 +677,7 @@ extern int mtd_device_unregister(struct mtd_info *mas=
ter);
>  extern struct mtd_info *get_mtd_device(struct mtd_info *mtd, int num);
>  extern int __get_mtd_device(struct mtd_info *mtd);
>  extern void __put_mtd_device(struct mtd_info *mtd);
> +extern struct mtd_info *of_get_mtd_device_by_node(struct device_node *np=
);
>  extern struct mtd_info *get_mtd_device_nm(const char *name);
>  extern void put_mtd_device(struct mtd_info *mtd);
> =20


Thanks,
Miqu=C3=A8l
