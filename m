Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C64E8459
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiCZVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCZVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:19:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC662FF;
        Sat, 26 Mar 2022 14:17:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so18776847lfj.11;
        Sat, 26 Mar 2022 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dorKyWKnXy7IlU5rrn/oj/4eomYs0ghYVJYTP+RQhwU=;
        b=YRqFWEWAZ28v076CK4im5SsXJvYcIfTGKam4+0bSK2o/aS6vIDYE9Y18URClNg/GqB
         RCIrT5/7wf+CDsHlQvI4o8cs9ZDgVgyG09UsPOCxV7FV/be8bWIFNAdFHLt232AT/u/R
         9tApWuES+tn6MKrH+Rd0XeuBjp3pfNrH9xiShEbuRChEEcxs22tXOEpjgP9sHh12IhF7
         pyRZ7G5XJCDBc28A619jRNMmcBnapRF4g8eyBhjm8NHdarSvsB1s9EOVtGA7U+e2x7Z+
         SqPOCtfjyDxdl+qszxJZ2uetnejw9VLLWyenYM/+BHW6jmXH/0j8qsRyJ0oRFmob/5Oz
         E37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dorKyWKnXy7IlU5rrn/oj/4eomYs0ghYVJYTP+RQhwU=;
        b=OWtiosIj/h7OB969mbqPDwL32NnFGh+IdR5T+kFRrgdcDsCPaYcBF2jaw1TVndYTI1
         gI6Zz/2j8a9NWwLkqi/riLMGSqwqbWH1VPnM5/KDzf+J0GUTkpKImYqNDB+gS2Erz2uS
         Nc9ZP8ahIcEheGpLr8oIUivl2nw5pQEDU1b/S+WtwoKMy1krKIKr/GCDPhR2mcvUDa3N
         KV1+N0UpLYZG6SL8LeMgfGtTPHDAlbG5+0b4djxAvVigIm4JaU+rwkWJhYD+p/xXL6IH
         3FzxUyMmlChbgLE+uYPNG2K+5SfTbgkVue/bDu/XBwGC/+hg7VWXs8uOr1tnBK50RDBw
         Dphg==
X-Gm-Message-State: AOAM533wnbmlWFwTFFPbwpbCK8kPmcrR3BMNlkNZDboD+y/BlxtKDJoQ
        FwqVkJWRKPgiYxAqTzoOlPS2rTYWiyvaEg==
X-Google-Smtp-Source: ABdhPJwR/+ymjQZpTMAtiHGRcZti14dQruOjPpTxdcJTz7Y/Kj/+bGyN0Cae9N+tEUxHtv4Zv8OG9Q==
X-Received: by 2002:ac2:434a:0:b0:443:e48d:50b7 with SMTP id o10-20020ac2434a000000b00443e48d50b7mr13484093lfl.45.1648329472824;
        Sat, 26 Mar 2022 14:17:52 -0700 (PDT)
Received: from dell.intranet (178235254230.gdansk.vectranet.pl. [178.235.254.230])
        by smtp.gmail.com with ESMTPSA id h8-20020ac25d68000000b00447b5cad2a7sm1174015lft.228.2022.03.26.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 14:17:52 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
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
Subject: Re: [PATCH v2] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to CCF
Date:   Sat, 26 Mar 2022 22:17:49 +0100
Message-ID: <1810824.tdWV9SEqCh@dell>
In-Reply-To: <20220322190753.GF297526@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com> <20220322163646.GD297526@darkstar.musicnaut.iki.fi> <20220322190753.GF297526@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaro,

Dnia wtorek, 22 marca 2022 20:07:53 CET Aaro Koskinen pisze:
> Hi,
> 
> On Tue, Mar 22, 2022 at 06:36:48PM +0200, Aaro Koskinen wrote:
> > On Mon, Mar 21, 2022 at 10:54:16PM +0100, Janusz Krzysztofik wrote:
> > > In preparation for conversion of OMAP1 clocks to common clock framework,
> > > identify users of those clocks which don't call clk_prepare/unprepare()
> > > and update them to call clk_prepare_enable/clk_disable_unprepare() instead
> > > of just clk_enable/disable(), as required by CCF implementation of clock
> > > API.
> > > 
> > > v2: update still a few more OMAP specific drivers missed in v1,
> > >   - call clk_prepare/unprepare() just after/before clk_get/put() where it
> > >     can make more sense than merging prepare/unprepare with enable/disable.
> > 
> > Something is still broken. When doing kexec (using CCF kernel), the
> > kexec'ed kernel now hangs early (on 770):
> [...]
> > [    0.928863] calling  omap1_init_devices+0x0/0x2c @ 1
> 
> It hangs in omap_sram_reprogram_clock() (<- omap1_select_table_rate()
> <- omap1_clk_late_init()).

I've reviewed my changes but haven't found anything suspicious.  Could you 
please provide:
- dmesg from both cold start and kexec, both non-CCF and CCF version, 
- contents of /sys/kernel/debug/clock/summary (non-CCF) after boot/kexec,
- contents of /sys/kernel/debug/clk/clk_summary (CCF) after boot?

Thanks,
Janusz

> 
> A.
> 




