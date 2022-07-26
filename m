Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0BA5815A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiGZOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiGZOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:47:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22919037
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658846868; x=1690382868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AVdLXZczB78wzjYne0LzeumnXgq283J0Ar7FnM/OkOY=;
  b=JrJx4XRUU4kj6ryLQZwGweBpZLSRlfU8DQLBtP26mCMRf+MIjaWlMvXW
   s4dRhjkq9pwMWUwN32hvfS6pRakmxQqZfiwkKOEqud1mpQlMF4bKfVw3E
   DjZnG/b+Pt4FRkH0eLRe6MjD5RGGQhombq8Ppj7dD9N01JmBJXGieLMmM
   bbmeStlUUN+FN9kIJabnWt6glnB5zuw8+CGHJhHD/sBCOLCVd9LyZh4hr
   a+mahSA4pqxcaF0r5L/8+fAcohBme9MQwJ6CTem2DV1VZQlqPbAW6OUkN
   nT980Jwui+bwKaYcct4WiKOH3WkETD8hDhBT1j1BmbEQP38m99O5vZswM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="286727545"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="286727545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 07:47:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="597047566"
Received: from adamreed-mobl.amr.corp.intel.com (HELO [10.212.70.145]) ([10.212.70.145])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 07:47:46 -0700
Message-ID: <013c0854-5b8e-6968-1ab2-88f2d0b142a0@linux.intel.com>
Date:   Tue, 26 Jul 2022 09:34:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1] ASoC: Intel: cirrus-common: Use UID to map correct amp
 to prefix
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Brent Lu <brent.lu@intel.com>, xliu <xiang.liu@cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
References: <20220726134634.2842185-1-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220726134634.2842185-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/22 08:46, Stefan Binding wrote:
> Since the order of the amps in the ACPI determines the device name,
> and the ACPI order may change depending on hardware configuration,
> use UID to dynamically compute the dai links, allowing dynamic
> assignment of the name_prefix.

This is interesting, I didn't even know what this _UID thingy could be
used for. ACPI is the gift that keeps on giving after 30 years, eh?

I think you should add an explanation on what this _UID is, nothing says
it actually needs to be an integer, I see e.g. this sort of 'id' in
various DSDT

Name (_UID, Zero)  // _UID: Unique ID
Name (_UID, 0x05)  // _UID: Unique ID
Name (_UID, "SerialIoUart0")  // _UID: Unique ID
Name (_UID, "PCHRESV")  // _UID: Unique ID
Name (_UID, "IoTraps")  // _UID: Unique ID
Name (_UID, "SADDLESTRING")  // _UID: Unique ID

and my favorite

Name (_UID, "TestDev")  // _UID: Unique ID


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
> @@ -175,8 +140,32 @@ static const struct snd_soc_ops cs35l41_ops = {
>  	.hw_params = cs35l41_hw_params,
>  };
>  
> +static const char * const cs35l41_name_prefixes[] = { "WL", "WR", "TL", "TR" };
> +
> +static const char * const cs35l41_uid_strings[] = { "0", "1", "2", "3" };

I must admit not understanding why you changed the order.

I vaguely recall Brent Lu added this on TL, WL, TR, WR order on purpose
and that it matches the order in the SOF topology. Brent, can you please
comment on this?

I don't really care about the order selected, just want to make sure we
don't introduce a channel swap with what the firmware does.

> +static void cs35l41_compute_codec_conf(void)
> +{
> +	int uid;
> +	struct acpi_device *adev;
> +	struct device *physdev;
> +
> +	for (uid = 0; uid < CS35L41_MAX_AMPS; uid++) {
> +		adev = acpi_dev_get_first_match_dev(CS35L41_HID, cs35l41_uid_strings[uid], -1);
> +		if (!adev)
> +			return;

shouldn't you log an error or something telling the user that their DSDT
configuration is incorrect?

If I understand the code above, is the expectation that the UID expected
in the DSDT should be:

Name (_UID, "0")  // _UID: Unique ID for WL
Name (_UID, "1")  // _UID: Unique ID for WR
Name (_UID, "2")  // _UID: Unique ID for TL
Name (_UID, "3")  // _UID: Unique ID for TR

Is yes that's worthy of a comment for future generations.

> +		physdev = get_device(acpi_get_first_physical_node(adev));
> +		cs35l41_components[uid].name = dev_name(physdev);
> +		cs35l41_components[uid].dai_name = CS35L41_CODEC_DAI;
> +		cs35l41_codec_conf[uid].dlc.name = dev_name(physdev);
> +		cs35l41_codec_conf[uid].name_prefix = cs35l41_name_prefixes[uid];
> +		acpi_dev_put(adev);
> +	}
> +}
> +
>  void cs35l41_set_dai_link(struct snd_soc_dai_link *link)
>  {
> +	cs35l41_compute_codec_conf();
>  	link->codecs = cs35l41_components;
>  	link->num_codecs = ARRAY_SIZE(cs35l41_components);
>  	link->init = cs35l41_init;
