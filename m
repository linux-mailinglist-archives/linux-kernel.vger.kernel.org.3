Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68E476ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhLPKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:25:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42936 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhLPKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:25:01 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D266A1F41E40;
        Thu, 16 Dec 2021 10:24:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639650300; bh=WfVkgDjDGwRztrZPRyO30Ci5s7IG2KmALynZrqky/VY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cCaFCaJbCmAQJnSsRH4HWATLh+qEdsuTTWvjeE6kubudTxIl/iTKsymGQD6ol7QFv
         a0aB6uBaSe8HzzybkymJRv2yxBbOJWtPgTQ23N8455XgFNkgnTHne8WYIvd5dKdWqW
         fhgLYqLPPUXcEo7i3rruKI4+grz8HgLI4SiuPNUl9l9YS/JQA7kU4qo9xNOch5j2Vl
         i/b21bdEsh/pIdKjbRwLQlAUdibHEz5dWz+7Qrfw15FqwUihCsbw1ceNT7LMjDdgpy
         ENT/FGAfv3WjY/sotHtAt3SzBFbqh1A0onLwZRyaShpKYYmtBlQ3E/eRVneNHNWZr4
         /Fv6+S19ydHUA==
Date:   Thu, 16 Dec 2021 11:24:56 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mtdchar: add MEMREAD ioctl
Message-ID: <20211216112456.327298dd@collabora.com>
In-Reply-To: <20211216083418.13512-1-kernel@kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:34:13 +0100
Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl> wrote:

> This patch series adds a new mtdchar ioctl, MEMREAD.  Its purpose is to
> serve as a read counterpart of the MEMWRITE ioctl, exposing a broader
> set of capabilities for read operations (e.g. use of MTD_OPS_AUTO_OOB,
> access to ECC statistics) to user-space applications making use of MTD
> devices via /dev/mtd* character devices.
>=20
> Changes from v1:
>=20
>   - Added patches 2-5 which enable the new MEMREAD ioctl to report ECC
>     statistics for the read operation back to user space.  (There are
>     obviously different ways these changes can be split up into separate
>     commits; I was aiming for maximum ease of review.)
>=20
>   - The 'retlen' and 'oobretlen' fields were not set in the struct
>     mtd_read_req returned to userspace.  This was done properly in
>     Boris' original draft patch [1], but I missed it in my v1.
>=20
>   - Invalid IS_ERR() checks were replaced with NULL checks.  This was an
>     artifact of copy-pasting mtdchar_write_ioctl() in v1: unlike
>     memdup_user() used therein, kmalloc() always returns NULL on error.
>=20
>   - Minor subject prefix adjustment for patch 1/5 ("mtd" -> "mtdchar").
>=20
> [1] https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html
>=20
> Micha=C5=82 K=C4=99pie=C5=84 (5):
>   mtdchar: add MEMREAD ioctl
>   mtd: track maximum number of bitflips for each read request
>   mtd: always initialize 'stats' in struct mtd_oob_ops
>   mtd: add ECC error accounting for each read request
>   mtdchar: extend MEMREAD ioctl to return ECC statistics

Splitting patch 1 and 5 means you have an incompatible ABI change
between those 2 commits, thus breaking bisectability. I'd recommend
putting patches 2-4 first and squashing patch 1 and 5 in a single
commit placed at the end of the series. The other options would be to
add a way to extend ioctls in a backward compatible way (the DRM
subsystem does that by filling the unspecified part of the struct with
zeros, and relying on the fact that 0 values always implies 'default
behavior' when the struct is extended [1]).

[1]https://elixir.bootlin.com/linux/v5.16-rc5/source/drivers/gpu/drm/drm_io=
ctl.c#L882

>=20
>  drivers/mtd/devices/docg3.c             |   8 ++
>  drivers/mtd/inftlcore.c                 |   6 +-
>  drivers/mtd/mtdchar.c                   | 136 ++++++++++++++++++++++++
>  drivers/mtd/mtdcore.c                   |   5 +
>  drivers/mtd/mtdswap.c                   |   6 +-
>  drivers/mtd/nand/onenand/onenand_base.c |  16 ++-
>  drivers/mtd/nand/onenand/onenand_bbt.c  |   2 +-
>  drivers/mtd/nand/raw/nand_base.c        |  10 ++
>  drivers/mtd/nand/raw/nand_bbt.c         |   8 +-
>  drivers/mtd/nand/raw/sm_common.c        |   2 +-
>  drivers/mtd/nand/spi/core.c             |  10 ++
>  drivers/mtd/nftlcore.c                  |   6 +-
>  drivers/mtd/sm_ftl.c                    |   4 +-
>  drivers/mtd/ssfdc.c                     |   2 +-
>  drivers/mtd/tests/nandbiterrs.c         |   2 +-
>  drivers/mtd/tests/oobtest.c             |   8 +-
>  drivers/mtd/tests/readtest.c            |   2 +-
>  fs/jffs2/wbuf.c                         |   6 +-
>  include/linux/mtd/mtd.h                 |   7 ++
>  include/uapi/mtd/mtd-abi.h              |  64 ++++++++++-
>  20 files changed, 276 insertions(+), 34 deletions(-)
>=20

