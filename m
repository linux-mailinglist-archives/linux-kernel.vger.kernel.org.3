Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB674E5D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346971AbiCXCUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348107AbiCXCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:18:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1D93988
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648088238; x=1679624238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C8ZC1JfJidJGGKJTTvn2HdT8RQJSx0oDAfiC+lrKKkQ=;
  b=l1RMvyKgiZ6mOntXpAZNYuLT5TTjXXVx2N9fLCQe1IoKQH0aIOqLDhHs
   D6YdzS9Gjox94+QDTXjtZhc34DwbLPCLilNKVtvmhUe1L0E+O6XRtpuST
   S+BzgqAUsboBoISfJniS/QOCQaQSd8KTFDFyoccK2t6QJ2ndx+d+G/J08
   I/Rdue0XSepwApEfPNut1+iSkmbCovcHhVHE3B56wYhCAWB/zfsmhDvAM
   qcMMZuo+1rKjsbkzBkorSHx5qKJT+3fcp7yJtCX8qq5F32r6S3jjMw2yh
   QSVL/iTaRibpdnMp7bbqeSbldmfhVGYTtqggWgiEvcvpvu6qZN59/gURs
   A==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="197043557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 10:17:16 +0800
IronPort-SDR: 9UB5IXLCGoDcPKqZatyl12uMQ8YdaSZm+uqotimokvUWohZNlyRgVz5rXcusqQ+udxAZJOCXzD
 fuDt+CJJy3/i1tOOfmHNrm6GPs3iylVtvBUvc/KLFtFaF1+sIAK1OTHKa7DlhisiBYZTvbfwdw
 9woaPktZHYK66qMYHDV5xZ1aH56jXP/YSCkEie7sf04F6UkVXxMR99yvB5JFh+y11ui9IpPekv
 6zb0bl+rScHkOPK5nzW2D8R+SUHTETqpr/I8nLZ+Xs4D/LELPWSqKjnAdcmig24WIoWkwe80V7
 cmc7bDXrG7nsdPVccfqxVWP4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:48:13 -0700
IronPort-SDR: VOjFIZaFtDjqwR/BCaakogQ+t7cVE+y0fvScaG+iASC9zoSi/GnvbtWpIoE44WlY/VPEN2GAAQ
 PtG/zrs/+lSax/kGe/8wqPbi/J/m2SLbTcMhS+94hFs9ifofNB9h52vALnwJrbtABPiO2gzo1Y
 P081KgwhyIlUaCNQbwSCXAp+sjG2I2gAyGaLFIbopPLtCmxV9usl5ckj83moW4gSSmqxcqIrXm
 GGj/mzavYXqH7gfEFd/CcgZj91HP96Jir3mVDBvvsPwKsSepl8oWpnJJ5aqqkU0RbzyW/JyOII
 gtI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 19:17:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP84W4DVwz1SVp1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:17:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648088235; x=1650680236; bh=C8ZC1JfJidJGGKJTTvn2HdT8RQJSx0oDAfi
        C+lrKKkQ=; b=FOT3gXpA129jN1eIYX1gm4o4xXeh6hGGrS9RAlqa9cBRLQpamPj
        cNozjURXZZw2im8fsdHtruWvNVtspQQseIg/1biNx6MMYTU4eNmVIG0GyUSigCDC
        qvgeoslr9zwLma/RngLlX1RTMT3XIoY8MC65m6gn4etU7zUvno/pHhicGbzdUNcN
        MJZheP9x46R38zMhdAFsaRnBkPcZy88q2jjm+p6VmziWuvT+wIoBN8NjSvxXlSJ3
        HXoSykoyTDBvftfMyHoP5JTtIrjInxqSufRtd5QcCVUJGBnFAyWy1qG9IBitildH
        EWPwkyg1Ceg1Sk8YlxUjdm65Kgbzmlas+gQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HGjgv5azRxLY for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 19:17:15 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP84T2DKKz1Rvlx;
        Wed, 23 Mar 2022 19:17:13 -0700 (PDT)
Message-ID: <eb79ee49-53aa-57eb-94af-90997aa6cbed@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 11:17:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 21/21] MAINTAINERS: Add maintainers for DWC AHCI SATA
 driver
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-22-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-22-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Add myself as a maintainer of the new DWC AHCI SATA driver and
> its DT-bindings schema.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0f68d4a34a..19c9ea0758cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10919,6 +10919,15 @@ F:	drivers/ata/ahci_platform.c
>  F:	drivers/ata/libahci_platform.c
>  F:	include/linux/ahci_platform.h
>  
> +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-ide@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

Wrong tree. This should be libata tree.

> +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +F:	drivers/ata/ahci_dwc.c
> +
>  LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
>  M:	Mikael Pettersson <mikpelinux@gmail.com>
>  L:	linux-ide@vger.kernel.org


-- 
Damien Le Moal
Western Digital Research
