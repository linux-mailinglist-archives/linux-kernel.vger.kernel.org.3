Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0274A6CC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbiBBIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:14:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64022 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiBBIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643789662; x=1675325662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vSETh49OX7xj5hAtW3QKd1iO/5P1xFYjPHj+NFETVXw=;
  b=jq6CK+WFJFyr0Cd9QzOpOCxCle/9UeaiZOClxBE8Yrt8vATKeCp/NOKm
   xSfsjeaR3HJoAZ95YajmKisdFONDCr2QQwKPMpUv90A0KvLUT6h8tibU2
   nLs4qc8/UeX8cBQvLjsZfwZ+KtoJpM7plea9HFTM0kXvs/e38luWbUmyx
   3vOmcgO99NiiHBxNWfDJsvm3gOsLIvXZsQeIwc+DfEbqenvgeiYVzsZQv
   xji9tgOAW7iXigh6n4JbKd/J8Htwauhpgm1ClRHW61zb58yxXbPgOHwGw
   urQY4LjbISta+g4yXY6lqKEW3+wgQPmqFY6dzm1tn2wLV+ixjdJffrvYn
   A==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="196763868"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 16:14:22 +0800
IronPort-SDR: +nvOfNHAJkXOHu3R7AyQpo4admHPVF19vMu1qHUkKPo1kOtiC1KRUxXRP+8wW/vWZ9scUmguzr
 r8s5QABwJpwjhxP/GPnu2UYb1zGmiETX7CB6CIYKCrQARBs7JvD/dv7rZtcDlQpyxCz9NoBlg9
 2g7LFGv56B/kFz86kB0IxOCsEzRadvmw/LV0Ygkoa/8jizN3mmWzx3KjptjtP7zFYYFShFQqnp
 lDr7mf6w21LNw6Xpmy7HRwZOZA2HcsNYMvVdTpGpNcHuG4gTvHCAA310icEV+CsAWXhPY0YktT
 8lY3ncyILS3FVo9qoBKNyELW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 23:47:32 -0800
IronPort-SDR: s0O91tj68mycCHiG83FqERzUBAFpTdJxy+GIp30rRuVaT7LiAKti4T9zYodb9R2Gu+frWyTx2m
 /Fd6yhGbnEAtLk3xM0E2o9grRJPQoa7/3pTeRn97q0hJ6RNogvO/oL5FDORYpcqUBSXh9MPsxy
 4gpBbyCiBKi1ORr3UgC2SGwLaTVt1v6qBk/yJ91+l3Q5iDestgxyhGxjJN/UsduGEnxAf5zTQC
 vgZkVD/zsz/wg9Yg4wjLfVgicArOvmDG5UWAPm8L8aTL3CPzbfqVW8lZwuYWEPbBLpnQW61kMD
 8no=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:14:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpZMf67vbz1SVnx
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:14:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643789662; x=1646381663; bh=vSETh49OX7xj5hAtW3QKd1iO/5P1xFYjPHj
        +NFETVXw=; b=ACJs15QDEwXJNVvHkp+cgX2gNOuqTvYL6dS9FzHX/8T81b/6RwJ
        5aWy5y6XeIXTcv+a66FwNOgyAbEG0rJLAKhmfWes+CcV+M/EtjP4BkTMRRLaltKD
        lUi3xT0Sl/XRRdgADUsrmbSQk5DJjP73MmLCLJHfoO4aHzFJPE+lYMAIBXNsaoLh
        BazYdVW3lVeByzfdVS0axR4wcK9t7eFWXi6ew4KytzDTG1rWdwOlTs/f0E8atBLY
        cB7nfhwgbBv12UbOnQYjY/LgVv3nV4Y9j8aJMhkY/jdcakMGcEy6rbKUM8aPM47/
        319oYvobQVEEAV4YvGgG1zGhKIulhOhSNwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wr0-jP9aWRQK for <linux-kernel@vger.kernel.org>;
        Wed,  2 Feb 2022 00:14:22 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpZMd6Js8z1RvlN;
        Wed,  2 Feb 2022 00:14:21 -0800 (PST)
Message-ID: <3437ffcb-68b5-04e5-acd5-b3857fbf1be7@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 17:14:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201071229.6418-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220201071229.6418-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 16:12, Paul Menzel wrote:
> The 200 ms delay before debouncing the PHY in `sata_link_resume()` is
> not needed for the Marvell 88SE9235.
>=20
>     $ lspci -nn -s 0021:0e:00.0
>     0021:0e:00.0 SATA controller [0106]: Marvell Technology Group Ltd. =
88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller [1b4b:9235] (rev 11)
>=20
> So, remove it. Tested on IBM S822LC with current Linux 5.17-rc1:
>=20
> Currently, without this patch (with 200 ms delay), device probe for ata=
1
> takes 485 ms:
>=20
>     [    3.358158] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000100 irq 39
>     [    3.358175] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000180 irq 39
>     [    3.358191] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000200 irq 39
>     [    3.358207] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000280 irq 39
>     [=E2=80=A6]
>     [    3.677542] ata3: SATA link down (SStatus 0 SControl 300)
>     [    3.677719] ata4: SATA link down (SStatus 0 SControl 300)
>     [    3.839242] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.839828] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.840029] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.841796] ata2.00: configured for UDMA/133
>     [    3.843231] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.844083] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.844313] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.846043] ata1.00: configured for UDMA/133
>=20
> With this patch (no delay) device probe for ata1 takes 273 ms:
>=20
>     [    3.624259] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000100 irq 39
>     [    3.624436] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000180 irq 39
>     [    3.624452] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000200 irq 39
>     [    3.624468] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000280 irq 39
>     [=E2=80=A6]
>     [    3.731966] ata3: SATA link down (SStatus 0 SControl 300)
>     [    3.732069] ata4: SATA link down (SStatus 0 SControl 300)
>     [    3.897448] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.897678] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.898140] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.898175] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.898287] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.898349] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.900070] ata1.00: configured for UDMA/133
>     [    3.900166] ata2.00: configured for UDMA/133
>=20
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: address comments for commit message (but forgot v2 tag)
> v3: resend with v3 tag in subject line/commit message summary
>=20
>  drivers/ata/ahci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ab5811ef5a53..edca4e8fd44e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -582,6 +582,8 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  	  .driver_data =3D board_ahci_yes_fbs },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
>  	  .driver_data =3D board_ahci_yes_fbs },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
> +	  .driver_data =3D board_ahci_no_debounce_delay },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L=
 */
>  	  .driver_data =3D board_ahci_yes_fbs },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L=
 */

Applied to for-5.18 with commit title and message changes. The title is n=
ow:

ata: ahci: Add support for Marvell 88SE9235 adapter

Since it is exactly what this patch is doing by adding a PCI ID.

The comments about the 200ms debounce delay not being needed is kept as
a description of how this new adapter support is defined, using the
board_ahci_no_debounce_delay board definition.

Thanks !

--=20
Damien Le Moal
Western Digital Research
