Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F3586E61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiHAQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiHAQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:14:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953237F9E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659370488; x=1690906488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y8Ios2pZ9qLf0wK9KahJsDuQ6Dyzgc57OUm0m3fCS5Y=;
  b=jvLoK19s83VEk3R8AtcDY6e8/+DohJLl3XppQ6lKkPha5+y9AFKRbsSb
   J6+BZXRST/RsfG6gFmSzxHLPBr1UBc/qPOUXBPXOZRHyFkLBxTznv2Ve7
   s5x2KI8KxHn+s2MSighZ4bmEMQYbU7/3XFgQYhDMef3U2Y/IxWSSS0m+U
   YiDmF3ZG89ggYrjZXtn+qQsxIKe6npv6+RRCE+U7OtV4PoM4cV/01uPAl
   Qs0ukucfpOx/F8vYsO1oVchTDqpE8t84feiyWZlBDbHRudZsjYHyleZhb
   or6x0E1wXM2XlqJFWYkTYHVPZqURAuX8u2OhmT1Lm55eSd5ye87eO2DeT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289958112"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="289958112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:14:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="605708771"
Received: from yuanbowa-mobl.amr.corp.intel.com (HELO [10.212.86.5]) ([10.212.86.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:14:47 -0700
Message-ID: <1e2c7dd9-0c28-17eb-b166-3bfaf65bbfe4@linux.intel.com>
Date:   Mon, 1 Aug 2022 10:25:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] ASoC: Intel: cirrus-common: Use UID to map correct amp
 to prefix
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Brent Lu <brent.lu@intel.com>, xliu <xiang.liu@cirrus.com>
Cc:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220801094034.3927841-1-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220801094034.3927841-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/22 04:40, Stefan Binding wrote:
> Since the order of the amps in the ACPI determines the device name,
> and the ACPI order may change depending on hardware configuration,
> use UID to dynamically compute the dai links, allowing dynamic
> assignment of the name_prefix.
> 
> The UIDs for these amps in ACPI are fixed, and map to a name_prefix,
> where:
> UID 0x0 -> WL
> UID 0x1 -> WR
> UID 0x2 -> TL
> UID 0x3 -> TR
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Thanks for the updates, LGTM

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_cirrus_common.c | 92 ++++++++++++----------
>  1 file changed, 49 insertions(+), 43 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
> index f4192df962d6..6e39eda77385 100644
> --- a/sound/soc/intel/boards/sof_cirrus_common.c
> +++ b/sound/soc/intel/boards/sof_cirrus_common.c
> @@ -10,6 +10,9 @@
>  #include "../../codecs/cs35l41.h"
>  #include "sof_cirrus_common.h"
>  
> +#define CS35L41_HID "CSC3541"
> +#define CS35L41_MAX_AMPS 4
> +
>  /*
>   * Cirrus Logic CS35L41/CS35L53
>   */
> @@ -35,50 +38,12 @@ static const struct snd_soc_dapm_route cs35l41_dapm_routes[] = {
>  	{"TR Spk", NULL, "TR SPK"},
>  };
>  
> -static struct snd_soc_dai_link_component cs35l41_components[] = {
> -	{
> -		.name = CS35L41_DEV0_NAME,
> -		.dai_name = CS35L41_CODEC_DAI,
> -	},
> -	{
> -		.name = CS35L41_DEV1_NAME,
> -		.dai_name = CS35L41_CODEC_DAI,
> -	},
> -	{
> -		.name = CS35L41_DEV2_NAME,
> -		.dai_name = CS35L41_CODEC_DAI,
> -	},
> -	{
> -		.name = CS35L41_DEV3_NAME,
> -		.dai_name = CS35L41_CODEC_DAI,
> -	},
> -};
> +static struct snd_soc_dai_link_component cs35l41_components[CS35L41_MAX_AMPS];
>  
>  /*
>   * Mapping between ACPI instance id and speaker position.
> - *
> - * Four speakers:
> - *         0: Tweeter left, 1: Woofer left
> - *         2: Tweeter right, 3: Woofer right
>   */
> -static struct snd_soc_codec_conf cs35l41_codec_conf[] = {
> -	{
> -		.dlc = COMP_CODEC_CONF(CS35L41_DEV0_NAME),
> -		.name_prefix = "TL",
> -	},
> -	{
> -		.dlc = COMP_CODEC_CONF(CS35L41_DEV1_NAME),
> -		.name_prefix = "WL",
> -	},
> -	{
> -		.dlc = COMP_CODEC_CONF(CS35L41_DEV2_NAME),
> -		.name_prefix = "TR",
> -	},
> -	{
> -		.dlc = COMP_CODEC_CONF(CS35L41_DEV3_NAME),
> -		.name_prefix = "WR",
> -	},
> -};
> +static struct snd_soc_codec_conf cs35l41_codec_conf[CS35L41_MAX_AMPS];
>  
>  static int cs35l41_init(struct snd_soc_pcm_runtime *rtd)
>  {
> @@ -117,10 +82,10 @@ static int cs35l41_init(struct snd_soc_pcm_runtime *rtd)
>  static const struct {
>  	unsigned int rx[2];
>  } cs35l41_channel_map[] = {
> -	{.rx = {0, 1}}, /* TL */
>  	{.rx = {0, 1}}, /* WL */
> -	{.rx = {1, 0}}, /* TR */
>  	{.rx = {1, 0}}, /* WR */
> +	{.rx = {0, 1}}, /* TL */
> +	{.rx = {1, 0}}, /* TR */
>  };
>  
>  static int cs35l41_hw_params(struct snd_pcm_substream *substream,
> @@ -175,10 +140,51 @@ static const struct snd_soc_ops cs35l41_ops = {
>  	.hw_params = cs35l41_hw_params,
>  };
>  
> +static const char * const cs35l41_name_prefixes[] = { "WL", "WR", "TL", "TR" };
> +
> +/*
> + * Expected UIDs are integers (stored as strings).
> + * UID Mapping is fixed:
> + * UID 0x0 -> WL
> + * UID 0x1 -> WR
> + * UID 0x2 -> TL
> + * UID 0x3 -> TR
> + * Note: If there are less than 4 Amps, UIDs still map to WL/WR/TL/TR. Dynamic code will only create
> + * dai links for UIDs which exist, and ignore non-existant ones. Only 2 or 4 amps are expected.
> + * Return number of codecs found.
> + */
> +static int cs35l41_compute_codec_conf(void)
> +{
> +	const char * const uid_strings[] = { "0", "1", "2", "3" };
> +	unsigned int uid, sz = 0;
> +	struct acpi_device *adev;
> +	struct device *physdev;
> +
> +	for (uid = 0; uid < CS35L41_MAX_AMPS; uid++) {
> +		adev = acpi_dev_get_first_match_dev(CS35L41_HID, uid_strings[uid], -1);
> +		if (!adev) {
> +			pr_devel("Cannot find match for HID %s UID %u (%s)\n", CS35L41_HID, uid,
> +				 cs35l41_name_prefixes[uid]);
> +			continue;
> +		}
> +		physdev = get_device(acpi_get_first_physical_node(adev));
> +		cs35l41_components[sz].name = dev_name(physdev);
> +		cs35l41_components[sz].dai_name = CS35L41_CODEC_DAI;
> +		cs35l41_codec_conf[sz].dlc.name = dev_name(physdev);
> +		cs35l41_codec_conf[sz].name_prefix = cs35l41_name_prefixes[uid];
> +		acpi_dev_put(adev);
> +		sz++;
> +	}
> +
> +	if (sz != 2 && sz != 4)
> +		pr_warn("Invalid number of cs35l41 amps found: %d, expected 2 or 4\n", sz);
> +	return sz;
> +}
> +
>  void cs35l41_set_dai_link(struct snd_soc_dai_link *link)
>  {
> +	link->num_codecs = cs35l41_compute_codec_conf();
>  	link->codecs = cs35l41_components;
> -	link->num_codecs = ARRAY_SIZE(cs35l41_components);
>  	link->init = cs35l41_init;
>  	link->ops = &cs35l41_ops;
>  }
