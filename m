Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682C74E467A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiCVTJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiCVTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:09:29 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56861A6;
        Tue, 22 Mar 2022 12:08:00 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-100-34-nat.elisa-mobile.fi [85.76.100.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id B3C5F20388;
        Tue, 22 Mar 2022 21:07:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1647976075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zTS3DT6xcfZw/ju05KElVTkQiN1fQ/ztsa9TbNgG2s=;
        b=cX6LmeT38lN2NaF7Qsx5VX0GwklLy2du9kOpxTh3b4+Qw5wrtoKy5+CaPdFHVPF7PUQJV7
        JP0eZNy7X0Jfbj3WAB5bQXsUGhmUeS+qIfMHxdWpTOM+QUCxar+jfmcf0+g1AFcQ1pCKkA
        q4bRX979489LLYULp2d8EW4EbP4qAGY=
Date:   Tue, 22 Mar 2022 21:07:53 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mmc@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to
 CCF
Message-ID: <20220322190753.GF297526@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com>
 <20220321215416.236250-1-jmkrzyszt@gmail.com>
 <20220322163646.GD297526@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322163646.GD297526@darkstar.musicnaut.iki.fi>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1647976075; a=rsa-sha256; cv=none;
        b=X6jYN8e4edIdwhVqd08HooVar4l9k4zaeYIbPBffuNKwdkVOZqop0cLduutP177L6DWw1t
        z3md1/KyrpNc4Oj2NmcgYKgqs06xOi37+Q82NbgDQR7qRGbl7dmfLBEOUOb/ZvPz8Q9kzG
        iv9WWWKrxOwoKKPEYH88Tk0Gi1Jit1A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1647976075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zTS3DT6xcfZw/ju05KElVTkQiN1fQ/ztsa9TbNgG2s=;
        b=uVqGTgouIQJQ2R58scj6U0J2KM/YtrOq4hq0tSnqJjTw6VkH13Shbd3ZumElBWGBl6w/C+
        SIBA6Ck0VAZhNiAy4cgvRL+DdTJJmixLaEk9B9FpqhWM/Nmc5koLsdctAdg9syFOac++N8
        L8McGNzCb7F/2+k2v1U0gta89xs02Sw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 22, 2022 at 06:36:48PM +0200, Aaro Koskinen wrote:
> On Mon, Mar 21, 2022 at 10:54:16PM +0100, Janusz Krzysztofik wrote:
> > In preparation for conversion of OMAP1 clocks to common clock framework,
> > identify users of those clocks which don't call clk_prepare/unprepare()
> > and update them to call clk_prepare_enable/clk_disable_unprepare() instead
> > of just clk_enable/disable(), as required by CCF implementation of clock
> > API.
> > 
> > v2: update still a few more OMAP specific drivers missed in v1,
> >   - call clk_prepare/unprepare() just after/before clk_get/put() where it
> >     can make more sense than merging prepare/unprepare with enable/disable.
> 
> Something is still broken. When doing kexec (using CCF kernel), the
> kexec'ed kernel now hangs early (on 770):
[...]
> [    0.928863] calling  omap1_init_devices+0x0/0x2c @ 1

It hangs in omap_sram_reprogram_clock() (<- omap1_select_table_rate()
<- omap1_clk_late_init()).

A.
