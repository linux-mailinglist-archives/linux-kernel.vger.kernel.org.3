Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9739B57042C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiGKNYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiGKNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:23:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514241C130
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:23:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1oAtO9-00075s-6K; Mon, 11 Jul 2022 15:23:49 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1oAtO8-0001XN-T3; Mon, 11 Jul 2022 15:23:48 +0200
Date:   Mon, 11 Jul 2022 15:23:48 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 6/7] clk: baikal-t1: Add DDR/PCIe directly controlled
 resets support
Message-ID: <20220711132348.GB3771@pengutronix.de>
References: <20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru>
 <20220708192725.9501-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708192725.9501-7-Sergey.Semin@baikalelectronics.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 10:27:24PM +0300, Serge Semin wrote:
> Aside with a set of the trigger-like resets Baikal-T1 CCU provides two
> additional blocks with directly controlled reset signals. In particular it
> concerns DDR full and initial resets and various PCIe sub-domains resets.
> Let's add the direct reset assertion/de-assertion of the corresponding
> flags support into the Baikal-T1 CCU driver then. It will be required at
> least for the PCIe platform driver. Obviously the DDR controller isn't
> supposed to be fully reset in the kernel, so the corresponding controls
> are added just for the sake of the interface implementation completeness.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v6:
> - Refactor the code to support the linear reset IDs only. (@Philipp)
> ---
>  drivers/clk/baikal-t1/ccu-rst.c     | 67 +++++++++++++++++++++++++++++
>  drivers/clk/baikal-t1/ccu-rst.h     | 10 +++++
>  include/dt-bindings/reset/bt1-ccu.h |  9 ++++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
> index 8fd40810d24e..c20aa3e07afb 100644
> --- a/drivers/clk/baikal-t1/ccu-rst.c
> +++ b/drivers/clk/baikal-t1/ccu-rst.c
> @@ -35,18 +35,29 @@
>  #define CCU_AXI_HWA_BASE		0x054
>  #define CCU_AXI_SRAM_BASE		0x058
>  
> +#define CCU_SYS_DDR_BASE		0x02c
>  #define CCU_SYS_SATA_REF_BASE		0x060
>  #define CCU_SYS_APB_BASE		0x064
> +#define CCU_SYS_PCIE_BASE		0x144
>  
>  #define CCU_RST_DELAY_US		1
>  
>  #define CCU_RST_TRIG(_base, _ofs)		\
>  	{					\
> +		.type = CCU_RST_TRIG,		\
> +		.base = _base,			\
> +		.mask = BIT(_ofs),		\
> +	}
> +
> +#define CCU_RST_DIR(_base, _ofs)		\
> +	{					\
> +		.type = CCU_RST_DIR,		\
>  		.base = _base,			\
>  		.mask = BIT(_ofs),		\
>  	}
>  
>  struct ccu_rst_info {
> +	enum ccu_rst_type type;
>  	unsigned int base;
>  	unsigned int mask;
>  };
> @@ -77,8 +88,18 @@ static const struct ccu_rst_info axi_rst_info[] = {
>   * well while the Linux kernel is working.
>   */
>  static const struct ccu_rst_info sys_rst_info[] = {
> +

Please drop this empty line. Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
