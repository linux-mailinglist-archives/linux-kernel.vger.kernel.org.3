Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAE4B6BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiBOMDj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Feb 2022 07:03:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiBOMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:03:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1ED0B5B;
        Tue, 15 Feb 2022 04:03:24 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jyfpt0tBJz67xgN;
        Tue, 15 Feb 2022 20:02:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 13:03:21 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 12:03:21 +0000
Date:   Tue, 15 Feb 2022 12:03:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel test robot <lkp@intel.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sh: Convert nommu io{re,un}map() to static inline
 functions
Message-ID: <20220215120319.00004feb@Huawei.com>
In-Reply-To: <4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be>
References: <4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 09:51:05 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Recently, nommu iounmap() was converted from a static inline function to
> a macro again, basically reverting commit 4580ba4ad2e6b8dd ("sh: Convert
> iounmap() macros to inline functions").  With -Werror, this leads to
> build failures like:
> 
>     drivers/iio/adc/xilinx-ams.c: In function ‘ams_iounmap_ps’:
>     drivers/iio/adc/xilinx-ams.c:1195:14: error: unused variable ‘ams’ [-Werror=unused-variable]
>      1195 |  struct ams *ams = data;
> 	  |              ^~~
> 
> Fix this by replacing the macros for ioremap() and iounmap() by static
> inline functions, based on <asm-generic/io.h>.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 13f1fc870dd74713 ("sh: move the ioremap implementation out of line")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good.

Thanks for the quick response.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> This is actually the third time this change was made, as Christoph
> converted iounmap() to a macro before in commit 98c90e5ea34e98bd ("sh:
> remove __iounmap"), reverting commit 733f0025f0fb43e3 ("sh: prevent
> warnings when using iounmap").
> 
> Probably sh-nommu should include <asm-generic/io.h>, but that would
> require a lot more changes.
> ---
>  arch/sh/include/asm/io.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index cf9a3ec32406f856..fba90e670ed41d48 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -271,8 +271,12 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
>  #endif /* CONFIG_HAVE_IOREMAP_PROT */
>  
>  #else /* CONFIG_MMU */
> -#define iounmap(addr)		do { } while (0)
> -#define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
> +static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
> +{
> +	return (void __iomem *)(unsigned long)offset;
> +}
> +
> +static inline void iounmap(volatile void __iomem *addr) { }
>  #endif /* CONFIG_MMU */
>  
>  #define ioremap_uc	ioremap

