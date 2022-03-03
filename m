Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BE4CBDA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiCCMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCCMXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:23:55 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6248890
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646310189; x=1677846189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ytR077ROdCEvm8uXoeYExz5DphYoqhERw4ias0FZyY=;
  b=a6icFj76NZ3VhLMtlCHaN4GvxIhB6v0CjDaqCV5FrTc7qAYBWbnCcMRL
   ONGiWZRkQ4+cB/Yp1ZmpILNNk54ofu2DTyHd6fOMD3ALok3X5+LAE9OtE
   oyqLIgv4aOaKOyDm0e+V+FDEd/y6p+DqszkIi0gK8OUTJ+k/aVZrWbTRX
   3p6MF+hJoqXmT7U5/jbcEmldBMWvI7fT+vvoVr8ZOAz5QpQvWK1hoKaeu
   AvY+ZAZ59r0ygfNLXdLzdZ8/VPmM/2EYNgWNEWEXop/bietxmP51QdqR0
   ki8QdDGq6JSMdFuScKdkav8AgWS650wsFTDAW6kTY8oNgFTML+9KF+x+e
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="298511904"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 20:23:06 +0800
IronPort-SDR: TGx5UzD12XkA+2UZwwYQPqSgsHoaEDCQN1/VCfBxBoL7YOOalAiVxMirsmEkq3VUXJOSCsBV2o
 uhF/1VJ3OuMKNJd0Zz5AZTTrqo59ZOutt3uVDm7rydmybOyb/1BGhooMxTFdRlyjjr1rnWRIE8
 D14XL2kH2M/B8w4iw6T0UIy9GqynZdyFiF0eI95HWiVfRxhSXHRxscaAi+M1qTnFQR9y4Bgr0w
 AzIT9YtD5byL79xmelm5cJVAZ4gvvlvCLgB6wlbTj3R4ikKgpWLe8aHOV4xqSxw+qHp5R1H7wh
 0qQyoP5HoHjUbnQb2dp0c2jx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:54:28 -0800
IronPort-SDR: 0Nz4aZRzth8c8ltzZZMQP7uGeyS4AcadeYGBPQueKh4AHyzUTSSWANDtSdvGYaTi3WWlhX43q4
 qdN+4Etaq63VORTwD4FW4j8RWHLM+TYrs54k0RMaSlfcfyCfZbyA8ma80se/+t6QgTaEcuEDu/
 qpNbaF1CrzLcm3feRMJtyEjGV9trXpvZnQ4bjjKMP4WkpPz6EdlmgOJKS6yuXEZNAhfgl3rv9R
 wd1ZZPs2mqEf/huP4cVX+yZHGQzymWjRNAPgdf+lnp9CMAzuALVxHKRlJtNCf4ctyM4nm4boID
 Rqs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:23:06 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8VWG0sWsz1SVp0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:23:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646310185; x=1648902186; bh=4ytR077ROdCEvm8uXoeYExz5DphYoqhERw4
        ias0FZyY=; b=JyEuOrwamXKsh+W4+k0zPCZFYK9548wacidSsF43Q/jL+k1wnGm
        hOFKoZpahEzZk5kFFMIVQXIwnqIUC3/rwO2WGaLQPs2WCbNnZRNRyesdwmc1jon6
        tpTqtyKHL7cn91vdLuXLnUxKEnqU+qIqB574WpL7VM1fqjbBY8NOHbpPZ1AGLqLy
        S4qj2cbdXJRe5AehEhIuPrqmU5FlQpn/jKTB/ek9jYrQZuGfcqnp34zNo7CSpR5Y
        X3Qq+0DuMVgg1PvTwWE5ZN2vU9IKtDguQLlypRbQcTDi8gJtNPeppmlFutLa8nyW
        Pn2fGcH2qowRe7wyxuDMk+sXOGNDE4ixsYg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zxz31DfOkYkC for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 04:23:05 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8VWD0Nfxz1Rvlx;
        Thu,  3 Mar 2022 04:23:03 -0800 (PST)
Message-ID: <0a7c8ee9-1e09-75a4-3241-883fc8540561@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 14:23:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] [RFC] ata: ahci: Skip debounce delay for AMD FCH SATA
 Controller
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
 <20220303100453.30018-2-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220303100453.30018-2-pmenzel@molgen.mpg.de>
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

On 2022/03/03 12:04, Paul Menzel wrote:
> AMD devices with the FCH SATA Controller 0x1022:0x7901 do not need the
> default debounce delay of 200 ms.
>=20
>     07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] =
FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
>=20
> So skip it, by mapping it to the board with no debounce delay.
>=20
> Tested on the MSI MS-7A37/B350M MORTAR (MS-7A37).
>=20
> To-do: Add test details and results.

Please squash this patch together with patch 1. Since you are adding a ne=
w board
entry definition, it is better to have a user for it in the same patch (t=
his
avoids reverts to leave unused code behind).

>=20
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> ---
> I am travelling so could not test this exact patch just yet, but I ran
> something similar for several weeks already. It=E2=80=99d be great, if =
the
> desktop and AMD folks could also give this a try.
>=20
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 0fc09b86a559..44b79fe43d13 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -456,7 +456,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>  	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hu=
dson-2 (AHCI mode) */
>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> -	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sard=
ine */
> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power_no_debounce_delay },=
 /* AMD Green Sardine */

Really long name, but I cannot think of anything better...

>  	/* AMD is using RAID class only for ahci controllers */
>  	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },


--=20
Damien Le Moal
Western Digital Research
