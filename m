Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C221F49FCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349576AbiA1Pbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:31:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:40192 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239667AbiA1Pbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:31:51 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SAlQGQ004181;
        Fri, 28 Jan 2022 09:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=wL0zJBiKIWod4uzVo58UrUjP2I3Psupby3Ex3AeWzPQ=;
 b=Mcq8z9yB9JWAcj/MHgRaOFISzsoLZgyA1Bs4Dxm6yBQlWxHLwvPLFgXWINFPhFp06Jiv
 efD+NVFGDKjekxesvNZ4DQdRZ0lJSabTYzPm9R4UkoUisHBD6rjtUbtNMbFf1y2FsBPO
 psMe2WdnL+5Qn25G5kwaph14y0YNNQFF/52aWoJfMxlIBsN6Bw0b3Bw1s0HSrl0ePFof
 BJSfG6mmdDBn0GiBa8QRH9b5EYtx3LyxSw5DFEWJTpGh2AShjVQpgwNeCKTtPR4cRBIz
 bX0h8lNsAcFeQXHlIUY7bgWxBrVyrEvI7YZqIrwoE0SHlKqwlW8ncgIdHd1eB7iu0KWM MQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dv90rrhu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Jan 2022 09:31:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 15:31:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 28 Jan 2022 15:31:24 +0000
Received: from LONN2DGDQ73 (unknown [198.90.238.118])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5A1E52A9;
        Fri, 28 Jan 2022 15:31:24 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Stephen Boyd' <swboyd@chromium.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Douglas Anderson' <dianders@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        'Lucas Tanure' <tanureal@opensource.cirrus.com>,
        'Takashi Iwai' <tiwai@suse.de>,
        'Daniel Vetter' <daniel.vetter@ffwll.ch>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Rob Clark' <robdclark@gmail.com>,
        'Russell King' <rmk+kernel@arm.linux.org.uk>,
        'Saravana Kannan' <saravanak@google.com>
References: <20220127200141.1295328-1-swboyd@chromium.org> <20220127200141.1295328-34-swboyd@chromium.org>
In-Reply-To: <20220127200141.1295328-34-swboyd@chromium.org>
Subject: RE: [PATCH v6 33/35] ALSA: hda/realtek: Migrate to aggregate driver
Date:   Fri, 28 Jan 2022 15:31:24 +0000
Message-ID: <003d01d8145c$1bfc83b0$53f58b10$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKTHzAglPObqNN3HmQB0+j3AO7d5wDuIK/MqvsC3oA=
Content-Language: en-gb
X-Proofpoint-ORIG-GUID: K_LOQM8TjPJrzG6NLbyR90eIF2EODU3A
X-Proofpoint-GUID: K_LOQM8TjPJrzG6NLbyR90eIF2EODU3A
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Boyd <swboyd@chromium.org>
> Sent: 27 January 2022 20:02
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Douglas Anderson
> <dianders@chromium.org>
> Cc: linux-kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; dri-
> devel@lists.freedesktop.org; freedreno@lists.freedesktop.org; Stefan
> Binding <sbinding@opensource.cirrus.com>; Lucas Tanure
> <tanureal@opensource.cirrus.com>; Takashi Iwai <tiwai@suse.de>; Daniel
> Vetter <daniel.vetter@ffwll.ch>; Rafael J. Wysocki <rafael@kernel.org>;
Rob
> Clark <robdclark@gmail.com>; Russell King <rmk+kernel@arm.linux.org.uk>;
> Saravana Kannan <saravanak@google.com>
> Subject: [PATCH v6 33/35] ALSA: hda/realtek: Migrate to aggregate driver
> 
> Use an aggregate driver instead of component ops so that we can get
> proper driver probe ordering of the aggregate device with respect to all
> the component devices that make up the aggregate device.
> 
> Cc: Stefan Binding <sbinding@opensource.cirrus.com>
> Cc: Lucas Tanure <tanureal@opensource.cirrus.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  sound/pci/hda/patch_realtek.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 668274e52674..80a2164c99b6 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6547,25 +6547,31 @@ static int find_comp_by_dev_name(struct
> alc_spec *spec, const char *name)
>  	return -ENODEV;
>  }
> 
> -static int comp_bind(struct device *dev)
> +static int realtek_aggregate_probe(struct aggregate_device *adev)
>  {
> +	struct device *dev = aggregate_device_parent(adev);
>  	struct hda_codec *cdc = dev_to_hda_codec(dev);
>  	struct alc_spec *spec = cdc->spec;
> 
>  	return component_bind_all(dev, spec->comps);
>  }
> 
> -static void comp_unbind(struct device *dev)
> +static void realtek_aggregate_remove(struct aggregate_device *adev)
>  {
> +	struct device *dev = aggregate_device_parent(adev);
>  	struct hda_codec *cdc = dev_to_hda_codec(dev);
>  	struct alc_spec *spec = cdc->spec;
> 
>  	component_unbind_all(dev, spec->comps);
>  }
> 
> -static const struct component_master_ops comp_master_ops = {
> -	.bind = comp_bind,
> -	.unbind = comp_unbind,
> +static struct aggregate_driver realtek_aggregate_driver = {
> +	.probe = realtek_aggregate_probe,
> +	.remove = realtek_aggregate_remove,
> +	.driver = {
> +		.name = "realtek_aggregate",
> +		.owner = THIS_MODULE,
> +	},
>  };
> 
>  static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo,
> struct hda_codec *cdc,
> @@ -6597,7 +6603,7 @@ static void cs35l41_generic_fixup(struct hda_codec
> *cdc, int action, const char
>  				return;
>  			component_match_add(dev, &spec->match,
> comp_match_dev_name, name);
>  		}
> -		ret = component_master_add_with_match(dev,
> &comp_master_ops, spec->match);
> +		ret = component_aggregate_register(dev,
> &realtek_aggregate_driver, spec->match);
>  		if (ret)
>  			codec_err(cdc, "Fail to register component
> aggregator %d\n", ret);
>  		else
> @@ -6648,7 +6654,7 @@ static void
> alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const st
>  				    "i2c-CLSA0100:00-cs35l41-hda.0");
>  		component_match_add(dev, &spec->match,
> comp_match_dev_name,
>  				    "i2c-CLSA0100:00-cs35l41-hda.1");
> -		ret = component_master_add_with_match(dev,
> &comp_master_ops, spec->match);
> +		ret = component_aggregate_register(dev,
> &realtek_aggregate_driver, spec->match);
>  		if (ret)
>  			codec_err(cdc, "Fail to register component
> aggregator %d\n", ret);
>  		else
> --
> https://chromeos.dev

Tested locally, and no issues found.
Tested-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks,
Stefan


