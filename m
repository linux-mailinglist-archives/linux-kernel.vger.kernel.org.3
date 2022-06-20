Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F88550E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiFTAoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiFTAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE32725
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655685801; x=1687221801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Rf8r+wOe+lnuGLzZHW/Ni/+bYgqxanadnJOT5BTb0E=;
  b=avZ6Udhfp4JNeng+gUge0mjqL1Y5Vv2xMB2m5V8RNmYa5ocEAzFolMdJ
   yHADIjEuJsbZ6LM+ylxZaMAxa2nxYOh6gyH97TaWZj9Q+ZCUcogqY6JMR
   mO4mhl803YBcx0wWfOpLlb9wkTeO2slvUW/TFitSCACgvMIbC0fg6LBTs
   P6/jzr5PKLXJh8YIWG9rxk48yPwH6Q2y6prCLGd4B4Ef+GwGq4hzxe0Uv
   KJL2tg7co9kj+uZdW2Ec1DXpr5f/A/ID/lu07Cj5IOrBQJZXDkmV8T5br
   HDeuGEScqokS1SiX0LnznN14LyiQLbgLbWlZVa24cMbMev3wsq4cGp+JY
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="203578461"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 08:43:14 +0800
IronPort-SDR: 9aUIAjbMAKuXcmYiAVO6QX6QpgIywxQT5EtjyHyyz1o2vK7poSCeWoeXaKP9hnHMHTsCf4S114
 cWa7gqmAD7EJB47SvUmPUVxhSo4V9m0vJ6v8LXH1f0vrFnLpPJw/qILkUnSkdyfovZVpkTZvMe
 C7CSIhWzlNnkgjTMQMpoajpm3jE9w9AIkpz5YOzwRTm2zjVfku8EL+X6WrXX2wqWzk33QV0SwL
 T2vBpg00Th6QETjRqhFyjM7OoKz8ypV+tNNNjji6yAfLedDTDCu+7J4p0CXnSYO9TEe9IvsFPN
 D02xcpk0B8X+fwVkFCLSgAYB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 17:01:25 -0700
IronPort-SDR: dUrTZSVA705o5iadGNlWYkloisIML9nddoqltHJ7r1mc+Nd/pDC+CtILUp2W8cmdGcdW8kvukd
 jOTG8Y/qJKQ8aEEmtpqve0hIdHDL1k3N5GGDlAnU2r8DrLRFykEpuEMN3YhI6fhyPy0zolXsPF
 EI861RHu/FKmXVZbCfntcIWxbpMWtwl5CV6HGGQlZtk9sGrP7+F01eYDDGheTC1k+iJiLYjHvn
 c5tpYIX9ag/1Oy87pjl3Wj2jMMYiaU4wQmzdg/AWz29DL22ZdbK4e7jFJK2meV7p8v6yrp/Dq6
 ZD8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 17:43:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR9qR6X9bz1Rvlx
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655685795; x=1658277796; bh=7Rf8r+wOe+lnuGLzZHW/Ni/+bYgqxanadnJ
        OT5BTb0E=; b=nLeYGftoA+8e//qc1CBj9bzCTRVSpykThdf+Z7x8/8sAXpEzjzr
        EGCIETeNPd2JecLtwhhf9madlIFStuMhcAy2i6PhzuaNCkwi1OcxfJPrtum3TpS7
        GkRwjWgePRSX+MH3q/79eRB+qv/fEYE7rcZWvSdbQaPXrP3HHCpJq0iMD5F8rfLL
        H20EgePk/vCsALroMi57rUVN1FiBG1/BEFyArtEBbQmYUYFn1vvx8bmsoiZ2+z7I
        7Yz89EcyVir3jg163F1kPbwZarLXRrFqfK7RSZBj3Y+4emkQ2OorXbG9dgsXLFCz
        iHc0YIbDi1flEBaRQFuXI/g+4Qo9HOmfEPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J5-cWGPgTiqL for <linux-kernel@vger.kernel.org>;
        Sun, 19 Jun 2022 17:43:15 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR9qQ2ntLz1Rvlc;
        Sun, 19 Jun 2022 17:43:14 -0700 (PDT)
Message-ID: <0e293be4-ba99-379e-75dc-0ba5cf7793b7@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 09:43:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: build warning after merge of the libata tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220620103400.6b03f8d9@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620103400.6b03f8d9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 09:34, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the libata tree, today's linux-next build (powercp
> ppc64_defconfig) produced this warning:

Will fix that.

> 
> In file included from include/linux/device.h:15,
>                  from arch/powerpc/include/asm/io.h:27,
>                  from include/linux/io.h:13,
>                  from include/linux/irq.h:20,
>                  from arch/powerpc/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:11,
>                  from include/linux/highmem.h:11,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/ata/pata_macio.c:18:
> drivers/ata/pata_macio.c: In function 'pmac_macio_calc_timing_masks':
> drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
>   129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
>       |                                         ^~~
> include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
>   163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>       |                                             ^~~~~~~
> drivers/ata/pata_macio.c:1031:9: note: in expansion of macro 'dev_dbg'
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |         ^~~~~~~
> drivers/ata/pata_macio.c:1031:52: note: format string is defined here
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |                                                  ~~^
>       |                                                    |
>       |                                                    long unsigned int
>       |                                                  %x
> In file included from include/linux/device.h:15,
>                  from arch/powerpc/include/asm/io.h:27,
>                  from include/linux/io.h:13,
>                  from include/linux/irq.h:20,
>                  from arch/powerpc/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:11,
>                  from include/linux/highmem.h:11,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/ata/pata_macio.c:18:
> drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
>   129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
>       |                                         ^~~
> include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
>   163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>       |                                             ^~~~~~~
> drivers/ata/pata_macio.c:1031:9: note: in expansion of macro 'dev_dbg'
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |         ^~~~~~~
> drivers/ata/pata_macio.c:1031:63: note: format string is defined here
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long unsigned int
>       |                                                             %x
> In file included from include/linux/device.h:15,
>                  from arch/powerpc/include/asm/io.h:27,
>                  from include/linux/io.h:13,
>                  from include/linux/irq.h:20,
>                  from arch/powerpc/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:11,
>                  from include/linux/highmem.h:11,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/ata/pata_macio.c:18:
> drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
>   129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
>       |                                         ^~~
> include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
>   163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>       |                                             ^~~~~~~
> drivers/ata/pata_macio.c:1031:9: note: in expansion of macro 'dev_dbg'
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |         ^~~~~~~
> drivers/ata/pata_macio.c:1031:73: note: format string is defined here
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=%lx, MWDMA=%lx, UDMA=%lx\n",
>       |                                                                       ~~^
>       |                                                                         |
>       |                                                                         long unsigned int
>       |                                                                       %x
> 
> Introduced by commit
> 
>   f0a6d77b351c ("ata: make transfer mode masks *unsigned int*")
> 


-- 
Damien Le Moal
Western Digital Research
