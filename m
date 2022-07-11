Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75775706C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiGKPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGKPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:12:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D473923;
        Mon, 11 Jul 2022 08:12:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a39so6563855ljq.11;
        Mon, 11 Jul 2022 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pjRUDXEBBcwSmCiD3m4BMtXVTKXGOIKhkWrDQAwd7uM=;
        b=i4vY3VVsWv+bHyuXbdCVj/ibOZtbK2KBApk7BDa2fauU85bzJaoDSK7Vw8MiFiD7EJ
         ot1A6QEuz61cgfxerZMhhRWqi3QpF3TcaKNaBnXiK8Lq+tF6kZRku28q40igTQQv/mMX
         cQBPMX3lMHZ78asGDdz4OSW2MkxEMbW8zA9Blz+if1N1JPpm3lide9dWdOnoNLYp/NIF
         2bjoTWACTd55YLjlVT1yH/LYpekVUtOjeGHgk2F2x2juMeySD+KO+j3Zf3U4eT/9fJrP
         3LbGjvAp3YACsBy+4WKzN0lyAAVzlATJDP3Tvnk8mj1zFdA6wL0hTWv+Kn9brAQt1EDd
         uB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pjRUDXEBBcwSmCiD3m4BMtXVTKXGOIKhkWrDQAwd7uM=;
        b=Z4VEPMHGQ/JIcxF8GzZJ2C9EJ+ym3PL/1/eSBp3HWWb1SNzfEZ3sSpecJMm1zIs/Ed
         Z20FjQR9+zKkwdKLjCkFnht47txQmAizAzNO0AgWnL4AZsc2g+zpxHB5BHPMHMsShIn4
         GSlg+bgGh/vbkRbutxidYRth+PyBstuqk83Cf2F9KdGWfIjIPSLeC3PyG4vKDzRCADLG
         svTM2LrAR82gD+H9YwnqjE0UUVdHBZi36T9PDEwnX+Q5UF9P08bFMfqo7XM84+E09jVa
         ge3KGpE2ut+qmptBjsvgeF5DbtnFCy0iibENst2Qgfw2z90y8YxubD68MhMt0CByIilx
         QWyQ==
X-Gm-Message-State: AJIora9Vw/15WF00xlzJ9NPqgwIOMaxpWYmxOMahI1DSQa/HCkYxg4gp
        4Bs6D6UIJECQmE0MYw1J/BA=
X-Google-Smtp-Source: AGRyM1uqCuw6kDX+p4gjHX6hRZQQQLWuGAYZCNeQAPsJMEy4SEjSMjEn4YAiR+dUiNxvbp+JGucDQw==
X-Received: by 2002:a2e:a224:0:b0:25d:7448:75fe with SMTP id i4-20020a2ea224000000b0025d744875femr1060353ljm.280.1657552357949;
        Mon, 11 Jul 2022 08:12:37 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f17-20020a193811000000b00479307e4a1bsm1580284lfa.135.2022.07.11.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:12:37 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:12:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 6/7] clk: baikal-t1: Add DDR/PCIe directly controlled
 resets support
Message-ID: <20220711151235.ausotedsmrgkccqn@mobilestation>
References: <20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru>
 <20220708192725.9501-7-Sergey.Semin@baikalelectronics.ru>
 <20220711132348.GB3771@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711132348.GB3771@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 03:23:48PM +0200, Philipp Zabel wrote:
> On Fri, Jul 08, 2022 at 10:27:24PM +0300, Serge Semin wrote:
> > Aside with a set of the trigger-like resets Baikal-T1 CCU provides two
> > additional blocks with directly controlled reset signals. In particular it
> > concerns DDR full and initial resets and various PCIe sub-domains resets.
> > Let's add the direct reset assertion/de-assertion of the corresponding
> > flags support into the Baikal-T1 CCU driver then. It will be required at
> > least for the PCIe platform driver. Obviously the DDR controller isn't
> > supposed to be fully reset in the kernel, so the corresponding controls
> > are added just for the sake of the interface implementation completeness.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v6:
> > - Refactor the code to support the linear reset IDs only. (@Philipp)
> > ---
> >  drivers/clk/baikal-t1/ccu-rst.c     | 67 +++++++++++++++++++++++++++++
> >  drivers/clk/baikal-t1/ccu-rst.h     | 10 +++++
> >  include/dt-bindings/reset/bt1-ccu.h |  9 ++++
> >  3 files changed, 86 insertions(+)
> > 
> > diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
> > index 8fd40810d24e..c20aa3e07afb 100644
> > --- a/drivers/clk/baikal-t1/ccu-rst.c
> > +++ b/drivers/clk/baikal-t1/ccu-rst.c
> > @@ -35,18 +35,29 @@
> >  #define CCU_AXI_HWA_BASE		0x054
> >  #define CCU_AXI_SRAM_BASE		0x058
> >  
> > +#define CCU_SYS_DDR_BASE		0x02c
> >  #define CCU_SYS_SATA_REF_BASE		0x060
> >  #define CCU_SYS_APB_BASE		0x064
> > +#define CCU_SYS_PCIE_BASE		0x144
> >  
> >  #define CCU_RST_DELAY_US		1
> >  
> >  #define CCU_RST_TRIG(_base, _ofs)		\
> >  	{					\
> > +		.type = CCU_RST_TRIG,		\
> > +		.base = _base,			\
> > +		.mask = BIT(_ofs),		\
> > +	}
> > +
> > +#define CCU_RST_DIR(_base, _ofs)		\
> > +	{					\
> > +		.type = CCU_RST_DIR,		\
> >  		.base = _base,			\
> >  		.mask = BIT(_ofs),		\
> >  	}
> >  
> >  struct ccu_rst_info {
> > +	enum ccu_rst_type type;
> >  	unsigned int base;
> >  	unsigned int mask;
> >  };
> > @@ -77,8 +88,18 @@ static const struct ccu_rst_info axi_rst_info[] = {
> >   * well while the Linux kernel is working.
> >   */
> >  static const struct ccu_rst_info sys_rst_info[] = {
> > +
> 

> Please drop this empty line. Otherwise,

Don't know how come this has got into the patch. Thanks for noticing
this. I'll fix it in v7.

> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Many thanks for review, Philipp. I really appreciate this.

-Sergey

> 
> regards
> Philipp
