Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B758A630
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiHEGzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiHEGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:55:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307213DD5;
        Thu,  4 Aug 2022 23:55:03 -0700 (PDT)
X-UUID: 5aafa9e119794ee8a52c2d6ad658eff4-20220805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9nir8zRQtJqQ4Wo+km5ez4xfHiBIhvwG0Vod/3Ig61E=;
        b=SxDtcbjvEKjmuqsgPsxVvg4FW2RwLUnaAmVYYfut+ZqmHzTYFzM1CDAbkkzFBjG2waTYSl+ywu6dYHvJ5+G0CHtt0QgWAufmMMMjM75bNVXpH8tYdnE6gP0QIAwyTJq/pPuzKUmLW4Qey5cHZo0YqUahc4Ohj4ek9CSsnz/FS/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0b5e8034-168c-4c43-8347-b483477deaa8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:0b5e8034-168c-4c43-8347-b483477deaa8,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:404b01ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:d028bb52bd57,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5aafa9e119794ee8a52c2d6ad658eff4-20220805
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 318569209; Fri, 05 Aug 2022 14:55:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 5 Aug 2022 14:54:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 5 Aug 2022 14:54:58 +0800
Message-ID: <ad9207524145fdc8338894be70228820f40a49d8.camel@mediatek.com>
Subject: Re: [PATCH v15 03/11] drm/edid: Add cea_sad helpers for freq/length
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <matthias.bgg@gmail.com>, <deller@gmx.de>,
        <airlied@linux.ie>
CC:     <devicetree@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <granquet@baylibre.com>, <jitao.shi@mediatek.com>,
        <liangxu.xu@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <msp@baylibre.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <wenst@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>
Date:   Fri, 5 Aug 2022 14:54:57 +0800
In-Reply-To: <87zggmenv8.fsf@intel.com>
References: <20220727045035.32225-1-rex-bc.chen@mediatek.com>
         <20220727045035.32225-4-rex-bc.chen@mediatek.com>
         <87zggmenv8.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-02 at 17:11 +0300, Jani Nikula wrote:
> On Wed, 27 Jul 2022, Bo-Chen Chen <rex-bc.chen@mediatek.com> wrote:
> > From: Guillaume Ranquet <granquet@baylibre.com>
> > 
> > This patch adds two helper functions that extract the frequency and
> > word
> > length from a struct cea_sad.
> > 
> > For these helper functions new defines are added that help
> > translate the
> > 'freq' and 'byte2' fields into real numbers.
> 
> I think we should stop adding a plethora of functions that deal with
> sads like this.
> 
> There should probably be *one* struct that contains all the details
> you
> and everyone need extracted. There should be *one* function that
> fills
> in all the details. The struct should be placed in
> connector->display_info, and the function should be called *once*
> from
> update_display_info().
> 
> Ideally, the function shouldn't even be exposed from drm_edid.c, but
> if
> you still need to deal with situations where you don't call connector
> update, maybe it needs to be exposed.
> 
> BR,
> Jani.
> 
> 

Hello Jani,

Thanks for your review.
After checking our patches, we found we will not use these two function
because we remove them in patch [11/11] drm/mediatek: Use cached audio
config when changing resolution.

I will drop [02/11] and [03/11].

Thanks!

BRs,
Bo-Chen

> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/drm_edid.c | 63
> > ++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_edid.h     | 14 +++++++++
> >  2 files changed, 77 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_edid.c
> > b/drivers/gpu/drm/drm_edid.c
> > index bc43e1b32092..2a6f92da5ff3 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -4916,6 +4916,69 @@ int drm_edid_to_speaker_allocation(const
> > struct edid *edid, u8 **sadb)
> >  }
> >  EXPORT_SYMBOL(drm_edid_to_speaker_allocation);
> >  
> > +/**
> > + * drm_cea_sad_get_sample_rate - Extract the sample rate from
> > cea_sad
> > + * @sad: Pointer to the cea_sad struct
> > + *
> > + * Extracts the cea_sad frequency field and returns the sample
> > rate in Hz.
> > + *
> > + * Return: Sample rate in Hz or a negative errno if parsing
> > failed.
> > + */
> > +int drm_cea_sad_get_sample_rate(const struct cea_sad *sad)
> > +{
> > +	switch (sad->freq) {
> > +	case DRM_CEA_SAD_FREQ_32KHZ:
> > +		return 32000;
> > +	case DRM_CEA_SAD_FREQ_44KHZ:
> > +		return 44100;
> > +	case DRM_CEA_SAD_FREQ_48KHZ:
> > +		return 48000;
> > +	case DRM_CEA_SAD_FREQ_88KHZ:
> > +		return 88200;
> > +	case DRM_CEA_SAD_FREQ_96KHZ:
> > +		return 96000;
> > +	case DRM_CEA_SAD_FREQ_176KHZ:
> > +		return 176400;
> > +	case DRM_CEA_SAD_FREQ_192KHZ:
> > +		return 192000;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +EXPORT_SYMBOL(drm_cea_sad_get_sample_rate);
> > +
> > +/**
> > + * drm_cea_sad_get_uncompressed_word_length - Extract word length
> > + * @sad: Pointer to the cea_sad struct
> > + *
> > + * Extracts the cea_sad byte2 field and returns the word length
> > for an
> > + * uncompressed stream.
> > + *
> > + * Note: This function may only be called for uncompressed audio.
> > + *
> > + * Return: Word length in bits or a negative errno if parsing
> > failed.
> > + */
> > +int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad
> > *sad)
> > +{
> > +	if (sad->format != HDMI_AUDIO_CODING_TYPE_PCM) {
> > +		DRM_WARN("Unable to get the uncompressed word length
> > for format: %u\n",
> > +			 sad->format);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (sad->byte2) {
> > +	case DRM_CEA_SAD_UNCOMPRESSED_WORD_16BIT:
> > +		return 16;
> > +	case DRM_CEA_SAD_UNCOMPRESSED_WORD_20BIT:
> > +		return 20;
> > +	case DRM_CEA_SAD_UNCOMPRESSED_WORD_24BIT:
> > +		return 24;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +EXPORT_SYMBOL(drm_cea_sad_get_uncompressed_word_length);
> > +
> >  /**
> >   * drm_av_sync_delay - compute the HDMI/DP sink audio-video sync
> > delay
> >   * @connector: connector associated with the HDMI/DP sink
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index c2c43a4af681..779b710aed40 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -373,6 +373,18 @@ struct cea_sad {
> >  	u8 byte2;
> >  };
> >  
> > +#define DRM_CEA_SAD_FREQ_32KHZ  BIT(0)
> > +#define DRM_CEA_SAD_FREQ_44KHZ  BIT(1)
> > +#define DRM_CEA_SAD_FREQ_48KHZ  BIT(2)
> > +#define DRM_CEA_SAD_FREQ_88KHZ  BIT(3)
> > +#define DRM_CEA_SAD_FREQ_96KHZ  BIT(4)
> > +#define DRM_CEA_SAD_FREQ_176KHZ BIT(5)
> > +#define DRM_CEA_SAD_FREQ_192KHZ BIT(6)
> > +
> > +#define DRM_CEA_SAD_UNCOMPRESSED_WORD_16BIT BIT(0)
> > +#define DRM_CEA_SAD_UNCOMPRESSED_WORD_20BIT BIT(1)
> > +#define DRM_CEA_SAD_UNCOMPRESSED_WORD_24BIT BIT(2)
> > +
> >  struct drm_encoder;
> >  struct drm_connector;
> >  struct drm_connector_state;
> > @@ -380,6 +392,8 @@ struct drm_display_mode;
> >  
> >  int drm_edid_to_sad(const struct edid *edid, struct cea_sad
> > **sads);
> >  int drm_edid_to_speaker_allocation(const struct edid *edid, u8
> > **sadb);
> > +int drm_cea_sad_get_sample_rate(const struct cea_sad *sad);
> > +int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad
> > *sad);
> >  int drm_av_sync_delay(struct drm_connector *connector,
> >  		      const struct drm_display_mode *mode);
> 
> 

