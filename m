Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5A4743B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhLNNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:41:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36644 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhLNNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639489297; x=1671025297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7RIc8kBGLS94DUip1gbTCJynyFkM5gL9bH9ry4sgvcE=;
  b=KZ71xnU+Y+kIOobdxBOLVLQ+5lpGAVAE7ETOm+8PO9VuE4mWavI8Cgx8
   unPrcquO2OzhQ9hS8Qyeds+q/7kwBNgaj84TD178dFO6aLj0NpL+vqJFk
   8379yt/RRSv/axU76J2gR2pzL9Hor4EnnKZ8A/clwAnNQoL3i75o9Aj8p
   UvEFi4NFXFlgJqmAVQ41dOWhsyC4O0k6LMRxAFjOMHrrJyWNAxq8xtQ10
   m3lQCpyJYK+wBmfNOpkVP/zJQeW1BIosJudidyicRrFRAdHnWec/R+1q6
   woWARlg5cpO5sh7hN3Hd7/PrYhMTn0oki0IbAAUU0ylOpXNfPB0ge1b6r
   A==;
X-IronPort-AV: E=Sophos;i="5.88,205,1635177600"; 
   d="scan'208";a="189230855"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 21:41:36 +0800
IronPort-SDR: 8K1y/VUd1IdO5YjLBebZStnun8XEGgarZWtmZfVBDH3OfG8Iu0335aopB00iEFA8ypx96lNdv8
 efYx+9CLLrlgQ4lGuCONM4nmF20359i7PxWMo1Omc1FftlIfSXDVP6egDrleCA/yPnnd3MVV/K
 y22kvX1AjyBiColqKi0C6VDgTatOi+lWX4nhg7O5jr66makE8rMdTfBXZ5Tgr5qSTfQjZO7prg
 0wgPTS+Fc4WGfAdLDCNPwkKXVvBPdyjWbWXFGuvhaumCFyVqSa/u8ra4XLklBZlBKFAXeAXwcc
 q4RlbiCY6CG/rlh3dN+ue1PU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:14:31 -0800
IronPort-SDR: Y3KyB3kUTyy9KkvWYUwECJpIGxDHDloq71OsyCMBsq939Su5Atja/XrYvGusK1C3/gbTErry0n
 1yhPdEXrPvckJB3ijYf58Fibw6PTyu9PJFfYrZ2lrlKe0Cz6b1yTRTvPC3ezK7k6K5o2pOvLAP
 mAbcP5zuS4zMU5qHS5M+dIidS7dNhOBNfhhlcY+CGvKW/wI/LgdqStj3+fSw6+jQXnDSmsicoo
 g6dJjqAZWvGyB95znUXs3OzTuKsC/C7Ark4u+QUfsSi7zu7BOura+ZUL2MvRn/xEPA0Ty6opDU
 xR8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:41:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JD00G1qgxz1Rvlf
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:41:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639489293; x=1642081294; bh=7RIc8kBGLS94DUip1gbTCJynyFkM5gL9bH9
        ry4sgvcE=; b=Rjv6U6kO5n0p6LLiSlGe5lb3RF/ORfqOySXezMQWKVsbslH9aiT
        0hysUybmLxR5XXZ07Ey/TO99S9M05+kc5Ipp49YQ2Pdqak2mtMOtdWrR9u1aRbNR
        S2fwHPlrc2cQ8momxVVpEkoesMKSe1nURVbAh8qhbaif8HgselpC+so0MNWFnmbq
        IlTCvZ5VWIbC/GC3KtpYhHS2IqgkkLAIwY2qfcv9+WPRERknJ/uOqNvm6xc2Abln
        i1iYZS6BCQ4v0O0AqzccMZgTKKf2awjg0CCUngpB2fOoanqqAntrQjyihygkiAs+
        +o4snp8SAOxi/i7wm/qBzZKYXU8H+uiUI8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id roMsAB8qMSqU for <linux-kernel@vger.kernel.org>;
        Tue, 14 Dec 2021 05:41:33 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JD00D6rzyz1RtVG;
        Tue, 14 Dec 2021 05:41:32 -0800 (PST)
Message-ID: <1e512500-bcd2-2dff-0704-ccb52aad907b@opensource.wdc.com>
Date:   Tue, 14 Dec 2021 22:41:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 3] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <a8cd9195-ab57-4067-d814-c9926eb36412@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <a8cd9195-ab57-4067-d814-c9926eb36412@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/14 22:25, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
>=20
> Cc:<stable@vger.kernel.org>
> Reported-by: syzkaller<syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> ---
>  =C2=A0drivers/ata/libata-scsi.c | 6 ++++++
>  =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 1b84d55..d428392 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct=20
> ata_queued_cmd *qc)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto invalid_fld;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> +=C2=A0=C2=A0=C2=A0 /* if T_LENGTH is zero (No data is transferred), th=
en dir should be=20
> DMA_NONE */
> +=C2=A0=C2=A0=C2=A0 if ((cdb[2 + cdb_offset] & 3) =3D=3D 0 && scmd->sc_=
data_direction !=3D=20
> DMA_NONE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp =3D 2 + cdb_offset;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto invalid_fld;
> +=C2=A0=C2=A0=C2=A0 }
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_=
offset] & 0x3) =3D=3D 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tf->protocol =3D ATA_=
PROT_NCQ_NODATA;

Why didn't you change the code as I suggested ?

Since (cdb[2 + cdb_offset] & 3) =3D=3D 0 is also used on the condition be=
low, you
can clean this up like this:

	if (!(cdb[2 + cdb_offset] & 0x3)) {
		/*
		 * When T_LENGTH is zero (No data is transferred), dir should
		 * be DMA_NONE.
		 */
		if (scmd->sc_data_direction !=3D DMA_NONE) {
			fp =3D 2 + cdb_offset;
			goto invalid_fld;
		}

		if (ata_is_ncq(tf->protocol))
			tf->protocol =3D ATA_PROT_NCQ_NODATA;
	}


--=20
Damien Le Moal
Western Digital Research
