Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15858EBED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiHJMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:24:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB37390A;
        Wed, 10 Aug 2022 05:24:25 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220810122422euoutp029218fe6af2cd3de66370842708bc77fc~J_1DMYGH_1252712527euoutp02c;
        Wed, 10 Aug 2022 12:24:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220810122422euoutp029218fe6af2cd3de66370842708bc77fc~J_1DMYGH_1252712527euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660134262;
        bh=+3l88EsjGyn55z4ZRs7gGju8VKtfIG8BwbGIKXpK3bc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=GNtF231Dlgnyvl2Ga/u8W64gnmoeF4aOvxQOZrCrtYj0fqjRg9zF529hKcpfTn+Ze
         TZnOjjwpsGrPwG0pGuDgpMYyk2Pq24FOIHiNLCeV+0KzITKaXuDkNI0+js0VURMkbQ
         9IlEQPzjCUBGR6WJXTOi2cGopyDXjl/Q5bNb/NWI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220810122421eucas1p18ddad99e5ed2c74a453eac86180fac40~J_1C_RwyV1021510215eucas1p1W;
        Wed, 10 Aug 2022 12:24:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.FC.09664.573A3F26; Wed, 10
        Aug 2022 13:24:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220810122421eucas1p2cc6ec714dd3694c3a940f167f1bd4e0f~J_1CftUue2435624356eucas1p29;
        Wed, 10 Aug 2022 12:24:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220810122421eusmtrp27c56f3582085b5cf2384109b4abfee15~J_1CeqCHi2578525785eusmtrp2d;
        Wed, 10 Aug 2022 12:24:21 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-6f-62f3a375baf2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.C5.09038.573A3F26; Wed, 10
        Aug 2022 13:24:21 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220810122421eusmtip1cfb9e32e43046f89b85c123ee7ad73d3~J_1COj95f0260102601eusmtip1U;
        Wed, 10 Aug 2022 12:24:21 +0000 (GMT)
Received: from localhost (106.210.248.55) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 10 Aug 2022 13:24:20 +0100
Date:   Wed, 10 Aug 2022 14:24:18 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     <Johannes.Thumshirn@wdc.com>, <snitzer@kernel.org>,
        <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <agk@redhat.com>, <hch@lst.de>, <dm-devel@redhat.com>,
        <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <pankydev8@gmail.com>,
        <jaegeuk@kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <bvanassche@acm.org>, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v9 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <20220810122418.uezvmhtpg4smhb3q@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="sgoahstkgh4p3pr6"
