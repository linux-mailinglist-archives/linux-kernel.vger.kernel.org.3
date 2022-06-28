Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF355C822
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiF1I7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245726AbiF1I72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:59:28 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9F2EA04
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656406766; x=1687942766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tLgWVuhPtORkgHFfRn51MDvCCJeZfMRDl0Z3GZEF2Q=;
  b=BdDmncEY5aDvFSo0pQFttPZNPcJYXkGuEXVc+ZNYNdFSwthZtZYmHQJT
   Rcr9u4SJFTjUdQAwKn3caQ0ZfNgJTTTpeuYrjAiu1glY4kqk83sf+J9+8
   SgabQrU0V8P0cETmL1RnbLZ0QT0PykyRPJ+zIzfrG3oyNeMsRZgAZBKhV
   bDK80LndtJY+77jHMh2b9feNxU0XkGkIB5qVG5E5nUebELJZ9tw+TERCh
   wx4H4tvsyNKWLNGLhR1MGJFSzdurveRwOdxW0WydCTE1fSuthHZtQbr16
   ReI2e15O66EpD4OiBCHEBQLuAE4s3AEmzTYhmS6qygqnPiMVN3KgDk6Hy
   g==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="205008496"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 16:59:25 +0800
IronPort-SDR: A3Eh7IUYaGYCAQF2Ov+SI0MDIQcUp8wPaW31k6R2wBasRodmf0+UvazDxexSjAe416CazPWV+J
 sWtUJVwDzWfg0Sin03CvZOYrGbTNDkL8k4asgAmAwCqfjAdRqqIxA4Bax1PIPZkuBDwxN5nUtY
 WwzRccx5cOMQM1lDThPdLHky17d8TItUgLzInDdSoG85nNuAn+yGM9WiM1+ikai9fNCTDD9wRV
 wKhOKe0fdGLLsi4pJPWFSU7aI6AgePyC2sv52C1IrL9Lc07d0WyIqduC3/pcxjUHOf0Yx57gU6
 bogRu1kV9FS0rKw35C+l6BLa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 01:17:05 -0700
IronPort-SDR: pk5y2jWMaTGCvHwg1973BCluEjoEGZyLeLBestpDHrFEzHjAgM6Jo1EhQa1GKoTne2Ps9cxu7S
 5X+YX/L2Iu3IsJEVUy40VZrXJ+eMsIgMJUYVAK1gGArkyNm+s2sXAzr73l1z3KKLzUO6uZVa2v
 2u0A1HadWVflhKEZ90O5+RT81JcMGaBYgsPYE/b4gudrUk8FLavUaQT2nd2M0uDc7yOpdz6FUc
 jK+L3xx+M4KmxtIBcM//KceJkmujvJHktVommfB0zc0K5647u4fZ/ME6N1TjTZB3sMhDa80RmQ
 ggA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 01:59:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXJSD6VHXz1Rwnm
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:59:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656406764; x=1658998765; bh=4tLgWVuhPtORkgHFfRn51MDvCCJeZfMRDl0
        Z3GZEF2Q=; b=MXOj3iHncCga2TST1BTd+EFNaUdnQI4uSukOtMt+dc3EGEftn7s
        dlCLLSbDCS+1NGLTrCK8yMpm4BMjmXdvxUm8L3nt/Bqjsrd44BwVLSvWbLGJ9Ymp
        FqA8M1sK1FFuarYsrpP0iiBqBwwfmzHzVVNI++hNqz/0wlVX7bSy/FSkV3axOlEE
        +XSENYLhEdXUSwxG5AhtOY3Wwj4Ddtr2MBFKvsECH2oSDwAVS9l0hJ85JyqIgIAF
        UKHyQ2mwcxusWDG4A/BxxDZKIwq23k3pXvx6B5UuIF04yNRd+KB9kJdvFH/7a1sD
        ha5Y7W6wj4tpoRAx9zSYJ9z2EeZ7XBJlULw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EHZhYYP1hoiq for <linux-kernel@vger.kernel.org>;
        Tue, 28 Jun 2022 01:59:24 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXJSC4BgNz1RtVk;
        Tue, 28 Jun 2022 01:59:23 -0700 (PDT)
Message-ID: <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
Date:   Tue, 28 Jun 2022 17:59:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 22:12, John Garry wrote:
> x86_64 allmodconfig build with W=3D1 gives these warnings:
>=20
> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_piomode=E2=80=
=99:
> drivers/ata/pata_cs5535.c:93:11: error: variable =E2=80=98dummy=E2=80=99=
 set but not used [-Werror=3Dunused-but-set-variable]
>   u32 reg, dummy;
>            ^~~~~
> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_dmamode=E2=80=
=99:
> drivers/ata/pata_cs5535.c:132:11: error: variable =E2=80=98dummy=E2=80=99=
 set but not used [-Werror=3Dunused-but-set-variable]
>   u32 reg, dummy;
>            ^~~~~
> cc1: all warnings being treated as errors
>=20
> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
> stubbed, which is the same as what we already do in pata_cs5536.c .
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>

Looks good, but I wonder why I am not getting this warning. I always do
W=3D1 and C=3D1 builds. I tried allmodconfig now and I am not getting the
warning...

>=20
> diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
> index 6725931f3c35..c2c3238ff84b 100644
> --- a/drivers/ata/pata_cs5535.c
> +++ b/drivers/ata/pata_cs5535.c
> @@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, s=
truct ata_device *adev)
>  	static const u16 pio_cmd_timings[5] =3D {
>  		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
>  	};
> -	u32 reg, dummy;
> +	u32 reg, __maybe_unused dummy;
>  	struct ata_device *pair =3D ata_dev_pair(adev);
> =20
>  	int mode =3D adev->pio_mode - XFER_PIO_0;
> @@ -129,7 +129,7 @@ static void cs5535_set_dmamode(struct ata_port *ap,=
 struct ata_device *adev)
>  	static const u32 mwdma_timings[3] =3D {
>  		0x7F0FFFF3, 0x7F035352, 0x7F024241
>  	};
> -	u32 reg, dummy;
> +	u32 reg, __maybe_unused dummy;
>  	int mode =3D adev->dma_mode;
> =20
>  	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);


--=20
Damien Le Moal
Western Digital Research
