Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA60510E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356940AbiD0Bt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356767AbiD0Bty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:49:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A8D49CAA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651024006; x=1682560006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MdLhKR3iPWnl3Ay7JNgoR0/piJKLQFs4RnW6vFuQAdo=;
  b=jMw31Nm4dwb+We+ct9QoUUGSIUctUMinnhUN/HO3/gyitsor08AEEEa2
   HK7M+OyvWpRxhh86OUrVh9vdl3coBThC5qaKugOMlVni09F0ENG/lYQ90
   miZzb34p0ecr1hXJV+gYJ6qijhUWpjll6VIzAMR/NZMXpXxdsbwSUPj/l
   A7AgotfpWNDF6ndti4ae4SDuVonXSeAu/5QIAIqttOJhuH+bnYKexjhZH
   9SOmOAsw952TnvV36YQrFmFW/AgxBhsdwR9cKwLAJD1ZKCq1AO260KyvT
   MNlt/EjnMuiA/7Sz3Kr+vl9AaYkV7DClFyI+MSDu9K1d/PhOm+QIkhJwB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="199801162"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 09:46:46 +0800
IronPort-SDR: 2wCUGqe9/rxL8fNpySWBVtQ2jJQA0JLkS5c1uAgIguYvWq7ai2rOSb9ubzZr8Qm8mKP1pVatLE
 NFCOdKr9a6TNeo8SD1P4uc7YCg1nMqE8LUiwG91CP6hOj8lHoYLH5iT7Rk/rzrA+GP9xmpy9AT
 ngWYkHW70I6XtQ3miuj7I5AUviVqIIUnk17Ig1l8NbAAkNS2SWFA08zzhMPeS2E62RlBtePTTN
 RitUukfi5QRZQoPhjxwT2MgDdjqsk7fj2QT9PoFgNccJNA8s/oDE5KwsTw7+RTRe4pG3CpWESw
 qYqKiGJRCG/frOfbQmEhYTEG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:16:53 -0700
IronPort-SDR: A4pkj6czLNGiDAday7lsGnpxOYoQoo/UwwUlSyVO4bGv6rJ4ML2296De7ASf6Vg4kfMNXKdr0+
 Q18aN1+QWqfVougVisya5EYvSFdAQIhbJLH9TbwAwewJVQu5wQw2Hz9iwg24opPRU9TmryrIdc
 /VC/X+igbbkCHGA4+Isbt43OsWvk/3HW6K0JSpsL1zXA475vRP1qVDB7mYTNIWVg3huWD/iUX6
 OJEdO06k3hoPMXznognpEpX782V8rfFp6+snWgElrS9BDs+BLpOo4MthLPtf4GK9u0K4Phr0Tn
 t78=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:46:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp1nY5vj7z1SHwl
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:46:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651024000; x=1653616001; bh=MdLhKR3iPWnl3Ay7JNgoR0/piJKLQFs4RnW
        6vFuQAdo=; b=UbjXvKITtW+c8uqObhMHINutNE6s65wr7ZyR+skvkVhpzM3SBil
        hbcGdVx4JcW9EfZIR4/n0lHtxSmeKPOrmYsBB+nmKmcnWVouAwR1uzIA9YhFpfiz
        KMI8B5bynIvl6lmFqblrcsReLuMfWVOCJ1A4k2MM4kyb5UtlXTqDBYpMsMtGF0cq
        Pq18fv/uSl3DHUxKvRgSqlfsdl1R1/WEZbZ6gNQjsWQAmjuZywyWfOd+GVWtB8ZT
        UV8fcFWI2Skqz2SB3N4pBjrZTdHwzVRh7HdKAIVgHGKbGviZ+6brvZZT7C8QEw7O
        16CCQExeMIyaG69VcpNWoiBoyeqcYEFEsaQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OU56RJ4W4Vcg for <linux-kernel@vger.kernel.org>;
        Tue, 26 Apr 2022 18:46:40 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp1nQ10FXz1Rvlc;
        Tue, 26 Apr 2022 18:46:33 -0700 (PDT)
