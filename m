Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC954AD2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbiBHIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348891AbiBHIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:08:39 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 00:08:37 PST
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165FC03FEC6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644307718; x=1675843718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xl8JZwiCBa1DAB909hnmWesBMcLW2Z8/Q6Unw3KRTvw=;
  b=Rn2RInNWX1Jl49bVQjIjsKtv1NG1A6obgy/SJPhQ/SrnNhpk9++aELSz
   MNVknpbPZ7TQ2+U5E4EmLQ2I7qzkrvhlZh31HjScgR3LCHBbt+wyol/1B
   x7fsoSJ8UiIBRdsI8ZPqlUM0DxlcFCCfluZ2lQcPdhOF324F8UDsTjtOO
   PgnMAwSHE/o4CA2jQb1MDFWQz56kjVff5B97D1gaZlZ/LDkDVJsYE1yEw
   za6wQmdgh3WqR5n8MxAPIYvAZ7Srs7jV7gCp6wLNCayowrbobyrIaEDIQ
   dWBNI1Lc7YHX9BmP5NUop1NfpSPE1wl2imJZVmJC1rPzEPErk4wCiC40r
   w==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635177600"; 
   d="scan'208";a="193381893"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2022 16:07:34 +0800
IronPort-SDR: +sqDrn/0/tQ0Fre2W8OmlYQ4t4bhsB1avfol4/70rN6ZiLzsD/EXUFJIxuPOIC0lDFkaeEtgje
 XEE8DbNcfgsfEAFFfIZr9MCMygnSTosyEBV2BRX9pw+ZZTUBdfTjkpQOec8++lc6jSVDSDdK3P
 lftUdh6vlegsgLXx/S2QzijGDq6Rx2kxd+TCLcIp8hVkVQ0Fq/eeDZroSymI82+adkn0mpZRc8
 FcSOA67Lj3o9KxNdlXbZWAGYmAgu9hHXxRuWDh13YEtfMkh09jglCMNW2rnbOzjfFSCSHR/gaP
 ZtYEDNsp3IjJUMNofyhhyVpA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 23:39:23 -0800
IronPort-SDR: xuSmEJrU5s4k59y/d+zxkdyFksj6P3gQR32Qdl1vsY5aD51LPk/EJGT7hlGiLHy2bJMmECXVY9
 /GbjKWrd4BCk46iojF4/mhR54Ts2SebsljJwEdORoH+SStP4ab3UZgRnscqEQ1tCpFpF/agG2+
 gJH4B7EsmoOlgKxKxwzSJMgJs7bQv9zQB/g3DNj9RNVQaCyCjXJHs8fa5ron2B/sq/DtWfUUpi
 VkZfSsXPglnp/at5x3p0tZT6Qma59lGDobWjZXmB8tz7ncFEKToIRPClYtH69cY3wvIGggM1y1
 7xw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 00:07:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtFx10TXbz1SVp1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:07:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644307652; x=1646899653; bh=xl8JZwiCBa1DAB909hnmWesBMcLW2Z8/Q6U
        nw3KRTvw=; b=VSs914drxwHDoOXI3uw/xQMXAlUQaEghI5YNQ7eRSeOkxI9RZ8t
        JsLPdhmzaFj/OzMXzLe3riKa/b7/9tbNtM75a7dnSTU6DKWZxPpv5rsLnRPJBB/7
        AGf38LZRVGFbbNIoU45fX/HTUCYp4TXKhyC7OQ26F8+iLC2Qx6QCm4NyWzAtuJcZ
        OgCf8qJh5Jw19J25DhEXzlNo+uTp85R3CLKk5uTWsJwpxa40nCUCj1MEUqq4m3K0
        kByXgZ9P5HgGAK6tawAC4Gs+6FtG6xkhxdQofqVaO5O2YMHDxsJws27Yf4azH5ss
        fNxLL6QF+Sav/YYA0rsJMS05p0PJz+L000w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fJYxeK7ahUkM for <linux-kernel@vger.kernel.org>;
        Tue,  8 Feb 2022 00:07:32 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtFx008WGz1Rwrw;
        Tue,  8 Feb 2022 00:07:31 -0800 (PST)
Message-ID: <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
Date:   Tue, 8 Feb 2022 17:07:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     zboszor@pr.hu, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     zboszor@gmail.com
References: <20220204125750.1771303-1-zboszor@pr.hu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220204125750.1771303-1-zboszor@pr.hu>
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

On 2/4/22 21:57, zboszor@pr.hu wrote:
> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>=20
> This device is a CF card, or possibly an SSD in CF form factor.
> It supports NCQ and high speed DMA.
>=20
> While it also advertises TRIM support, I/O errors are reported
> when the discard mount option fstrim is used. TRIM also fails
> when disabling NCQ and not just as an NCQ command.
>=20
> TRIM must be disabled for this device.
>=20
> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.co=
m>
> ---
>  drivers/ata/libata-core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 67f88027680a..4a7f58fcc411 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
> =20
>  	/* devices that don't properly handle TRIM commands */
>  	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
> =20
>  	/*
>  	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT

Applied to for-5.17-fixes. Thanks !

--=20
Damien Le Moal
Western Digital Research
