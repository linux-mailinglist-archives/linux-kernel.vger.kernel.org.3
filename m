Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6D4F6482
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiDFP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiDFP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:56:55 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD156ED5D;
        Wed,  6 Apr 2022 06:21:56 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-76-218-nat.elisa-mobile.fi [85.76.76.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 67FC71B000E0;
        Wed,  6 Apr 2022 16:21:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1649251312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwR7bU/LqezBbEgTJDf+iEsMymzvGIHgAIteyu5Psh0=;
        b=eQ8xzLBJMgXjtwB7Yzjx/LojJlTidJ/nTLI5pX0s3cY3Zpsn8b7BqqyMs3XT0RDiE5x3gs
        VxYcG9eYTL2ti5Y7V7hFYM+rqV7NikHD3H+p5eERqlQfhhkziGxt5EzkIqEux9pVT/63ct
        9RZefQzE5i14yPjKv+zCKIJs/eTPZg90LntJxUwFkLpuxJfeJHGC27x/eapHvMw+3QBCfO
        gmU++itRdwNwFQooc8+77js9RrGrUrR+mkDgelpwUoV/wq1kCEziaeZMKg/gpUDKVDqGmb
        sdmlvWnhCTYcYS7NFr9PDY7i6KlEk5IH1VV/If5zeEdFsCEIB7hDvyObaWz3Xw==
Date:   Wed, 6 Apr 2022 16:21:49 +0300
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
Message-ID: <20220406132149.GC594699@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com>
 <20220322163646.GD297526@darkstar.musicnaut.iki.fi>
 <20220322190753.GF297526@darkstar.musicnaut.iki.fi>
 <1810824.tdWV9SEqCh@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1810824.tdWV9SEqCh@dell>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1649251312; a=rsa-sha256;
        cv=none;
        b=G3rkvREcvYSgPILWjB5NXkPEwDB12zuDb/aFmiEvpjUFHoIPAJkYCg4gSvydBuXsCOrASV
        qwVzzbSSEMx9mt98MsnoQGVKzIanrO0nr1oceqozsnLldbYtfYofM5nMCz1ygfNCoiqH+K
        IgUw/j2ZP7FR0vbtq7AE6gODdl7vMQ3Vfs+C4Xr8gfhiKcLrcewjnyFbLJ8VzM6wBTdU7t
        gGydIzbI/MdPmrFnVpcq2dLpYJlLq8V5O5cFhpaQPPezxVpgC6QZLcN3upxt341r2aPWzQ
        DGmnbA4hUe8LZaRUfUkOTNHA0z69SzxLRjRbScNwYpTyKIoK+T6Q5ps5tgqjKw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1649251312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwR7bU/LqezBbEgTJDf+iEsMymzvGIHgAIteyu5Psh0=;
        b=vWn818AHWtvsq5cDnlrJUnWE79qMNnj8xFj19jFSqwBPLeAtdZ43oHVi70bcMK+nMmLrSK
        egs3u5wrj9LuerZbuMRnIpytvyvxIRPPV7q5I7a2AsQUHhbykzAHVVpq/9fp7ydLJC4BkE
        /j7PyMCSQ8gsrfNhsiwPPt7loNA6QMRRlDk5Z6QZ2s9NdMXLpTvDXdFyETUiIH9yQ6N8ZV
        UA7Ohf8mDgm8uV/Dx1bNcCT7oIamV8mar/PlKoL+fP1XJy/PNu3ZxCz87uc5NkMQwotWIp
        I92ppcKhR83XiGqTSWPAjd1EkDpGjMI2CtDXW+kr0FIUmivOhk5Ny7zCGfDavA==
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

On Sat, Mar 26, 2022 at 10:17:49PM +0100, Janusz Krzysztofik wrote:
> Dnia wtorek, 22 marca 2022 20:07:53 CET Aaro Koskinen pisze:
> > On Tue, Mar 22, 2022 at 06:36:48PM +0200, Aaro Koskinen wrote:
> > > Something is still broken. When doing kexec (using CCF kernel), the
> > > kexec'ed kernel now hangs early (on 770):
> > [...]
> > > [    0.928863] calling  omap1_init_devices+0x0/0x2c @ 1
> > 
> > It hangs in omap_sram_reprogram_clock() (<- omap1_select_table_rate()
> > <- omap1_clk_late_init()).
> 
> I've reviewed my changes but haven't found anything suspicious.

The below change is fixing the kexec boot. Based on the comment in the
code, it seems this clock is needed for the SRAM to work.

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index e33e11f826af..b8b4876ff935 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -285,7 +285,7 @@ static struct omap1_clk tc1_ck = {
  */
 
 static struct omap1_clk tc2_ck = {
-	.hw.init	= CLK_HW_INIT("tc2_ck", "tc_ck", &omap1_clk_gate_ops, 0),
+	.hw.init	= CLK_HW_INIT("tc2_ck", "tc_ck", &omap1_clk_gate_ops, CLK_IS_CRITICAL),
 	.ops		= &clkops_generic,
 	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC2_CK,

A.
