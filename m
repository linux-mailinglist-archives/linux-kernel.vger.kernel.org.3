Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A494F8751
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346941AbiDGStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDGSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:49:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3325D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19662B8260F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A729C385A4;
        Thu,  7 Apr 2022 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357254;
        bh=SVrHOFOrp4LkSdxf9IrDTGBKQw2pW5xOGs2OcPhHsLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WeeIz+LTk9Khndp+7GXzQ84jQ5ZQVEDaV71Nd4ySkPevv8V5xyAqR60zMiDUrVK0V
         Wia4OdAcUABKcolcbzNqWkDDSQiN2dzZxjUWHmGHw85ZJDYssq5llnQ+pNAxpDAwKo
         yrxmRBXninI7xL1hM2BFCgEJplx8LTib1Qc1pmXPGGoO9DFSlJCHHsBe76CMZSF4/g
         kuQRHY08smB1uQJ+6JNrc93gagqQSMMi4EUcTmgBophBZuvIyR7TA2X/oECBLNKdkT
         amQjgDCqW+tODzyuUOAY3NZ3EJDirmJuTGw+B/fcqJ4VitYdCfrFPmgZ9WexHFC/Lm
         SDAJSe8NJCDeQ==
Date:   Thu, 7 Apr 2022 20:47:28 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ASoC: Intel: sof_es8336: add a quirk for headset
 at mic1 port
Message-ID: <20220407204728.7710ebfa@coco.lan>
In-Reply-To: <0dac70ef-1355-3379-ef41-eec6467886b1@linux.intel.com>
References: <cover.1649275618.git.mchehab@kernel.org>
        <baf412bc431650fc7f3a157c6ab96d08120940fc.1649275618.git.mchehab@kernel.org>
        <0dac70ef-1355-3379-ef41-eec6467886b1@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 6 Apr 2022 22:08:53 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> escreveu:

> >   static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
> > @@ -145,13 +148,23 @@ static const struct snd_soc_dapm_route sof_es8316_audio_map[] = {
> >   	{"Speaker", NULL, "HPOL"},
> >   	{"Speaker", NULL, "HPOR"},
> >   	{"Speaker", NULL, "Speaker Power"},
> > +
> > +	{"Differential Mux", "lin1-rin1", "MIC1"},
> > +	{"Differential Mux", "lin2-rin2", "MIC2"},
> > +	{"Differential Mux", "lin1-rin1 with 20db Boost", "MIC1"},
> > +	{"Differential Mux", "lin2-rin2 with 20db Boost", "MIC2"},  
> 
> this is surprising, shouldn't this be part of the codec driver?
> 
> The part that should be machine-specific is really how MIC1 or MIC2 are 
> connected (as done below), but the routes above seem machine-independent?

Yeah, this should be there... and it is there already ;-)

Tested without it and it still works.

So, I'll just drop the above.

Thanks,
Mauro
