Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5FB55A9A0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiFYL5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiFYL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4155527FD2;
        Sat, 25 Jun 2022 04:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2E17611BC;
        Sat, 25 Jun 2022 11:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91D3C3411C;
        Sat, 25 Jun 2022 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656158229;
        bh=Jh+t8pyQkjetLG1QIFJX8UAzx2DiAOj2gLxy8XB7H/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=snNV/G4kd+r8meYshIqn89rxH2c7R66yMKy91Y5dd9j+sMcV0lE1dHxDH+OIUTuQP
         o4fL6KjTU/vORqLYLfRNrvyZPQaJpjJv9+8oT9XD4PBBPJ2QvxWFmzfVtgXhe7592H
         muidqJurcd/jwTOGf+ixC/jdeFCKIBE3F+F+J8wJk81wCSV6aMJWS1fzq5dsx1yGHf
         Pwoso3fQyXCwZMoFwrSrIRb7Ylo+/tFIQsi2/MKv6yJKbY26RgpU5HZjlG4iGns3f9
         gNzBBri3j7ZU+OYgb3jvl4Md3TTQJFns2yh9WbCdlTL5n7gggVHZswRwGMLLKEtJz8
         +GC2s+dFw84iA==
Date:   Sat, 25 Jun 2022 13:06:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 04/10] iio: adc: mcp3911: add support for interrupts
Message-ID: <20220625130637.223180f2@jic23-huawei>
In-Reply-To: <20220625125652.2f988964@jic23-huawei>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-4-marcus.folkesson@gmail.com>
        <20220625125652.2f988964@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


...

> >  static int mcp3911_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -352,6 +382,15 @@ static int mcp3911_probe(struct spi_device *spi)
> >  	if (ret)
> >  		goto clk_disable;
> >  
> > +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
> > +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> > +				0, 2);
> > +	else
> > +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> > +				MCP3911_STATUSCOM_DRHIZ, 2);
> > +	if (ret < 0)
> > +		goto clk_disable;
> > +
> >  	indio_dev->name = spi_get_device_id(spi)->name;
> >  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> >  	indio_dev->info = &mcp3911_info;
> > @@ -362,6 +401,32 @@ static int mcp3911_probe(struct spi_device *spi)
> >  
> >  	mutex_init(&adc->lock);
> >  
> > +	if (spi->irq > 0) {
> > +		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > +				indio_dev->name,
> > +				iio_device_id(indio_dev));
> > +		if (!adc->trig)
> > +			goto clk_disable;  
> You definitely want to use devm managed cleanup for these.
> 
> There is a patch set that adds these as standard functions, but I haven't
> yet seen it being picked up for this cycle (reviews have been slow coming).
> 
> https://lore.kernel.org/all/20220520075737.758761-1-u.kleine-koenig@pengutronix.de/

Ah, elsewhere in my unread email was a thread that says it's in clk-next so
will be in the next merge window.  I haven't confirmed, but looks like Stephen
put up an immutable branch so I could pull it into the IIO togreg branch if you
want to transition directly to that new code. @Stephen, would you be fine
with me pulling your clk-devm-enable branch into IIO (with the fix which
got posted earlier in the week presumably also going on that branch when
you push out?)

Thanks,

Jonathan



> 
> In meantime role your own with devm_add_action_or_reset()
