Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7245D5092E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382848AbiDTWgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbiDTWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:36:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC933CFDD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650494037; x=1682030037;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4lgTYp4beWNQQ0PzTvH+WAeDNBZ25X0ElX3e2wBoqyY=;
  b=LvEVoO/VrfRzbmHEsbRmMjPy2R9bLNtLWd/xQzo6c9AE8vdTrUEDHXsX
   4jK7FIZat2CNgcfxHmjgroUvxBdNOqcCTkm/D25Paio5cGF+02ZRr0boO
   tPI1+myBBGwO4fupaMvuP9HGWZ8FUPcUBWhxks878L7J9JyIBUN9CgXCk
   TrsnWAGh1SHgLre1d1Crq0uOqwJkmjlIEtqr7dRCq3fI8i/l8iWfGmZsa
   4bitdP+IgqZmhohtIz8DVub9g3v54xXC+KyxzFd2Znvtty7+CqPrg2XmM
   uhd573uXkRvBNLhBnRCUj3JQmsHMvRpfUH3jcRFCBN9bWw7VMMjSxPZhe
   g==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643644800"; 
   d="scan'208";a="203273501"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 06:33:55 +0800
IronPort-SDR: TK25q4UoYzoHTFk7ttfw3o1/QCyVbVJojDucCzXYB6sHU4ci5v+Sjv0jwJJrVUOj7d+ze2xb5g
 D3ZPTE1JGsnudJH/OFJzKru06/naci6EL6dFSuj5IbaeeED1O5OEq8IB9jLvOLl5HEnueC/5Nb
 hpeTE38gDObfRRI8Fizob9I9Vx6Aum/SOtzaFjHlOJ80b6RnuBw1WGZFrGc3vY75i4hgxi1YJW
 BPyPNAanfTUam3psnAoy76KEFCx6spZcZDnGaRWHAWwK3QeatKRMr+0Hni+SXn3+Yzr+TyBbVF
 qgGSKcBXDH2OFV+u50CaRKJ0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 15:04:14 -0700
IronPort-SDR: 2aSaWKKp56SH8Lw3jAWWhXmhct+Kc7cshZb3F1zxOUF1x0XSy1iiATo86Yh7qzfwxWabSUKFBz
 kY1rSxp9l9SSSh3VnE2h0Yc03P+kxBLePfsbGo4+RbaIfZlLnLrmCWnDFOddesfDIdUzA96GOf
 F+dPkiYRP8A40wF5mKFT/ZuUEFADtbPfDIz3u+9p2nq3jyVl2FG1fEqACghhhDynZ4LVHD2oxi
 TlOeglPrsoNC8YmV83Awyw+8wpwvu6zb++LGxyY7gJTF5ZfVLTSLcxyRYAglTOlXqfqzkuGfSA
 /7M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 15:33:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkFnv3m81z1SVp0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:33:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650494034; x=1653086035; bh=4lgTYp4beWNQQ0PzTvH+WAeDNBZ25X0ElX3
        e2wBoqyY=; b=bWDY651T5piuKIZEzu/pqHevDlQF+nH8LEBqH2TmRoyOgMo7Mtv
        mdE1WtVPjY4+58pFJ8s0bZHkjev4DCi80eppn/nR++1lLNwz7My0rqNaAspZHL9p
        oTeiEMeuekE3GnnbRgolbpuzBESk/9zZwE+k08EfbTZUWTCGeqXygwSFkL2GgCgp
        /To7SBNQ8PszPzPYSWnNlWe2gaolErwce1ccHuzaTQhSz+XpOPPgSvuW1/u5Nx0T
        QullpKAPdB7DR53MAsufyYgacsRJM+y1cBF5+vXWx9hPE7WurC5cTWgvNQnpb4cC
        MKrHguBvPVjWQx3WMHm+eCaj0W/BZ5hSFRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xlp4GOfBWzm3 for <linux-kernel@vger.kernel.org>;
        Wed, 20 Apr 2022 15:33:54 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkFns6zfRz1Rvlx;
        Wed, 20 Apr 2022 15:33:53 -0700 (PDT)
Message-ID: <da32482a-a38c-091d-ae28-aecb56fe1e7a@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 07:33:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ata: pata_marvell: Check the 'bmdma_addr' beforing
 reading
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220420122134.430997-1-zheyuma97@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220420122134.430997-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 21:21, Zheyu Ma wrote:
> Before detecting the cable type on the dma bar, the driver should check
> whether the 'bmdma_addr' is zero, which means the adapter does not
> support DMA, otherwise we will get the following error:
> 
> [    5.146634] Bad IO access at port 0x1 (return inb(port))
> [    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
> [    5.150856] RIP: 0010:ioread8+0x4a/0x60
> [    5.160238] Call Trace:
> [    5.160470]  <TASK>
> [    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
> [    5.161728]  ata_eh_recover+0x3520/0x6cc0
> [    5.168075]  ata_do_eh+0x49/0x3c0
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/ata/pata_marvell.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
> index 0c5a51970fbf..d2922699be5e 100644
> --- a/drivers/ata/pata_marvell.c
> +++ b/drivers/ata/pata_marvell.c
> @@ -77,7 +77,9 @@ static int marvell_cable_detect(struct ata_port *ap)
>  	switch(ap->port_no)
>  	{
>  	case 0:
> -		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
> +		if (!ap->ioaddr.bmdma_addr)
> +			return ATA_CBL_PATA_UNK;
> +		else if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)

No need for the "else" here.

>  			return ATA_CBL_PATA40;
>  		return ATA_CBL_PATA80;
>  	case 1: /* Legacy SATA port */


-- 
Damien Le Moal
Western Digital Research