Content-Disposition: inline
In-Reply-To: <20220803094801.177490-14-p.raghav@samsung.com>
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7djPc7qliz8nGTT16VqsP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
        nrJbTGj7ymyx5uZTFosTt6QdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddBQqdrvb4vEnOo/1AN1MAdxSXTUpqTmZZapG+XQJXxva5qxgL7rcxVnQ92sPUwHgyq4uR
        k0NCwETid9dNli5GLg4hgRWMEu1Tr0I5Xxglds3fwgThfGaU2PbgNxNMy/9l11ghEssZJT7+
        WopQdXv/EihnC6PE99bX7CAtLAKqEv/e7mYEsdkEdCTOv7nDDGKLCGhIPLuyGayBWWA/s8SV
        t4uBEhwcwgJZEi+fyoDU8AqYS7z40MMCYQtKnJz5BMxmFqiQ+HuoiRGknFlAWmL5Pw6QMKeA
        jcTV3f2sEJcqSVx7/pQFwq6VWHvsDDvIKgmBf5wSS9edhEq4SCz7PxWqQVji1fEt7BC2jMT/
        nfOhXs6W2DllFzOEXSAx6+RUNpC9EgLWEn1nciDCjhILT/eyQ4T5JG68FYS4kk9i0rbpzBBh
        XomONiGIajWJHU1bGScwKs9C8tcsJH/NQvgLIqwjsWD3JzYMYW2JZQtfM0PYthLr1r1nWcDI
        vopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwqZ7+d/zTDsa5rz7qHWJk4mA8xKgC1Pxo
        w+oLjFIsefl5qUoivGWLPicJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpa
        kFoEk2Xi4JRqYJpquHrXWu9PElPOfS14OJnfO2DVs/dHFWM1BS1Xb7GKePD2llihZ56ootxX
        ro0z501Yr77tSWOx/r2pTb8u8iWeXK0YaTZbpfDqyqkdiodPT9i5akPTk4Jcq5+CXO9zK95O
        3NgYEhoarHvhmONePbeTHLpNa5h6uNOK01Pvh4ltLzntUHv4fsCqtk7Ou/lv2B+2h+sXTHrn
        PzdqTlLIF4/Z3qdv391x4dFlzenvvTb+8NZqedRtl/Tp4bkTd7UynhutvrT3Jr/C3xaJCisN
        PefVUwWMp/H7VRnm9n2abZi/zeXnFpNtuSrVb29acTiY1a6Zfuy7mO+F+yJLJ0avOnV01fyu
        uSL1fB57nr037NyrxFKckWioxVxUnAgAc49epyUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsVy+t/xu7qliz8nGcyZz22x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtdizaBKTxcrVR5ksnqyfxWzxt+seUOKWtsXlXXPYLOYv
        e8puMaHtK7PFmptPWSxO3JJ2EPC4fMXbY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHjtb77N6
        vN93FSh0utrj8yY5j/YD3UwB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6GQ9a9rMW3G1jrFi6dB9rA+PxrC5GTg4JAROJ/8uusXYxcnEICSxl
        lDj1tIEVIiEj8enKR3YIW1jiz7UuNoiij4wSD+8/ZgJJCAlsYZToeJMNYrMIqEr8e7ubEcRm
        E9CROP/mDjOILSKgIfHsymYmkGZmgf3MElfeLgZKcHAIC2RJvHwqA1LDK2Au8eJDDwvEggOM
        Ep9+72aGSAhKnJz5hAWknlmgTGLrMwUIU1pi+T8OkApOARuJq7v7oW5Wkrj2/CkLhF0r8er+
        bsYJjMKzkAyahTBoFsIgkApmAS2JG/9eMmEIa0ssW/iaGcK2lVi37j3LAkb2VYwiqaXFuem5
        xUZ6xYm5xaV56XrJ+bmbGIGJZduxn1t2MK589VHvECMTB+MhRhWgzkcbVl9glGLJy89LVRLh
        LVv0OUmINyWxsiq1KD++qDQntfgQoykwDCcyS4km5wNTXl5JvKGZgamhiZmlgamlmbGSOK9n
        QUeikEB6YklqdmpqQWoRTB8TB6dUA1OmgCyLBIdBtpG6z6JrB57L9LS/SvI5xerGHWdkbW2e
        2CEqWbNo8pRrl2p6A9Wf+y16ck514s9wG78VL/ZOvLYo8l4wh84Nd716PhOX1X2vvi2rFeBJ
        kFie53sk8cISoe9V02Q6Ns28usu4RXlt4Lv05MyV7nofHhUs/rov6Urgqw1iMpoOTY75UUVp
        63Vmam051vvB7sXChoeyE6/Oqha722d6fMolJbWQr/pvprdP57K6pP56RfdN/513493YZjB+
        j9vT7fyKO4dNOzg8SKli4mXWzYcS5QOXBUq/Do3+NN95ba/5zJmPPV/9vyVtXpjAamv78nXE
        PYc5Kjqq/Y0nLrFcjj6hvDtrErvmUyWW4oxEQy3mouJEAHYcxDHBAwAA
X-CMS-MailID: 20220810122421eucas1p2cc6ec714dd3694c3a940f167f1bd4e0f
X-Msg-Generator: CA
X-RootMTR: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672@eucas1p1.samsung.com>
        <20220803094801.177490-14-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sgoahstkgh4p3pr6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2022 at 11:48:01AM +0200, Pankaj Raghav wrote:
> Only zoned devices with power-of-2(po2) zone sizes were supported in linux
> but now non power-of-2(npo2) zone sizes support has been added to the
> block layer.
Would it make sense to replace this first paragraph with:
"
Only zoned devices with power-of-2(po2) zone sizes (in number of
sectors) were supported in linux but now non power-of-2(npo2) values are
supported in the block layer.
"
?

In this way you have made clear that zone sizes are in number of sectors
and every time you reference it afterwards, it is implied that it is in
number of sectors.

