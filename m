Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA034DCEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiCQTS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiCQTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:18:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D521BC4A;
        Thu, 17 Mar 2022 12:17:08 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220317191705euoutp01d8d55a6882c6f48c8e14e23f8cb4ed70~dQRu1iEjC1184911849euoutp01V;
        Thu, 17 Mar 2022 19:17:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220317191705euoutp01d8d55a6882c6f48c8e14e23f8cb4ed70~dQRu1iEjC1184911849euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647544626;
        bh=IuOdG+4FsA39V9eFsqldCmTTU3BdeTK9A6hAbQWkWZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpwtdOyZgaR61XwTd8z1bJao9MsJXquF2WCwXx6ncPU14Wy9ThA6AmzE3Fv+INc8M
         LfUXvhvhY0XKipITEts2XpCJI48ure4HYGNtToh9S1AwVN4U2qKL6FKyAb0GMW6Kdy
         2cO05RaSa/cOTieVzBb2Bm7htzh9glMjoGTAYHqU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220317191705eucas1p1f8f62076c5130750b9fd59d6892dcbca~dQRuWKLbL1281012810eucas1p1V;
        Thu, 17 Mar 2022 19:17:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.4B.10009.13983326; Thu, 17
        Mar 2022 19:17:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220317191704eucas1p1b53cee77511f1c79fef0bf764cab4f6c~dQRtZkhQt3195731957eucas1p1T;
        Thu, 17 Mar 2022 19:17:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220317191704eusmtrp270f7badd744c77abf3c9bcf8f55732b2~dQRtYz6Ii1716717167eusmtrp2U;
        Thu, 17 Mar 2022 19:17:04 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-64-623389313dde
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.13.09522.03983326; Thu, 17
        Mar 2022 19:17:04 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220317191704eusmtip1638baaa358065f0b03daaa040c95d974~dQRtLfj302211522115eusmtip1D;
        Thu, 17 Mar 2022 19:17:04 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 25/38] media: platform: s5p-g2d: move config to its
 own file
