Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C755F2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiF2Bvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiF2Bvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:51:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4B2DD63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656467490; x=1688003490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mC9KTh44NseJcYgO5qIlz6Lcu7ZWIZ9u3GTtZ3n6bbc=;
  b=rB9RPeU6PXwVKramJQ54Ty9Rl+UDrTtkB1ppDg3QssPqgXvvy/00UFV3
   DhLHdFdABYj9sTAzwAPZ5vXvpf5MN/Ju+fEunbYe5vEqf/3nBhurgJyT5
   7S1sjZq4WWCCyeKabehhF5h2pm/mMwep2LVfHD/LfLxCoyQKHwgepmbuF
   ciksuH9JWL/eoGPR0VfOrp7uYTMLjKkJ94t3Y5u+ReVL/SE1IzXQpmt9f
   VBIn4RYzumlRJgjJZu78axgYKwiu61KHJ00EHfUQMgNl1Haiiygp4Sapk
   Ri0MY7jUihxSOVSE8xQ+wDRaxu/Ldh9HE8n1Q3Ma6uGBkOvS1dL7hjzFv
   g==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="204343896"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 09:51:28 +0800
IronPort-SDR: /FsvKn/sNejVzwKLl7ENl8gASOa1ML8mdAlHpEzPDyev6KHhlwDPY1G93wxQjhGgUR08r1tA4i
 QxLRoOnnQFdBFM3xXh3DpcON2XBc10itemObWnmgfU0US2IgKUHMRBYzClgrWDkcIA2WqdubIM
 wdEKj++N+MaG7Q0PF7pVaEJXQOsNzGviVWNUSp4mvd+dtKKm1KMFkoTd1O6ekA9SHb4lxXOMxv
 2+Qf+XHfb0V+cIquPiAfqcK3sWHx8e6qPqwuCODJHUh9kMSrFockC9DR1eeaAZfDA5TxEFjAJT
 JDP5BTynqgFnO+SPiJR59AES
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:09:07 -0700
IronPort-SDR: Vzn/mGVYXxoXT3gG8ftnPoCvjZOhFH4TN6rkj84C9eaEMK195poYFJMiQmLh0x5OELxg932m6x
 CeflhM6jH89/qwnRAkS0F3CrNCdOqlUSvmRLNeEnhSMs80qkNxnBuSBrIZ1QKafUYjem5SpE0k
 JtDzKSfrQqCGluL37nCUIF+VTSRpAS7skGEaMHC5l5Qa3feBQdmsuls4M37KgN3c66z2Y7QVIG
 iT9JFQj4Yexhkt4pNZx2lcvcR47T+HW0m9JIAYKU9500UOGtKNdHFGGMrC1MMsgVNWLntKkAmC
 DDA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:51:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXkw03l6fz1Rwnl
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:51:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656467488; x=1659059489; bh=mC9KTh44NseJcYgO5qIlz6Lcu7ZWIZ9u3GT
        tZ3n6bbc=; b=AUrCvbIXWpkkNk9It5e8ZPr34Idl9naLr9OkavLHhqzgFvI31eD
        mFniX4anpLeZoM1npj5ia9zZLKjNtiHUPSN6nXORqE9osBmJ7LATMXgElj3YrK/I
        j1HdNqkwGMtf79jfNETEU6xBUF2TpswJdw96ESUqz3zlax6e/bA1eN1hp8CcwPVy
        UD4lyURHDHaLnAsYA0xuJztRW97BAESlCWL1rhVE5oaVJLza3os0/6oQ5Ezer12H
        i2m16xQPcdXhiY/vK9gHcR17ExqIXwfJYFuMExubY46y7lqLlcMknB022g27xxQq
        1GLONQGOTk3MpSUcAdqAUb23KVFPMYxrOmw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ubCVgsjpK_0H for <linux-kernel@vger.kernel.org>;
        Tue, 28 Jun 2022 18:51:28 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXkvz3cY7z1RtVk;
        Tue, 28 Jun 2022 18:51:27 -0700 (PDT)
Message-ID: <69ed5587-52fd-4171-b97f-091df8b377c6@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 10:51:26 +0900
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

Applied to for-5.20. Thanks !

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