otherwise LGTM
Reviewed-by: Joel Granados <j.granados@samsung.com>
>=20
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 size zoned target so that file systems can initially work
> without any explicit changes by using this target.
>=20
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> number of sectors.
>=20
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
>=20
> Device layout :-
> zone capacity =3D 3M
> zone size =3D 3M
>=20
> |--------------|-------------|
> 0             3M            6M
>=20
> Target layout :-
> zone capacity=3D3M
> zone size =3D 4M
>=20
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
>=20
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
>=20
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
>=20
> Note that the target does not support partial mapping of the underlying
> device.
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> ---
>  .../admin-guide/device-mapper/dm-po2zone.rst  |  71 ++++++
>  .../admin-guide/device-mapper/index.rst       |   1 +
>  drivers/md/Kconfig                            |  10 +
>  drivers/md/Makefile                           |   2 +
>  drivers/md/dm-po2zone-target.c                | 240 ++++++++++++++++++
>  5 files changed, 324 insertions(+)
>  create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
>  create mode 100644 drivers/md/dm-po2zone-target.c
>=20
> diff --git a/Documentation/admin-guide/device-mapper/dm-po2zone.rst b/Doc=
umentation/admin-guide/device-mapper/dm-po2zone.rst
> new file mode 100644
> index 000000000000..b2c240697e00
> --- /dev/null
> +++ b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
> @@ -0,0 +1,71 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +dm-po2zone
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The dm-po2zone device mapper target exposes a zoned block device with a
> +non-power-of-2(npo2) zone number of sectors as a power-of-2(po2) zone nu=
mber
> +of sectors.
> +The filesystems that support zoned block devices such as F2FS and BTRFS
> +assume po2 zone size sectors as the kernel has traditionally only suppor=
ted
> +those devices. However, as the kernel now supports zoned block devices w=
ith
> +npo2 zone size sectors, the dm-po2zone target can be used by the filesys=
tems
> +before adding native support.
> +
> +Partial mapping of the underlying device is not supported by this target.
> +
> +Algorithm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The device mapper target maps the underlying device's zone size to the
> +zone capacity and changes the zone size to the nearest po2 number of sec=
tors.
> +The gap between the zone capacity and the zone size is emulated in the t=
arget.
> +E.g., a zoned block device with a zone size (and capacity) of 3M will ha=
ve an
> +equivalent target layout with mapping as follows:
> +
> +::
> +
> +  0M           3M  4M        6M 8M
> +  |             |  |          |  |
> +  +x------------+--+x---------+--+x-------  Target
> +  |x            |  |x         |  |x
> +   x               x             x
> +   x               x             x
> +   x              x             x
> +   x             x             x
> +  |x            |x            |x
> +  +x------------+x------------+x----------  Device
> +  |             |             |
> +  0M           3M            6M
> +
> +A simple remap is performed for all the BIOs that do not cross the
> +emulation gap area, i.e., the area between the zone capacity and size.
> +
> +If a BIO crosses the emulation gap area, the following operations are pe=
rformed:
> +
> +	Read:
> +		- If the BIO lies entirely in the emulation gap area, then zero out th=
e BIO and complete it.
> +		- If the BIO spans the emulation gap area, split the BIO across the zo=
ne capacity boundary
> +                  and remap only the BIO within the zone capacity bounda=
ry. The other part of the split BIO
> +                  will be zeroed out.
> +
> +	Other operations:
> +                - Return an error
> +
> +Table parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +::
> +
> +  <dev path>
> +
> +Mandatory parameters:
> +
> +    <dev path>:
> +        Full pathname to the underlying block-device, or a
> +        "major:minor" device-number.
> +
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +::
> +
> +  #!/bin/sh
> +  echo "0 `blockdev --getsz $1` po2zone $1" | dmsetup create po2z
> diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Document=
ation/admin-guide/device-mapper/index.rst
> index cde52cc09645..1fd04b5b0565 100644
> --- a/Documentation/admin-guide/device-mapper/index.rst
> +++ b/Documentation/admin-guide/device-mapper/index.rst
> @@ -23,6 +23,7 @@ Device Mapper
>      dm-service-time
>      dm-uevent
>      dm-zoned
> +    dm-po2zone
>      era
>      kcopyd
>      linear
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 998a5cfdbc4e..7cdd2d03ba7d 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -518,6 +518,16 @@ config DM_FLAKEY
>  	help
>  	 A target that intermittently fails I/O for debugging purposes.
> =20
> +config DM_PO2ZONE
> +	tristate "Power-of-2 zone number of sectors target for zoned block devi=
ces"
> +	depends on BLK_DEV_DM
> +	depends on BLK_DEV_ZONED
> +	help
> +	  A target that converts a zoned block device with non-power-of-2(npo2)=
 zone
