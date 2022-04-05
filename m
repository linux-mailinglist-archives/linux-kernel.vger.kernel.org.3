Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610944F4F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583559AbiDEXxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457284AbiDEQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C922314E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9FD61851
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80488C385A0;
        Tue,  5 Apr 2022 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649173027;
        bh=B71FoNUqZdUne/qe1E9xWKXEEFKXBJjXYedQ6YEnXDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ckGGO2G2Mbm4Yc3/yniY9O0/9GsO/TkdzlK1/hwMowWAtPWLGK9oe5WuHXF3KuHEP
         0mmL8ZQmDPhElerlXQV4l1gXG2CLU7QyMlO4kFzz6To9DeDvIRciNeAH97aycDTfMg
         1Q5tOjYzaeutYMASko1MjrGd/2SJ+bYqlV3gJKLqGtgUUw8r7XWegyoW69UWcY+kj3
         wfWNLcyf5hoRV3YKvQ3+wno4633847GBEcNlVj6t4P9eyneI8SZu6nvep7D3tOQVp8
         H49zOcY6sbTXYDl9Uod9KKfew3WCCfyn97ZOzNo0HiOdPX2j1RbPZ0js8QmU9I/Sdt
         SBzAZaMGek0LA==
Date:   Tue, 5 Apr 2022 17:37:01 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: Intel: sof_es8336: support a separate gpio
 to control headphone
Message-ID: <20220405173701.1459b198@coco.lan>
In-Reply-To: <5df9bb3c-2346-f465-fcae-eb6fe381def3@linux.intel.com>
References: <cover.1649147890.git.mchehab@kernel.org>
        <0f1e8233fc6744c3d78353e4a20f9669035e693d.1649147890.git.mchehab@kernel.org>
        <5df9bb3c-2346-f465-fcae-eb6fe381def3@linux.intel.com>
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

Em Tue, 5 Apr 2022 09:57:30 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> escreveu:

> On 4/5/22 03:44, Mauro Carvalho Chehab wrote:
> > From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > 
> > Some devices may use both gpio0 and gpio1 to independently switch
> > the speaker and the headphone.
> > 
> > Add support for that.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> > 
> > See [PATCH v2 0/2] at: https://lore.kernel.org/all/cover.1649147890.git.mchehab@kernel.org/
> > 
> >   sound/soc/intel/boards/sof_es8336.c | 60 ++++++++++++++++++++++++-----
> >   1 file changed, 50 insertions(+), 10 deletions(-)
> > 
> > diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
> > index 5e0529aa4f1d..bcd80870d252 100644
> > --- a/sound/soc/intel/boards/sof_es8336.c
> > +++ b/sound/soc/intel/boards/sof_es8336.c
> > @@ -30,6 +30,7 @@
> >   #define SOF_ES8336_TGL_GPIO_QUIRK		BIT(4)
> >   #define SOF_ES8336_ENABLE_DMIC			BIT(5)
> >   #define SOF_ES8336_JD_INVERTED			BIT(6)
> > +#define SOF_ES8336_HEADPHONE_GPIO		BIT(7)
> >   
> >   static unsigned long quirk;
> >   
> > @@ -39,7 +40,7 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
> >   
> >   struct sof_es8336_private {
> >   	struct device *codec_dev;
> > -	struct gpio_desc *gpio_pa;
> > +	struct gpio_desc *gpio_pa, *gpio_pa_headphone;
> >   	struct snd_soc_jack jack;
> >   	struct list_head hdmi_pcm_list;
> >   	bool speaker_en;
> > @@ -51,15 +52,28 @@ struct sof_hdmi_pcm {
> >   	int device;
> >   };
> >   
> > -static const struct acpi_gpio_params pa_enable_gpio = { 0, 0, true };
> > +static const struct acpi_gpio_params pa_enable_gpio0 = { 0, 0, true };
> > +static const struct acpi_gpio_params pa_enable_gpio1 = { 1, 0, true };
> > +
> >   static const struct acpi_gpio_mapping acpi_es8336_gpios[] = {
> > -	{ "pa-enable-gpios", &pa_enable_gpio, 1 },
> > +	{ "pa-enable-gpios", &pa_enable_gpio0, 1 },
> >   	{ }
> >   };
> >   
> > -static const struct acpi_gpio_params quirk_pa_enable_gpio = { 1, 0, true };
> >   static const struct acpi_gpio_mapping quirk_acpi_es8336_gpios[] = {
> > -	{ "pa-enable-gpios", &quirk_pa_enable_gpio, 1 },
> > +	{ "pa-enable-gpios", &pa_enable_gpio1, 1 },
> > +	{ }
> > +};
> > +
> > +static const struct acpi_gpio_mapping quirk_acpi_headphone_es8336_gpios[] = {
> > +	{ "pa-enable-gpios", &pa_enable_gpio0, 1 },
> > +	{ "pa-enable-headphone-gpios", &pa_enable_gpio1, 1 },
> > +	{ }
> > +};
> > +
> > +static const struct acpi_gpio_mapping quirk_tgl_acpi_headphone_es8336_gpios[] = {
> > +	{ "pa-enable-gpios", &pa_enable_gpio1, 1 },
> > +	{ "pa-enable-headphone-gpios", &pa_enable_gpio0, 1 },
> >   	{ }  
> 
> This is starting to be a bit messy, the initial gpios were really 
> intended for speakers and should be clearly referring to speakers now. 
> the TGL quirk really means gpio1 is used instead of gpio0, and I can't 
> figure out what the 'pa' prefix is needed for.
> 
> Can I suggest the attached cleanup patch be added first? That would make 
> it clearer and more readable IMHO. Compile-tested only since I don't 
> have hardware.

Makes sense. I'll place it before the first patch, rebase them,
test and re-submit.

> Thanks!

Thanks!
Mauro
