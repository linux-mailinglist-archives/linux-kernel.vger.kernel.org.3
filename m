Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41124DE8F7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbiCSPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiCSPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:15:12 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C422A7769;
        Sat, 19 Mar 2022 08:13:51 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-3-17-nat.elisa-mobile.fi [85.76.3.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 984741B005CC;
        Sat, 19 Mar 2022 17:13:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1647702829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XhlgZ0Wc09MSr8A7dkXipS3QK+pUiU/zSGRxylNUegc=;
        b=UhSPGHz8W+GC7+6Mh0NyXiO4i5i+vH9Z2+wXfXkGJYF5h0CMpKQuK97zPxtwBwyxlfkNeH
        UeCFr8vdgFT3GU65CYMKDFxyFYoQaAiAxvoSzsbaiVl+Ar3eMbgH+yFwBZSE/mLXFuqAsw
        r+QZhe+8tW4oAu4Ow862f9gz3HQ7GH9fo/O9MLDWlQoX1AAzXvJ4nrverpo/3eRIvuuv6w
        oC0REesxFeybp1kR/cgQyrETybLBLSDZ6kceknGFN7cN42NojxV0rJA0KU3Z32ckVhcR9j
        mvZQpOOQweCpBPm698+7K6VjSC0cDUFQCLMjGtwEpCrydZGL2KEcaEgqSJ44Kw==
Date:   Sat, 19 Mar 2022 17:13:46 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED] input: ads7846: touchscreen broken on Nokia 770
Message-ID: <20220319151346.GE1986@darkstar.musicnaut.iki.fi>
References: <20220227185038.GA3016@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227185038.GA3016@darkstar.musicnaut.iki.fi>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1647702829; a=rsa-sha256;
        cv=none;
        b=KL61wi7ESnfAE7U2Nj9JD9F5b9KGfxYfptx8QvzFT6QEimSDopzax5bvk1R+duBmNEdtbJ
        klKD2iMbe0/UshVS/JjkYoq0QCo9gEdkK+w4QGyfVn5qDPoOEFj3qxEicyvy6e2vNa/XG7
        +ITuYdeCqzKarlnI/GS3yfUrjjlkkVIF6VFr619MMeEBMszLYNvWRfT5ns+NwyKV/0H4K4
        Hz5PFZ89lcfN/7JX5qYnp3HG1LfWGhVXpMI3hl2xn1iJCNxODAECWbX1N7vPpeuxwKfWrh
        IqqQhqnWkfzF3GMTNzdDaWDJcJgaQ88ticioE3HgbV6km+lboBbi6zIdAHC41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1647702829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XhlgZ0Wc09MSr8A7dkXipS3QK+pUiU/zSGRxylNUegc=;
        b=jgFBl8uSXb/OyCHXzrDmZS7Q0GbsorqGtJbcWkBwshmFveBsvcpmSSRnbP8XrRbqZ4yXf6
        7h1bI/IkVBYEOpN6uGrX0FKcaU3VhCbKV6PCCOHN+jR694PmFa+mb4wTFlB1ywgkuqaCgy
        HgyZZmpeSL4kaf/8yR4EEnzWSR/W4qs3pdSDWBS2JBNBg54FDCOE8GG84vZjl5X+qIRPUV
        ayXXpNSLcfLU+c3IG1pwYvZWKFJjUSsxWXF2WxtnKMz0aQdRMRe95mBAMtvRyzweVpQszO
        PFobfer/7oTwizw3eBBfdMw9gltKEosxl0AL1kz0Siyw1kO5iI6OmuyWVEGcEg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 27, 2022 at 08:50:39PM +0200, Aaro Koskinen wrote:
> I noticed touchscreen does not work anymore on Nokia 770:
> 
> [    2.131011] ads7846 spi2.0: touchscreen, irq 175
> [    2.200622] input: ADS7846 Touchscreen as /devices/platform/omap_uwire/spi_master/spi2/spi2.0/input/input0
> 
> (then touching the screen:)
> 
> [   52.316894] ads7846 spi2.0: spi_sync --> -22
> [   52.336944] ads7846 spi2.0: spi_sync --> -22
> 
> bisected this to:
> 
> commit 9c9509717b53e701469493a8d87ed42c7d782502
> Author: Oleksij Rempel <o.rempel@pengutronix.de>
> Date:   Wed Nov 11 16:39:05 2020 -0800
> 
>     Input: ads7846 - convert to full duplex
> 
> It seems it's failing on SPI_CONTROLLER_HALF_DUPLEX check in
> __spi_validate(). The controller used on this board (spi-omap-uwire)
> sets that flag. How ads7846 is now supposed to work in that case after
> this conversion?

Any comments?

The touchscreen works after reverting the following patches:

6965eece2a89 ("Input: ads7846 - convert to one message")
9c9509717b53 ("Input: ads7846 - convert to full duplex")

A.