> +	  number of sectors to be power-of-2(po2). Use this target for zoned bl=
ock
> +	  devices with npo2 zone number of sectors until native support is adde=
d to
> +	  the filesystems and applications.
> +
>  config DM_VERITY
>  	tristate "Verity target support"
>  	depends on BLK_DEV_DM
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index 84291e38dca8..c23f81cc8789 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -26,6 +26,7 @@ dm-era-y	+=3D dm-era-target.o
>  dm-clone-y	+=3D dm-clone-target.o dm-clone-metadata.o
>  dm-verity-y	+=3D dm-verity-target.o
>  dm-zoned-y	+=3D dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
> +dm-po2zone-y	+=3D dm-po2zone-target.o
> =20
>  md-mod-y	+=3D md.o md-bitmap.o
>  raid456-y	+=3D raid5.o raid5-cache.o raid5-ppl.o
> @@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+=3D dm-crypt.o
>  obj-$(CONFIG_DM_DELAY)		+=3D dm-delay.o
>  obj-$(CONFIG_DM_DUST)		+=3D dm-dust.o
>  obj-$(CONFIG_DM_FLAKEY)		+=3D dm-flakey.o
> +obj-$(CONFIG_DM_PO2ZONE)	+=3D dm-po2zone.o
>  obj-$(CONFIG_DM_MULTIPATH)	+=3D dm-multipath.o dm-round-robin.o
>  obj-$(CONFIG_DM_MULTIPATH_QL)	+=3D dm-queue-length.o
>  obj-$(CONFIG_DM_MULTIPATH_ST)	+=3D dm-service-time.o
> diff --git a/drivers/md/dm-po2zone-target.c b/drivers/md/dm-po2zone-targe=
t.c
> new file mode 100644
> index 000000000000..64c4c0611ddf
> --- /dev/null
> +++ b/drivers/md/dm-po2zone-target.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/device-mapper.h>
> +
> +#define DM_MSG_PREFIX "po2zone"
> +
> +struct dm_po2z_target {
> +	struct dm_dev *dev;
> +	sector_t zone_size; /* Actual zone size of the underlying dev*/
> +	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
> +	unsigned int zone_size_po2_shift;
> +	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
> +	unsigned int nr_zones;
> +};
> +
> +static inline unsigned int npo2_zone_no(struct dm_po2z_target *dmh,
> +					sector_t sect)
> +{
> +	return div64_u64(sect, dmh->zone_size);
> +}
> +
> +static inline unsigned int po2_zone_no(struct dm_po2z_target *dmh,
> +				       sector_t sect)
> +{
> +	return sect >> dmh->zone_size_po2_shift;
> +}
> +
> +static inline sector_t target_to_device_sect(struct dm_po2z_target *dmh,
> +					     sector_t sect)
> +{
> +	return sect - (po2_zone_no(dmh, sect) * dmh->zone_size_diff);
> +}
> +
> +static inline sector_t device_to_target_sect(struct dm_po2z_target *dmh,
> +					     sector_t sect)
> +{
> +	return sect + (npo2_zone_no(dmh, sect) * dmh->zone_size_diff);
> +}
> +
> +/*
> + * This target works on the complete zoned device. Partial mapping is not
> + * supported.
> + * Construct a zoned po2 logical device: <dev-path>
> + */
> +static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **a=
rgv)
> +{
> +	struct dm_po2z_target *dmh =3D NULL;
> +	int ret;
> +	sector_t zone_size;
> +	sector_t dev_capacity;
> +
> +	if (argc !=3D 1)
> +		return -EINVAL;
> +
> +	dmh =3D kmalloc(sizeof(*dmh), GFP_KERNEL);
> +	if (!dmh)
> +		return -ENOMEM;
> +
> +	ret =3D dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
> +			    &dmh->dev);
> +
> +	if (ret) {
> +		ti->error =3D "Device lookup failed";
> +		kfree(dmh);
> +		return ret;
> +	}
> +
> +	zone_size =3D bdev_zone_sectors(dmh->dev->bdev);
> +	dev_capacity =3D get_capacity(dmh->dev->bdev->bd_disk);
> +	if (ti->len !=3D dev_capacity || ti->begin) {
> +		DMERR("%pg Partial mapping of the target not supported",
> +		      dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	if (is_power_of_2(zone_size))
> +		DMWARN("%pg:not a useful target for devices with po2 zone number of se=
ctors",
> +		       dmh->dev->bdev);
> +
> +	dmh->zone_size =3D zone_size;
> +	dmh->zone_size_po2 =3D 1 << get_count_order_long(zone_size);
> +	dmh->zone_size_po2_shift =3D ilog2(dmh->zone_size_po2);
> +	dmh->zone_size_diff =3D dmh->zone_size_po2 - dmh->zone_size;
> +	ti->private =3D dmh;
> +	ti->max_io_len =3D dmh->zone_size_po2;
> +	dmh->nr_zones =3D npo2_zone_no(dmh, ti->len);
> +	ti->len =3D dmh->zone_size_po2 * dmh->nr_zones;
> +
> +	return 0;
> +}
> +
> +static int dm_po2z_report_zones_cb(struct blk_zone *zone, unsigned int i=
dx,
> +				   void *data)
> +{
> +	struct dm_report_zones_args *args =3D data;
> +	struct dm_po2z_target *dmh =3D args->tgt->private;
> +
> +	zone->start =3D device_to_target_sect(dmh, zone->start);
> +	zone->wp =3D device_to_target_sect(dmh, zone->wp);
> +	zone->len =3D dmh->zone_size_po2;
> +	args->next_sector =3D zone->start + zone->len;
> +
> +	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
> +}
> +
> +static int dm_po2z_report_zones(struct dm_target *ti,
> +				struct dm_report_zones_args *args,
> +				unsigned int nr_zones)
> +{
> +	struct dm_po2z_target *dmh =3D ti->private;
> +	sector_t sect =3D po2_zone_no(dmh, args->next_sector) * dmh->zone_size;
> +
> +	return blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
> +				   dm_po2z_report_zones_cb, args);
> +}
> +
> +static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
> +			  blk_status_t *error)
> +{
> +	struct dm_po2z_target *dmh =3D ti->private;
> +
> +	if (bio->bi_status =3D=3D BLK_STS_OK && bio_op(bio) =3D=3D REQ_OP_ZONE_=
APPEND)
> +		bio->bi_iter.bi_sector =3D
> +			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
> +
> +	return DM_ENDIO_DONE;
> +}
> +
> +static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *=
limits)
> +{
> +	struct dm_po2z_target *dmh =3D ti->private;
> +
> +	limits->chunk_sectors =3D dmh->zone_size_po2;
> +}
> +
> +static bool bio_across_emulated_zone_area(struct dm_po2z_target *dmh,
> +					  struct bio *bio)
> +{
> +	unsigned int zone_idx =3D po2_zone_no(dmh, bio->bi_iter.bi_sector);
> +	sector_t nr_sectors =3D bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +	return (bio->bi_iter.bi_sector + nr_sectors) >
> +	       (zone_idx * dmh->zone_size_po2) + dmh->zone_size;
> +}
> +
> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
> +					  struct bio *bio)
> +{
> +	sector_t start_sect =3D bio->bi_iter.bi_sector;
> +	unsigned int zone_idx =3D po2_zone_no(dmh, start_sect);
> +	sector_t relative_sect_in_zone =3D start_sect - (zone_idx * dmh->zone_s=
ize_po2);
> +	sector_t split_io_pos;
> +
> +	/*
> +	 * If the starting sector is in the emulated area then fill
> +	 * all the bio with zeros. If bio is across emulated zone boundary,
> +	 * split the bio across boundaries and fill zeros only for the
> +	 * bio that is between the zone capacity and the zone size.
> +	 */
> +	if (relative_sect_in_zone < dmh->zone_size) {
> +		split_io_pos =3D (zone_idx * dmh->zone_size_po2) + dmh->zone_size;
> +		dm_accept_partial_bio(bio, split_io_pos - start_sect);
> +		bio->bi_iter.bi_sector =3D target_to_device_sect(dmh, start_sect);
> +
> +		return DM_MAPIO_REMAPPED;
> +	}
> +
> +	zero_fill_bio(bio);
> +	bio_endio(bio);
> +	return DM_MAPIO_SUBMITTED;
> +}
> +
> +static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> +{
> +	struct dm_po2z_target *dmh =3D ti->private;
> +
> +	bio_set_dev(bio, dmh->dev->bdev);
> +	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
> +		if (!bio_across_emulated_zone_area(dmh, bio)) {
> +			bio->bi_iter.bi_sector =3D target_to_device_sect(dmh,
> +								       bio->bi_iter.bi_sector);
> +			return DM_MAPIO_REMAPPED;
> +		}
> +		/*
> +		 * Read operation on the emulated zone area (between zone capacity
> +		 * and zone size) will fill the bio with zeroes. Any other operation
> +		 * in the emulated area should return an error.
> +		 */
> +		if (bio_op(bio) =3D=3D REQ_OP_READ)
> +			return dm_po2z_map_read_emulated_area(dmh, bio);
> +
> +		return DM_MAPIO_KILL;
> +	}
> +	return DM_MAPIO_REMAPPED;
> +}
> +
> +static int dm_po2z_iterate_devices(struct dm_target *ti,
> +				   iterate_devices_callout_fn fn, void *data)
> +{
> +	struct dm_po2z_target *dmh =3D ti->private;
> +	sector_t len =3D dmh->nr_zones * dmh->zone_size;
> +
> +	return fn(ti, dmh->dev, 0, len, data);
> +}
> +
> +static struct target_type dm_po2z_target =3D {
> +	.name =3D "po2zone",
> +	.version =3D { 1, 0, 0 },
> +	.features =3D DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES,
> +	.map =3D dm_po2z_map,
> +	.end_io =3D dm_po2z_end_io,
> +	.report_zones =3D dm_po2z_report_zones,
> +	.iterate_devices =3D dm_po2z_iterate_devices,
> +	.module =3D THIS_MODULE,
> +	.io_hints =3D dm_po2z_io_hints,
> +	.ctr =3D dm_po2z_ctr,
> +};
> +
> +static int __init dm_po2z_init(void)
> +{
> +	return dm_register_target(&dm_po2z_target);
> +}
> +
> +static void __exit dm_po2z_exit(void)
> +{
> +	dm_unregister_target(&dm_po2z_target);
> +}
> +
> +/* Module hooks */
> +module_init(dm_po2z_init);
> +module_exit(dm_po2z_exit);
> +
> +MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
> +MODULE_LICENSE("GPL");
> +
> --=20
> 2.25.1
>=20

