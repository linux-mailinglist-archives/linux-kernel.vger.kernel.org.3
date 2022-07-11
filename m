Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC72570D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiGKWDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGKWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:03:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C8F51A3C;
        Mon, 11 Jul 2022 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=l2rAa3CH+5LxK4TvgAIGy1nPuA1HPecPbAqbMJbBy/A=; b=LzhN36IZ8lFoobUI+haQ9C1kbA
        XAk2tblC4HcUtMapuS64qBsAn+olvay95b9xLJ24pXmG3Antk82tJdzmH2U3mEXcyPaPcG8f+q4Oj
        LGpN7+0LbsIzvXmwtr8D3c4bLsVkJDbfcPsqkLD5h62yRiEai4AF/YpZ04L6rLVxHAlTZ8tjR+jIH
        4rAyk9H91m1Ud1qwUkH5vhFW6v4/KB9a74cWsJJPvl5nb9LyIyctlJ9aR3kZHKOKJyCL3GkAt5CZZ
        K+9WmF6hvkPNdZ22NFQwOzSl9+0XAfzWVus0A7R3n4UvJl76puVnlepPvHCd2ah6BwkW49QS6Orrv
        xyZcLbvA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB1Uf-0059dC-B9; Mon, 11 Jul 2022 22:03:05 +0000
Message-ID: <279b1221-ce2d-c54b-95ca-df6c67cc1bdc@infradead.org>
Date:   Mon, 11 Jul 2022 15:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 3/6] soc: imx: add i.MX93 SRC power domain driver
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
 <20220711062452.3575032-4-peng.fan@oss.nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220711062452.3575032-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/10/22 23:24, Peng Fan (OSS) wrote:
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index a840494e849a..5bfc1dfea28b 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -20,4 +20,14 @@ config SOC_IMX8M
>  	  support, it will provide the SoC info like SoC family,
>  	  ID and revision etc.
>  
> +config SOC_IMX9
> +	tristate "i.MX9 SoC family support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	default ARCH_MXC && ARM64
> +	select SOC_BUS
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  If you say yes here you get support for the NXP i.MX9 family
> +	  support.

Please drop the second "support".

-- 
~Randy
