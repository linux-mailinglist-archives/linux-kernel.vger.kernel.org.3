Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AECE4932B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350855AbiASCHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:07:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:14240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350649AbiASCHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642558053; x=1674094053;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SADnO3+RxA7TLM946fh6hsuryNfZzjZ8vuXRamwkzA0=;
  b=hD6483/cPfvT/FSLEDd0eyI7o4itsSwTVYEmcTa5dPVKfMOzzcaqj02F
   KcEnHODx23gVK6SPLJM9IAAzMnycm3x+rxa/JfgbLk1hy3G6ayS22VReF
   NuP4YCiXaBorWRsSqI3C+Kujhgn+04nR4LX612mco/UVSKJulfEa30RRn
   MLQgZxR6J0tAkBb/VFgTlQZ6TgepLGZffBspy9A7sUcIwJos+Y35KX/j7
   im8T51VEsC2DTQssqXK4rg3Q6gLtXJtTIhPpzFE68tQiyvuGSFz70yNKs
   GtVQ9q8mspDhnXFLEcBKooam0eYLFdBV6y1FXgB8M8Tr9BMaZdaOjolPr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244756699"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="244756699"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:07:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="622350895"
Received: from mdzurick-mobl.amr.corp.intel.com (HELO [10.209.145.208]) ([10.209.145.208])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:07:31 -0800
Subject: Re: [PATCH v2 2/2] ASoC: SOF: compress: Implement get_caps and
 get_codec_caps
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        cezary.rojewski@intel.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, paul.olaru@nxp.com,
        daniel.baluta@nxp.com, sound-open-firmware@alsa-project.org
References: <20220118212732.281657-1-daniel.baluta@oss.nxp.com>
 <20220118212732.281657-3-daniel.baluta@oss.nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <41ae6093-8e27-01d4-e532-8a28fb1d9cf1@linux.intel.com>
Date:   Tue, 18 Jan 2022 19:00:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220118212732.281657-3-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/22 3:27 PM, Daniel Baluta wrote:
> From: Paul Olaru <paul.olaru@nxp.com>
> 
> These functions are used by the userspace to determine what the firmware
> supports and tools like cplay should use in terms of sample rate, bit
> rate, buffer size and channel count.
> 
> The current implementation uses i.MX8 tested scenarios!
> 
> Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/sof/compress.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
> index 91a9c95929cd..e3f3f309f312 100644
> --- a/sound/soc/sof/compress.c
> +++ b/sound/soc/sof/compress.c
> @@ -308,6 +308,78 @@ static int sof_compr_pointer(struct snd_soc_component *component,
>  	return 0;
>  }
>  
> +static int sof_compr_get_caps(struct snd_soc_component *component,
> +			      struct snd_compr_stream *cstream,
> +			      struct snd_compr_caps *caps)
> +{
> +	caps->num_codecs = 3;
> +	caps->min_fragment_size = 3840;
> +	caps->max_fragment_size = 3840;
> +	caps->min_fragments = 2;
> +	caps->max_fragments = 2;
> +	caps->codecs[0] = SND_AUDIOCODEC_MP3;
> +	caps->codecs[1] = SND_AUDIOCODEC_AAC;
> +	caps->codecs[2] = SND_AUDIOCODEC_PCM;

I don't think you can add this unconditionally for all
devices/platforms, clearly this wouldn't be true for Intel for now.

If the information is not part of a firmware manifest or topology, then
it's likely we have to use an abstraction layer to add this for specific
platforms.

it's really a bit odd to hard-code all of this at the kernel level, this
was not really what I had in mind when we come up with the concept of
querying capabilities. I understand though that for testing this is
convenient, so maybe this can become a set of fall-back properties in
case the firmware doesn't advertise anything.

> +
> +	return 0;
> +}
> +
> +static struct snd_compr_codec_caps caps_pcm = {
> +	.num_descriptors = 1,
> +	.descriptor[0].max_ch = 2,
> +	.descriptor[0].sample_rates[0] = 48000,
> +	.descriptor[0].num_sample_rates = 1,
> +	.descriptor[0].bit_rate = {1536, 3072},
> +	.descriptor[0].num_bitrates = 2,
> +	.descriptor[0].profiles = SND_AUDIOPROFILE_PCM,
> +	.descriptor[0].modes = 0,
> +	.descriptor[0].formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> +};
> +
> +static struct snd_compr_codec_caps caps_mp3 = {
> +	.num_descriptors = 1,
> +	.descriptor[0].max_ch = 2,
> +	.descriptor[0].sample_rates[0] = 48000,
> +	.descriptor[0].num_sample_rates = 1,
> +	.descriptor[0].bit_rate = {32, 40, 48, 56, 64, 80, 96, 112, 224, 256, 320},
> +	.descriptor[0].num_bitrates = 11,
> +	.descriptor[0].profiles = 0,
> +	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
> +	.descriptor[0].formats = 0,
> +};
> +
> +static struct snd_compr_codec_caps caps_aac = {
> +	.num_descriptors = 1,
> +	.descriptor[0].max_ch = 2,
> +	.descriptor[0].sample_rates[0] = 48000,
> +	.descriptor[0].num_sample_rates = 1,
> +	.descriptor[0].bit_rate = {128, 192},
> +	.descriptor[0].num_bitrates = 2,
> +	.descriptor[0].profiles = 0,
> +	.descriptor[0].modes = 0,
> +	.descriptor[0].formats = SND_AUDIOSTREAMFORMAT_MP4ADTS | SND_AUDIOSTREAMFORMAT_MP2ADTS,
> +};
> +
> +static int sof_compr_get_codec_caps(struct snd_soc_component *component,
> +				    struct snd_compr_stream *cstream,
> +				    struct snd_compr_codec_caps *codec)
> +{
> +	switch (codec->codec) {
> +	case SND_AUDIOCODEC_MP3:
> +		*codec = caps_mp3;
> +		break;
> +	case SND_AUDIOCODEC_AAC:
> +		*codec = caps_aac;
> +		break;
> +	case SND_AUDIOCODEC_PCM:
> +		*codec = caps_pcm;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  struct snd_compress_ops sof_compressed_ops = {
>  	.open		= sof_compr_open,
>  	.free		= sof_compr_free,
> @@ -316,5 +388,7 @@ struct snd_compress_ops sof_compressed_ops = {
>  	.trigger	= sof_compr_trigger,
>  	.pointer	= sof_compr_pointer,
>  	.copy		= sof_compr_copy,
> +	.get_caps	= sof_compr_get_caps,
> +	.get_codec_caps	= sof_compr_get_codec_caps,
>  };
>  EXPORT_SYMBOL(sof_compressed_ops);
> 
