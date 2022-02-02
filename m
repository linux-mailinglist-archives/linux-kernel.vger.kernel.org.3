Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422934A7C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348218AbiBBX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:59:20 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49724 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBBX7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643846360; x=1675382360;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6IF4rZAMsjlqA6054YRskctrA5vMy2AoOfxr6RnDIqs=;
  b=AswEEH0eRw+iYMr2kRKDeZQ0nRUnx3SYywbPWYDe6QNAHr34oAj2moV2
   BLW2PgoCb8iq+7/AOFOt50zwycPPmVKA+Lb8/4MI1bXhmeoblEW2Fn6oA
   Ihprx/M5T0IKT9NWKkaF6dTfryealxNrEhkCWSsa/3Q7cQUhUtGg7txSp
   ukeRc4ek6kgSHXXK4eEWtXCCgajTYWUpC0Lh+Coe093gtErXflosdvN/y
   gJnZtK4u2w+uPTVTeKd4tHLrNDcH2SKFyK+jg6B6qe+r3vK52UFqJZ5yP
   EUeTtUDe3sSJ1HucTQjlh2lwj82yAngYh9U5hHqJ2IhDynGh8+4FWOiwL
   w==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="193007328"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 07:59:19 +0800
IronPort-SDR: YH39U3oe1LrzNV1NegVJbkjSJoJ/N6f6nb3jXa0L+WqX7BLyDAMVlX6ecT11cWYVoUOhnvzh1Q
 Y8IdsxtpHAz3PXrNAuNFLXeliR/hW2Dv1KHvQ94xCjVuRy8rrC+dRgyxSmm8BIsCWBDdsvPPhp
 vQ/9L2ds6jMy4ZjrKW/6N5ieS3FELD9+U8XMHmeouKE2k197gAcHUDiIDafVOV4I7tRCJdpmGT
 oumem9+ZFPle9i/bs8la7j+fIDYxqObLPSdbQy4hcjRQAPLs3vOntqn8V7SUOs+SrFH9YM53hh
 xoI599KL3ZsT1XPiEHCxI9TB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:32:27 -0800
IronPort-SDR: YslFi4LujAVaPsr5WmqDXHbtWcsNiGhLMV9yL/AUta+d4ubOt1TLqkv+GVaIh9c+kzqCYXC3MK
 YYoYhwbo7zsl1iGuW+JWJCWtCNe6dT34agalexPomKoD2WVHN8CTbcsSrRv7DTjdEK1j7xWJus
 s+btSx4ctzd/781lgtglma0FB42Ee7IDRQN72njE5aSLa3vzqirdyd6ZADogJ7Edfzqj4zsnvh
 fYLsZmS1l8ZK/N3tefoNtfY5YOHlPE0YPrflY4ccDiKCbwreBrVBHCcJyFtTxVUXzrK2WUsvUn
 EPY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:59:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpzKy5lKkz1SVnx
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:59:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643846358; x=1646438359; bh=6IF4rZAMsjlqA6054YRskctrA5vMy2AoOfx
        r6RnDIqs=; b=SIuUVM4lZbXCp7Ro/uh8CYB7FpaRUHqGwhNt58WDQP9bSSkRHSD
        w45+4ieEFa6O9r9nmhVWVjQ5GiiA79tlM4gbTJrVSHQ+Oqee6/cVEmibl9FXjtlR
        xOAVXwrPeweao/TiJtZPZV1eMwRRWyOlEPR2fFv30VMUVIGDD4gqfq2SdrNv7Yol
        DDJc7u+hIbF6EICdBLr/lb4Sdw/JSVkaCDWU+veBRSCuuZ5yjP1hsvCstktKj/Y4
        m6Kb2Uq5v6GPDWbUDuCNeoGtMcDhdMUjtX6YmDQnlpUEV8kdN7AdPLxFckJKV5Id
        Ls9jQPTItCzDlKl0zdowlv6Njp7XRagbrnQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a1bzy0k9qtxx for <linux-kernel@vger.kernel.org>;
        Wed,  2 Feb 2022 15:59:18 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpzKx6cL8z1Rwrw;
        Wed,  2 Feb 2022 15:59:17 -0800 (PST)
Message-ID: <fb19cd3c-3969-032b-1f2d-fb0a02907f4c@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 08:59:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: add myself as PATA drivers reviewer
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f0c50df2-c7a1-7037-9c5f-c74cbcb987ac@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f0c50df2-c7a1-7037-9c5f-c74cbcb987ac@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 06:30, Sergey Shtylyov wrote:
> Add myself as a reviewer for the libata PATA drivers -- there has been some
> activity in this area still... 8-)
> Having been hacking on ATA from the early 90s, I think I deserved this
> highly responsible position, at last! :-)
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: libata/MAINTAINERS
> ===================================================================
> --- libata.orig/MAINTAINERS
> +++ libata/MAINTAINERS
> @@ -10880,6 +10880,12 @@ T:	git git://git.kernel.org/pub/scm/linu
>  F:	drivers/ata/pata_arasan_cf.c
>  F:	include/linux/pata_arasan_cf_data.h
>  
> +LIBATA PATA DRIVERS
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +F:	drivers/ata/ata_*.c
> +F:	drivers/ata/pata_*.c
> +
>  LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-ide@vger.kernel.org

Applied to for-5.17-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
