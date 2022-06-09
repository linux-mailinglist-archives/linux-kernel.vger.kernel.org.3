Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B675451A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiFIQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbiFIQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:12:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D372531D0F6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:12:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so22699190wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XiAQQdU/syZOX3eZddGQQvraY9oVpO1zoYtsZwQRY3k=;
        b=STWPtDi+oAzSmtHAhwMSNDjOl2/fyL2ZJT4oNxXPfMUy9ajJs93VZOC+hLHAVcKZgU
         Gm04dw9gtP+Ui4FHjY9oN9XH1fqQbVEBTtQqdz6cyMkmRJy83pfncAs1dw6Q/k9IsnHw
         6JIK7/BdYFVP9SgeFh/Ebx1/vQEzJGoXeP3GogsrS6cYl6uuaqHiwpuNGSlIgBY8n8cW
         AHDgq44H4far41vngtYuuiF3irVYVSTbuMTckeeXdd8VFjSjRrPssDU9sTIAenm0CkK/
         Y47NOBtpGDMhqD5pWA8yAg5IDwdpT1orZrQ+uo4T6RK2fuq9Mog6bufHngmRaqHEEV+0
         2kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XiAQQdU/syZOX3eZddGQQvraY9oVpO1zoYtsZwQRY3k=;
        b=QZ94iYiGSZzFLaqjrWF606BfAuKkaSIDpc6uY3n13QY0WVrRmksp5eJpggfepSEJ6H
         BUBVmme2HKl3Tfg5MsaCNZHc/2xUxG0/KCXyZXzrmPcpbjpegFoIN9nVM6F5ZFhJAsR1
         wGWPG9ufEZLFyQV1gdAhR3Y13Xds628xtD9fQhrSyQQBQqze6gOA0NPIssxc1fUTg3hb
         UwRpVehIdbPdcFoRulV17ycPqtREPtzu6jjHA9+Qx8hw1Xu/GL6tssongJ7hspi5U9rO
         /uS5T4A4UPY/WFjRAfyy6ZeD1jXZxmqsVHYOh1FafhoTQ/RPQuKFtKZnpo77kP8vLYuG
         f1hw==
X-Gm-Message-State: AOAM533NRLzJpnfRYDQyJ55Gyr3l9K2gaQyynysnT7Bf4QOInMKlaZBx
        gTaAGQul5r0e9GXAx8MK3w1qSg==
X-Google-Smtp-Source: ABdhPJyNuZ+1HFvTvBnHQ0x5sU3r4iWWLOFW2JaLVDCEvHC7fSxcHi0ublXnUBe8MVGRA5FnIVcjUw==
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id 10-20020a5d47aa000000b002185ac8f3a8mr11114082wrb.442.1654791126376;
        Thu, 09 Jun 2022 09:12:06 -0700 (PDT)
Received: from blmsp (dynamic-046-114-004-246.46.114.pool.telefonica.de. [46.114.4.246])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0021004d7d75asm25498970wrn.84.2022.06.09.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 09:12:05 -0700 (PDT)
Date:   Thu, 9 Jun 2022 18:12:03 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP
 cap
Message-ID: <20220609161203.o33ydagex5r7pgd2@blmsp>
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220530204214.913251-3-fparent@baylibre.com>
 <bfe13669-0b22-2b50-12df-e37095faf62c@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfe13669-0b22-2b50-12df-e37095faf62c@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, May 31, 2022 at 07:17:08PM +0200, Christophe JAILLET wrote:
> Le 30/05/2022 à 22:42, Fabien Parent a écrit :
> > From: Alexandre Bailon <abailon@baylibre.com>
> > 
> > This adds support of MTK_SCPD_STRICT_BUSP cap.
> > This is required by the mt8365, for the MM power domain.
> > 
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mtk-pm-domains.c | 37 ++++++++++++++++++++-------
> >   drivers/soc/mediatek/mtk-pm-domains.h |  1 +
> >   2 files changed, 29 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 90b91b3b19a8..beaa5785fda2 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -263,17 +263,36 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
> >   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> > -	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > -	if (ret)
> > -		goto err_pwr_ack;
> > +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP)) {
> > +		/*
> > +		 * In few Mediatek platforms(e.g. MT6779), the bus protect
> > +		 * policy is stricter, which leads to bus protect release must
> > +		 * be prior to bus access.
> > +		 */
> > +		ret = scpsys_sram_enable(pd);
> > +		if (ret < 0)
> > +			goto err_pwr_ack;
> 
> Hi,
> with this new path, the error handling path looks odd because the order of
> operation is not the same.

True, thank you. I am taking over this series and will fix it for v2.

Best,
Markus

> 
> > -	ret = scpsys_sram_enable(pd);
> > -	if (ret < 0)
> > -		goto err_disable_subsys_clks;
> > +		ret = scpsys_bus_protect_disable(pd);
> > +		if (ret < 0)
> > +			goto err_pwr_ack;
> 
> Here...
> 
> > -	ret = scpsys_bus_protect_disable(pd);
> > -	if (ret < 0)
> > -		goto err_disable_sram;
> > +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > +		if (ret < 0)
> > +			goto err_pwr_ack;
> 
> ... and here as well.
> 
> CJ
> 
> > +	} else {
> > +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > +		if (ret)
> > +			goto err_pwr_ack;
> > +
> > +		ret = scpsys_sram_enable(pd);
> > +		if (ret < 0)
> > +			goto err_disable_subsys_clks;
> > +
> > +		ret = scpsys_bus_protect_disable(pd);
> > +		if (ret < 0)
> > +			goto err_disable_sram;
> > +	}
> >   	return 0;
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> > index a3955d960233..5347471bc3c4 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -8,6 +8,7 @@
> >   #define MTK_SCPD_SRAM_ISO		BIT(2)
> >   #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
> >   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
> > +#define MTK_SCPD_STRICT_BUSP		BIT(5)
> >   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
> >   #define SPM_VDE_PWR_CON			0x0210
> 
