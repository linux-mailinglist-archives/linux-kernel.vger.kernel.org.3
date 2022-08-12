Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8B591075
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiHLMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiHLMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:03:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A099242;
        Fri, 12 Aug 2022 05:03:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220812120337euoutp02e0d27dcd908d5945a879ec632d9aa33e~Kl1gLu69X2736627366euoutp02V;
        Fri, 12 Aug 2022 12:03:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220812120337euoutp02e0d27dcd908d5945a879ec632d9aa33e~Kl1gLu69X2736627366euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660305817;
        bh=hIhIJSCGNBKAFOYSav+Nf3xC/FBXseENeTWE3RoQW3s=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=paRJg2pIllZkxpTnPrleKwqSZIlJVuM99HyIdVzBzIq6nozsSEFEOZK8p3yKfOatg
         VB/Ej2tIJ5C65uGZ6jSJIsHzjyS3D6g9pWESS1E38ZQ74XovnEP9xIWIe2T45ngSWN
         s1t3H+vvYjtjQqiBOrxQZF5HBvyYfy9/CIHrzoFY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220812120336eucas1p1b93a191b4ff1fbccb496f2c4fab11ed2~Kl1f54OrM1245312453eucas1p1N;
        Fri, 12 Aug 2022 12:03:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.7E.10067.89146F26; Fri, 12
        Aug 2022 13:03:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220812120336eucas1p196380c619caf30310cf027b2bed24048~Kl1fV4Uue1251712517eucas1p1I;
        Fri, 12 Aug 2022 12:03:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220812120336eusmtrp17fec9dc826ada2931062094f49505642~Kl1fUjZL32108221082eusmtrp11;
        Fri, 12 Aug 2022 12:03:36 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-fd-62f64198e252
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.69.09038.79146F26; Fri, 12
        Aug 2022 13:03:35 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220812120335eusmtip277845581eeba604c2b56277631113cc3~Kl1e4YPVv0836808368eusmtip2F;
        Fri, 12 Aug 2022 12:03:35 +0000 (GMT)
Received: from localhost (106.210.248.55) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 12 Aug 2022 13:03:32 +0100
Date:   Fri, 12 Aug 2022 14:03:29 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     <snitzer@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <agk@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-block@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <bvanassche@acm.org>, <matias.bjorling@wdc.com>, <hare@suse.de>,
        <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <pankydev8@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <20220812120329.zkdgwl5uwrwpp25d@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="nuyvy3t234ebxitc"
