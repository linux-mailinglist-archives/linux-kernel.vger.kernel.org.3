Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B05E5667B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiGEKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiGEKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:20:48 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6572140A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:20:46 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id rNLf270094C55Sk06NLfeX; Tue, 05 Jul 2022 12:20:44 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o8ffa-0029jA-Kj; Tue, 05 Jul 2022 12:20:38 +0200
Date:   Tue, 5 Jul 2022 12:20:38 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Cezary Rojewski <cezary.rojewski@intel.com>
cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        upstream@semihalf.com, kai.vehmanen@linux.intel.com,
        harshapriya.n@intel.com, rad@semihalf.com,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        hdegoede@redhat.com, amadeuszx.slawinski@linux.intel.com,
        cujomalainey@chromium.org, lma@semihalf.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] ASoC: codecs: Add HD-Audio codec driver
In-Reply-To: <20220511162403.3987658-3-cezary.rojewski@intel.com>
Message-ID: <alpine.DEB.2.22.394.2207051218200.513966@ramsan.of.borg>
References: <20220511162403.3987658-1-cezary.rojewski@intel.com> <20220511162403.3987658-3-cezary.rojewski@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Cezary,

On Wed, 11 May 2022, Cezary Rojewski wrote:
> Add generic ASoC equivalent of ALSA HD-Audio codec. This codec is
> designed to follow HDA_DEV_LEGACY convention. Driver wrapps existing
> hda_codec.c handlers to prevent code duplication within the newly added
> code. Number of DAIs created is dependent on capabilities exposed by the
> codec itself. Because of this, single solution can be applied to support
> every single HD-Audio codec type.
>
> At the same time, through the ASoC topology, platform drivers may limit
> the number of endpoints available to the userspace as codec driver
> exposes BE DAIs only.
>
> Both hda_codec_probe() and hda_codec_remove() declare their expectations
> on device's usage_count and suspended-status. This is to catch any
> unexpected behavior as PM-related code for HD-Audio has been changing
> quite a bit throughout the years.
>
> In order for codec DAI list to reflect its actual PCM capabilities, PCMs
> need to be built and that can only happen once codec device is
> constructed. To do that, a valid component->card->snd_card pointer is
> needed. Said pointer will be provided by the framework once all card
> components are accounted for and their probing can begin. Usage of
> "binder" BE DAI solves the problem - codec can be listed as one of
> HD-Audio card components without declaring any actual BE DAIs
> statically.
>
> Relation with hdac_hda:
>
> Addition of parallel solution is motivated by behavioral differences
> between hdac_hda.c and its legacy equivalent found in sound/pci/hda
> e.g.: lack of dynamic, based on codec capabilities, resource allocation
> and high cost of removing such differences on actively used targets.
> Major goal of codec driver presented here is to follow HD-Audio legacy
> behavior in 1:1 fashion by becoming a wrapper. Doing so increases code
> coverage of the legacy code and reduces the maintenance cost for both
> solutions.
>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks for your patch, which is now commit b5df2a7dca1cc6c6 ("ASoC:
codecs: Add HD-Audio codec driver") in sound-asoc/for-next.

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -937,6 +937,16 @@ config SND_SOC_HDAC_HDA
> 	tristate
> 	select SND_HDA
>
> +config SND_SOC_HDA
> +	tristate "HD-Audio codec driver"
> +	select SND_HDA_EXT_CORE
> +	select SND_HDA

I am wondering if this needs a platform dependency?
Or perhaps this symbol should be made invisible, as it is selected by
SND_SOC_INTEL_AVS_MACH_HDAUDIO?  Are there any other users?

Thanks!

> +	help
> +	  This enables HD-Audio codec support in ASoC subsystem. Compared
> +	  to SND_SOC_HDAC_HDA, driver's behavior is identical to HD-Audio
> +	  legacy solution - including the dynamic resource allocation
> +	  based on actual codec capabilities.
> +
> config SND_SOC_ICS43432
> 	tristate "ICS43423 and compatible i2s microphones"
>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
