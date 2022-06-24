Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE355A496
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiFXXE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiFXXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:04:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E1988B11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UgGZSiTann1FsLffy7zbYdwIpMQCZ2jn74pvxu+ZQ/c=; b=cFlu/UrLn0Z4Pv2rVtyWUCAyat
        lZxyI3lABiXr82Vnf+AwvWvvqJ9Hxsan+CfMfb8ldL/6Q5clOShbiBXYlmp5VznI8245Ot3Y7snvR
        sbidiGJnIdyARj8c48QHB9W/MKbBoLbMF3qqoM/UvpEngt4k4a/rhZCKxTpDbgsgY2Cj7m3+eud4y
        HZJtIApT5RrlwjMoQr/00BV2G8v561VHoRzHfrOldTNyDBqXFu+C7OBwhMg+966VCao/7F3aNahIE
        pKISP8ZQRs0CR9Scn01nkwJw0nKTEqFrzaS5DD9/J6xXWhxRV2oS2ugA3VRxbJzPcrp6mgHEKeML1
        ZNwM3ouA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4sLL-0044s6-4w; Fri, 24 Jun 2022 23:04:03 +0000
Message-ID: <6a210c39-2a04-2d39-9d5f-51b4e777b81d@infradead.org>
Date:   Fri, 24 Jun 2022 16:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] ASoC: amd: acp: Add legacy audio driver support for
 Rembrandt platform
Content-Language: en-US
To:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Syed Saba kareem <ssabakar@amd.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Meng Tang <tangmeng@uniontech.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220624194821.287462-1-Vsujithkumar.Reddy@amd.com>
 <20220624194821.287462-4-Vsujithkumar.Reddy@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220624194821.287462-4-Vsujithkumar.Reddy@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/24/22 12:48, V sujith kumar Reddy wrote:
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index 7e56d2644105..abc089f38b6c 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -40,6 +40,17 @@ config SND_AMD_ASOC_RENOIR
>  	help
>  	  This option enables Renoir I2S support on AMD platform.
>  
> +config SND_AMD_ASOC_REMBRANDT
> +        tristate "AMD ACP ASOC Rembrandt Support"
> +        select SND_SOC_AMD_ACP_PCM
> +        select SND_SOC_AMD_ACP_I2S
> +        select SND_SOC_AMD_ACP_PDM
> +        depends on X86 && PCI
> +        help
> +          This option enables Rembrandt I2S support on AMD platform.
> +	  Say Y if you want to enable AUDIO on Rembrandt
> +	  If unsure select "N".

Documentation/process/coding-style.rst says:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


so please indent as expected, and consistently.

-- 
~Randy