Date:   Thu, 17 Mar 2022 20:17:03 +0100
In-Reply-To: <c801234d44c13878854d1348b2297826b78d178e.1647006877.git.mchehab@kernel.org>
        (Mauro Carvalho Chehab's message of "Fri, 11 Mar 2022 15:07:38 +0100")
Message-ID: <dleftj5yocmlsg.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87qGncZJBq9/CFis/viY0eLizLss
        Fp0Tl7BbbHp8jdXi8q45bBY9G7ayWizb9IfJYtf0HewWd0/qOHB67Jx1l91jdsdMVo9NqzrZ
        PDYvqffY+G4Hk8fzy9/ZPD5vkvM49fUzewBHFJdNSmpOZllqkb5dAlfGwesPGQt+SFVMuriS
        tYGxTbyLkZNDQsBEYkL3DOYuRi4OIYEVjBJdp14xQThfGCVafi2FynxmlGiY38gK03Jt0xt2
        EFtIYDmjxLbblRBFz4Had94BKuLgYBPQk1i7NgKkRgTIfL75IgtIDbPAfSaJ1d0HmUASwgKh
        Eg83fAOrZxFQlWhZUg9SwymwiFHiXPt6ZpAaXgFzicvHJ4AtFhWwlPjz7CM7RFxQ4uTMJywg
        NrNArsTM828YQZolBOZzSqyYcIcRZKiEgIvEti9iEEcLS7w6voUdwpaR+L9zPhNESb3E5Elm
        EK09QL/M+cECUWMtcefcLzaIGkeJR1/FIEw+iRtvBSG28klM2jadGSLMK9HRJgTRqCKxrn8P
        1BApid5XKxghbA+JhuZZrJCQWsMocWL3H9YJjAqzkDwzC8kzs4DGMgtoSqzfpQ8R1pZYtvA1
        M4RtK7Fu3XuWBYysqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLT2Ol/xz/tYJz76qPe
        IUYmDsZDjCpAzY82rL7AKMWSl5+XqiTCe+aFfpIQb0piZVVqUX58UWlOavEhRmkOFiVx3uTM
        DYlCAumJJanZqakFqUUwWSYOTqkGJq89bRdZnmT9c9rOznXs1qVrlwNPvFuhEhj/PF4+k3VS
        7xR3aYGKheJWnO++7xDqn/lHvHmP/bTZiefZUoO8D2zm4j544n3dIo2eCTmGa74w3Urbf6qL
        79eSB2f7Tu/ZeYb/1ZXb8zlCtYLjwwy7bOev+PnGd94jW3eTgpT/W0/M3isQfmHtpeyNH6do
        HZfmq604faZCdgVfapBt3st/mrbRyzc9ZV7q5NSo+anlqJHsrdVu4k86xfiKDVZ3TxGVXvvM
        d/nklS1feX8INPNYLNpsz6tiUi4oNcHmSFyOmqx8voAWi+yKLCYvV6Gstjs795+v3XI3duXq
        0yf+yk5eeC9UVJbR9soHs8sW21o9VZRYijMSDbWYi4oTAXjPkBneAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7oGncZJBouahS1Wf3zMaHFx5l0W
        i86JS9gtNj2+xmpxedccNoueDVtZLZZt+sNksWv6DnaLuyd1HDg9ds66y+4xu2Mmq8emVZ1s
        HpuX1HtsfLeDyeP55e9sHp83yXmc+vqZPYAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4PWHjAU/pComXVzJ2sDYJt7FyMkhIWAicW3TG/Yu
        Ri4OIYGljBKz/y1n62LkAEpISaycmw5RIyzx51oXG0TNU0aJ1W9XM4PUsAnoSaxdGwFSIwJk
        Pt98kQWkhlngIZPEzQsvmEESwgKhEg83fGMFqRcSiJD4tZQfxGQRUJVoWVIPUs4psIhR4lz7
        erByXgFzicvHJ7CC2KIClhJ/nn1kh4gLSpyc+YQFxGYWyJb4uvo58wRGgVlIUrOQpGYBrWAW
        0JRYv0sfIqwtsWzha2YI21Zi3br3LAsYWVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERuG2
        Yz8372Cc9+qj3iFGJg7GQ4wqQJ2PNqy+wCjFkpefl6okwnvmhX6SEG9KYmVValF+fFFpTmrx
        IUZToNcmMkuJJucD00NeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwen
        VANTUrDO79To6BMFSmdYJQ6xnvzr6pu3vm3ebD3ZD15dTp+uRZ47/GmLV2aBlNC8c0efL84x
        +bDg4Z//E0/m2s72y9wx0VLzf1Ibm4/8krzHr670Hpy/IPHInxd/72VlT8hz2iUnvuTNxkP3
        RJY+/8WVzKmwZH6FfsJb2e0JRS8Nf9x5szmmV23x762PvqZJv9y3RX7mn3+Z5w2fRqY9MJaZ
        ZlxaWdUtcslLRTKkUnTi01+71UXDFrH/shJ7//X8m7tFqxQiD517x3OFQZH1xZylk86siNv/
        1Jj5hfbuv3LJYsyKqbO8+W44dfzcHHfkrUKnnrrk8vtrMx9EpIXW/5hhkTTx4pZNMhyL/D7k
        19Q/XaLEUpyRaKjFXFScCABLKHlvVwMAAA==
X-CMS-MailID: 20220317191704eucas1p1b53cee77511f1c79fef0bf764cab4f6c
X-Msg-Generator: CA
X-RootMTR: 20220317191704eucas1p1b53cee77511f1c79fef0bf764cab4f6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220317191704eucas1p1b53cee77511f1c79fef0bf764cab4f6c
References: <c801234d44c13878854d1348b2297826b78d178e.1647006877.git.mchehab@kernel.org>
        <CGME20220317191704eucas1p1b53cee77511f1c79fef0bf764cab4f6c@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2022-03-11 pi=C4=85 15:07>, when Mauro Carvalho Chehab wrote:
> In order to better organize the platform/Kconfig, place
> s5p-g2d-specific config stuff on a separate Kconfig file.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover.
> See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git=
.mchehab@kernel.org/
>
>  drivers/media/platform/Kconfig         | 11 +----------
>  drivers/media/platform/s5p-g2d/Kconfig | 11 +++++++++++
>  2 files changed, 12 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/media/platform/s5p-g2d/Kconfig
>

Acked-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kcon=
fig
> index 633fbc408b8c..95f66255b635 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -67,6 +67,7 @@ source "drivers/media/platform/qcom/venus/Kconfig"
>  source "drivers/media/platform/aspeed/Kconfig"
>  source "drivers/media/platform/rockchip/rga/Kconfig"
>  source "drivers/media/platform/s3c-camif/Kconfig"
> +source "drivers/media/platform/s5p-g2d/Kconfig"
>=20=20
>  config VIDEO_MUX
>  	tristate "Video Multiplexer"
> @@ -164,16 +165,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
>  	help
>  	    Generic deinterlacing V4L2 driver.
>=20=20
> -config VIDEO_SAMSUNG_S5P_G2D
> -	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && VIDEO_V4L2
> -	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> -	select VIDEOBUF2_DMA_CONTIG
> -	select V4L2_MEM2MEM_DEV
> -	help
> -	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
> -	  2d graphics accelerator.
>=20=20
>  config VIDEO_SAMSUNG_S5P_JPEG
>  	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
> diff --git a/drivers/media/platform/s5p-g2d/Kconfig b/drivers/media/platf=
orm/s5p-g2d/Kconfig
> new file mode 100644
> index 000000000000..9bc9d90a666a
> --- /dev/null
> +++ b/drivers/media/platform/s5p-g2d/Kconfig
> @@ -0,0 +1,11 @@
> +config VIDEO_SAMSUNG_S5P_G2D
> +	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
> +	  2d graphics accelerator.
> +

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmIziS8ACgkQsK4enJil
gBA7ugf5ARjok/bSwjqedPBl0uFwsLnjwSBIzka1yyJYlhz+n32ym3+m9GNeNzGd
y77jzevMUqeowUfrkjQd0HK0UkIzkHAqDcm0Zb4cQGGAhM2bDsNE3ttnw9HPoE9v
J1DLTezlTOXM9Y/jjSCky4Sv/t4p/4Lun3YkWIaw3JwvIql1Mp3tU6knmKvc3wUO
rpNXxt3e9glKIgXGN5AlFKVtkGmlm6oRh9NcmtCPZQnr5y3BryVL1DkBGifGz4+Y
cDL4D28B9YGcfJcRGnyWlBIQ7xmvcoicbpBzQXaiDzFkR/wbT4PRjBNixgJx8DX2
m15lv5enSQ4pMiBnY6MsNXI/UO9I9g==
=puL7
-----END PGP SIGNATURE-----
--=-=-=--