Content-Disposition: inline
In-Reply-To: <20220811143043.126029-14-p.raghav@samsung.com>
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZduznOd0Zjt+SDNY+V7ZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujF/9KgUX2xgrjh/4wd7AeDKri5GT
        Q0LARGLjvH+MXYxcHEICKxglOv+/h3K+MEpsX7sEyvnMKPHiVi8rTMvpL3PYQGwhgeWMEtN3
        MMMVnZr/lBXC2cIocXjFc7AqFgFViUOzzzKB2GwCOhLn39xhBrFFBDQknl3ZDBZnFtjPLNGz
        IqeLkYNDWCBbYmKHDYjJK2AucWRlKEgFr4CgxMmZT1ggqisktv1ewQhSwiwgLbH8HwdImFPA
        RmL++gY2iDOVJK49f8oCYddKrD12hh3kMgmBf5wS57ddYAPplRBwkbg+xQaiRlji1fEt7BC2
        jMTpyT1QvdkSO6fsYoawCyRmnZwK1Wot0XcmByLsCHTZLagwn8SNt4IQR/JJTNo2nRkizCvR
        0SYEUa0msaNpK+MERuVZSN6aheStWQhvQYR1JBbs/sSGIawtsWzha2YI21Zi3br3LAsY2Vcx
        iqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEptLT/45/2cG4/NVHvUOMTByMhxhVgJofbVh9
        gVGKJS8/L1VJhLds0eckId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KL
        YLJMHJxSDUzc65d/0Xnn1Rdroi5tcjJDp9VN2/3iSsnrRSVPGTtlTNefKgy7oNHsWLb8pUJQ
        U+K0Y80TNmg27nhyuIXv4tb3zyxMJcOmiSx/vPtqQZG5a9CUdeIvcrda/VhaqB94vnNede1N
        7yW7eNg2HOKOjj9kIK/672X1DPdTfbcvLlWw1w405dtzNtD79x/fmX55278zvMhUPVRasYj3
        PuvhtlCZy+kdfwPtt3525ZZV0Lq/cpJ5kEe0tUfqolqe9h1WXy89mtIk+26SpNpNS/+3i0P+
        rvX/e9OI4VTg1d/N526uebLZd96NDXIl/lJfdps9Dv48/9ge+5ttvrfjTu3frujd0+G1fce5
        9HW87DFzpj5SYinOSDTUYi4qTgQAE5hg/iAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsVy+t/xe7rTHb8lGWzZZW2x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtdizaBKTxcrVR5ksnqyfxWzxt+seUOKWtsXlXXPYLOYv
        e8puMaHtK7PFmptPWSxO3JJ2EPC4fMXbY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHjtb77N6
        vN93FSh0utrj8yY5j/YD3UwB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6GQce72IsON3GWLGt4RVbA+PxrC5GTg4JAROJ01/msHUxcnEICSxl
        lJi/dgIrREJG4tOVj+wQtrDEn2tdUEUfGSWWXmlhh3C2MEp0H7jIAlLFIqAqcWj2WSYQm01A
        R+L8mzvMILaIgIbEsyubmUAamAX2M0s0HJ4C1M3BISyQLTGxwwbE5BUwlziyMhRi5gFGiemL
        XzCC9PIKCEqcnPkEbD6zQJnEpaZfrCD1zALSEsv/cYCEOQVsJOavb2CDOFRJ4trzpywQdq3E
        q/u7GScwCs9CMmkWkkmzECZBhLUkbvx7yYQhrC2xbOFrZgjbVmLduvcsCxjZVzGKpJYW56bn
        FhvpFSfmFpfmpesl5+duYgQml23Hfm7Zwbjy1Ue9Q4xMHIyHGFWAOh9tWH2BUYolLz8vVUmE
        t2zR5yQh3pTEyqrUovz4otKc1OJDjKbAQJzILCWanA9Me3kl8YZmBqaGJmaWBqaWZsZK4rye
        BR2JQgLpiSWp2ampBalFMH1MHJxSDUy9tzs/lcjfWPc6e3P0Kwb2unkX+sLyC3ymF08WnWJV
        26eveDfevOx0ZHA3A4f5pt3OXkpbiw3czKf90T729m3g8713y55nWFp7yb0o2Xyv6Gj2ymet
        MvyLp+YtvimbkCKcc+exgrrlx9zFOT9knl/MOxHU/y5drjQxwFXjxv6cszY6QQV8Pvf/GMW5
        S5n8/Zq9VvnI55AGtpXxznP9neYzyNeeD/j9f8LnFcXe7styRCyDTvxlOpvCYvDbYrHbryof
        1dPHtM9Zll9f9bOZ7zCjeeDpzO83e9Ys7KjWyeor9Wus6Jq8K1tzWVGAq++WJ0GZZr+kj55i
        ujmx8ue5nlSPO5ur566/Gx3xUuCRgxJLcUaioRZzUXEiABFPT77DAwAA
X-CMS-MailID: 20220812120336eucas1p196380c619caf30310cf027b2bed24048
X-Msg-Generator: CA
X-RootMTR: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
        <20220811143043.126029-14-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nuyvy3t234ebxitc
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2022 at 04:30:43PM +0200, Pankaj Raghav wrote:
> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.

