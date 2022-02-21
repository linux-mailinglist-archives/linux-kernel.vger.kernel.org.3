Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54094BE612
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356879AbiBUOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:30:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiBUOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:30:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9861EC5E;
        Mon, 21 Feb 2022 06:30:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E49B81F437A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453808;
        bh=g3slv7bO+i9JLZnG8f+h6pHx2C2DHBVoYfxFRSRsfkU=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=AQ9zpeRHw4BCi6CuLlgjKEZrjpXNSRcN6K234xSdy7JXtdX2dDcmexIqP19rcxAdy
         QL6qZgpsiQIlYliIHF6Q5CQ3NiTEc82v5ey0ftyb962tbeHWLgBb8pFcmTFKdHmxJO
         GKXuxeo4muP0TLUli8w8ki4NtrXP4lI7wMGJyHm/ttmnQsupQIRNeMAN/54AgQOIGN
         gnqCPt3OgXH/+C8BLro2XJhZjQYmhIzmDzbSQ2o9XhEe4gH4NCoT3JAHgEfi/l2IFs
         9MXk+jRjgWh0LUG2lFnAvA90OziqJq8wz2942w/GJpMedTj7Rg/ty6FtiUrtI0qO6k
         CYO/LmILCK0aw==
Message-ID: <c5a83b5f-91cc-61f9-a570-fafb5672de9f@collabora.com>
Date:   Mon, 21 Feb 2022 15:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 03/19] drm/edid: Add cea_sad helpers for freq/length
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-4-granquet@baylibre.com>
Content-Language: en-US
In-Reply-To: <20220218145437.18563-4-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This patch adds two helper functions that extract the frequency and word
> length from a struct cea_sad.
> 
> For these helper functions new defines are added that help translate the
> 'freq' and 'byte2' fields into real numbers.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/gpu/drm/drm_edid.c | 74 ++++++++++++++++++++++++++++++++++++++
>   include/drm/drm_edid.h     | 18 ++++++++--
>   2 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 12893e7be89bb..500279a82167a 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4747,6 +4747,80 @@ int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb)
>   }
>   EXPORT_SYMBOL(drm_edid_to_speaker_allocation);
>   
> +/**
> + * drm_cea_sad_get_sample_rate - Extract the sample rate from cea_sad
> + * @sad: Pointer to the cea_sad struct
> + *
> + * Extracts the cea_sad frequency field and returns the sample rate in Hz.
> + *
> + * Return: Sample rate in Hz or a negative errno if parsing failed.
> + */
> +int drm_cea_sad_get_sample_rate(const struct cea_sad *sad)
> +{
> +	switch (sad->freq) {
> +	case DRM_CEA_SAD_FREQ_32KHZ:
> +		return 32000;
> +	case DRM_CEA_SAD_FREQ_44KHZ:
> +		return 44100;
> +	case DRM_CEA_SAD_FREQ_48KHZ:
> +		return 48000;
> +	case DRM_CEA_SAD_FREQ_88KHZ:
> +		return 88200;
> +	case DRM_CEA_SAD_FREQ_96KHZ:
> +		return 96000;
> +	case DRM_CEA_SAD_FREQ_176KHZ:
> +		return 176400;
> +	case DRM_CEA_SAD_FREQ_192KHZ:
> +		return 192000;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL(drm_cea_sad_get_sample_rate);
> +
> +static bool drm_cea_sad_is_uncompressed(const struct cea_sad *sad)
> +{
> +	switch (sad->format) {
> +	case HDMI_AUDIO_CODING_TYPE_STREAM:
> +	case HDMI_AUDIO_CODING_TYPE_PCM:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * drm_cea_sad_get_uncompressed_word_length - Extract word length
> + * @sad: Pointer to the cea_sad struct
> + *
> + * Extracts the cea_sad byte2 field and returns the word length for an
> + * uncompressed stream.
> + *
> + * Note: This function may only be called for uncompressed audio.
> + *
> + * Return: Word length in bits or a negative errno if parsing failed.
> + */
> +int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad *sad)
> +{
> +	if (!drm_cea_sad_is_uncompressed(sad)) {
> +		DRM_WARN("Unable to get the uncompressed word length for a compressed format: %u\n",
> +			 sad->format);
> +		return -EINVAL;
> +	}
> +
> +	switch (sad->byte2) {
> +	case DRM_CEA_SAD_UNCOMPRESSED_WORD_16BIT:
> +		return 16;
> +	case DRM_CEA_SAD_UNCOMPRESSED_WORD_20BIT:
> +		return 20;
> +	case DRM_CEA_SAD_UNCOMPRESSED_WORD_24BIT:
> +		return 24;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL(drm_cea_sad_get_uncompressed_word_length);
> +
>   /**
>    * drm_av_sync_delay - compute the HDMI/DP sink audio-video sync delay
>    * @connector: connector associated with the HDMI/DP sink
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 18f6c700f6d02..a30452b313979 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -361,12 +361,24 @@ struct edid {
>   
>   /* Short Audio Descriptor */
>   struct cea_sad {
> -	u8 format;
> +	u8 format; /* See HDMI_AUDIO_CODING_TYPE_* */

Hello Guillaume,

since you're adding comments to all the rest of the struct members,
I think that a small effort to instead convert this to kerneldoc is
totally worth it.
Can you please do that?

Thanks,
Angelo

>   	u8 channels; /* max number of channels - 1 */
> -	u8 freq;
> +	u8 freq; /* See CEA_SAD_FREQ_* */
>   	u8 byte2; /* meaning depends on format */
>   };
>   
> +#define DRM_CEA_SAD_FREQ_32KHZ  BIT(0)
> +#define DRM_CEA_SAD_FREQ_44KHZ  BIT(1)
> +#define DRM_CEA_SAD_FREQ_48KHZ  BIT(2)
> +#define DRM_CEA_SAD_FREQ_88KHZ  BIT(3)
> +#define DRM_CEA_SAD_FREQ_96KHZ  BIT(4)
> +#define DRM_CEA_SAD_FREQ_176KHZ BIT(5)
> +#define DRM_CEA_SAD_FREQ_192KHZ BIT(6)
> +
> +#define DRM_CEA_SAD_UNCOMPRESSED_WORD_16BIT BIT(0)
> +#define DRM_CEA_SAD_UNCOMPRESSED_WORD_20BIT BIT(1)
> +#define DRM_CEA_SAD_UNCOMPRESSED_WORD_24BIT BIT(2)
> +
>   struct drm_encoder;
>   struct drm_connector;
>   struct drm_connector_state;
> @@ -374,6 +386,8 @@ struct drm_display_mode;
>   
>   int drm_edid_to_sad(struct edid *edid, struct cea_sad **sads);
>   int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb);
> +int drm_cea_sad_get_sample_rate(const struct cea_sad *sad);
> +int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad *sad);
>   int drm_av_sync_delay(struct drm_connector *connector,
>   		      const struct drm_display_mode *mode);
>   