--sgoahstkgh4p3pr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLzo2kACgkQupfNUreW
QU/PnAv/TzTqEO4SbfzO8fmgWp4EO3lbGkG1vl2pFyvrFJibH4iLTHaYn0KMha9i
NcEjmSGtayFLGNI51JKt2rXb/INPs0yplnk9dyx8NZa2CFbafyTC9iwfoxvWbvdK
s4k6pBJxDDvk+HzA2dlAwTrsO7TN6f1a91QWdloKDxhgmUfpA9IM3v6vlZQqidxG
aQv0u5N29cs5lSyRS8HrAUPyy4CQsIQkifk3WMq35BNnsimRFqjscfvbF/pvg8gO
a9yzKjm80Aq9TTHot6M7plNuZATXiXundqGSJdbeBU/jIAq21GR1a3G5Ovw8G4yC
S/4+nVuuJiYj2ib6qeIA3PpNxw1vwGwmfH1c760AE8ep6fqboCtY3ierC/TNPKpz
Il4JkEUTeBuKWEHj9lSfG21mvhPkShST4Kce72OJNxfyh6SAj1LXBsYE/ZUED/V/
Po+gKYWFrrs8jFlncAU50+jtzvIA/26njg2HkBe7YaSNGsPhlOnBYAua69xFmUp8
1g6xLfIX
=GJRJ
-----END PGP SIGNATURE-----

--sgoahstkgh4p3pr6--