LGTM. I believe the commit message to be more clear like this. I also
looked at the other changes and it seems that they have addressed the
previous comments

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
> Reviewed-by: Joel Granados <j.granados@samsung.com>
> ---
>  .../admin-guide/device-mapper/dm-po2zone.rst  |  71 +++++
>  .../admin-guide/device-mapper/index.rst       |   1 +
>  drivers/md/Kconfig                            |  10 +
>  drivers/md/Makefile                           |   2 +
>  drivers/md/dm-po2zone-target.c                | 245 ++++++++++++++++++
>  5 files changed, 329 insertions(+)
>  create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
>  create mode 100644 drivers/md/dm-po2zone-target.c
>=20
> diff --git a/Documentation/admin-guide/device-mapper/dm-po2zone.rst b/Doc=
umentation/admin-guide/device-mapper/dm-po2zone.rst
> new file mode 100644
> index 000000000000..19dc215fbcca
> --- /dev/null
> +++ b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
> @@ -0,0 +1,71 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +dm-po2zone
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The dm-po2zone device mapper target exposes a zoned block device with a
> +non-power-of-2(npo2) number of sectors per zone as a power-of-2(po2)
> +number of sectors per zone(zone size).
> +The filesystems that support zoned block devices such as F2FS and BTRFS
> +assume po2 zone size as the kernel has traditionally only supported
> +those devices. However, as the kernel now supports zoned block devices w=
ith
> +npo2 zone sizes, the filesystems can run on top of the dm-po2zone target=
 before
> +adding native support.
> +
> +Partial mapping of the underlying device is not supported by this target.
> +
> +Algorithm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The device mapper target maps the underlying device's zone size to the
> +zone capacity and changes the zone size to the nearest po2 zone size.
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
> index 998a5cfdbc4e..638801b2449a 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -518,6 +518,16 @@ config DM_FLAKEY
>  	help
>  	 A target that intermittently fails I/O for debugging purposes.
> =20
> +config DM_PO2ZONE
> +	tristate "Zoned block devices target emulating a power-of-2 number of s=
ectors per zone"
> +	depends on BLK_DEV_DM
> +	depends on BLK_DEV_ZONED
> +	help
> +	  A target that converts a zoned block device with non-power-of-2(npo2)
> +	  number of sectors per zone to be power-of-2(po2). Use this target for
> +	  zoned block devices with npo2 number of sectors per zone until native
> +	  support is added to the filesystems and applications.
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
> index 000000000000..d7610463245d
> --- /dev/null
> +++ b/drivers/md/dm-po2zone-target.c
> @@ -0,0 +1,245 @@
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
> +	if (ret) {
> +		ti->error =3D "Device lookup failed";
> +		kfree(dmh);
> +		return ret;
> +	}
> +
> +	if (!bdev_is_zoned(dmh->dev->bdev)) {
> +		DMERR("%pg is not a zoned device", dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
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
> +		DMWARN("%pg: underlying device has a power-of-2 number of sectors per =
zone",
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
> +	       (zone_idx << dmh->zone_size_po2_shift) + dmh->zone_size;
> +}
> +
> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
> +					  struct bio *bio)
> +{
> +	sector_t start_sect =3D bio->bi_iter.bi_sector;
> +	unsigned int zone_idx =3D po2_zone_no(dmh, start_sect);
> +	sector_t relative_sect_in_zone =3D start_sect - (zone_idx << dmh->zone_=
size_po2_shift);
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





--nuyvy3t234ebxitc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmL2QYcACgkQupfNUreW
QU8mNwv/XpQFHcRGx13rBKk/LmTE4MHlR3O0ZgOiu48SGSkMsEd03eumNQLYoSEi
QtJawAluDJra3XZZERuXfS1stHhO4M5cVlu3x6KCEPix9nTJXbfCMgWkkJTYy5Fj
3y13CXPH4+OdSOsSiIYZepcgMN7VXBZCs3dWoKXkIVqcFGgcVCzNGp9sEh4A6Hni
eiN0u0NiPlh6aEbRI0vANJalWrGgq1bRG3YhbGkrMj2nQVmDoFmNU7+52U1eqqbS
sRdyyFAKGgmg1q+idhXYghp9Dadr0fmp3wP2IYHSmh4keVXygjN01LFQ6PviC373
j+vT1dHSE9QG7xU3VBaV0XRAO5Uq0KOt7HZreb34P2YX12eW/DBSBJoMqMw4oqS7
E1qxNYcIowaG6IOO6r7FJH7Rvzsr3OIUbm2vZVsUIBDESx/TUSuc4lB1bSrX8BDB
/op2UTsSeEcwYjxa2r99JMVl8/D4VCsNE17ANgs5A2ZDvjDLKB7i+pwa+qdRIYWf
HBdipUzu
=0lpZ
-----END PGP SIGNATURE-----

--nuyvy3t234ebxitc--