Message-ID: <c02f67e1-2f76-7e52-8478-78e28b96b6a1@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 10:46:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> The patch series covers the points discussed in November 2021 virtual c=
all
> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> We have covered the Initial agreed requirements in this patchset.
> Patchset borrows Mikulas's token based approach for 2 bdev
> implementation.
>=20
> Overall series supports =E2=80=93
>=20
> 1. Driver
> - NVMe Copy command (single NS), including support in nvme-target (for
>     block and file backend)
>=20
> 2. Block layer
> - Block-generic copy (REQ_COPY flag), with interface accommodating
>     two block-devs, and multi-source/destination interface
> - Emulation, when offload is natively absent
> - dm-linear support (for cases not requiring split)
>=20
> 3. User-interface
> - new ioctl
> - copy_file_range for zonefs
>=20
> 4. In-kernel user
> - dm-kcopyd
> - copy_file_range in zonefs
>=20
> For zonefs copy_file_range - Seems we cannot levearge fstest here. Limi=
ted
> testing is done at this point using a custom application for unit testi=
ng.

https://github.com/westerndigitalcorporation/zonefs-tools

./configure --with-tests
make
sudo make install

Then run tests/zonefs-tests.sh

Adding test case is simple. Just add script files under tests/scripts

I just realized that the README file of this project is not documenting
this. I will update it.

>=20
> Appreciate the inputs on plumbing and how to test this further?
> Perhaps some of it can be discussed during LSF/MM too.
>=20
> [0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=3DzT1=
4mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
>=20
> Changes in v4:
> - added copy_file_range support for zonefs
> - added documentaion about new sysfs entries
> - incorporated review comments on v3
> - minor fixes
>=20
>=20
> Arnav Dawn (2):
>   nvmet: add copy command support for bdev and file ns
>   fs: add support for copy file range in zonefs
>=20
> Nitesh Shetty (7):
>   block: Introduce queue limits for copy-offload support
>   block: Add copy offload support infrastructure
>   block: Introduce a new ioctl for copy
>   block: add emulation for copy
>   nvme: add copy offload support
>   dm: Add support for copy offload.
>   dm: Enable copy offload for dm-linear target
>=20
> SelvaKumar S (1):
>   dm kcopyd: use copy offload support
>=20
>  Documentation/ABI/stable/sysfs-block |  83 +++++++
>  block/blk-lib.c                      | 358 +++++++++++++++++++++++++++
>  block/blk-map.c                      |   2 +-
>  block/blk-settings.c                 |  59 +++++
>  block/blk-sysfs.c                    | 138 +++++++++++
>  block/blk.h                          |   2 +
>  block/ioctl.c                        |  32 +++
>  drivers/md/dm-kcopyd.c               |  55 +++-
>  drivers/md/dm-linear.c               |   1 +
>  drivers/md/dm-table.c                |  45 ++++
>  drivers/md/dm.c                      |   6 +
>  drivers/nvme/host/core.c             | 116 ++++++++-
>  drivers/nvme/host/fc.c               |   4 +
>  drivers/nvme/host/nvme.h             |   7 +
>  drivers/nvme/host/pci.c              |  25 ++
>  drivers/nvme/host/rdma.c             |   6 +
>  drivers/nvme/host/tcp.c              |  14 ++
>  drivers/nvme/host/trace.c            |  19 ++
>  drivers/nvme/target/admin-cmd.c      |   8 +-
>  drivers/nvme/target/io-cmd-bdev.c    |  65 +++++
>  drivers/nvme/target/io-cmd-file.c    |  49 ++++
>  fs/zonefs/super.c                    | 178 ++++++++++++-
>  fs/zonefs/zonefs.h                   |   1 +
>  include/linux/blk_types.h            |  21 ++
>  include/linux/blkdev.h               |  17 ++
>  include/linux/device-mapper.h        |   5 +
>  include/linux/nvme.h                 |  43 +++-
>  include/uapi/linux/fs.h              |  23 ++
>  28 files changed, 1367 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: e7d6987e09a328d4a949701db40ef63fbb970670


--=20
Damien Le Moal
Western Digital Research
